Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37356C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:23:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA74C2065F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="PFALF9Yl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA74C2065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbK0J-00018v-4i
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jbJzY-0000fI-Qw
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:22:20 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935]:37399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jbJzW-0002ue-BP
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:22:20 -0400
Received: by mail-ua1-x935.google.com with SMTP id g34so167499uah.4
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 01:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=80N3308sjW1G8UGwZUINucuf9nwtMNEE/5owF0yLVsE=;
 b=PFALF9YlQgNxvmPjAYCGqRff9VlrNMMxhq2HvGLVKlBasqaWiQcFlShyi5gsd+BzVD
 uOahoLKeZl49YTqo9p2UXuloE2DSBZZqFcubzKctQkTt6w/jMdXUQn4nMJ1b9SqgSvn8
 NFtjl5kGFXzwNBH053cT7v0tW6BWCKqL1uSomMmVXKb0VARgz0Uh9hAoTqw1SZxnKCCx
 gQ1vSj4t0/mWvN0iT13qVosV0TkVJB3Jp6v8GPkf6S5MBAOLGoyoBsbsxMURQsqZls59
 5dxTIEby7za2/P0oprfOtVcSd1XoJPZLRd6jL4CKsgmb33jKmm1aFqCKrA4ivjzEVA+P
 iy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=80N3308sjW1G8UGwZUINucuf9nwtMNEE/5owF0yLVsE=;
 b=MWEJNfCLkpOM/wmvzW9PRGWWkHm3ujwHfM8jcgc5u8b/00LJqphqNt0NClQ6t84Uv0
 m93veg6UkYWHULFp6uCkGnkECwET4pCZDStNqtQxCcGGRQu16l1HzEn2NeP3ifZvc4Jt
 HClrbID+YN1DPjHFXEwmV1VwKTfTBJZqsXUPcLJGOd8e4IxOxsOHwjvb7nFb0WL4cr1P
 O9pA/qCMcTiVuygQt9P+ABxVOxkwLjgLmkaKO296kBFcW0H15EoV5eW44aG7UnLlgmuM
 qU871RLRzzvFWbHkrY9m3LAQ1sIYg0Mc6uCljrIhJQNP27dzscp61gUYEPh1XVAX/u56
 qUbA==
X-Gm-Message-State: AOAM531cSbCqcqrPHYlJh4ody45Kn2oTZ+hCA4pLXJd38GvxQAlW0aCs
 Whqno2knMGIG47Yc0o0QCqGcdel7OIPTicDRDANGxw==
X-Google-Smtp-Source: ABdhPJy5to2SMB1Sl6PsyvEBFI26oy8edNWf903Ey2i+SL0+zkcrdzLPS23I+o/hnyBrJ3H9Q5tYMiK1Gu4kE/54mTM=
X-Received: by 2002:ab0:2f5:: with SMTP id 108mr2576949uah.122.1589962936518; 
 Wed, 20 May 2020 01:22:16 -0700 (PDT)
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
In-Reply-To: <986fbf33-8127-870b-9163-4aa8d332553f@redhat.com>
From: Li Feng <fengli@smartx.com>
Date: Wed, 20 May 2020 16:22:05 +0800
Message-ID: <CAHckoCxw=j8+uXHD3tzQc4vGkRu-_xhcHn8sSeiKaSHw=Bt6mA@mail.gmail.com>
Subject: Re: kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs'
 failed.
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::935;
 envelope-from=fengli@smartx.com; helo=mail-ua1-x935.google.com
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
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=883:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On 20/05/20 05:50, Li Feng wrote:
> >>>>>>>>> qemu-system-x86_64: error: failed to set MSR 0x48f to 0x7fefff0=
0036dfb
>
> The high 32 bits are 0111 1111 1110 1111 1111 1111.
>
> The low 32 bits are  0000 0011 0110 1101 1111 1011.
>
> The features that are set are the xor, so 0111 1100 1000 0010 0000 0100:
>
> - bit 2, vmx-exit-nosave-debugctl
> - bit 9, host address space size, is handled automatically by QEMU
> - bit 15, vmx-exit-ack-intr
> - bit 17, vmx-exit-save-pat
> - bit 18, vmx-exit-load-pat
> - bit 19, vmx-exit-save-efer
> - bit 20, vmx-exit-load-efer
> - bit 21, vmx-exit-save-preemption-timer
>
> Try removing all of these and see if QEMU starts:
>
> qemu-kvm ... -cpu
> host,-vmx-exit-nosave-debugctl,-vmx-exit-ack-intr,-vmx-exit-save-pat,-vmx=
-exit-load-pat,-vmx-exit-save-efer,-vmx-exit-load-efer,-vmx-exit-save-preem=
ption-timer
>
> And then add them back one at a time.

Hi, Paolo.
Thanks, the crash is still here when removing the above features:
qemu-system-x86_64: error: failed to set MSR 0x48f to 0x36fff00036dff

After computing xor, the result is 0b1000000000.
The bit 9 is set.

>
> Paolo
>

