Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AC5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 663C320738
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="lAJ2Und+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663C320738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2ubZ-0006Gw-FC
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 06:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2uTT-0000pZ-Lw
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:47:15 -0400
Received: from mout.web.de ([212.227.17.12]:44291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2uTR-0003Zf-U4
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596538009;
 bh=qv/5xayjAYXqpeYnwgPYY0OgvSh+N7XscqU3e7q3x5c=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=lAJ2Und+grdyffvxSbOKGq4imtyCr6byGkY+dkmckGNF4IQPh/P+Im+19zC52T67r
 veGF0tckBOMn9AG8oedRT3mlXJ17+ADgsPldV97u+ch+h6ixlCoZ4/AjrMLZjOnfjz
 EoBOk7XHhlTTbKoxH/KDcVIY2/dsHgzjqMjEKbgI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.220]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MgOCo-1kQbkd0sdC-00Nk32; Tue, 04
 Aug 2020 12:46:49 +0200
Date: Tue, 4 Aug 2020 12:46:48 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v3 2/7] avocado_qemu: Introduce pick_qemu_util to pick qemu
 utility binaries
Message-ID: <a61e4eebe323ddfdd7e0a0ee7c52461f2e6a97ab.1596536719.git.lukasstraub2@web.de>
In-Reply-To: <cover.1596536719.git.lukasstraub2@web.de>
References: <cover.1596536719.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yEZ=uCjxRHhoWEs1uasGeqc";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:v+8x6PHYu/0EInerpsZm7Y9E779xUOy0Ra3svE6DvdeH1mfOE4d
 GnMcnp5rn5CXXsFv1giuk/HqdXkQ5Tij1MxSTwaVwZ97VnQe8l4Q2dl3E3I1s+rOvB7knTb
 j3ScdzWCcBwgCLobuDlfiNa3lMHi+ge3s2df6hOOkT/GIFcxrQE2NNc9ui7eUrCjHCRDZsO
 AQlCcD+8ZfvPojCldBdpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+cLejGJF30c=:XDYbSLDZixBctgzeF2i9ty
 38vSjGf6Dg1iAG5L5jrfrhpWD6AvdqxPNO/F4bezq21l5HqNkawEzbjODDFX+PHCGPl3FwJQG
 +mw5I49BcXwuZnX3EGWUK6EJpIz04+JoJUEvvK1DvthbpWXtlVZ8XUEAviseHNRwgjmHPILXh
 uCH66DxcFqv/akE54YZ4Nclw8kAXYl+rZuifG12WBlW3v1ZpyUgQ4Qz9giG4AmG4I6ePRU27O
 uOYCun/JEt1b2CqoZFRdpvD5wU2LSVN+nPQv5wWnmqoDs8cf+0V6EnLtwLTXVdQmy+/SdvXq+
 XXJUuTIBCjXxyftrImrO+Q39eYW3HJd5c6ymgv3nIiaQ7fHxlMh7CfyxBc7qMI65WCBG2XCbk
 ol6h7Nx4XJnxo/vAqOkOnRNNn14wIQ1mUgQFUNRIIukT7pfSrlskeZ+IelRXNcUazCV30Yr/R
 ovR8vAuaDkMlydF6BWwkkSkclxrIWEeo2mXL84Qrs73mxnK/agjL+C38Dz9Qcp5efmN2BTApd
 DIk+O7uHrGd3TEVWAHO6KJZtH0bgdhB7kLSbn8ePMGIGD6Eo6hZWa/hf9Mouyomhfv1j9xVhI
 Q5bAGYZvXwofh8rb1+CwovlmndtjoD5ElLaz2lnfMpyX3LbvFKexipNq+Brm45PK75ZmLN9c5
 LaJuKXl9bJ0oBzBAgzV9QnHoHbHcbXGxrlkWEs6qJ1263m0AEL9GUWrcUdk4iEOr9LsNclmP+
 3wPJxZWFU/QUM/C08OzzjnFKm2hVO6dDmFhn3Ahb/v3qvP+JTPRe2x/OIfAOKoQVehXiqX0sr
 /bbvlBvUTQOZIsocG3nxxXYPuL8W8/zC2ggnyyslhQiPDYkDGuZmSOq0Fkyay60XBEd0vXxgF
 jTL0xiFUgtzDe4tK7/3tSGNWLb9vaQiAPwud0HP+5+u4kjus98+1G0i27o47/zoEJQiG9mYZN
 +9AZ3pi7JZHllkPdIASR1bhMz8FwTC6v4N3vL6Q83LCqJ9OKv+ZROJ/46OFXcaI5Tqs3hnozX
 19Tpb7+bKboF5DwwI7M+bpYm4qincA33UzUDhMOS3RZb75cSCp81QLgMZESHS5tai71YBQTUZ
 8qUMDXiYM1gUZFc1i3OTxGnIUlzHqaqMXidpE12S7+kbATrnFKWS6VWPWKQWx812q3udtNgmK
 3kCPO7c7rbg033FR3oa/BjQR/GsKuDMxFmAllHfcpQXeanC9o7nbtow7Uc7G5MBJoMPcy4qtO
 Vb1BfNXE+TUWltQidqWwc8aSuxpoGl+6QzZJWtw==
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--Sig_/yEZ=uCjxRHhoWEs1uasGeqc
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
index 77d1c1d9ff..fbc47ccb3d 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -15,6 +15,7 @@ import uuid
 import tempfile

 import avocado
+from avocado.utils.path import find_command

 #: The QEMU build root directory.  It may also be the source directory
 #: if building from the source dir, but it's safer to use BUILD_DIR for
@@ -147,6 +148,20 @@ def exec_command_and_wait_for_pattern(test, command,
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


--Sig_/yEZ=uCjxRHhoWEs1uasGeqc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8pPJgACgkQNasLKJxd
slj3ig//bYph2vQwohz2vbXziNs1fMmC0pI1K3Xyc6IIUxbUiXV3FsxBwvV8ztkE
fom7raUqAVbV5Q8CJjXvwartY4xykYvDUE0ZrlHHaWIrRfx6aZoD+DNdVRS6x7S7
md48BwFekjkNEKQge0/k6dUBRWvZTfflIAitCobQ7ro9gPU2JgPlsCbdpEwQojUE
xmPfxV9aDqiwQwnUDmTQnBcfflpojzUVLjRcn9DvP05DPfyxQQggTHUHvaidDktJ
eMIVKc9DrwZTspIAn1YyrE0M48prGx2mc/XGEkYQen5j2PpTIo15HHhblnEvW6ke
5DLf6qYDFMQIXNW3aUC8VMb5KELF7/vz8I626fbDMtbVtv+0nHqPrthWzMXTDoH3
1iB9+ErDNtaAtPYikbcVcZ3+Z6cYMqGEN10tJHwyE+CYsEm8VMDxJA9F2dJJ2GQH
98LYdcA7jfK+4B1WX/5NiTgS3QZAjKqlujSxsr9pJhLpKwu1C9VLg1j5JCiEtbEW
2nAzg5wm/dhziS7kfLxFCoFfImvdtEJaq+ngFTlxKLEI75GexLy53Vbg+pMD7IeZ
62hlS1cT2bEToEzclK82Gs6wFd77EMB4LQYXf2kdnf/A8gT6ASiCHBU7eHH1koA6
Yj0oNj2XIZBv8asphsHuoZFMaSPLLw2IHEAsHVZTBP5bBTI6sCA=
=b5+F
-----END PGP SIGNATURE-----

--Sig_/yEZ=uCjxRHhoWEs1uasGeqc--

