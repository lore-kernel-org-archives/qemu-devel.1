Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1F3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 16:54:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B607214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 16:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jl6Ywodb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B607214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwU8G-0001B9-96
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 11:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iwU7c-0000Wq-GY
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:53:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iwU7b-00043U-9J
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:53:52 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51359)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iwU7b-00041y-21
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 11:53:51 -0500
Received: by mail-wm1-x342.google.com with SMTP id t23so3315712wmi.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 08:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=LqBnatKRaMvjpcxq1rK3Mi9Fi0D5wxsX1HWy81mUk20=;
 b=Jl6YwodbLK5hgyEH+5INZAmE/LJd6h6mUNR8XsgB/5vhavekMdd+ywUd9yRqMmdp7H
 mfXAnQ9igRFtHgAzhgXJEl2ogFu2RjuIIGp2OvCPTzl6kE5/lfFcIjZmg/EpBuc8wl3W
 Jgb5vYzpBuff1twrm7Q68Fp/lxWT0r7tq10V/bfcfJNp9HwFTV6T3wpJQFR8po5u4PFQ
 VKpWGDxRLtUVtgakfv44li/ulwJ340YQONlWs5+3GDNWx1WJkOlcHK65fqZMVERKaf0F
 Gi8JtM09CinqACPOZADZkH83CWUM4UTWC8yRrcr817YB82ZE06lDZH+mx+zizNF97E2d
 F8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=LqBnatKRaMvjpcxq1rK3Mi9Fi0D5wxsX1HWy81mUk20=;
 b=V0ZnxIfpKGv0JymtxmTulcwnNYcHwckyxZrVA7ps36oPfN9eIkJuAT1UPNjEOppoL8
 C/lJy11RqtaGwb8ubE+rcXeEe+iEn3oaoBl0EsdhjIGW9nXSotp/TS95Jd3HdkV40s9D
 sPkohFTZwLbXaCeIpAqc3cHasHI8a0Ceeasut8Lzi7II2yphfW6A9fdRQ1Qb3wCB1p8S
 a/bjDiHwr+D6hHpeT8RJpLs326n0K+ho6U2EabvgMV3oRhsxvYnbW3xp9X6p9My19jlH
 Fd6j1ztiQV/qCo0hiIEh2bwyx9eHf/luQqi2o058ewxDYwriTFST3x4j8LhjEJeh/KJc
 WZDw==
X-Gm-Message-State: APjAAAXXxxhiwC06MzZZFJKe1POUT4LCDXc3cB4mUKw4MuAkdXwAa/LJ
 JThMYAj5yGYM/qdPxqh8XxXUXw==
X-Google-Smtp-Source: APXvYqy1B1PUW4zOAMzeW5gYPvcuxhWrZIWH4CSn9+B9SgkUloQ1xoxwMOSYBjHBJshdVId7RXXiSQ==
X-Received: by 2002:a1c:2ed5:: with SMTP id u204mr6279770wmu.170.1580230429766; 
 Tue, 28 Jan 2020 08:53:49 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m3sm25684105wrs.53.2020.01.28.08.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 08:53:48 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CEDB81FF87;
 Tue, 28 Jan 2020 16:53:47 +0000 (GMT)
References: <20200117192808.129398-1-jkz@google.com>
 <20200117192808.129398-2-jkz@google.com>
 <295472c5-4378-4ae1-1e9f-854b15075cf6@vivier.eu>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v2 1/4] linux-user: Use `qemu_log' for non-strace logging
In-reply-to: <295472c5-4378-4ae1-1e9f-854b15075cf6@vivier.eu>
Date: Tue, 28 Jan 2020 16:53:47 +0000
Message-ID: <871rrjfrok.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Josh Kunz <jkz@google.com>, riku.voipio@iki.fi, qemu-devel@nongnu.org,
 imp@bsdimp.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laurent Vivier <laurent@vivier.eu> writes:

> Le 17/01/2020 =C3=A0 20:28, Josh Kunz a =C3=A9crit :
>> Since most calls to `gemu_log` are actually logging unimplemented featur=
es,
>> this change replaces most non-strace calls to `gemu_log` with calls to
>> `qemu_log_mask(LOG_UNIMP, ...)`.  This allows the user to easily log to
>> a file, and to mask out these log messages if they desire.
>>=20
>> Note: This change is slightly backwards incompatible, since now these
>> "unimplemented" log messages will not be logged by default.
>
> This is a good incompatibility as these messages were unexpected by  the
> tools catching stderr. They don't happen on "real" systems.
>
> ...
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 249e4b95fc..629f3a21b5 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -1545,20 +1545,18 @@ static inline abi_long target_to_host_cmsg(struc=
t msghdr *msgh,
>>              - sizeof(struct target_cmsghdr);
>>=20=20
>>          space +=3D CMSG_SPACE(len);
>> -        if (space > msgh->msg_controllen) {
>> -            space -=3D CMSG_SPACE(len);
>> -            /* This is a QEMU bug, since we allocated the payload
>> -             * area ourselves (unlike overflow in host-to-target
>> -             * conversion, which is just the guest giving us a buffer
>> -             * that's too small). It can't happen for the payload types
>> -             * we currently support; if it becomes an issue in future
>> -             * we would need to improve our allocation strategy to
>> -             * something more intelligent than "twice the size of the
>> -             * target buffer we're reading from".
>> -             */
>> -            gemu_log("Host cmsg overflow\n");
>> -            break;
>> -        }
>> +
>> +        /*
>> +         * This is a QEMU bug, since we allocated the payload
>> +         * area ourselves (unlike overflow in host-to-target
>> +         * conversion, which is just the guest giving us a buffer
>> +         * that's too small). It can't happen for the payload types
>> +         * we currently support; if it becomes an issue in future
>> +         * we would need to improve our allocation strategy to
>> +         * something more intelligent than "twice the size of the
>> +         * target buffer we're reading from".
>> +         */
>> +        assert(space > msgh->msg_controllen && "Host cmsg overflow");
>>=20=20
>>          if (tswap32(target_cmsg->cmsg_level) =3D=3D TARGET_SOL_SOCKET) {
>>              cmsg->cmsg_level =3D SOL_SOCKET;
>
> Could you move this to a separate patch: you are not using qemu_log()
> here and I'm not convinced that crashing is better than ignoring the
> remaining part of the buffer.

I suggested it should be an assert in the first place. It certainly
makes sense to keep it in a separate patch though. I guess you could
argue for:

  qemu_log_mask(LOG_UNIMP, "%s: unhandled message size");

but is it really better to partially work and continue? It seems like
you would get more subtle hidden bugs.

>
> For the other changes:
>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>
> Thanks,
> Lauren


--=20
Alex Benn=C3=A9e

