Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1788C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311CE20EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9q5nOZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311CE20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKHam-0003Tm-4j
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 04:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kKHZk-0002cd-Av
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:53:35 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:52473)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kKHZh-0005Ft-AC
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:53:31 -0400
Received: by mail-pj1-x1043.google.com with SMTP id bw23so4253448pjb.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 01:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IGK8v6zRkQq6Ctee0UpKuf+8dtCXkkeTCH0iFMJIWNY=;
 b=Y9q5nOZNQwnHYEA2fAJ/h2PF6zclAEvKbXKUmOXpS/Qrr54feu6API5s0cuVGPx6ee
 n4QJqHeogfLLwvRgLpUZZIIBmjxhaxrmzvBbKYSun8OriDqxtrefHvVgKIYjqAs4ZKns
 yMNMuXmQN+4pXs3JGkJC6O+OqmgXAFCuMafk6OuwhDjCBeKgc2J5EySjfTIMZlWycxtl
 KZ6pZhwpmUgaITG91v8fTTlZ8nihina1SqShO5KLiQORiz0Q+ZfDVrama3bxsip6b2T9
 yet1pDJFVZ2nn27iTIMEWtEjGFvxRSWiCptL7NkSE8u9S71B6O68pi89TRJirLI57DcE
 5/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IGK8v6zRkQq6Ctee0UpKuf+8dtCXkkeTCH0iFMJIWNY=;
 b=MwftYNqocZ77NeUII93lcrHhLWih4PsiySkgtljE3of6D0splbG42/KuVyaU/h8P41
 jDSgXjSdhQnS/8bOgnwOyLOZ6hO0FLAte0XpgdoK/PVxuAlEDqjq2qGRsx4Qh+zLzE5N
 DPEnedqGkqqFeBA9z4/7Go6RrDUhbQ0toGvGdQjy1zx6Qpo7JxPl5T6kZUVyouEXHd1d
 QfjCnNlZJuUTFsWPH74iN2sE3MWM1tWao6vJLBb4GprjM1UuLWPYJKpEjKE1pRz9vgMW
 lMNwG8GqFDEZQ+Sdk3JJn4m7iTBJN0upjVIsEB8x3cQlCIX7J6AmvsoxtUx5WAQtwIUz
 dHfg==
X-Gm-Message-State: AOAM531vuYcPhz+Jb6QVlgW1HFIOD+dFtqJhtm8/0rbOtfqGNAC7vHNx
 fH2PrgW1IAhmGQqHubutbkIW1voSYx629YVOSCA=
X-Google-Smtp-Source: ABdhPJyzsKHX/FjzgxxKbf+T+7uY2RDHAT2x1hVKC9q3posKpLWWeDWYkfOo+rzavZ6qh3eKY8sUGdlB9n3L/j+q2J0=
X-Received: by 2002:a17:90a:77c6:: with SMTP id
 e6mr21860668pjs.116.1600678407679; 
 Mon, 21 Sep 2020 01:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200821165458.100591-1-sgarzare@redhat.com>
 <e5fdb193-952a-2bed-a1c7-4eb8bb0bbff7@redhat.com>
 <20200821203833.h2lcbu763kzu42p4@steredhat>
In-Reply-To: <20200821203833.h2lcbu763kzu42p4@steredhat>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 21 Sep 2020 09:53:14 +0100
Message-ID: <CAJSP0QVgt56ufW=iDp18KqntRPc+yBeKMHF2kwyE+_nhGu-sfg@mail.gmail.com>
Subject: Re: [PATCH] tests/docker: add liburing-devel to the Fedora image
To: Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=stefanha@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 9:38 PM Stefano Garzarella <sgarzare@redhat.com> wr=
ote:
> On Fri, Aug 21, 2020 at 07:55:02PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > On 8/21/20 6:54 PM, Stefano Garzarella wrote:
> > > Install liburing-devel dependencies to get better coverage on
> > > io-uring stuff (block/io_uring.c and util/fdmon-io_uring.c).
> > >
> > > Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > >  tests/docker/dockerfiles/fedora.docker | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/do=
ckerfiles/fedora.docker
> > > index 70b6186bd3..9650d324fa 100644
> > > --- a/tests/docker/dockerfiles/fedora.docker
> > > +++ b/tests/docker/dockerfiles/fedora.docker
> > > @@ -38,6 +38,7 @@ ENV PACKAGES \
> > >      libssh-devel \
> > >      libubsan \
> > >      libudev-devel \
> > > +    liburing-devel \
> > >      libusbx-devel \
> > >      libxml2-devel \
> > >      libzstd-devel \
> > >
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >
> > ../util/fdmon-io_uring.c:106:17: error: address argument to atomic
> > operation must be a pointer to _Atomic type ('unsigned int *' invalid)
> >     old_flags =3D atomic_fetch_or(&node->flags, FDMON_IO_URING_PENDING =
|
> > flags);
> >                 ^               ~~~~~~~~~~~~
> > /usr/lib64/clang/10.0.0/include/stdatomic.h:138:42: note: expanded from
> > macro 'atomic_fetch_or'
> > #define atomic_fetch_or(object, operand) __c11_atomic_fetch_or(object,
> > operand, __ATOMIC_SEQ_CST)
> >                                          ^                     ~~~~~~
> > ../util/fdmon-io_uring.c:130:14: error: address argument to atomic
> > operation must be a pointer to _Atomic type ('unsigned int *' invalid)
> >     *flags =3D atomic_fetch_and(&node->flags, ~(FDMON_IO_URING_PENDING =
|
> >              ^                ~~~~~~~~~~~~
>
> mmm, I'll try to fix this issue!

This issue was also reported here:
https://bugs.launchpad.net/qemu/+bug/1895471

