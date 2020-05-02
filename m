Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF14C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 19:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A917420731
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 19:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kb0G72lx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A917420731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUxUb-0002cS-Pr
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 15:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUxTt-0001ph-AM
 for qemu-devel@nongnu.org; Sat, 02 May 2020 15:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUxTs-0005t8-C5
 for qemu-devel@nongnu.org; Sat, 02 May 2020 15:07:20 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUxTr-0005sv-SD
 for qemu-devel@nongnu.org; Sat, 02 May 2020 15:07:20 -0400
Received: by mail-wm1-x341.google.com with SMTP id k12so3742090wmj.3
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 12:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=oijl9c3h/tgiJaCL7XASCXVHAxOQqclCQt4/PQvylQg=;
 b=kb0G72lxYPZo/3/gn5drRFsHtXmUpLdLSIrPHfyIt9OF8MdfQRkkA72as+KlYYXPKl
 vRB4p3RGKiAgnlHg6kxmM9RXG4K5TEz2ceIOehAyYOVRN9XxL5O4pAHPLY6560zlovp6
 Qz8zozRAAuWVV2QI73nffmtZgNJ/vo/gkt+t5PkQ7pu0ZpB1zKXFBIUN+0ApmpNgRkv3
 d3G0AVxi/J4skbE6uuHg+zO73y7RXEMTZfIBaRYbWlh1SE8NpKB5LGugLx0ctoEfl7l4
 YVLlk7ekBzk4982PS71qX5X+MxnstcBYeWRbgrngfWEsx+ff4molBxrO5NbKy653s4mp
 jreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=oijl9c3h/tgiJaCL7XASCXVHAxOQqclCQt4/PQvylQg=;
 b=rbnFn1Qx+/evH9oaWRj7mOB/TBV7YJb0a6ZaiPf7qOQQWjViOqYfySRlKdqUYjmbz3
 geR+PJf581rOzhuoT4LQXu4oRRSjfhXkOcgf+y6lj9LuEq6BJ4LN0zNv8aAgkMybbYWQ
 vwLvPXcj9x4ZCe0KHKzCilG7ngQGHf+S9OxiSslPESV20WAWNey44pWRKlY98SIdoFKw
 qsB00+mWOHeRIIozenc4X9y62pAhqFSQG9zR6hl51jjpW8Q41aGY9nM+mEcZGiCxEUJ4
 3c7g+/dRVjtOXFSKEBoTmvg5xuEcS8l+YWkLDk8TnhS5jcksTtct0jfQfvTEC+fKAhwR
 Ph3g==
X-Gm-Message-State: AGi0PubRrS+jL1WKTXIzjvnJqBawElpx4Y32OROn0aNA7PKLg9t1elVq
 0V7Ue3DqYAB4MDDqzXBHwUfgLA==
X-Google-Smtp-Source: APiQypKrF6pNUcF3XWCgb/lTZiQSAtHkX2TjBEOM76WlOcHK0lDi60ADCHXq8XtKc5EKsY6Ge0HPYQ==
X-Received: by 2002:a1c:3985:: with SMTP id g127mr5931075wma.102.1588446438209; 
 Sat, 02 May 2020 12:07:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w11sm5198589wmi.32.2020.05.02.12.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2020 12:07:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 333A81FF7E;
 Sat,  2 May 2020 20:07:16 +0100 (BST)
References: <alpine.DEB.2.21.2005010038260.30535@digraph.polyomino.org.uk>
 <87d07niidw.fsf@linaro.org>
 <alpine.DEB.2.21.2005011911420.26026@digraph.polyomino.org.uk>
 <87a72rih9x.fsf@linaro.org>
 <alpine.DEB.2.21.2005012046280.26026@digraph.polyomino.org.uk>
User-agent: mu4e 1.4.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Joseph Myers <joseph@codesourcery.com>
Subject: Re: [PATCH 3/4] softfloat: fix floatx80 pseudo-denormal comparisons
In-reply-to: <alpine.DEB.2.21.2005012046280.26026@digraph.polyomino.org.uk>
Date: Sat, 02 May 2020 20:07:15 +0100
Message-ID: <875zdekvfg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Joseph Myers <joseph@codesourcery.com> writes:

> On Fri, 1 May 2020, Alex Benn=C3=A9e wrote:
>
>> OK - so these only turn up in i386?
>
> Patch 1, silencing sNaN, is about generic semantics of IEEE floating-poin=
t=20
> conversions (which are implemented correctly in various other cases in=20
> QEMU), and would be equally applicable to m68k (I believe, without having=
=20
> m68k hardware to test).
>
> Patches 2 and 3 are i386-specific (just like everything in the existing=20
> softfloat code relating to floatx80 subnormals), because m68k interprets=
=20
> biased exponent zero differently.
>
> Patch 4 would apply equally to m68k, because all that matters there is=20
> that a certain representation is a small nonzero value, not exactly what=
=20
> value it is.
>
> None of these apply to any other architectures supported by QEMU.
>
>> We have two tests currently (float_convs and float_madds) which
>> currently exercise the various combinations of limits and NaN types
>> using some common float_helpers.c support. Maybe extend it for have a
>> table of the various ext80 types and write a i386 only test case to
>> exercise the functions you fixed?
>
> It seems to me that appropriate tests would be entirely i386-specific (in=
=20
> tests/tcg/i386?).

Yes.

> How are such tests supposed to signal success or=20
> failure, since all the tests currently there seem to exit with status 0=20
> unconditionally?

Non-zero exit. The float_convs and madds tests always pass but the
second phase is a diff with a reference output which may fails.
Whichever is easier for your test case.

> I do have a test I'm using to check these fixes (in C code for convenienc=
e=20
> of implementation, with only a little inline asm), but it's not suitable=
=20
> for inclusion as-is, since it includes many tests that currently fail=20
> (e.g. for exceptions generated, since the i386 floating-point support in=
=20
> QEMU currently discards exceptions from the softfloat code; one of the=20
> things I intend to fix but haven't yet).  It also doesn't yet cover all=20
> the problems I think I've found so far in the floating-point support in=20
> the i386 port (at least ten such bugs beyond the ones fixed in the presen=
t=20
> patch series).  And it might well depend on details of compiler code=20
> generation to test some of the bugs effectively.

OK - we certainly want to include tests for fixed functionality as we
add it. It's something we are trying to get better at since the big
re-write a few years ago.

--=20
Alex Benn=C3=A9e

