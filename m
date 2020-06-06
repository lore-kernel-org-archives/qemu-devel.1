Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D73DC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:22:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B85A2067B
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="eZ2v6eR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B85A2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jheOr-0006jq-Fs
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 15:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jheKy-0004VY-Sp
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:18:37 -0400
Received: from mout.web.de ([212.227.17.12]:40629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jheKy-0005bY-0m
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591471078;
 bh=pt9EkwFNNdSEgpLYZHULMnvivuY+bmJWAt3j33lN1f4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=eZ2v6eR/9uiUfkwXOhJkOs4fXeraBPUh8KJZW1pYbbsnlO2S8aki6u2pECTDVhKZC
 +zahAa9aZkDipPnYFIGmcjuZX7AAZY3cdfEouxoMQlUxUmk+0fYfR5ipmsZ8gmi3gw
 V3PCImcfDL2xX5EIMKh2S975l6V3IjDVlzP9lkgA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.73]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mg7I1-1jMQYF2ITN-00NQvU; Sat, 06
 Jun 2020 21:17:58 +0200
Date: Sat, 6 Jun 2020 21:17:57 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 2/7] avocado_qemu: Introduce pick_qemu_util to pick qemu
 utility binaries
Message-ID: <3bf59de49c6d97d457e9955efe401335cf28930a.1591456338.git.lukasstraub2@web.de>
In-Reply-To: <cover.1591456338.git.lukasstraub2@web.de>
References: <cover.1591456338.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UOdQJT+xMKOZy/ZGHlT3gE_";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:5v9ACSDUWM+V0dvUq18Xd/bgtoXuTBUBeOwhR5VnaSK1bapmP7i
 U0MVaxTplKQDDUSZQUEErbhuznjFFG83fPFLdODFsZ+TjRR5jJx6eS/4H4D2orEz02MBmri
 4rziNL96p97ITuzAAjl+S27I3wBBmBk3HSbFNNE4+qJINukaJF5vNJKDpvRsJl1mLIfbl97
 xpQDeYTTivyM4kBpl9Zww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EVNUZvtHjJ4=:CUjtx16pwyq4UEU+6HLuVE
 UCZJYmG2Hpd+bhEOm1Fo4QaHq5x4ayaEt/iCtlD23pZbVMlRfCTVGa+ns9id/CGDoGqvEbNrp
 3/+0d4/RVxXJNpAVi05lpKcGwXRTEbeCI3usoSsLlZpocH+v519hmgXH7ER2CrqSAtA9OA1To
 6hdUuoEVJ7kec8k2wMBZn59wRO4BRDRcHmX7OS+FAckHFGfhkZMB8qnLT7KMhjc2bORAdwp7C
 0ZzUpMcXFqa3MwzGW/p7lVDQTBbOL9zbRW450t8P53mxIOL1YdQzb7wepSqkBRvEFaBZnNzmq
 0pCdq0G3+mk8ZEnX/C+rt7xwG5vdZbbR8837ck78ANYatWlXXdeXZUhnFq/cWK1i0sPUcq1+u
 3pfrPBpkk5xu7wE9qi6oENlGGBS+YIF0dKgxPRECCBijLzT4IR1LrUEqEIqihteE+9f5/3w6U
 4SEO2YFkE7lbw52t7Vd1ONVltYahljSsIyYqaYkxLW9NesqMtkBj+kWFDRgObZ+nxk8pDC1WV
 bcVuB/lxzgdnz1dafiNgsh7reXCqTJeA7vN2A5pfv21GM46Mitm3kgDwFu0zGn84FMi2iY+cp
 M1luwT/snv+PIasbMGWqM6DEBUw4mNS7xD4VqMB9/HPoZhcK7DNO8ybWijpcNNm2kOjkL/VPX
 1SJdZ/qENaUCGO98xPt5+GA4Y0Fkc0ADmheDfkcofNs0MWR90/Bv9yr9PVunoyFhvs3O0JdyA
 MEUWjDxwF8MhZhgnMV4NdWyhTfexB+oa+7DpYdES+h4QpWGip59OuJ4OLg0efflRIEgjNeVwa
 /cCw7edl0zJ1XNr6qBcCn0ChddU5IKWcxNl4/glMVx4Svkgjp7zA6SkvKXc+mhooGlyN7CbEG
 rMeUT7H0duiTQvYXXnUJsAsksrtQ+NSoDMrULsgGieuV7LbP1NXgtcxvyM6XZodg5xF6Uu+v/
 gIPvfY1OtGskxUlwuh0+szAvV6IA9U2NmdteeEZgwNj6wCw1QyHIwGDmZA6apsgk3+SmERbI7
 63KV35h02PQc6PAqWFMkNHGOZ/jw/OOlGz+0hI3Ig4UNrXYZ3RFoTcxY85DKzDFrFKYnTK9gF
 t8P/Dg9+fg3NL9Y4rVwfVwogsydS1KJi4vjPxNr3vJ2zU7sNxUdhyvJQFhEkpVhIijnN6ZcFb
 alnJnN/EFpfYQYx+Cs8tFTuybxYq9YBp0f75GRnh5thHRCenHNshvX2kbrl28Lng9JHQhbsU/
 ZY/DMae0CBlBrVJUv
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 15:18:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--Sig_/UOdQJT+xMKOZy/ZGHlT3gE_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

