Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED4DC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD22024810
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ajUjszch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD22024810
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXqVQ-0002ru-Cl
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 14:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kXqSL-0000VF-VS; Wed, 28 Oct 2020 14:45:59 -0400
Received: from mout.web.de ([217.72.192.78]:37931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kXqSJ-0003NN-G6; Wed, 28 Oct 2020 14:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1603910748;
 bh=NEk33/VRdzWR3gA85uwpaaoNM5m0YixLtMaSx3M2VbQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=ajUjszchan9GfJsXF0r2nQjECDc3m7D2od3h4jmZeLKuItB3O3mHIKBVbLteXCwxR
 LDJzGInFRIEyECeD3EZoSuqDH7fP0GOvtZSD9qwwy8J/rZAc4cO4OpwXHsQGsWLF0Z
 9KjJqj0FNYBL7btIQTt67wJPi+ZtW76E7wHXFpM0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.124]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MHp8z-1kWSTR0FJt-003cSJ; Wed, 28
 Oct 2020 19:45:48 +0100
Date: Wed, 28 Oct 2020 19:45:46 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v9 8/8] tests/test-char.c: Wait for the chardev to connect
 in char_socket_client_dupid_test
Message-ID: <3428deda3f07bbaa1a0d98424416e144a9d57a6d.1603909658.git.lukasstraub2@web.de>
In-Reply-To: <cover.1603909658.git.lukasstraub2@web.de>
References: <cover.1603909658.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jyshal6RFUSLHw.fxdLtHKd";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:8baryHbG1vcAsU50iZfUVX2jYzoFCJo7pOjqgEHSldYVARocB74
 YO61PESS/i7u/0H83F+Hybd8vFjJxSJStdIDXT6Y9C/VuPSW6AcNTcWD2H3xgFa2m5wS1wo
 +0PRutHqgkVDmoU2lPG8DBDqu/KXIX3bkYzqUy03dMMLuzMTD/ThnHrgjZVnEw7BF2Q5IOc
 c99ALh11I3tis2x0RrCYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UKK+M9vx+eI=:nGOfhypLhVdgRu51fKwQnf
 Zv5cgXj5bKLkoQ8cD5NDhzQwF/+MEw5F83xGvrjterdcT9Vgo306ABkxpzMJL5le5L9S+pHOX
 D72nYPjNa67isP0b9JhBx7knUy/S/Mw5KxQZpN++PfeVdd4WeaK5FGexPVA9B2nXeu05kqwKe
 wMqiORumHWrOadlbb6uhYTPCCyl9dW1TYfa5JXWrIrBwiLdMkJBhdzbB00TFWc5IaMeh77LLH
 Oj7t/kogiXmBjlMMMSzNAddpWCSc4trhLGgZuf7UleuKWhYDkjZYc6jsRBJWnu/GSCJfoHjRb
 GkAb44Xy0lTpPlX9GiYG8yIDLoRvGFZpdifCK6yIk93zfdOhKUYVA9i6CMntY666askcg+FgL
 Sz/zIbYCHq3K9yda8GqaB4Dq75fnafP1RUU8pbEEJ34kwx8y1tEuc4IUu5Zrg9zYMFoPjVZu5
 LuuuHllOGztaxnTSSNC3xpxOsHEf/pbzGAhYnvUY9qStZYjmEtC95wDr/9pTPo+P1bx0sj+r8
 xiGMgjHRom0vG72BYYCxOrukEJigtqTccfjaZ22lC8XdFSLUZPL2UlfDYiSNJAumfjpHz6477
 z69IwVUpL+hPrDzBYF5mm5bu55rZpSCoQDQ4ybqXuEWFJKdXTtwkcaot5AQLR4mhlvGIp2oGZ
 xgApCxlGv1TI78RfCWHiubNEUuQLaXdV0qLE/2Ed1SpS73fioSyA/kCB//KuTZ5KK8ame5g1c
 2vl02NXIYafyLOtEVLk3LBLfd0Nze8OWkUXflNCoUgZeSMY9i54A/V9c3HvLXnroVWGD5gbPm
 5s53tMb95eNQ7ma2FEYxqHF6qvNoGt6kckraajMofYvTjwKbhaI4Ym1AKTv88/p1y+mc+dkmT
 i7MHqAIELygTABdNChiA==
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 13:12:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/jyshal6RFUSLHw.fxdLtHKd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

A connecting chardev object has an additional reference by the connecting
thread, so if the chardev is still connecting by the end of the test,
then the chardev object won't be freed. This in turn means that the yank
instance won't be unregistered and when running the next test-case
yank_register_instance will abort, because the yank instance is
already/still registered.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/test-char.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index 9196e566e9..aedb5c9eda 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -937,6 +937,7 @@ static void char_socket_client_dupid_test(gconstpointer=
 opaque)
     g_assert_nonnull(opts);
     chr1 =3D qemu_chr_new_from_opts(opts, NULL, &error_abort);
     g_assert_nonnull(chr1);
+    qemu_chr_wait_connected(chr1, &error_abort);

     chr2 =3D qemu_chr_new_from_opts(opts, NULL, &local_err);
     g_assert_null(chr2);
--
2.20.1

--Sig_/jyshal6RFUSLHw.fxdLtHKd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl+ZvFoACgkQNasLKJxd
sljVkBAAn7sIcmiS3YWlS0XN8NVXmSRSFhvnanNYzGVTx9UqDEqrw+zu/WZTzOjc
ZOdXXzOoh7guUocwR4AB5Xoq7AAjLvnHWMS//tgcQwnHxC9h30k6qXj/wPD+C2zv
4sX+oGnfd1mvnq+SrtQmmr1PdsGxq/H4hj0SCeocRRehZmeqNP55sCXDDDCTsMI6
8lcsqxUdeURc5yTDUU2p6f4KGp46LJWawD0M19jP1luADq8WtDD2A9VBPMIENr+K
bZtx4ve8crqh07+PM932JCULkOMi9K0uwSP4pjB9auyO74EbKrLSnPCIbeF2c89A
l5PFw1HM6hw7KkEu9IuceA/i6llv+MO1NI3jPekJIt7UFjAImRavJdOx/nlqMkN4
eSDM4WpzkRU/DcOZOUTvbtFzcksOvkHecAciw8IkMn1FJAJ+HYkm+GTKa+TxDgT5
mB00HcdJ/hqH/fPdbBJAnO8uLloLOJt6ORk28DVMDRvOuRSz5zTVOmGcQe2NoD+6
kYWyyud8fQ5OyRhzEHZCKaeE11eJ60pf0ErmXLjSiYdZZHkGjqts228eGvLBTlIv
NsIGZLGmj0ltdzouFgwC9mEir14/tVx1VgpCj3EmKX/8V8Bn5XQGByf4viheOsI3
y9NtenIeimi4CDM1If0+sqGlh84Q9CftVHVplvCdIuBqYH13wBU=
=o3I2
-----END PGP SIGNATURE-----

--Sig_/jyshal6RFUSLHw.fxdLtHKd--

