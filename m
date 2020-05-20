Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35FEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 09:37:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A58DE2065F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 09:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="1Xi+z+zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58DE2065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbLA6-0002Rb-U5
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 05:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jbL9Y-0001z7-B7
 for qemu-devel@nongnu.org; Wed, 20 May 2020 05:36:44 -0400
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44]:39834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jbL9W-0008MU-P2
 for qemu-devel@nongnu.org; Wed, 20 May 2020 05:36:43 -0400
Received: by mail-vk1-xa44.google.com with SMTP id 21so599129vkq.6
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 02:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NMpHlr/YZp6uGKYxaWVXg+ZVGUld5nQNp7/jWhT+QmQ=;
 b=1Xi+z+zuxyW3vkhnorAWhewweOyhVMcQayWAx0+0ePe4WSZIfK1fdsNeAewrC5F6nv
 r20bAi4mAsMSzI2TUghC0qGV3TfvxUKet0dQKx2JItVBPWneK1FZVCmfSdAGBAhfdwMO
 zoBUtROFf+dbucxK9J4oI1lyRx8m0xuTP4QKzIYp3CbK5xxikajdedQEAoUt9eT+/3Vo
 U8rTwRPxN11Hp2cejISwPdsDcAE8pIb101sWSEVh9te/tck9rpn7PBz5DUV90/cMN6SQ
 RAruHGO+LtyUCv5G/LR+yxciO57WzKPR1UpU00eSqxGa0bcoMyZqV6ediBEqZ6WDvSrl
 CEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NMpHlr/YZp6uGKYxaWVXg+ZVGUld5nQNp7/jWhT+QmQ=;
 b=qs0/TYGAwmjlN4CO1tqHD7VCCNcJVWZ22fewYqK8m+3Y6JMbQFMPJeHSsXDkMiyzHR
 SHBj5iXGQ9LLxo44HZebkGcC0Jyt8O7NExWS+VNRsxrPOkkJhXJ0pGTJSQ7sltEwknjp
 Ps6BB1Fd0DSdHveOtZSPYOYgGIrd/BHauIepPJYH5H9XHqgj2wHAc2Ar86dTOWtziT0r
 w9QQhCUhFY0ZIHvsQFVByBWJ87cwJsxCG3mDCyPIfULz/Lz814cOPgBiesQYPW8zpb5x
 bt0fsYZjEL4w5EgPNu/a6fDNA515+6yCKLthgK/klzdd0z7avEFgW3X3RouKAy3bzkrG
 vVSw==
X-Gm-Message-State: AOAM5320uUVnExCs7ARfv48WNphHdG2ePk2lCkXScoOvnRD2EH/Ubuc2
 G6vYe5cfQ1Ftpvo/O/rCNQVValHt0po1EL9SYqGBWQ==
X-Google-Smtp-Source: ABdhPJwdGlcwa11XuLqIkr9JwX3wjYwMHRHEualklQnoZJao46tSys3ELT1EJexlhUiT0y8r8jCtycTMRbwpDXrIFac=
X-Received: by 2002:a1f:1386:: with SMTP id 128mr3084625vkt.46.1589967401057; 
 Wed, 20 May 2020 02:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHckoCymFfuVd=tKV-hk+PHn2fk6ydWjSxwKVorj9Qe5KV6nGQ@mail.gmail.com>
 <CAHckoCzWmN4oedOHMvR_TbbBcbYqSjg1fUr2RjJkh-iuZO-Jng@mail.gmail.com>
 <55b6466c-0769-6652-a237-c6bc18704064@redhat.com>
 <20200514125220.GJ2787@work-vm>
 <CAHckoCyegWG9yH_y6VjHhnghfHJD-Wq+EmOyRZE3EYguTOHfPw@mail.gmail.com>
 <20200514151600.GO2787@work-vm>
 <CAHckoCxc2XTA3ckU0sq-BmbZZFtfAY_GaEOW46XFzfZ2qXjeMQ@mail.gmail.com>
 <20200514153129.GP2787@work-vm>
 <CAHckoCxOjNEAM4DwWtXS9JT_aPsqOtDAzf5zhhiRrDyAmQa00Q@mail.gmail.com>
 <CAHckoCwee+aNHcgRFvReCCz_0J-vLrM5=MPZFpqvQjkefV2MiQ@mail.gmail.com>
 <986fbf33-8127-870b-9163-4aa8d332553f@redhat.com>
 <CAHckoCxw=j8+uXHD3tzQc4vGkRu-_xhcHn8sSeiKaSHw=Bt6mA@mail.gmail.com>
 <7ecfb762-0359-92a4-d8b3-1a9e081ace92@redhat.com>
 <CAHckoCwEt+citc5pQkJxhsWkLuqJa47A98YUYtMHd7epmx0esQ@mail.gmail.com>
 <5902006b-655a-9208-796d-1af7b36da52c@redhat.com>
In-Reply-To: <5902006b-655a-9208-796d-1af7b36da52c@redhat.com>
From: Li Feng <fengli@smartx.com>
Date: Wed, 20 May 2020 17:36:29 +0800
Message-ID: <CAHckoCyZmYXU8bz-3UAVXGi1MpdNdb20no1-kB09MoWOGPz_VA@mail.gmail.com>
Subject: Re: kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs'
 failed.
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::a44;
 envelope-from=fengli@smartx.com; helo=mail-vk1-xa44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: vkuznets@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:34=E5=86=99=E9=81=93=EF=BC=9A
>
> On 20/05/20 10:55, Li Feng wrote:
> >>> After computing xor, the result is 0b1000000000.
> >>> The bit 9 is set.
> >> Are you running KVM with a 32-bit kernel.
> >>
> > No, I'm running 64 bit.
> >
> > $ uname -a
> > Linux 31_216 5.6.7-1.el7.centos.x86_64 #1 SMP Mon Apr 27 15:26:08 CST
> > 2020 x86_64 x86_64 x86_64 GNU/Linux
>
> Can you do "rdmsr 0x48f" (as root)?  On my machine for example I get
> 1ffffff00036dfb.
>
$ rdmsr 0x48f
3fffff00036dfb

> Thanks,
>
> Paolo
>

