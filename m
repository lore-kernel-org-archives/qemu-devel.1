Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955A6C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB6720829
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="bxzYYSdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB6720829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1RSO-00059D-0c
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 05:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1RJp-0007sF-9J; Fri, 31 Jul 2020 05:27:13 -0400
Received: from mout.web.de ([217.72.192.78]:44603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1RJn-0003JH-Hp; Fri, 31 Jul 2020 05:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596187625;
 bh=NSowfk+zdZfBN/U0N2yBWTJeqtU0sa+7Wn61uH1ecNA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=bxzYYSdxqLVscnidGrbqaUlRaya6/sTI0Bs3sDDqzBb/9fYL+YQqrjFatF4nqQXh5
 cLONVZP96AI0E0+xn3fLGgijdM1AEOsiTt5HYjZTKTKbQ7+gdA+9LZqZ8GX6OwN2TA
 B3lx05RyKNtTLUnLpXPfqjRnCXg/+U2l1ahgj9wM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.42]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M43Kc-1k1RJh30jo-000154; Fri, 31
 Jul 2020 11:27:05 +0200
Date: Fri, 31 Jul 2020 11:27:04 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v6 8/9] chardev/char.c: Check for duplicate id before
 creating chardev
Message-ID: <b6d4b5712afc095f3d315818723809a20a2de21e.1596184200.git.lukasstraub2@web.de>
In-Reply-To: <cover.1596184200.git.lukasstraub2@web.de>
References: <cover.1596184200.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nA=MHDqm8NS91DAd3oM8WUT";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:f1CtYLThf3u08hoLWCEmQjAxIGLMDlS9MedX3jm4SsU3viGlXOd
 TrvQX0JeM54bfTubYHR2Jbx8cauWxvFY9GXlFFTDiDzVNvd6CnOo3mbqAHFtUqN+t/yE2q+
 nnflLogIF9STqBbDpUKyKwX6HBVVgKnzsoiWD0E2g2WL8hIQ3W84BBROF77Zaq00diE65Lk
 zYwSDnm2DUNuCICIF4EOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zU0f4ePo6I0=:UO0wF9GXwgJpvgm/fexQ0s
 /BKm8PDWG023Nv1vGdbjXZs9KFxR/vZGK9OkxPlXiktOIyF5rbohx4WVwGGtzeda7RQ77aiaL
 eAu/i+Tx1nrY9tl592uethasixtBc+6qh30KSOsc2jfqY2YgdfsykSz6s671UDPPNP3pi4qxd
 SJd7Bc8UPTyvVSOR+3EcrO76tTUta0ULTV8Kif4/my7xjX/SL+65rjudQKzBnylw/S90Urbe0
 gToGnfOEtv9YOaG0BW+kze7L+HJ7pOr2vZoaMwN0Cs5dlG8zjX3DmmI49yxRqqPLhH9D8TWUc
 wmWim9k3IwQMFxKd/tmQobphoexV6LINA4YmYCKs6/E+mXmasoZx3Urwmil2Q2D/flh01gGD7
 VrwYDamwGXjcWy9cZzQQ+sYRaM/Q/2b5zU+3VO0VUAHgXU8gsvWQsWAemk1iF7IHpRcYZRYA6
 5ua0iFzM+ppLZh8Gku+Z4I4PQdaXQXTu47NZKTpOXbdlwxeCHdRbt0KafRZOR5hxpaLobEmTH
 CuBu3gIJlvQwuA1OQW+gkGz2HS/Ujx0YMhfWQx7rEW8nmakk7tCjyqZakLWbH61QCtFyOPIF2
 lkutlPbAUHQsGATL3fGA7speHA8HlrSYjc68G3fdGIf1t2JO51b5B8zT+CxwooiHPKrmBlQvn
 Xusf4FD0FQbawOQzDnKsn4h2kFXnFuq7W6fP7rQXd9DnPF57BHDfSVEcypR+/G/j1VmmE/s6c
 dfu0uryOaUXacxlPzdhLSJpzx056Ttk2HcvmdohTM3zv4eunwxU0FLhJL79NFK6Z/v964MLm3
 hF6h7Cz8xobWpnOCjXEPuH/lA4XF2bEVAxuxc7YVfZBHSKqkJ28WB4iX/0078o9CPCYvQT+An
 TrgPShg6neIy9W82R+sm1yAAe+YmyaQ+1xjztNw9ZKF+aNG1D33Wp9AZ763B1yp24OJ8va8GE
 8j0yFHkth5pClxfdKaAb87777zcsJ2MmRbXJjmJNYrgBJYkglxWd2MTlLw39FQzeWy4h+0cBv
 Zaahdn6pj9U4WLaN/nmtiAwuzwKBqK8h7YbH86bBXsXvXjMbSzxddlnIE5xaPRniuy1aYuyG+
 QtIQCJ08+2v8bJtk/vhO6Y8du9TCrtDppYtWHjej1lhehbKyXWuYR14l45JtDKbxGF8MwonIw
 MQ55se8RR2TlDev7dyjP1cZasRlZ2PvpC4XVjpgy6jRZP0TTeUV5k7ZV2vinpHpxL09KlE7Ys
 rf9qDZkFs00XPIHLgtB1CgWFQA2iHsETGc7aJ1w==
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 03:52:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
 "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/nA=MHDqm8NS91DAd3oM8WUT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

