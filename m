Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4CDC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C142067B
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="VHoP9c/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C142067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhej9-0003av-JQ
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 15:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jheLE-0004ov-GA
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:18:56 -0400
Received: from mout.web.de ([212.227.15.3]:45719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jheLD-0005gC-BL
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591471102;
 bh=PCI9v1TIN9fslp7TWYM5Z1p4UyDjMOCaUMLRPqGUwLk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=VHoP9c/EwsQbShI2m/encPh+84vTxDZMRIQqpXxVdROERLpBwOiIKvUPoA2UwBRoM
 Trv6a0GUUojazmXKNbLo+WeEq60Ckx1OW0WF94OkMyrmH0RYayDOTTvmz3I2YuGMuf
 mKNatYdq949xAQud/xVtXxyHHSHoE/1wbh8fZEyQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.73]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LbftD-1jE2fW4A6l-00lCC4; Sat, 06
 Jun 2020 21:18:22 +0200
Date: Sat, 6 Jun 2020 21:18:20 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 7/7] MAINTAINERS: Add myself as maintainer for COLO
 resource agent
Message-ID: <daf68f77ba82cdaf8603de61bb0fdc0830f6c094.1591456338.git.lukasstraub2@web.de>
In-Reply-To: <cover.1591456338.git.lukasstraub2@web.de>
References: <cover.1591456338.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2QZByna4AgwUQHdn4./osFb";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:2OeJiL3BWZAPzUk9ak7vxY4H/J9dGRdDz/EsfDEBVqf9t72Yzia
 P6x/UzKSYnTMQ+flavZ78Mw8gUcenfkboNLPOZ4+llk4koabHkJDi+ykexoG5sbneNgbFYW
 inyGCroKvQX5ZuapNikwbrB0n3Dbp+GCqGbuWSjJspt5rJ1zo75Y1dxcysiRTElOFAflh9O
 IeEvxzFIRS0X6NdOFo/Tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BN8Za0EJlNM=:4CoCiVv7Oy66dS5ZlZkJBv
 s43E37qnbvsgOyiLzrZeiZWCjU6M2m+VysykOG0nU03WbvI+RVLrcmrSgwuVT0BPa4DlQ+hLS
 QPUA8L0u/ivUQ+XQd9Vrn3SmdSszi1+AAATWW2lz4rW9RiXlYJjvEjgWlpf1qycEuGlBHHbZN
 te1rSa+Jv4XrJOOrTJRJfsIzzn5nR72Bgb/Njr0LrqSfvLFaHmd+N91dHYeLZc0xbHGgrF4Ax
 w2EHMpLqlg1m1bUvVurEFwjsZFiEDsk2s/DpCa2DLiwjd/1TpyKg3ngbS8Ge3MZ414tjujDJD
 CDFE35GEXtkPluL464ubm148mTu+b+OBAnvrZ+sAt56UnKH22hwHb693LIUYP4X4rSKdyLRRo
 JaH4idPzwRdVSqV5eduag63Ybmv/f3MQ+titnUWFWBJxwgDxii4RucCqk8CEHpXnC+0PiQHt+
 L/JI7c8WIPpZXTUDfspOrYGUxsWKjQ8o/uPsub4m2wo3FGjcPIBLTKSJUK0a0W+kXNGY7FswG
 2ChuCyu58b4PMqBSOQxSmO8dKdTC4uW9uGuGz2fNjplYFLmUYL+Ufee7kLxRHdQg/r5nVMvfs
 N8N8dHlr56rGn/F4JgIC48KXL7zLk/fZO6SANu45Fjx4M75/aDrOcPHE9MdveMT+0NxdVNdl5
 bQyAaIpHm1uRJj9daSEnYIg5B0QwKbPJ6pxBZLizJrAyuSITCOqZLzEcTDwjtjIKoXNXoLEX9
 KtoPNMBvNw/XLlfgEZ8lhock2//7mQOYAJ0tSZcf49JqNQDjebBusMKoMYxIB+5dBShs0zEOZ
 lZyIY2YLoabTKWHMQmSc6MMsqhRqAbO48W476eA8Ekr8mPRm0RXJ3KhvZD74yJAbB5Q7rOymD
 KQU5v0zbnTDNPpFsoEr4K+XH1fJ4EeOEteJKAt//dRQk0ialWHWsYRXZbSu5E4cvr3qfXYM5F
 Rz9Z9xVCmRZQ5txg81VzCYeS94KE4EDVwOaQTlTxjWRkAa/MwEEzABXbvOYSd58ZVCKdtjSi5
 +fGwnxtp3XoAvOG/cvEiC5eyExgp8Q4bh1oWhxB9iaRrcqEH3SXm+Vsh74q1TXI8n1P4YtzZd
 38IfskUHHwA5YvgQyA0W9FPDBSztG/J0q1pPpU82hRmmn8CJzWgDpD5osCiYlOaH/sC8j7Ac1
 3U/27l7p0bdVBJtmtVy9rxydvue5CGLTEzUVtDEclWp3QrkDNCSk0PjSULtzP1QnKfq2e2s9c
 FDZMUWay9j6l09sIy
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 15:17:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/2QZByna4AgwUQHdn4./osFb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

While I'm not going to have much time for this, I'll still
try to test and review patches.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cbc1fac2b..4c623a96e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2466,6 +2466,12 @@ F: net/colo*
 F: net/filter-rewriter.c
 F: net/filter-mirror.c

+COLO resource agent and testing
+M: Lukas Straub <lukasstraub2@web.de>
+S: Odd fixes
+F: scripts/colo-resource-agent/*
+F: tests/acceptance/colo.py
+
 Record/replay
 M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
 R: Paolo Bonzini <pbonzini@redhat.com>
--
2.20.1

--Sig_/2QZByna4AgwUQHdn4./osFb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7b6/wACgkQNasLKJxd
slgv2g/+KRSPf+RMet1gNF/WR7Y2Bl24twc+JVoGGnvZwJZpqfDb8OCpvLBuLkHp
Dm6FrTQeT90DD0S4+ujjN/Cr6I7jpWAlr+fQylRZ5nbwSwgYi/qe/ONHTcP3GWNe
4g7VHZ/ZT8cpfdTKovxSGwXDE8rzVH2+yXKVn9AXYbxfHfbCuTQ9cq28klQrGbtt
84eSvURyVUcIuny8HQiHR0uamLeYjInBfSjFCIp5wT6ulISc53eNq3ZYBOAgFVK+
xUtr2Igw8gtvQKLnWs11t4az9uIFmCdb675vsQ740krLCpFKkaScrhoJM20SU1zX
NDwGXzZJ2mAM4dUd/L8IQ2GmjeP9uDC61VT2Deo88nUSN29VVWjP2eefTmZF3+iw
NPxl9lpjMVi66nX1aaIoUTxtPqhwdFic+OofdXvQgS6wX4tZ9i2/O1PAAdUwCw/1
Dchvfn5kL6oKm9k5O2Ddydm8hEf/7LgBXAeaOa+EksSbhY2H/l2r1xVVRQYprFRs
+cSHUiN8t0M8n4Ze2XeaP7mIrWevTNRzdVOs2ulDoKIiH3AzIMs0iCKlyyl7x/f7
/uVIffVmAWft8GM/AguCZlKPkDnDxZZU5h7PJjdyrkyLOgmarkk2l2HknSsWSWHN
tYAAMKwiU4oaJeXTjbAGeJbURR4tmkCPppMGaHpFoEdu+UUjpr0=
=vXPM
-----END PGP SIGNATURE-----

--Sig_/2QZByna4AgwUQHdn4./osFb--

