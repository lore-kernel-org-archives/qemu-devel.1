Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD7CC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 10:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A799421738
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 10:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="O1gUqubW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A799421738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39712 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCMGx-0000W3-RB
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 06:40:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCMGB-0000Eb-Gj
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1hCMG9-0005xL-Ij
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:39:47 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::2]:35365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1hCMG5-0005rT-KI
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554460775;
	s=strato-dkim-0002; d=aepfle.de;
	h=Message-ID:Subject:To:From:Date:X-RZG-CLASS-ID:X-RZG-AUTH:From:
	Subject:Sender;
	bh=uz1saOV920f9bn5MWqeEVmDQLo9MvJ9HXz9ZUME9tPE=;
	b=O1gUqubWK3MClVREi9b18GATOW7ohoxgGLd8jNMElrwnNrhAGwTGw8srtY5FUqAh33
	YKzEyZ5RHIKEzN2nGAPKy3aqd+BkxKUNqMsWxMwihoMPrsjvQQ4qdCLYinMXijALmufY
	0Hwpr30vUaDZ6mdLXYKF/HhMVrGj80pL6QdJSueSBmBIFKeY7HPRF4Pcsd0i0Xun49fz
	00VNnDjjLpeItfHkDqZJW2isjVuE8yTY3prl8uPxn+cvydCc5hQSIZHvY9clYN5Iokpm
	TNqTsD24/S75SJLmssTLv8WBVHgoJNyH8XkeNdMD88IPMlxXEY9bQIOM7EP04zG1gZZv
	lhNg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivsAEtyZCGP8Vn3U6NBQHRrVwM9zJHX/gJPE7W8Q"
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 44.18 AUTH)
	with ESMTPSA id 3086c5v35AdZpHN
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1
	with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate) for <qemu-devel@nongnu.org>;
	Fri, 5 Apr 2019 12:39:35 +0200 (CEST)
Date: Fri, 5 Apr 2019 12:39:28 +0200
From: Olaf Hering <olaf@aepfle.de>
To: <qemu-devel@nongnu.org>
Message-ID: <20190405123928.70da87e2.olaf@aepfle.de>
X-Mailer: Claws Mail 2019.03.13 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/AYpR9aZwhs_17BsV=fNIudv";
	protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 2a01:238:20a:202:5300::2
Subject: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
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
Message-ID: <20190405103928.0vr_fq0Ae8Is5o4UEGL8WzyJP_8ekdWjFaDpIiOrWjw@z>

--Sig_/AYpR9aZwhs_17BsV=fNIudv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

It seems in qemu.git#master the edk2.git submodule is now mandatory.
For me it fails to compile. This is not a new error. It needs to be compile=
d with -fPIC since essentially forever.

But I wonder, why does it fail to compile only for me?!
Example of failure:

 $ grep -h CommonLib.o /dev/shm/*/.build.log=20
[   85s] gcc  -c  -I .. -I ../Include/Common -I ../Include/ -I ../Include/I=
ndustryStandard -I ../Common/ -I .. -I . -I ../Include/X64/  -MD -fshort-wc=
har -fno-strict-aliasing -Wall -Werror -Wno-deprecated-declarations -Wno-st=
ringop-truncation -Wno-restrict -Wno-unused-result -nostdlib -g -O2  Common=
Lib.c -o CommonLib.o
[   89s] ar crs ../libs/libCommon.a BasePeCoff.o BinderFuncs.o CommonLib.o =
Crc32.o Decompress.o EfiCompress.o EfiUtilityMsgs.o FirmwareVolumeBuffer.o =
FvLib.o MemoryFile.o MyAlloc.o OsPath.o ParseGuidedSectionTools.o ParseInf.=
o PeCoffLoaderEx.o SimpleFileParsing.o StringFuncs.o TianoCompress.o PcdVal=
ueCommon.o
[  106s] /usr/lib64/gcc/x86_64-suse-linux/7/../../../../x86_64-suse-linux/b=
in/ld: ../libs/libCommon.a(CommonLib.o): relocation R_X86_64_32 against `.r=
odata.str1.1' can not be used when making a PIE object; recompile with -fPIC
[  106s] /usr/lib64/gcc/x86_64-suse-linux/7/../../../../x86_64-suse-linux/b=
in/ld: ../libs/libCommon.a(CommonLib.o): relocation R_X86_64_32 against `.r=
odata.str1.1' can not be used when making a PIE object; recompile with -fPIC
[  120s] /usr/lib64/gcc/x86_64-suse-linux/7/../../../../x86_64-suse-linux/b=
in/ld: ../libs/libCommon.a(CommonLib.o): relocation R_X86_64_32 against `.r=
odata.str1.1' can not be used when making a PIE object; recompile with -fPIC

What do I need to change in my setup so that -fPIC is not required?

Olaf

--Sig_/AYpR9aZwhs_17BsV=fNIudv
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXKcwYAAKCRBdQqD6ppg2
fur5AJ9MGZtoafXZUTXbNLVTny3ukV+yJgCglJTI8TeRtBuWk5Cv59y64iXjZpY=
=++Fo
-----END PGP SIGNATURE-----

--Sig_/AYpR9aZwhs_17BsV=fNIudv--

