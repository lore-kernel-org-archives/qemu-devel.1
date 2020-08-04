Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CF3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B281D2070A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="hAczr/Xk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B281D2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2uWM-0002rC-PM
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 06:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2uTP-0000oo-Cc
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:47:11 -0400
Received: from mout.web.de ([212.227.17.12]:33591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2uTN-0003ZR-CR
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596537999;
 bh=oyV8yrb/5yR5cpKkH5B0b+l3XhG0PKQ13nr9iKn9EtE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=hAczr/Xkoxp7JIxPIJ8eurCZ1LKlmLcZarjxg+QsrnFS5T4/bi3RjbV2w4R/9ezA+
 EoqufmHaWrk+hmP5Q9l9dgWojZyBPEQ1U21q2k3Pt/Xq/RsKwvdkJ7oTREsLirhrbV
 eAawucp7e+FehpEakAABbFYiAUaJb6NXOgk0AW4E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.220]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MhDgb-1kOgc22eFV-00MMIC; Tue, 04
 Aug 2020 12:46:39 +0200
Date: Tue, 4 Aug 2020 12:46:29 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v3 0/7] colo: Introduce resource agent and test suite/CI
Message-ID: <cover.1596536719.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fhjTU9R9gszSAyH0lA3LQ3h";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:7Re61OlpHGv02HNM7bWCHyyyMTTqhFnd2QLNz/KZ8OjO+3soouC
 wK/7aB3wygYWq3pzz5cfK8/M85aYsFYg1VuqSnDmCCV2MqNIiDcRSJI6KWLhcNbPAgoCY+n
 L89sTYQ8MZDsXwxjKI2Ux5pIrjlQIOm577dRwAMyDsyPP28Che6opV1WQudprvEUr3+Y6yW
 IP5vQPWytwr0VqGIC5Dpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c1lpdK3Q7v8=:w3xeFrtImH5wwfGrbCD0WI
 YxBZ8yfC+v0mjrDi8YaFvieherstF5iJ2AUaumtgQ/D//CC/EAvixGYl2FYkLTNJqKt/ft/hZ
 pKexFTYUTqydGmR5W0kwP/e45EMMkUfip7+AUbqm36sgx4sNjj+c5PgZnR/ty/HUlZUObq8Fr
 iEEokm27N+2KjX+aGJmHFk8llq7q//Lt40yjDXNqUvnKU4V03dzi2q0ZY1DXzhmXfrWnTk67d
 7fEd6k6K2Tw8OToRuyVQ12+mnfoEP6CkYPiMEinTZmUOJHxeWC2w+GDJ8462qqQCO8omaGjvc
 eYMLI6wsHWes85TNbqw7wqWUQQniGbqUO+A6aU/DrgOweiIp7SbG3NX05w8hmStP095HtDMYM
 ADYvV3t3tQ8w+EORhi8zfMKOMBfK+kh9ZnzWDq44g0zGvQujfGTgcuTfnv5q497hfPrco32zm
 GsgpLsGAUClUpPJEZgBAMZjQ+5y6VSczqkeSxkcJbI4prz1RQCEEWlwnTMpz9U4ETAT8OuR+I
 j5nzjnZc8o4lJL+yIB+9kPHDdbD0m1kJMYOJ/TupFqVJVTT2hwsscUHn+boCNLjvIOCjOjQW+
 or5TL+EqlgEhvcEoyS82A2QR5RBLFpbQB00nsLNJLRGmeam/lMBakuF1BuUQkPpMFAu99bWDi
 amuXJW2pums+SNFpP01L6iMEf77BV2PoTwcvQ/k8QzJRAz7GfC4qNOaNfYoHmVqmc5EWEqxdQ
 2mUMJ62Sr0NIdWigHL5DHnNXwdoAZut43jGI4gRraAUyVT/V2c2RWKEX5zFBSvvKjIHGSUQfv
 cRUZuWLZjB+cF2F6YZxBFAVWDBItqWziQoxx9TMPMM6tq1K9v8t6GTFL+C6f32wJewdrin+9e
 FlR6OJfwiOZL4EAJqN1e0nsDlnWA248wOvly4N0ioCD367e0TwTlxA7WvVtB9Dn5taqvp392A
 aAsprVkRiX0v4tadvrOyfNHGfAYoMTjE8OcVXl0Fy3225WTnXXfxKp2FNMTdCQZ90KjdaWB2W
 scBz2N722uYxCbmDrZgzv2QvHtqMOuVwx0NofRNw3LyP0DzxOJygdkBn5zT5uMKco4tLBbf54
 u+NyE7CdvAurSQTOie5XFvUgtdqaHD/xyS+Rbi4RnPkCVMGzjvhk1qmgsz91ea9c0g+K3GNRM
 pswPUFElB09lbYxxhnphUQAUOG1nrToKvotSGIY0bQ0KDgPFJEspKvYuzUoT58HVT0tuGAhHB
 07Kzcq4G1X27yWZeaF7mPCHBbLzCgPReKoMxnfQ==
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 06:47:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

