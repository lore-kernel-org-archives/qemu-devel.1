Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38ABC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF7220748
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oYKocwaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF7220748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHrAx-0007a8-Js
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 11:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHrAE-00079L-RK
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHrAC-00019Y-8e
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:44:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:32776)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHrAB-0000w0-5t
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:44:52 -0400
Received: by mail-wr1-x442.google.com with SMTP id a25so11998698wrd.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 08:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3EnITb1pXoD4XFClMiiM/tUlsIS6k4Qo2eAdqRbbXWQ=;
 b=oYKocwaJ4oO21PvJpqveZPBArIzel5uxyStEtEd6z5vxCjmNqNESZbEjrze1Y7ekmE
 IWdijGloWfjQthDe/+mnqubQtFc34M/ZdsiAGQhcOVkX6LIbTGsx/W+DYKOivpTK6UjR
 oOdb58uv0ejMUFWj1UuQmh8ujVllcDGa4RByGtX3aHtTNCxkYPsn9njKpXgMP6FAa2ks
 bbbKDIjdEZROdrCkNO5VTe3cNqgWMxfPx4myJNu3+E8tBBkOIDT3nO9T7URZyDBcczOR
 mHP4ZhwyE8Ldwek6fTvms/mR588PtckHQa2+g8C331ChJXj7GVHE8n9f1m0QQ5FVVjZB
 4kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3EnITb1pXoD4XFClMiiM/tUlsIS6k4Qo2eAdqRbbXWQ=;
 b=iqN0oTG4UKI4cYvX+Gfq7kQaItEWm3EXz+ZjUAzfv5yw+ovBRMAveqeWKT4EE64KwA
 OOf4q5mae/JAG2zN0Rjd6CyFK+CyfIT0Zar1QtKz13NYT3wnWTHMXaY7mtIYd2RWNb8T
 QKseOmMP193u5v/G1M3PzSrnlRqgXNf1XSQFZ694VeqJ0dyKL9kJsg8G2HmiUsPf36pt
 ThrIwe/PcaRVmg5wFVkSFtD2qL6AlAwPylc8oL7flc3mNBvVmoqLvfqWio6c8Ll4xGqZ
 zw5gwMBbx65pQRxryf4IIMsUAqh2PzHqIpy1eFt1WjGH8LW2bHoPkZS/d1aPzWhFDV2y
 9rSQ==
X-Gm-Message-State: ANhLgQ0BJiZB/N2j+x+qXTnu2ZTwrucvYJGFTWvrTbJR/xwxbErtVHPh
 sLI9C5WbtGU0kSyTno4QbMb7tw==
X-Google-Smtp-Source: ADFU+vvQvi80oWyzDh0glt8xLzSasHdtMkMgRpJC9LhTIBLhxLdTDuQth1+kbV6LMcHey7uAARI62A==
X-Received: by 2002:a5d:5408:: with SMTP id g8mr70468wrv.82.1585323889948;
 Fri, 27 Mar 2020 08:44:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k3sm9069334wro.39.2020.03.27.08.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 08:44:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C5BF41FF7E;
 Fri, 27 Mar 2020 15:44:47 +0000 (GMT)
References: <20200326134316.36059-1-roger.pau@citrix.com>
 <f71f7cf8-af7d-7b45-a026-8ab87e106759@linaro.org>
 <20200327101600.GA28583@Air-de-Roger> <87sghum3zv.fsf@linaro.org>
 <20200327140839.GB28583@Air-de-Roger>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>
Subject: Re: [PATCH] qemu-user: fix build with LLVM lld 10
In-reply-to: <20200327140839.GB28583@Air-de-Roger>
Date: Fri, 27 Mar 2020 15:44:47 +0000
Message-ID: <878sjln6og.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: =?utf-8?Q?Daniel_P?= =?utf-8?Q?=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Dimitry Andric <dim@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Roger Pau Monn=C3=A9 <roger.pau@citrix.com> writes:

> On Fri, Mar 27, 2020 at 11:28:04AM +0000, Alex Benn=C3=A9e wrote:
>>=20
>> Roger Pau Monn=C3=A9 <roger.pau@citrix.com> writes:
>>=20
>> > On Thu, Mar 26, 2020 at 09:56:38AM -0700, Richard Henderson wrote:
>> >> On 3/26/20 6:43 AM, Roger Pau Monne wrote:
>> >> > lld 10.0.0 introduced a new linker option --image-base equivalent to
>> >> > the GNU -Ttext-segment one, hence use it when available.
>> >> >=20
>> >> > This fixes the build of QEMU on systems using lld 10 or greater.
>> >> >=20
>> >> > Signed-off-by: Dimitry Andric <dim@FreeBSD.org>
>> >> > Signed-off-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
>> >> > ---
>> >> > Cc: Laurent Vivier <laurent@vivier.eu>
>> >> > Cc: Richard Henderson <richard.henderson@linaro.org>
>> >> > Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>> >> > Cc: Paolo Bonzini <pbonzini@redhat.com>
>> >> > Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
>> >> > ---
>> >>=20
>> >> The Plan is still to drop this whole section of code.
>> >>=20
>> >> However, it's still blocked on getting the x86_64 vsyscall patches up=
stream.
>> >
>> > While this doesn't materialize, could it be possible to get this patch
>> > accepted?
>> >
>> > This is currently blocking the build of QEMU on FreeBSD HEAD, which
>> > has already switched to LLVM 10.0.0.
>>=20
>> I think the vsyscall patch has just been merged, however way I don't
>> think targeting HEAD of a OS release during the rc phase is appropriate.
>
> I'm not sure I understand what you mean. If QEMU doesn't build on
> FreeBSD HEAD it won't build on the next release. Also the LLVM
> toolchain used is not a development version AFAIK, but the actual
> 10.0.0 release, which QEMU should aim to support?

QEMU's supported build platforms are based on what is currently shipping
as stable versions:

  https://www.qemu.org/docs/master/system/build-platforms.html

> Can this be applied to stable branches then please if QEMU master
> doesn't have that chunk in configure anymore?

Usually platforms released after a given QEMU release will just carry
their own patches in the local packaging. When is the current HEAD due
to be cut as the next release? The schedule for QEMU's release is
documented on out planning pages:

  https://wiki.qemu.org/Planning/5.0

> FWIW, I've just looked at configure from git master branch and it
> still has that exact same linker detection chunk that this patch is
> trying to fix.

Now the vsyscalls patch is in this can be cleaned up I think. Richard?

--=20
Alex Benn=C3=A9e

