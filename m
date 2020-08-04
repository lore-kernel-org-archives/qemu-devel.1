Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAA4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 11:11:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC937206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 11:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="bdrWX1B+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC937206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2uqW-0002ZY-LC
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 07:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2uTy-00014q-Ut
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:47:46 -0400
Received: from mout.web.de ([212.227.15.3]:36633)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2uTx-0003ct-7F
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596538041;
 bh=na+x7nHp2V2qblH5lygjvDmxBhzSJNmnFZ514Gu4Kpw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=bdrWX1B+hbV3FoGe2sCjHFsVLW5UDqYjRfJwRQsgA9Uo0YFdce5RgtRgxWIY3Ssp0
 z6WyByS8jop3EVuIwZXp5O1AeoE7YSrR1PTcI4blnH9Fc56OFQLLPbfhuEKZ1Rb66f
 8BC56wpZPUrqopbORe7GwV0Y3Jt7C0m6PSgHRUYU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.220]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MdLYB-1kKr8N3J4N-00ITyP; Tue, 04
 Aug 2020 12:47:20 +0200
Date: Tue, 4 Aug 2020 12:47:17 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v3 7/7] MAINTAINERS: Add myself as maintainer for COLO
 resource agent
Message-ID: <868acf5fff4f0f9334fd163794f83132be52f538.1596536719.git.lukasstraub2@web.de>
In-Reply-To: <cover.1596536719.git.lukasstraub2@web.de>
References: <cover.1596536719.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5IwX2e/tCFoeBM9CN4NqZL=";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:qtitU0WDqlkMBgKbjFdRwstfT+5p7pgwtpxZiTbfLQIFRNSz4GD
 s1156DHGsvu/4wwZDKjqfQbOGq6aQYC9gbZmCV29j0H+wmvalyI1TlB9h9Fp+OepPkIVZVP
 rdvB51xpFT6AhW4XsuSYQAoXCDXjegv5lYNLy6xfNYqVM7m+cm+554/folZFhVUEClOsIWw
 qGp2XhENc3QQLCsO6RiKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fUSBl0z9CWw=:MBOquASC8/Om6Ih/67JQvE
 0R0B+mwM8/FaElF1YOxhifObulm1wcntQOh2ODyEsICeelAjJU+ETCJTpRjh4kkat60+bfaAW
 VuU6A6JLBaVNQDo4nicvzeg9GdSZpiAavdwmcnajw4m7xCX6xqGc/lkxAKQaptSg8GsnyHlWv
 kKw5PqClYiH8sWrM8U33To8NZXg6FWjkrlMiyCHtru7zNVt90aEz3vzGeQiqqvcsIClxLVe1x
 ewSBuETHq1w7dddX3xUBSUMBtQlUNIji2qDVEnXB3MGg36SRYXDJpUdTCfMhnuGtoQ5yFuv+K
 NPVmzqSHnfSqzVgllTIGZ0RHPxg8qpSKRkAF3inowQmPu/bQCPdbz96bn8esyno3Jbg19nmpw
 bf3y0KIOWRfm//ZgcsFKzgdq+nJMHKsPhrpQDEx4PMdHmWfhXqQlEpL5Nco2G21OEjDbYQ4+X
 QfCjkSSvAbEbT5ntlIMddqAvDR4XOm2OKv2Gh2tIGv6jgZ2utPwHiugtBq/YGSKxHQr5XUYyQ
 Dip6+BXvQhJ9sstTwMIxNgA/c1REwO/0P2JaSkNUbBvjkiKTSWth3V1l6TkUGmvTNR81dD2GT
 8QqgdtsqizyXlEuP52mV70j6Reg9rmNV0GkCMybC8nE5+wK08W8fRDrhhbJw1CC1g04T6bbdv
 MHOcTl42Ieel/cEqwd2GNaiojbtCXBNQFdgLIcD/TGWUVP8sjUkv+nokweL3VVAbTLgwzqvUo
 gZhBuZR8KT3foGnXhuQFcdRwPo7wnYzaWyrK0A/i4WWBC+mHavHOFFPdkH+gjvMxylEB1wrin
 U1fBRPa/Ix+aii/EYjt7skvFVVwo46fsgGAA3iqLcmEOVBcGAZd1w8wyTMXiWDflor0h8GrQN
 fhMt7zoE1J5v/r0aCOluMgCRhtW3uEO1n4XMZ8UwfBf4lxRbSMCJ+RP0bobWu4Vca4B0XC5QV
 4ZAj0AEFDBLGZaaxGLM348Jk+HGewt3FjMZvPft+Z2XZvupkvD3l4yY02bP/ogbxcNSBcSjJm
 lTGfnLSJToVL+IWEwkh3IT29iLzDKQNm/SJSEzuEeWQO/MI6BQqvFzHd9QUWfiws566Z2gIg/
 8NWzk8Ikgb06JYqXHbDhcQDwR07LSJkI3L7UJ7jbiMhW9HQubi8XWcdMvjsZv2MFlFWR4wuA5
 bYiXvQKwx65XcewaD8zcDkOOMikxJ2pgKSQ4LXqyW5X4E4Hqw+S8t4x2LT+jLwJfa+MMthREG
 n0hdnztJK18pc/iYAM/fFdNif2rdoiJ5VWlJIXw==
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 06:47:13
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

--Sig_/5IwX2e/tCFoeBM9CN4NqZL=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

While I'm not going to have much time for this, I'll still
try to test and review patches.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0886eb3d2b..02090a728b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2631,6 +2631,12 @@ F: net/colo*
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

--Sig_/5IwX2e/tCFoeBM9CN4NqZL=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8pPLUACgkQNasLKJxd
sljQ0g//Y1w4qr6W7jYjZpHB41tg1kAJKAjjhY6MyNc8JLAs5+YOeP9zKLy4Bjga
boDOVa5QrpCladTfwBhYuaAabhaiOKE1cBYZhilSFEK0a3bCso5/yDpdsMXDwY15
M+I66MSlIIz15r8a3UJfuUxj4nbQJXWvot+G2TGm4utNuvvcRWThqjll3nUGniLe
JXnehm8joXdFXJZ1y48xVj75GI1B0fZ1w6rhzwcrUfFT3IKI1SGzz1YYGk3MRV4b
uZvnMQlYxqfL2GdfdnKAaO7T7qv3hwhnaj10JkzwgpmdAHqcEU9OCf5lvSn8s/Hh
gXvmxWhdAjqOJXaKI8RdlP4kz6OIAkVpcToFRTqC/xAswTq7aRSAqvVrP2Ken0P9
/3LvuTX7FRVHLJD57/5Xa8NYrX5qfvUXXHAVwllutqfidhxACxLB1zlmA4XxO6hg
KoNf1c/BpEg3mrsiioc22rJi3PuN/6O2eIYLekD1QGrAbMCID1/WDsUSKfS3Sldc
6Lk6KCszAmvEKKN7to7KHN5lg+xME6uMHPlLUYD0JglRGIpZb3hnlldi7ZZp1VKw
d3/4cqfhM1rkRC3IKasZeAWpAZaUaSzBGFj2WH4MPacnbrOKalVZNqW6Ms7R69/8
iIjlZJxnFsUXzN53j8fWGTqWkx7z1YKSNWNtKCAgtWOqOQlVb7I=
=tQlR
-----END PGP SIGNATURE-----

--Sig_/5IwX2e/tCFoeBM9CN4NqZL=--

