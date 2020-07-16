Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64C2C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E1D205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/qdyeDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E1D205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw871-0000rS-Np
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 13:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jw86L-0000Dz-F2
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 13:55:21 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a]:33229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jw86I-0007lM-W7
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 13:55:21 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id d125so1356685oob.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 10:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:from:user-agent:to
 :references:in-reply-to:message-id:subject:date;
 bh=0yW0JmZURen0kdfxNgJAT7ZcuZVipB3zSQg+knhVqpM=;
 b=k/qdyeDAiAIq0LV9kP+UhV/z9CsRqfsAGcPflXIueVS5C1F5izIRq0/d9hnerf4nf9
 v0nM93dj5ixs9FszoV5QHq82ueEOkYgcaVdU0Y0WkzYTgsWDpHUN7f3EVlpUINtbUJcv
 C4MzbRDca7NlKOKjeBGAyh6QeSQFAgeIgCyPUXn8weYKz28GoJwYm/PnDDLpVotvOH1R
 u0xm1cGINmr5WiaJm4RFLX6/4msPRzrK0M3Q/M1b2vcr7UcA1MXI6hccH8H1aA9Jfsfa
 vBKlP/cMexxVMndtTYnu11B96Q07Fqyo+BID7hqM5aMHo62BSspc9TcYyxRGNEvgy4Bv
 91lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding
 :from:user-agent:to:references:in-reply-to:message-id:subject:date;
 bh=0yW0JmZURen0kdfxNgJAT7ZcuZVipB3zSQg+knhVqpM=;
 b=ZvOsjsv3juS4c+QCl7EavHSqkUAttl5taqpbKzz2PWu0z8t8T+UzXLXbx07bg/84gv
 b3od5mHbFMCVNlN0YtyamhjFC86ZzcI9XabSLma7cJSf60ZohNXIYbZbbMWg0IN1X2kp
 9uRKqM3Stj6gnyw/TuQMaMGr61/sTtp+2x6mNPOeFm0SQSkjqtpSD3g5rgSXfnxBcBEZ
 SvMFlTFQxy7/XnxgD6iHdikUpvK0OpNNcsKmOM7nqohdXgWqbg0wOf/3r9SyhUXLGMGc
 IUUk1H/iXnBxU+STVIoOxrO6Q/ZUQTGILAcW3DvLFkTfK+j//0/60dajk79v5T2v/DXI
 Uo7g==
X-Gm-Message-State: AOAM5300VCA3WF0wtIb0POwrJWsvkLtbDJRrv1MK/0qM/U5Wo5F4WIr1
 5HGpgsBmCipIY8D4EfPGgT8=
X-Google-Smtp-Source: ABdhPJywYxi8HtJPRvUqtlR6lpWHZBudl4YNyxkn+J3aDfldlPmJrRBXjecws4FRniZuQ0SPyABQTQ==
X-Received: by 2002:a4a:b503:: with SMTP id r3mr5217529ooo.92.1594922117061;
 Thu, 16 Jul 2020 10:55:17 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id j8sm1382956ooh.34.2020.07.16.10.55.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 16 Jul 2020 10:55:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA-reu8gKpBMgEffStTRA+M02OWj75riXqBYXjgtOh5Z_A@mail.gmail.com>
In-Reply-To: <CAFEAcA-reu8gKpBMgEffStTRA+M02OWj75riXqBYXjgtOh5Z_A@mail.gmail.com>
Message-ID: <159492211230.15440.2651129078319986183@sif>
Subject: Re: qemu test-qga failure on mergebuild after VERSION file change:
 dependency issues??
Date: Thu, 16 Jul 2020 12:55:12 -0500
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc2a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Peter Maydell (2020-07-16 05:53:17)
> The first merge I tried to process after bumping VERSION for rc0
> failed on test-qga like this:
> =

> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-qga -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driv
> er.pl --test-name=3D"test-qga"
> PASS 1 test-qga /qga/sync-delimited
> PASS 2 test-qga /qga/sync
> PASS 3 test-qga /qga/ping
> **
> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-qga.c:303:test_qga=
_info:
> assertion failed (version =3D=3D QEMU_VERSION): ("5.0.9
> 0" =3D=3D "5.0.50")
> ERROR test-qga - Bail out!
> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-qga.c:303:test_qga=
_info:
> assertion failed (versio
> n =3D=3D QEMU_VERSION): ("5.0.90" =3D=3D "5.0.50")
> Aborted (core dumped)
> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:659:
> recipe for target 'check-unit' failed
> =

> Looking at timestamps on files, tests/test-qga.o never got rebuilt,
> even though config-host.h has been updated (and so has the new
> QEMU_VERSION). Any idea what's gone wrong here?
> =

> Also weird: this build tree has no .d files in it.

I've been trying to reproduce with:

make
make check-unit
*bump VERSION
make check-unit

but test-qga.o gets rebuilt as expected and the test passed.

This is with ubuntu 18.04, x86, with out-of-tree build directory. Are you a=
ware
of any other factors that might be needed to reproduce this?

> =

> thanks
> -- PMM

