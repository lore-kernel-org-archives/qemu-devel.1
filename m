Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566D4C282DC
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 20:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9922791F
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 20:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJDgFp7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9922791F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52776 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXXIp-0007Nb-Tr
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 16:42:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1hXXGt-0005TX-Ga
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 16:40:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1hXXFZ-0002kl-Mb
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 16:38:42 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c]:43479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1hXXFZ-0002hx-FZ
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 16:38:41 -0400
Received: by mail-lj1-x22c.google.com with SMTP id 16so662038ljv.10
	for <qemu-devel@nongnu.org>; Sun, 02 Jun 2019 13:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:user-agent:mime-version
	:content-transfer-encoding:content-disposition:message-id;
	bh=Dl96BWL/Mw+r/D/fsMaT+TlyKRhXulpzkr8rxu4rphQ=;
	b=lJDgFp7OnKtF1s/ny9nuEHDObectnZmnporWKgux7NoVAuT/WsqXCvAZSvq+tOjo5y
	tcVRFjgiTh3u48zw5BxTCb+O5uzAm14ootNBknWccqxeYVCOoM9ih6PuDCvcWGQilxUy
	zsh4T1UxHYQFVo67nA6IkGGy/V7TX/Pk/As8AjSfqC8EAKkJFvbdirmNrvBxouF+mseS
	SzQZ5Ca2eurgdjBZe2yuhu3IkHXuVK+z7F8uks6v4JnHiNlTi/hySGFwiTCVfqVYmG7u
	c5xJpCtqHzx4/gWBDaghZlCdtAzRroIfoqR6Ik0XZj2E6mSESVzpQZde5b6MjFvpS7bp
	zowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:user-agent:mime-version
	:content-transfer-encoding:content-disposition:message-id;
	bh=Dl96BWL/Mw+r/D/fsMaT+TlyKRhXulpzkr8rxu4rphQ=;
	b=WHXgN3z13qFPeduqBnC1Z7lILYSU5uFeTSeRB6vdARBci1ECHm9HdI6RvyWx5+dCzp
	fIataipSUtXeG1tzJKvdIQXatG/UNdvE+myUK7FCeyAenuazPfeiN7jNN0FPB9OHNt+u
	fVPp9QE+h0EPUOodk16Z+leQuZNxCAqVrtEHCM8T4nTE8r3JZJqJyrudwVWAv/YRii6m
	SBiyjTLp1+NhXNowaAG9yp2KMbI3UKwD/OwpmlnAvVWiG3PGgIR0M1x4mNzv+RQ+xHgr
	lWG/CremZzDrrguLUFShwjl/jo2Hb0iv53gM93aVkioNXy0BEBycaWbkemNgnL4Rwxl/
	IirQ==
X-Gm-Message-State: APjAAAVVDFJy5E0tk6z4qJL4fc2rZa+lG0efRfSE7S0H+O0+cpVCUHEx
	dppJCMD2AbBKlOuYFdljT6A=
X-Google-Smtp-Source: APXvYqzFW6hj/P12MRa8Mzc2ZfL6cwGL2WmTEyLvPv09/QeCtLKL8oVNLFiWTWnbhgIOBtF7etMS7g==
X-Received: by 2002:a2e:9cd5:: with SMTP id g21mr10650113ljj.39.1559507917292; 
	Sun, 02 Jun 2019 13:38:37 -0700 (PDT)
Received: from [192.168.1.108] ([176.116.252.109])
	by smtp.gmail.com with ESMTPSA id 18sm371123ljw.27.2019.06.02.13.38.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 02 Jun 2019 13:38:34 -0700 (PDT)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
To: alex.bennee@linaro.org,
 qemu-devel@nongnu.org
Date: Sun, 2 Jun 2019 23:30:33 +0300
User-Agent: KMail/1.9.10
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201906022330.33888.randrianasulu@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::22c
Subject: Re: [Qemu-devel] "accel/tcg: demacro cputlb" break
 qemu-system-x86_64
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Could you run:

>  make check-tcg

> And report which tests (if any) fail?

Unfortunately, test was SKIPped:

make check-tcg
make[1]: =C2=F5=EE=E4 =E2 =EA=E0=F2=E0=EB=EE=E3 `/dev/shm/qemu/slirp'
make[1]: =D6=E5=EB=FC `all' =ED=E5 =F2=F0=E5=E1=F3=E5=F2 =E2=FB=EF=EE=EB=ED=
=E5=ED=E8=FF =EA=EE=EC=E0=ED=E4.
make[1]: =C2=FB=F5=EE=E4 =E8=E7 =EA=E0=F2=E0=EB=EE=E3=E0 `/dev/shm/qemu/sli=
rp'
        CHK version_gen.h
  BUILD   TCG tests for x86_64-softmmu
  BUILD   x86_64 guest-tests SKIPPED
  RUN     TCG tests for x86_64-softmmu
  RUN     tests for x86_64 SKIPPED

