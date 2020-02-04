Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166E3C33CAC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 02:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54DA20732
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 02:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e8tDiVBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54DA20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyoPz-0000r2-3N
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 21:58:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jkz@google.com>) id 1iyoNU-0004hg-5O
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:55:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jkz@google.com>) id 1iyoNS-0002xX-RA
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:55:52 -0500
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:46728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jkz@google.com>) id 1iyoNS-0002tV-L4
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:55:50 -0500
Received: by mail-vs1-xe42.google.com with SMTP id t12so10386792vso.13
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 18:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LINaloSPKzML9ZlYqDWAv4wjjM1vYqJ25kiWsWMIH5s=;
 b=e8tDiVBrAlS0o3biwUgxdM4VMdCx4B+H2CaPjpFghd9Ng3VRsKC55/NjKjRc0YKwPS
 BauywD7Ej+mz7ZyjlSo9d1ZIwbCmsv2bwiB+tEvcWNHwdwy0lS1RfzRxPkbrgPnR+0Tb
 mkJO/P5pL2f2w41FtoH3hhvAeUTtG5fkKumbrT96CyBu47auW4VVo0+qNsnYQ/kOMUyp
 V2cPQEar/irZWRgC3WGG4t1fZ6AB9SeFsRK0DsqXGsDWmPCHPV5v5z1s36mqjjOwh/Qk
 fLG+SX32kuzuFLqeafZKmm5jzHTVGggzHSqqFDfFyeEl4wfHsKcbWvwvEaDoUa9/smPX
 WKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LINaloSPKzML9ZlYqDWAv4wjjM1vYqJ25kiWsWMIH5s=;
 b=sz9SDtiKXsJF+/gWL8l/ONM9fHkm+7lAihBk7TDaN6OcH+jmo8fwF2rURsPmBGVeMo
 k7Y60tf2JoizKaOlsWaRvbxGyp8xGweXzu7Mhn1mfe8oT79sFROANlD6oEZ/s0Wa3R7Y
 yuVp3QikIp8Zde5D9xEbRl/sbSdnheIhp3WBM3F2x6RTT3bTexbA/YIB609yH5y0JeIg
 1LT+a6PfogxVHwX9RkfRq9C6YJ9ekap5J4gQuab3Mts+zw8G2Jz0V0QAh7Aw/VGNbu8s
 QjKuxVGGKTQ4UcXvQ5s2uEtGR2L5qNPtI2YGXaaPqTK7BT92ZK8dvwy67ahSpkrYcwGG
 3bGQ==
X-Gm-Message-State: APjAAAXPZH1SK2Ru/Q+hSjSXl7kEtUXGswjkVPJCMTYdBm3FqldFJ8PL
 KR0Hi/L1lsDsqfMYJJqnldjLQZTqDmgdxShIHEPIrQ==
X-Google-Smtp-Source: APXvYqzZYcO7aPoWsFdoQmPRO+0QJQRkihfWdhTeJhXxD46rPZLfaNjR0/9Hvp/uu8E8Zr2TPC/Du4TM2PCYW1Tt0tc=
X-Received: by 2002:a67:ec41:: with SMTP id z1mr17735925vso.197.1580784949712; 
 Mon, 03 Feb 2020 18:55:49 -0800 (PST)
MIME-Version: 1.0
References: <20200117192808.129398-1-jkz@google.com>
 <20200117192808.129398-2-jkz@google.com>
 <295472c5-4378-4ae1-1e9f-854b15075cf6@vivier.eu> <871rrjfrok.fsf@linaro.org>
 <1aeb55ef-3563-9b97-7f15-59cd8408bd2a@vivier.eu>