This introduces a generic function to pick qemu utility binaries
from the build dir, system or via test parameter.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 tests/acceptance/avocado_qemu/__init__.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/a=
vocado_qemu/__init__.py
index 59e7b4f763..d0529dca6c 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -15,6 +15,7 @@ import uuid
 import tempfile

 import avocado
+from avocado.utils.path import find_command

 #: The QEMU build root directory.  It may also be the source directory
 #: if building from the source dir, but it's safer to use BUILD_DIR for
@@ -144,6 +145,20 @@ def exec_command_and_wait_for_pattern(test, command,
     _console_interaction(test, success_message, failure_message, command +=
 '\r')

 class Test(avocado.Test):
+    def pick_qemu_util(self, util):
+        default =3D os.path.join(BUILD_DIR, util)
+        if not os.path.exists(default):
+            default =3D find_command(default, False)
+            if not default:
+                default =3D None
+
+        ret =3D self.params.get(util, default=3Ddefault)
+
+        if ret is None:
+            self.cancel("Could not find \"%s\"" % util)
+
+        return ret
+
     def _get_unique_tag_val(self, tag_name):
         """
         Gets a tag value, if unique for a key
--
2.20.1


--Sig_/UOdQJT+xMKOZy/ZGHlT3gE_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7b6+UACgkQNasLKJxd
slhifA//Wf3rog2ZIq9cL4AlOFMW/uc8kWSEhboFwjZqtOPJ5qBsj82PAC/oexJW
17THcdu4bFdO/GYsrqjfoWofg6ATSpwK8hBqIWaV0L7kFl5ARF+f05TgKGiW2rdh
mgyh7twU6d6+jFF2RO6MR4WbDhgDlKrVQYiOg+7OVd7uBXjQ+AcOw13LshZ90L7J
JuBgknMkVcf6D9qiBW2G7KsILAPUqw61qgFsaphv9ivCQYFWHmGAi3j6GBXWWi0T
MmLJ5hqdP6pAMWdWB6DLSxzeevumKcKZSDIYSs5UkKiBLbPMdWxwWSPqe7tvMNkv
ljhVFh4y7xn7fhCNtp1eRgHX9qmD8gE95bsGGPJ+1ka+uwVOESKXdb+Kzu8Kt9R4
SXCyFo9XtuuzIjNTpkEZEEnbfQg2LrqFSSTnJo3OcZnUCUyuVv7pxy1p3ZH828oe
91HCM9pH/FouF2f6/S9nY36XvsJA4wiQt2cFYvXsgLatVmE1YJWU3bvKuzQTNEN3
3Lgqc2gEnIKuU+8IAJf5UW2BkDAnOAyICVvbldL4S7Ndmfq2J6jPe9AhOljdta1U
utpwq83oLVYkCZFQhU16hmG0t+AFVE39lbLw2DLuuSdwyOBzV7HtqTPMYze0ErsV
K/oMfmc5+z7dtKivZoSVp/E2v7p6De2Gkaftj92IGt6AP5XXbgQ=
=tims
-----END PGP SIGNATURE-----

--Sig_/UOdQJT+xMKOZy/ZGHlT3gE_--

