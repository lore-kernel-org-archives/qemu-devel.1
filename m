Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90998C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 13:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E49D20883
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 13:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kIGO1MpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E49D20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35030 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVc7j-0002Dn-6w
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 09:26:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVc6K-0001Lp-Fe
	for qemu-devel@nongnu.org; Tue, 28 May 2019 09:25:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVc6I-0004NG-IQ
	for qemu-devel@nongnu.org; Tue, 28 May 2019 09:25:12 -0400
Received: from mail-it1-x130.google.com ([2607:f8b0:4864:20::130]:34741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hVc6G-0004He-CU
	for qemu-devel@nongnu.org; Tue, 28 May 2019 09:25:08 -0400
Received: by mail-it1-x130.google.com with SMTP id g23so2663457iti.1
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 06:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=hFz/nPOGe5CRS6k5OCB8Xk7jdiskzPGGDIrr697CiNk=;
	b=kIGO1MpQrZW07B/QLTJ0rPI11azBsXInQKN7VkWfFM7jUQWj11dJS1gbw3LMyerw2U
	p0B6np6JLM+npwlzSjdmIc2eocWWIYjH9Y1+OjCDDh+r+96CKe8Vz+aOmD9vrDku+jvM
	ESTrBiTz7DGY/m4f00U7HzCKVPUFgDcXQjMwK1y5R2Mz7iAQZdPwCB2cNAOpVSx2Q0lE
	z7miaPuvExvDTahfKOEOAeKD4GAgpTTis6G/X64gZayUcZUkFPY1Rxg611FCCkrBLJAJ
	AV6rJS/qxPjR2LdtdLWKPKGwFjumoa+03Uc7piGRBcbE6D3C5PcodHywEv+/Wp9IANHe
	uDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=hFz/nPOGe5CRS6k5OCB8Xk7jdiskzPGGDIrr697CiNk=;
	b=eds+CZv+7yPtz3XEyzuuY8qzLWdYWBCSp4PwY28UG1h3bA0HI1CLwSOqn/uJZ4P3Hn
	3KVu7I1SZvTW/+/1rG9G5EMcX3zVzVaoz8hvinLde5/9ubua8l7GY/lIUATzHzYQmCRs
	ip1fy62slHg0EbNoTeYMIgsDlZqBPDAFh2dF43jhPwI5LQ5rkle3Y8aj/y/esATHS8K3
	HpjIUw+FDxn4s2SZh3gjzpPaispPWAIktX/GYvXTKiY8id96yltjNHsF8ROuK3ZsLLcm
	9MjRvSXljTfAg/UCSht/wfV5OzeMpfr4pHjU+hMh3TuO4K7rgj+9iVl06O+AzsC1QHd/
	2nPA==
X-Gm-Message-State: APjAAAU7VXRPcAaqhMZ4MQ8axA6XWPJqol1l0yPI2W/ayWUHhr2bjJ25
	SPcKcJVvPyYHPAR+Rd80jEPNM5MlJxZOoyjljv8b9A==
X-Google-Smtp-Source: APXvYqwRo6MAFdKSTpZIbI4Lqb7sv+he6Ij8eiMtasDatYjbbpTVL8edz7GUc9qaHvhtLTBdbxhbE26o6Hh7G1tFwCQ=
X-Received: by 2002:a02:bca:: with SMTP id 193mr8512443jad.46.1559049905860;
	Tue, 28 May 2019 06:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190528094953.14898-1-alex.bennee@linaro.org>
In-Reply-To: <20190528094953.14898-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2019 14:24:55 +0100
Message-ID: <CAFEAcA-Cbot1POVcbAzXhaLqNJpi6M_0z18=YoB7vyqY3PekUg@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::130
Subject: Re: [Qemu-devel] [PULL 00/28] testing/next (system tests, docker,
 iotests)
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

On Tue, 28 May 2019 at 10:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit a7b21f6762a2d6ec08106d8a7ccb1182991452=
3f:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.1-p=
ull-request' into staging (2019-05-24 12:47:49 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-next-280519-1
>
> for you to fetch changes up to 4a344d91083e351c1c5ac877c0ab215335a1e23d:
>
>   tests: Run the iotests during "make check" again (2019-05-28 10:28:51 +=
0100)
>
> ----------------------------------------------------------------
> Various testing updates
>
>   - semihosting re-factor (used in system tests)
>   - aarch64 and alpha system tests
>   - editorconfig tweak for .S
>   - some docker image updates
>   - iotests clean-up and make check inclusion
>

Hi; this fails 'make check' on the clang sanitiser build for Linux x86-64.
It looks like the code in qemu-imo-cmds.c is incorrectly doing
a division-by-zero if the operation it is reporting on took
less than a second...

make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/clang=
'
/home/petmay01/linaro/qemu-for-merges/tests/check-block.sh
  TEST    iotest-qcow2: 001
  TEST    iotest-qcow2: 002
  TEST    iotest-qcow2: 003
  TEST    iotest-qcow2: 004
  TEST    iotest-qcow2: 005
  TEST    iotest-qcow2: 007
  TEST    iotest-qcow2: 008
  TEST    iotest-qcow2: 009
  TEST    iotest-qcow2: 010
  TEST    iotest-qcow2: 011
  TEST    iotest-qcow2: 012
--- /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/013.out
 2014-12-15 11:11:04.234972929 +0000
+++ /home/petmay01/linaro/qemu-for-merges/build/clang/tests/qemu-iotests/01=
3.out.bad
   2019-05-28 14:06:57.827692927 +010
0
@@ -17596,6 +17596,7 @@

 With offset 0:
 =3D=3D=3D IO: pattern 0
+/home/petmay01/linaro/qemu-for-merges/qemu-io-cmds.c:264:18: runtime
error: division by zero
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 4096/4096 bytes at offset 4096
@@ -21994,6 +21995,7 @@
 No errors were found on the image.
 With offset 4294967296:
 =3D=3D=3D IO: pattern 0
+/home/petmay01/linaro/qemu-for-merges/qemu-io-cmds.c:264:18: runtime
error: division by zero
 read 4096/4096 bytes at offset 4294967296
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 4096/4096 bytes at offset 4294971392
  TEST    iotest-qcow2: 013 [fail]
QEMU          --
"/home/petmay01/linaro/qemu-for-merges/build/clang/tests/qemu-iotests/../..=
/x86_64-softmmu/qemu-system-x8
6_64" -nodefaults -machine accel=3Dqtest
QEMU_IMG      --
"/home/petmay01/linaro/qemu-for-merges/build/clang/tests/qemu-iotests/../..=
/qemu-img"
QEMU_IO       --
"/home/petmay01/linaro/qemu-for-merges/build/clang/tests/qemu-iotests/../..=
/qemu-io"
 --cache writeback -
f qcow2
QEMU_NBD      --
"/home/petmay01/linaro/qemu-for-merges/build/clang/tests/qemu-iotests/../..=
/qemu-nbd"
IMGFMT        -- qcow2 (compat=3D1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 e104462 4.15.0-48-generic
TEST_DIR      --
/home/petmay01/linaro/qemu-for-merges/build/clang/tests/qemu-iotests/scratc=
h
SOCKET_SCM_HELPER --
/home/petmay01/linaro/qemu-for-merges/build/clang/tests/qemu-iotests/socket=
_scm_helper

--- /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/013.out
 2014-12-15 11:11:04.234972929 +0000
+++ /home/petmay01/linaro/qemu-for-merges/build/clang/tests/qemu-iotests/01=
3.out.bad
   2019-05-28 14:06:57.827692927 +0100
@@ -17596,6 +17596,7 @@

 With offset 0:
 =3D=3D=3D IO: pattern 0
+/home/petmay01/linaro/qemu-for-merges/qemu-io-cmds.c:264:18: runtime
error: division by zero
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 4096/4096 bytes at offset 4096
@@ -21994,6 +21995,7 @@
 No errors were found on the image.
 With offset 4294967296:
 =3D=3D=3D IO: pattern 0
+/home/petmay01/linaro/qemu-for-merges/qemu-io-cmds.c:264:18: runtime
error: division by zero
 read 4096/4096 bytes at offset 4294967296
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 4096/4096 bytes at offset 4294971392

thanks
-- PMM