In-Reply-To: <1aeb55ef-3563-9b97-7f15-59cd8408bd2a@vivier.eu>
From: Josh Kunz <jkz@google.com>
Date: Mon, 3 Feb 2020 18:55:38 -0800
Message-ID: <CADgy-2uC64goo4TNBuqpZDDakjRUhyTTyPmRRNfnDAUu-snd9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] linux-user: Use `qemu_log' for non-strace logging
To: Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>,
 armbru@redhat.com, Warner Losh <imp@bsdimp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e42
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I've switched it to a LOG_UNIMP, similar to to the one several lines
below. I will follow up with a change to switch this to an assert as
recommended.


On Tue, Jan 28, 2020 at 9:07 AM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 28/01/2020 =C3=A0 17:53, Alex Benn=C3=A9e a =C3=A9crit :
> >
> > Laurent Vivier <laurent@vivier.eu> writes:
> >
> >> Le 17/01/2020 =C3=A0 20:28, Josh Kunz a =C3=A9crit :
> >>> Since most calls to `gemu_log` are actually logging unimplemented fea=
tures,
> >>> this change replaces most non-strace calls to `gemu_log` with calls t=
o
> >>> `qemu_log_mask(LOG_UNIMP, ...)`.  This allows the user to easily log =
to
> >>> a file, and to mask out these log messages if they desire.
> >>>
> >>> Note: This change is slightly backwards incompatible, since now these
> >>> "unimplemented" log messages will not be logged by default.
> >>
> >> This is a good incompatibility as these messages were unexpected by  t=
he
> >> tools catching stderr. They don't happen on "real" systems.
> >>
> >> ...
> >>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> >>> index 249e4b95fc..629f3a21b5 100644
> >>> --- a/linux-user/syscall.c
> >>> +++ b/linux-user/syscall.c
> >>> @@ -1545,20 +1545,18 @@ static inline abi_long target_to_host_cmsg(st=
ruct msghdr *msgh,
> >>>              - sizeof(struct target_cmsghdr);
> >>>
> >>>          space +=3D CMSG_SPACE(len);
> >>> -        if (space > msgh->msg_controllen) {
> >>> -            space -=3D CMSG_SPACE(len);
> >>> -            /* This is a QEMU bug, since we allocated the payload
> >>> -             * area ourselves (unlike overflow in host-to-target
> >>> -             * conversion, which is just the guest giving us a buffe=
r
> >>> -             * that's too small). It can't happen for the payload ty=
pes
> >>> -             * we currently support; if it becomes an issue in futur=
e
> >>> -             * we would need to improve our allocation strategy to
> >>> -             * something more intelligent than "twice the size of th=
e
> >>> -             * target buffer we're reading from".
> >>> -             */
> >>> -            gemu_log("Host cmsg overflow\n");
> >>> -            break;
> >>> -        }
> >>> +
> >>> +        /*
> >>> +         * This is a QEMU bug, since we allocated the payload
> >>> +         * area ourselves (unlike overflow in host-to-target
> >>> +         * conversion, which is just the guest giving us a buffer
> >>> +         * that's too small). It can't happen for the payload types
> >>> +         * we currently support; if it becomes an issue in future
> >>> +         * we would need to improve our allocation strategy to
> >>> +         * something more intelligent than "twice the size of the
> >>> +         * target buffer we're reading from".
> >>> +         */
> >>> +        assert(space > msgh->msg_controllen && "Host cmsg overflow")=
;
>
> Should it be in fact :
>
>   assert(space <=3D msgh->msg_controllen && "Host cmsg overflow");
>
> >>>          if (tswap32(target_cmsg->cmsg_level) =3D=3D TARGET_SOL_SOCKE=
T) {
> >>>              cmsg->cmsg_level =3D SOL_SOCKET;
> >>
> >> Could you move this to a separate patch: you are not using qemu_log()
> >> here and I'm not convinced that crashing is better than ignoring the
> >> remaining part of the buffer.
> >
> > I suggested it should be an assert in the first place. It certainly
> > makes sense to keep it in a separate patch though. I guess you could
> > argue for:
> >
> >   qemu_log_mask(LOG_UNIMP, "%s: unhandled message size");
> >
> > but is it really better to partially work and continue? It seems like
> > you would get more subtle hidden bugs.
>
> ok, you're right. crash seems to be a better solution.
>
> So, we only need to move this change to a separate patch.
>
> Thanks,
> Laurent
>

