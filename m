Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC64C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E0D52088F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fs8jQQbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0D52088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXT3C-0008AG-OW
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iXT2L-0007Q9-Du
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iXT2H-00005j-Ij
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:41:00 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37417)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iXT2H-0008WT-96
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:40:57 -0500
Received: by mail-wm1-x342.google.com with SMTP id b17so322748wmj.2
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Fzw6AvuhTdSk7eMKis7RGWNJuPHFoaP+GEfOD5+BxlU=;
 b=fs8jQQbN7wh6is5PZIl9wRheguT0rDLUJMsLpxj9ZbwQsDyN3ct7YIfWGcaC8X7uU5
 St3/IKra5tB0ladroDKuGQhJeuhshTJ0enuS+XmwzzAAz4okR4Bur5w6j7AZEb4cMj4d
 TkEczCNCZL955TUn4rcqicaxd29eIzjUUfWPQ6NukgumTsCumvMGDIUVqT3TAxeDM/SK
 fv8wqRpOWeGuBRYAbSiPKSg3ABE6Zb4GpIS8okl5dJBNhEEbLFxs7vzTC6DgO21f549k
 DMDcxMjMkRr2R420+Ouiewb7AaWml81BJxI0S8PC3UTO98vbRDMDBegEgH/UEgKkScWM
 U3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Fzw6AvuhTdSk7eMKis7RGWNJuPHFoaP+GEfOD5+BxlU=;
 b=FaltaLV/bp2R5MztiNG2FkDt5jtpaw7WGBkxMDJSI1MVGRQKKtuvVjI2XLn+59fBya
 Z7p+wm0cOiSDGLsss1pWimLBBlgqGlQbMuBCZYghcHv4FR39zgXUdsOoQXq3/TJ/98LC
 AHw+2odWlEc9OHLMfrQkxQilN8vscOXokh3EuS0D68z+1ugArVuHAR5l76OzeQsKMYMb
 QAS40Bf4nDq/a+jVYMfjzBeFj99f1v1inFhuVIvC57nUw8a9yWWAGCHT3plKz3T+FTuW
 dI9ixR5wECfFvDigDI6kIwws9/VR1kezIWolp0oShxQMIoHDecnu2oZprx2vVcwr4eFf
 QjiA==
X-Gm-Message-State: APjAAAXWg5JOJ1v3iJVbZwtnEldcnEXJTe5sm3FuIBpDm7IK7kqDpZ41
 DRUmRG4f79FvtGAyH77U/t2cvA==
X-Google-Smtp-Source: APXvYqzuPA9+3uyYBUPbWfEwLg0VJEf29UYNOPipBqNVxDHjm6FoEk0I/wuyJpU7BmL/FDy3XMdtwQ==
X-Received: by 2002:a1c:2d4b:: with SMTP id t72mr4534872wmt.112.1574268055434; 
 Wed, 20 Nov 2019 08:40:55 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h140sm7614813wme.22.2019.11.20.08.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 08:40:53 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BCC931FF87;
 Wed, 20 Nov 2019 16:40:52 +0000 (GMT)
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <a77ce406-5307-cee8-8e0b-7c08056fb0df@redhat.com>
 <BYAPR02MB488666AA94EBB57C2A318004DE4C0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <8c92b107-b707-b8a7-6284-5b1ed8e95897@vivier.eu>
 <BYAPR02MB4886E559B9286FE580C28556DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <98464579-194a-2b96-5cb9-3b7a7d9e680d@vivier.eu>
 <42954e4f-11cd-6c95-e74c-9dbec2f90d56@linaro.org>
 <BYAPR02MB48867C73CDE23CA70FEE5369DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of
 patches - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon - Files in target/hexagon/imported are from another project
 and therefore do not conform to qemu coding standards
In-reply-to: <BYAPR02MB48867C73CDE23CA70FEE5369DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
Date: Wed, 20 Nov 2019 16:40:52 +0000
Message-ID: <87k17ufqln.fsf@linaro.org>
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Taylor Simpson <tsimpson@quicinc.com> writes:

> Is there a precedent for this?  I'm OK with DEBUG_HEX, but I assumed revi=
ewers wouldn't approve
> #ifdef FIXME
> #define DEBUG_HEX
> #endif

We are trying to phase out this style of #define as it's prone to
bitrot. What you can do if define a debug helper like:

#define D(fmt, ..) \
  if (DEBUG_HEXAGON) { \
      qemu_log(fmt, ## __VA_ARGS__); \
  }

So the debug will still be built (and format strings checked etc) but
with DEBUG_HEXAGON as 0 things get dead coded away.

>
> Taylor
>
>
> -----Original Message-----
> From: Richard Henderson <richard.henderson@linaro.org>
> Sent: Wednesday, November 20, 2019 3:02 AM
> To: Laurent Vivier <laurent@vivier.eu>; Taylor Simpson <tsimpson@quicinc.=
com>; Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>; riku.voipio@iki.fi; =
qemu-devel@nongnu.org
> Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of pa=
tches - linux-user changes + linux-user/hexagon + skeleton of target/hexago=
n - Files in target/hexagon/imported are from another project and therefore=
 do not conform to qemu coding standards
>
>
> On 11/20/19 9:33 AM, Laurent Vivier wrote:
>> Le 20/11/2019 =C3=A0 05:48, Taylor Simpson a =C3=A9crit :
>>> For the general DEBUG_HEX messages, I think the trace infrastructure is=
n't quite what I'm looking for.
>>>
>>> Here's a sample of what it prints
>>> Start packet: pc =3D 0x4002f0
>>> Packet committed: pc =3D 0x4002f0
>>> Regs written
>>>         r18 =3D -69420 (0xfffef0d4)
>>>         r19 =3D -69412 (0xfffef0dc)
>>> Stores
>>>         memd[0xfffef0b0] =3D 0 (0x0000000000000000) Next PC =3D 0x4002f8
>>> Exec counters: pkt =3D 17, insn =3D 24, hvx =3D 0
>
> For something like this, I'd keep DEBUG_HEX.
>
>>>     if (qemu_loglevel_maks(CPU_LOG_EXEC)) {
>
> CPU_LOG_EXEC already has a specific structure, listing the TranslationBlo=
cks that are executed.  It shouldn't be hijacked for something else.
>
> If you really want a runtime flag for this, we should add a new CPU_LOG_*=
 flag.
>
>
> r~


--
Alex Benn=C3=A9e

