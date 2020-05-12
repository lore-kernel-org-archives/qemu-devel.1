Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B424AC54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84707206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84707206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYQlE-0000dN-Ow
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 04:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.pour@hetzner.com>)
 id 1jYQis-0005BT-Dw; Tue, 12 May 2020 04:57:10 -0400
Received: from mail.hetzner.company ([2a01:4f8:d0a:203a::1]:39392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.pour@hetzner.com>)
 id 1jYQip-0004Xs-37; Tue, 12 May 2020 04:57:08 -0400
Received: from [88.198.139.25] (helo=[10.17.32.77])
 by mail.hetzner.company with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.89) (envelope-from <raphael.pour@hetzner.com>)
 id 1jYQih-0008VZ-5I; Tue, 12 May 2020 10:56:59 +0200
From: Raphael Pour <raphael.pour@hetzner.com>
Autocrypt: addr=raphael.pour@hetzner.com; keydata=
 mDMEXmXjyxYJKwYBBAHaRw8BAQdAtiEYnlLIuIUjvvqOH//nEbhrxSa54ZyAl7Iel403QaW0
 J1JhcGhhZWwgUG91ciA8cmFwaGFlbC5wb3VyQGhldHpuZXIuY29tPoiWBBMWCAA+FiEEvj4O
 DnHb6pxm/uWJzbHrt4XF634FAl5l48sCGwMFCQlmAYAFCwkIBwIGFQoJCAsCBBYCAwECHgEC
 F4AACgkQzbHrt4XF635TcwD+NEMqL1HZPHP/WRsYujCDtqt0p+7uxGcpvzv//AjqMZ0A+wUh
 0bOYYNdlXWNMMNLA88SsAT2mxAfD+F/paVmLpdoLuDgEXmXjyxIKKwYBBAGXVQEFAQEHQB0z
 JYP6jtTj989IJL1vguinsiIxia5fkW83OB1+Bb4QAwEIB4h+BBgWCAAmFiEEvj4ODnHb6pxm
 /uWJzbHrt4XF634FAl5l48sCGwwFCQlmAYAACgkQzbHrt4XF6372LgEAi3qfceU+R53Ehg/Y
 SSHV4wg+zfPwrD6ylEg/xKabYDcBALrD0E3YX458RPjLIOC8H0u0rcFIvBqNYx/kGaMEmbEG
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu-nbd: Close inherited stderr
Message-ID: <ac17fad1-baf1-75ad-843d-cab8d17f1b2e@hetzner.com>
Date: Tue, 12 May 2020 10:56:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="iIW4pD4LD2mH6V1RCfQvjB97TZmSo54io"
X-Authenticated-Sender: raphael.pour@hetzner.com
Received-SPF: pass client-ip=2a01:4f8:d0a:203a::1;
 envelope-from=raphael.pour@hetzner.com; helo=mail.hetzner.company
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iIW4pD4LD2mH6V1RCfQvjB97TZmSo54io
Content-Type: multipart/mixed; boundary="HYWvrtjcfB1Q8MJlYLuDvgyeGulioOZqu"

--HYWvrtjcfB1Q8MJlYLuDvgyeGulioOZqu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello,

after e6df58a5, the inherited stderr 'old_stderr' won't get closed
anymore if 'fork_process' is false. This causes other processes relying
on EOF to infinitely block or crash.

=46rom 47ab9b517038d13117876a8bb3ef45c53d7f2f9e Mon Sep 17 00:00:00 2001
From: "Raphael Pour" <raphael.pour@hetzner.com>
Date: Tue, 12 May 2020 10:18:44 +0200
Subject: [PATCH] qemu-nbd: Close inherited stderr

Close inherited stderr of the parent if fork_process is false.
Otherwise no one will close it. (introduced by e6df58a5)

Signed-off-by: Raphael Pour <raphael.pour@hetzner.com>
---
 qemu-nbd.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 108a51f7e..f2981e18a 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -1032,8 +1032,15 @@ int main(int argc, char **argv)
                 exit(EXIT_FAILURE);
             }

-            /* ... close the descriptor we inherited and go on.  */
+            /* ... close the descriptor we inherited and ...  */
             close(stderr_fd[1]);
+
+            /* ... also close the old_stderr IF fork_process is false
otherwise
+             * it will never get closed.
+             */
+            if (!fork_process) {
+              close(old_stderr);
+            }
         } else {
             bool errors =3D false;
             char *buf;
--=20
2.25.4


--=20
Hetzner Online GmbH
Am Datacenter-Park 1
08223 Falkenstein/Vogtland
raphael.pour@hetzner.com
www.hetzner.com

Registergericht Ansbach, HRB 6089
Gesch=C3=A4ftsf=C3=BChrer: Martin Hetzner, Stephan Konvickova, G=C3=BCnth=
er M=C3=BCller


--HYWvrtjcfB1Q8MJlYLuDvgyeGulioOZqu--

--iIW4pD4LD2mH6V1RCfQvjB97TZmSo54io
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQS+Pg4OcdvqnGb+5YnNseu3hcXrfgUCXrpk1wAKCRDNseu3hcXr
flJ1AQCEJ/CtW3roS8iS6IRRZb8CzuivK7REbVTEG6SkjrrcXwEAnWs1qZ0nqK5x
0LQYcCyT1jEM7oMuY4K5/sB8XbpKmQA=
=Hm17
-----END PGP SIGNATURE-----

--iIW4pD4LD2mH6V1RCfQvjB97TZmSo54io--

