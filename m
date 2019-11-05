Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD03C49EAB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 10:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB62F21928
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 10:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GV64dKqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB62F21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRvqw-0001om-4N
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 05:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iRvq4-0001Ne-Hx
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 05:13:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iRvq3-0000j6-2h
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 05:13:28 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:44660)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iRvq2-0000iJ-Qp
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 05:13:27 -0500
Received: by mail-wr1-x433.google.com with SMTP id f2so11715258wrs.11
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 02:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version:content-transfer-encoding;
 bh=UN3cTxYYVIMthdLLioztz7f9T8rb4jIIkM8BgeFLyhk=;
 b=GV64dKqjEpfOtv/fELJksy4gzhZm5nRzyIMSswbcI+AEYh9y65d0DnL+OCgF4L0UcN
 9aXt6z/hRoq3VMe+JgeXZBYe+ALW1AG9HfslBwE8LU5jnNUINBTjRmlaylBJe9d6qZI8
 HiLuSHmru5+a55NhkxYxg3ejYZYDyNdvQeFCaEHfd6uOFr0+Fkmh2dmyYBSlVR7Bftc4
 J0GxH8fSs+p/TI5umvLqz4BkBgG511ooY5clFcPIe23/jfz2+z/rtHfFHSSS0HDlwEa8
 e0k+vy9AhcdqshL6nMgTu7KucD9sigo9kTCWZfauoAT54pffFFpSM5KkZGTk1j5J9EBF
 nocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=UN3cTxYYVIMthdLLioztz7f9T8rb4jIIkM8BgeFLyhk=;
 b=MXo9GuyUOCzibH1dytuwSU/dkagBDX991U1H05qTKPrqmBs44Oy0AZFj0BQaf8OKIZ
 KmhSBUQarVRUC+93o2vQI8Nn98ZFI+fm2IBXBKL3O3fGksQ6qfrXnysDzvK/KVi6BQID
 ztUYq1qUEAK5EctFto2JIUlFjVFqQtRO4Tp83gk1fbmoSnRbz7dCSpyZ8IhQbAjyT/np
 Lb+kNop+WL5VyAkZgGvSo1gZrGPK9ug/pixYwLgOCGWHSX3TOfN21+xPwXYcE4R4Vaiv
 s1krVq/+cmzWVD9hOJ27hOPR0OKFwYfsKEceDO45MwssiO3KW1Nh9mbSfvWx85GU5BCJ
 aeag==
X-Gm-Message-State: APjAAAV+tM465+7LQNexnpCbAltCfvmm4hAair2K8/eKJxvMHrLvY/8b
 NgVHjIKiIYx2HoSqEOlUQmV4XkK0WMw=
X-Google-Smtp-Source: APXvYqzxLIuMu0JvoH6PHL/Y3zq7uMgE4zq+qhsZgCtVhaT08USckO+DwYBG40a/4/9zgJhidEDqnw==
X-Received: by 2002:adf:f004:: with SMTP id j4mr29491699wro.68.1572948804724; 
 Tue, 05 Nov 2019 02:13:24 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j19sm25781410wre.0.2019.11.05.02.13.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 02:13:23 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F10581FF87
 for <qemu-devel@nongnu.org>; Tue,  5 Nov 2019 10:13:22 +0000 (GMT)
References: <BYAPR02MB4886C25E683DEAFB1B8121FCDE7F0@BYAPR02MB4886.namprd02.prod.outlook.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: SIGSEGV question (Hexagon)
In-reply-to: <BYAPR02MB4886C25E683DEAFB1B8121FCDE7F0@BYAPR02MB4886.namprd02.prod.outlook.com>
Date: Tue, 05 Nov 2019 10:13:22 +0000
Message-ID: <87a79ak4vx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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


Taylor Simpson <tsimpson@quicinc.com> writes:

> Philippe suggested that I run the TCG tests for Hexagon.  Thanks Philippe=
!!
>
>
>
> I discovered that I=E2=80=99m not handling SIGSEGV properly.  We pass oth=
er signal tests, but not this one.  I=E2=80=99m hoping someone can help.
>  The first thing that I realized is that I hadn=E2=80=99t provided a tlb_=
fill function for CPUClass.  What is this function supposed to
> do?

It's does two subtly different things depending on system emulation vs
user-mode:

 * @tlb_fill: Callback for handling a softmmu tlb miss or user-only
 *       address fault.  For system mode, if the access is valid, call
 *       tlb_set_page and return true; if the access is invalid, and
 *       probe is true, return false; otherwise raise an exception and
 *       do not return.  For user-only mode, always raise an exception
 *       and do not return.

>I looked at other targets and found they are setting
>cs->exception_index to something and then call cpu_loop_exit_restore.

cpu_loop_exit_* brings you back to the sigsetjmp of cpu_exec short
circuiting any more TCG code. For linux-user the exception code should
get kicked back to cpu_loop. As we are jumping out of the TCG all your
CPUState should be coherent by this point. For pure TCG code this should
be the case. If you have faulted in a helper this could be problematic.

> I tried various values for exception_index, but the best I seem to get
> is re-executing the offending instruction forever.

For linux-user you need to then catch that exception in your cpu_loop
code and do the requisite setting up (probably a queue_signal in this
case). This should get picked up by the process_pending_signal at the
end of your cpu_loop which will then set the PC as appropriate to your
signal handler.

This is where we find out if your CPUState is now consistent ;-)

>
>
>
> Any insight would be greatly appreciated.
>
>
>
> Thanks,
>
> Taylor
>
>
>
>
>
> PS  The only other bug that these tests uncovered was that truncate isn=
=E2=80=99t implemented properly.  This was straightforward to fix.


--
Alex Benn=C3=A9e