yank_register_instance (called when creating the new chardev object)
aborts if the instance already exists. So check for duplicate id before
creating the new chardev to prevent this.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 chardev/char.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 77e7ec814f..ce041dface 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -951,6 +951,11 @@ static Chardev *chardev_new(const char *id, const char=
 *typename,

     assert(g_str_has_prefix(typename, "chardev-"));

+    if (id && object_resolve_path_component(get_chardevs_root(), id)) {
+        error_setg(errp, "Chardev '%s' already exists", id);
+        return NULL;
+    }
+
     obj =3D object_new(typename);
     chr =3D CHARDEV(obj);
     chr->label =3D g_strdup(id);
@@ -969,11 +974,7 @@ static Chardev *chardev_new(const char *id, const char=
 *typename,
     }

     if (id) {
-        object_property_try_add_child(get_chardevs_root(), id, obj,
-                                      &local_err);
-        if (local_err) {
-            goto end;
-        }
+        object_property_add_child(get_chardevs_root(), id, obj);
         object_unref(obj);
     }

--
2.20.1


--Sig_/nA=MHDqm8NS91DAd3oM8WUT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8j4+gACgkQNasLKJxd
slhIKw//dxkS/c0jv6gPWiwrP6/V6WCl+9hKMteMPCRNcqGUo/ybXwt526+Rt/Wg
NpDi76R/lXnKrYWMZbFOJN0kcyGNudvhRbpXXeOXD0aNimpBLbLJ0Lhg7oHTh7l7
x7/KkLjIy9fPtlz6bu8kgMTFlLEDdhANyq0rtr+o5AuZ8KzUt2/2c9sp1Z88sVxW
yZOIhmJ09Z6YzLgy2jOPrG7pv+fM6oY3/i70r9P6oQ6yFVMKefDamsbznbuelXhO
D5Wpp9aAL0ihHVqbzw8EBFwUpG4a0YFVEU+0d8KUgR9RJiFWNqnQShzd+/I3JX6a
tPrBwxoDICAFvGpio/zKxn8hIcGNki6hrbJvC8rODt5XkdqAlBXGF8zzxvS/nDRV
JIalOooAEG+GP0EwHvF1ilfsfdNuxFIOo5BO+QDT4gDSxBJlDkX0lyDGw2CxwBVt
8/e54gImlUw/dxeIbPsVwT9mXkDm/PAgzHcLxUB0ABpNys/ndCKpbJbCHu57iARi
LGbgg1lBfh0nTG/1XrN+SLUP3u7w42VDG/Qf1vjjmfsTP1m9E56IW0X7T4v96G+R
huC//yS90D9Ym2P+GLJgJz5uwfZuq6hRbimGo4UYVbdwxPxjOFm6u87P4bTt5/ex
afGI2vCckvbgWrCXKwhRTTKpJ7O5gN8Qn+fwU5LCBVt+gXP6rhw=
=Ia2N
-----END PGP SIGNATURE-----

--Sig_/nA=MHDqm8NS91DAd3oM8WUT--

