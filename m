Return-Path: <SRS0=wjfX=SQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35C2C10F13
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 18:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7994120850
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 18:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7MnsSHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7994120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38580 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFjbL-0006f6-15
	for qemu-devel@archiver.kernel.org; Sun, 14 Apr 2019 14:11:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hFjZv-0005GC-QT
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hFjWa-0008Kj-Pz
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:06:41 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:34961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hFjWa-0008JZ-9M
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:06:40 -0400
Received: by mail-ot1-x32b.google.com with SMTP id m10so12588890otp.2
	for <qemu-devel@nongnu.org>; Sun, 14 Apr 2019 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=RakPMWVb1AcL2UXbpj/tTpwnzaqb3TipUVpFNvDIE+4=;
	b=X7MnsSHw9ODMvWDMRIiorPeY1jpdtWveMWW0twLg+GgadWkAswwKEa+FBGY9RkSQiZ
	qHk1kSiNvmsTIM6lep85Fnb2rWREe78ZI4SkDNuOp4h3Ttb1zc2qXJi8t6sFtx/XmP4J
	KCi4myOvVvz6fx0C/kXfoMpvuvZWNe8Ghocft30RZDxCN93CiZzhv85ldC2fGIaNRFRI
	ErBQFZx01YWlpmeBL0tuQgGCg6jZunP9c2+S/Ve0vnMqPi5zbJJMKZNvRt07MIwCzSKF
	VWFQ0uQ0VNsx2u2xA5QMmlxjOhtdNx745kbLZIrNxFYY7oCVO/FFlUppwVMw55pJYmkR
	lfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=RakPMWVb1AcL2UXbpj/tTpwnzaqb3TipUVpFNvDIE+4=;
	b=kBGQp/3Bmm6l0zUjWc2BkOMhB4N6lIgWJJLZiAij+BhW8MtSnCK6Y8C2lPYR2fWvBN
	Chokq/D2RENC+yyMgH1FazlCNVR89rRcguwBmtgEEQCKwAAx/TIIZsvAb0B7V1EzMH7C
	i/oaRmf0l73MumsMDSQTSjyLDjo8dNxYMtrC9sJTjHkAxajZH9ct8haaM3iQX/NLfVEZ
	1H8lkxtx8A/a2/HG+c0qN9GViDkcFHrZ1Ch+XQG/Yyu8j9+vDAcuqr1YfzA9US4ZUl3X
	trCg+MwWgWig4/LhoNllqHnf7IGsu5M34KDbHMwvoc5SI9dypjqZlK+qb5crLQgXyO+0
	HD4Q==
X-Gm-Message-State: APjAAAWfXDmvzTHjSE83eutLgGpdmC69DjTWIB0/EFGQ90LHZS8IUeUC
	30B8zAfDM1DtEOuXS5m2JIIylYlsggbhmkFH17io0Q==
X-Google-Smtp-Source: APXvYqxQuwPfD842GVyNb9oS+lxdJwEt+BI4GBiiY6lk28r0h+NlDrateCTDcSZtPqzyGaZx3/xn7S5AqzrBRv8GtVA=
X-Received: by 2002:a05:6830:1cb:: with SMTP id
	r11mr38737694ota.302.1555265199110; 
	Sun, 14 Apr 2019 11:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <CA+7cjLHg8+X0GDGLbk=Dvo=Hjo_LpECa-bPzMO-higpnKoo8LA@mail.gmail.com>
In-Reply-To: <CA+7cjLHg8+X0GDGLbk=Dvo=Hjo_LpECa-bPzMO-higpnKoo8LA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 14 Apr 2019 19:06:27 +0100
Message-ID:
 <CAFEAcA9dVne1=R+_zSMfrpSVY3JCGFRLCfw0DcmJKefZ2UV71Q@mail.gmail.com>
To: =?UTF-8?B?5a6L5bu25p2w?= <icarus19971031@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Subject: Re: [Qemu-devel] How to use QEMU's "cpu_physical_memory_" functions?
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190414180627.DSxt0xVDlVbhS29Zilb4AOlFXlzJASM6rN395qJFpxo@z>

On Sat, 13 Apr 2019 at 10:47, =E5=AE=8B=E5=BB=B6=E6=9D=B0 <icarus19971031@g=
mail.com> wrote:
> I have started a project which requires the host to continuously write to
> VM's memory. VM reads its memory and performs some operations.
> I've found in this thread
> <https://lists.gnu.org/archive/html/qemu-devel/2014-11/msg03166.html> tha=
t
> I can use QEMU's "cpu_physical_memory_" functions. And I have found their
> definitions in "include/exec/cpu-common.h" in the source code of QEMU.

For QEMU functions which access guest memory, see
docs/devel/loads-stores.rst. cpu_physical_memory_* are
generally not what you want to use in current QEMU,
though some legacy code does.

thanks
-- PMM

