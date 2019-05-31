Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992E9C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 08:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2644225C57
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 08:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WKVPGJ8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2644225C57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38464 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWcn4-00073C-9g
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 04:21:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWcmE-0006lA-Hw
	for qemu-devel@nongnu.org; Fri, 31 May 2019 04:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWcmC-0002Na-WB
	for qemu-devel@nongnu.org; Fri, 31 May 2019 04:20:38 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWcmB-0002L7-2M
	for qemu-devel@nongnu.org; Fri, 31 May 2019 04:20:35 -0400
Received: by mail-wm1-x341.google.com with SMTP id 16so1029081wmg.5
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 01:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=D9Ka9HoL1ACypwY/N4ALGnE+bQD874oDZ1g1mtY6pXo=;
	b=WKVPGJ8DCy4y2xsubf8EzAIjZ3QEEY1s4Yr7xjd6F6iuyVui0MQwlbEEo3clR56xo4
	+5ixKyFZ54EZpwhUzhXYXFg2WgCEUrTr0M/PxGgcCxn0u0fCrAbnM+bJbSH529KRUNCp
	8xnsx9N6Qg2XdnUxnBy+vcSPu292EIWv+590h6J4gJRXbUs7QgBpH9NHl0AiH4uDqr2b
	eO7+SQvAfMN54GcP3myy186Bi6jsryJ+gcufDFKIRpAhGw+DYQBCbzFg+dRo9+wogeJA
	V+ke9V8LNTG4FkYMpgF8nmq+YwnzRVTzLItrrzmiP4y4Dzn1qEn5YmeelLoUvI5oNTUK
	/AVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=D9Ka9HoL1ACypwY/N4ALGnE+bQD874oDZ1g1mtY6pXo=;
	b=rO1IqEyyQBgxPR5P7W9iB2cTnVCwNV5w5lgiZs7lbn2S7Kwjd+Y8/H+9xOwu9ORfOB
	O8tyEKhN0v+poZqm+18IfVba4ZrF95FB/HuT0YG6NJbKQuTc2XNcatlTUHdM7cWHwU/p
	ho+D0+PsP9YSP0argETxqJUV5419BkdCU/XtjOmbsvoF7ixrof2bABD8F96K+zHDanQ1
	G8tWi1rKSrRiWVNvBVmYlHxE/3meBDvF1rQeDEionFzG+XJ1nwcyzoWJPOMkI4J5M+8j
	Vr9O6FlGnJBAEL6YhH1VG/Co59aLkiTBEDbYWDH3RIOz0Ogdw6W9KY0fZlrUxy5bSpV5
	ODBw==
X-Gm-Message-State: APjAAAWU8vDcgHkvqXaSsOS9CaKP1Cl+VTpTLlGHJrydTn8O+RCUPtwt
	2HDTEz9qVaIQm1R1uoaDQLNWJg==
X-Google-Smtp-Source: APXvYqyQ7Tghi1nIz1/oURUFC3J5PZmOah8mqT/7chuD8+uco1pbFigzcoK/hjUqBdpqehgjSv8Dug==
X-Received: by 2002:a05:600c:21c1:: with SMTP id
	x1mr4698650wmj.5.1559290832799; 
	Fri, 31 May 2019 01:20:32 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	p16sm9995574wrg.49.2019.05.31.01.20.31
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 01:20:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 4D2751FF87;
	Fri, 31 May 2019 09:20:31 +0100 (BST)
References: <20190523204954.13122-1-richard.henderson@linaro.org>
	<155865586800.24.17673050455759130330@549697c9ad12>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <155865586800.24.17673050455759130330@549697c9ad12>
Date: Fri, 31 May 2019 09:20:31 +0100
Message-ID: <87v9xr3ui8.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Update capstone module
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
Cc: richard.henderson@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


no-reply@patchew.org writes:

> Patchew URL: https://patchew.org/QEMU/20190523204954.13122-1-richard.hend=
erson@linaro.org/
>
>
>
> Hi,
>
> This series failed build test on s390x host. Please find the details belo=
w.
>
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> # Testing script will be invoked under the git checkout with
> # HEAD pointing to a commit that has the patches applied on top of "base"
> # branch
> set -e
> CC=3D$HOME/bin/cc
> INSTALL=3D$PWD/install
> BUILD=3D$PWD/build
> mkdir -p $BUILD $INSTALL
> SRC=3D$PWD
> cd $BUILD
> $SRC/configure --cc=3D$CC --prefix=3D$INSTALL
> make -j4
> # XXX: we need reliable clean up
> # make check -j4 V=3D1
> make install
>
> echo
> echo "=3D=3D=3D ENV =3D=3D=3D"
> env
>
> echo
> echo "=3D=3D=3D PACKAGES =3D=3D=3D"
> rpm -qa
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>
>   GEN     ui/input-keymap-qcode-to-atset1.c
>   CC      cs.o
>   CC      utils.o
> cs.c:17:10: fatal error: capstone/capstone.h: No such file or directory
>    17 | #include <capstone/capstone.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> ---
>   CC      /var/tmp/patchew-tester-tmp-c6t41dq_/src/build/slirp/src/socket=
.o
> In file included from utils.h:13,
>                  from utils.c:12:
> cs_priv.h:7:10: fatal error: capstone/capstone.h: No such file or directo=
ry
>     7 | #include <capstone/capstone.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
>
>
> The full log is available at
> http://patchew.org/logs/20190523204954.13122-1-richard.henderson@linaro.o=
rg/testing.s390x/?type=3Dmessage.

I saw this on my laptop (which doesn't have system capstone installed)
as well. Did I imagine there was a patch floating around to deal with
the captone/capstone inconsistency?

--
Alex Benn=C3=A9e