--Sig_/fhjTU9R9gszSAyH0lA3LQ3h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
So here is v3. Patch 1 can already be merged independently of the others.
Please review.

Regards,
Lukas Straub

Based-on: <cover.1596528468.git.lukasstraub2@web.de>
"Introduce 'yank' oob qmp command to recover from hanging qemu"

Changes:

v3:
 -resource-agent: Don't determine local qemu state by remote master-score, =
query
  directly via qmp instead
 -resource-agent: Add max_queue_size parameter for colo-compare
 -resource-agent: Fix monitor action on secondary returning error during
  clean shutdown
 -resource-agent: Fix stop action setting master-score to 0 on primary on
  clean shutdown

v2:
 -use new yank api
 -drop disk_size parameter
 -introduce pick_qemu_util function and use it

Overview:

Hello Everyone,
These patches introduce a resource agent for fully automatic management of =
colo
and a test suite building upon the resource agent to extensively test colo.

Test suite features:
-Tests failover with peer crashing and hanging and failover during checkpoi=
nt
-Tests network using ssh and iperf3
-Quick test requires no special configuration
-Network test for testing colo-compare
-Stress test: failover all the time with network load

Resource agent features:
-Fully automatic management of colo
-Handles many failures: hanging/crashing qemu, replication error, disk erro=
r, ...
-Recovers from hanging qemu by using the "yank" oob command
-Tracks which node has up-to-date data
-Works well in clusters with more than 2 nodes

Run times on my laptop:
Quick test: 200s
Network test: 800s (tagged as slow)
Stress test: 1300s (tagged as slow)

For the last two tests, the test suite needs access to a network bridge to
properly test the network, so some parameters need to be given to the test
run. See tests/acceptance/colo.py for more information.

Regards,
Lukas Straub

Lukas Straub (7):
  block/quorum.c: stable children names
  avocado_qemu: Introduce pick_qemu_util to pick qemu utility binaries
  boot_linux.py: Use pick_qemu_util
  colo: Introduce resource agent
  colo: Introduce high-level test suite
  configure,Makefile: Install colo resource-agent
  MAINTAINERS: Add myself as maintainer for COLO resource agent

 MAINTAINERS                               |    6 +
 Makefile                                  |    5 +
 block/quorum.c                            |   20 +-
 configure                                 |   10 +
 scripts/colo-resource-agent/colo          | 1501 +++++++++++++++++++++
 scripts/colo-resource-agent/crm_master    |   44 +
 scripts/colo-resource-agent/crm_resource  |   12 +
 tests/acceptance/avocado_qemu/__init__.py |   15 +
 tests/acceptance/boot_linux.py            |   11 +-
 tests/acceptance/colo.py                  |  677 ++++++++++
 10 files changed, 2286 insertions(+), 15 deletions(-)
 create mode 100755 scripts/colo-resource-agent/colo
 create mode 100755 scripts/colo-resource-agent/crm_master
 create mode 100755 scripts/colo-resource-agent/crm_resource
 create mode 100644 tests/acceptance/colo.py

--
2.20.1

--Sig_/fhjTU9R9gszSAyH0lA3LQ3h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8pPIUACgkQNasLKJxd
slhBxA/+PUIVVV7PhZeb0gKhCgieFA1WHw0sCu2b5U2tOGIn0eOiOjwvrEcwVNr2
QI/KIWIKJgE3+RUsP7dS/1xWyqEMtKnMVuw2NFWGcY+Zh567ZLyFhQjes8ZVQRKp
T4z8HS3V3nBri3F620polTIZJx3pJL2kh6qMgj9WlbsjwRQx9Nk1Usbs96WGr60q
doOSSOP9XEE/VBuSH8vmDZQ+ut+t+iTlIaFLgIhaTZ3WAqikyudqZWgSFTGyx62N
aORpI30GHlndcZJPqGL8u1zii6OZ0a/ovsWwdWsk1l1ouPJt58ednZpH2WVlKuVC
Z9xCv93pg1KSoYVsyIEKJ1CENJufz6+nkgmEHb0Iwk3qfhk1W414PMmdD3q5ai/z
R7UoFbLGQQWRsASvRyTGxmhKl5HZqUhtf24NmhojZc3Lx5rosVzjb2IP4V4JQBbX
BN0/EXIfy9ZudixHri6rpy4EfMUhuc0kG3n8ljbI7fHFO9SpkhyDESTEio9T8ozm
0FCjzp5SIavTi5PBlQ0Uie9VJ3jXr9UrqqVDXH0VN7OzqRXn4y1+NmqF+oK8Uayg
uV0p1pwjl0OC/aqKyTPA1/BdTfvSwojyGPi4jc+u7yNT3k/DLC4PTBdX/CGhBEeM
+Qr9IlxjNlf+USCovfCUUDWzx5YVw+umH6OBS3MBXktqyfk5c54=
=4EgS
-----END PGP SIGNATURE-----

--Sig_/fhjTU9R9gszSAyH0lA3LQ3h--

