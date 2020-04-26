Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F83BC54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 20:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D58CC2070A
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 20:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ElEB1RDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58CC2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSnTl-00048k-FD
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 16:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSmuk-0001F2-1H
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 15:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSmuj-0005yW-LS
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 15:26:05 -0400
Received: from mout.web.de ([212.227.15.14]:42449)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jSmuj-0005wu-4I
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 15:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587929151;
 bh=6+6MZT8Ab+jZgOaD9X6OGDmKx94FIwONlN3kC0VukBU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=ElEB1RDhB/vBAqotmLPzwiJJEexTvPemiTihzpa0kChZcZq7ci818uyljehMBABP6
 BS5cH5oFTztRwV1AyVVa35b9pnQ5dWyykxhWBvRLp2YPYakACUGAXqQ1atTdGyLuS/
 UGPlSHYI73ojYitHrke52n/7DRNOUmt2GaDYc6PA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.95]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M9GcY-1jLcQb2ATG-00Cixk; Sun, 26
 Apr 2020 21:25:51 +0200
Date: Sun, 26 Apr 2020 21:25:50 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 4/6] net/colo-compare.c: Only hexdump packets if tracing
 is enabled
Message-ID: <e0e3f058620cce728ec5cb18d136f2f2b475b5ec.1587927878.git.lukasstraub2@web.de>
In-Reply-To: <cover.1587927878.git.lukasstraub2@web.de>
References: <cover.1587927878.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cM6k0gq=PlFfK0vyhPpQgAu";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:n/rkiTd5GDj8kGwOKPJTmNnVLS3yb9EWFozZ2/lP9XJJeeqlxmE
 t/bSY9rkkFJ2cQVrtmHnFDtgtpAsq6iZGH13igU013IO1JeGtTXANejP0do8YKawR/YQzo7
 OUrn2+7fnrBMlazTKhPKCY2gTzF6kd3PNWVHWuuPev/rsfqRkh4zD6czHfwyDxQuzR73Z44
 USb8DcuxwhxG42N8CFkyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rKjFoMJHE5w=:KQImwCN4slNzRykidLG3Iv
 YB/R34hhoU8ezdQiaf7MZYcrQk7u2+eoEwD0i5v28yB3sGD1Dt+Vhog7dj1uaGWcLArGW9A8Z
 Yg974fgmvG04mD7vJFbYgJlMsz5gujUGS9jOCyguw8sQ1DToIKuhOkSF6P2OljSZAeY8k7poE
 V0Y3T81Neg1LTVCdZEbarwIw00KgJTpcYpWrAHiamnG3/4dw1XTeBF54U2il3CovvOSgCMDyP
 XBVGLI45aIRvoQkS8CBnkSOPSzZ1jbBnQ/OxX/J2Htkhgzpa72uKMbuLXCkpt1E5dxLBk+gH+
 sDfJNpJsljy8Wv8/BcB1LO5tU/PkT83Ou/RdxrjfTmTYG9/4UIe1leCmpNQ66Nd9Lwc39j5nH
 1qW/+DvXVZSB85H4c6ozXXvfNUkqcBbOStQNvN/mmJsGIe4CVjZlj4FPefzw2RZbfoUn2QaYx
 C5r2LQ5qGlXaz6UNoRwHxMvlebMLIFApzBmd0c/H1MlelE/v0cOxGKtfxwQVGs40/8i6kqc1p
 6CVf4pO46ICX+maS7b+1FGQdzgSmC9XGH8o00uM4SLZ3iOLiMr970HdW++XYKa4++Qwp5P4ug
 mJyjpKYY4QnxKW5IDVzil/VNmTJ7bBd0QD7zUJyyytb8XyuASsYzO8P/6hnv2dABPCUAk27k1
 Bs+YDSfMOvQQfj0k0bajPw7JG1GjB6lXgLwyC7Qe9BiDW3pUvM8uILVTR4GAwRf/AxxngyQk5
 8crI0jEyGtx+CBVloNpox+53MBhDQaoe7y+XPrn6sT05oKS++L3HWAxWVEOJNIVYRuw6RQRq7
 ZlZilYCwKEU09UAnDu7KsKNJYuBlJ6LMINvRtHrMSqnrJFOa8uWst6mjGqcTMyoFLXaBv/3Tq
 whnNAKsRMISPCrE8OvZXlvAfoWpUaqxZz/eHR7XkClwOmoQVUI5nhCvNfC5Gbyk5AB5mGyolF
 rCaKPli9Fay1TQPvZgVB+B4BBdFRBpvAawUQhZkdgR530w+wGH8jFBsXLnTQQZv4UT5V/R8il
 n09LdSfBuc7gg61wfqs4wBbVLYMPoXM29Y20f/rgsRjXU0iW/JkI1rcuAgsoixs2dJXNEnVzZ
 06JgJAp1eQLL6Zf5DWauGuswkUtifFLpSJ/XjAaGBQQE7hksHcyrX3WW6HSWrlyuFKE7orm6R
 AMQo1We1QSw9/AAf/UG54kBHYmhkiII5i8mwJQ3hghMaVcSmcTMw88qe8S8sNUiZsE0z6ckPX
 zb2bw4DQ1+2zhcN66
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 15:26:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.14
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/cM6k0gq=PlFfK0vyhPpQgAu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Else the log will be flooded if there is a lot of network
traffic.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 net/colo-compare.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index ff6a740284..6634911770 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -479,10 +479,12 @@ sec:
         g_queue_push_head(&conn->primary_list, ppkt);
         g_queue_push_head(&conn->secondary_list, spkt);
=20
-        qemu_hexdump((char *)ppkt->data, stderr,
-                     "colo-compare ppkt", ppkt->size);
-        qemu_hexdump((char *)spkt->data, stderr,
-                     "colo-compare spkt", spkt->size);
+        if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE))=
 {
+            qemu_hexdump((char *)ppkt->data, stderr,
+                        "colo-compare ppkt", ppkt->size);
+            qemu_hexdump((char *)spkt->data, stderr,
+                        "colo-compare spkt", spkt->size);
+        }
=20
         colo_compare_inconsistency_notify(s);
     }
--=20
2.20.1


--Sig_/cM6k0gq=PlFfK0vyhPpQgAu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6l4D4ACgkQNasLKJxd
sljQZw/+LB6oAtGmXKkiq7p37XOUdTRV4q6F//YHQ2i+AupyBZGDno2iUg9O66qv
ZRgR7Nel76XGLDKRFZP/Ign54qHaYQE7VagkmEbvjcVNa7A5HLAgSK61980EPXss
4+EMGQ6tZpZLtwq+WY/SDicnXugIv+qj9s6RMZgErXlrfRuJNH6lTzli3gfC47RF
AIYBhuNIM0mRgIup66124qWqPVwR8jlC93foBhSm3nQqVJJLwHJUtX3dNeh+ZiuT
MktHfo0sftxMadSsABuHsnn8woX4nYoVW/pfwao1JYX4VvP64b0NoVWnZC7P3xVk
YuEDtw4yo0nl/mCG2hrmpwzS1pU1DNgzIcPS+PztsU2k/nOtEKloxjdTaLb/hNzb
gIdFTwrJtyj19VC3qle0B6Ec2Xn4HkJDCQspVAY0NQav2adlwFRmM85YE3tgOuEx
FrIWX+Y+75lZF19ALagKvBQ80rbsEtwtGKyAwNczVRBt5KyZabEFjG1XdqllsMYl
1y+wPtbHO6bnhKdgd86HCc3+TR3GAc/o75iF7rCCo2pUmQyXfZqSxnRonHmUQ5fh
JK09JKhCufZK49Rm3EJq4jwBeRZFTD3391oOrItnPLINg3KkBMkGJ0FayBqasTg6
kdXBYfrIExcldFKLf9psh5FjPaSjsVfoZDvVwQyEFtT/O/ZLh2k=
=14Ux
-----END PGP SIGNATURE-----

--Sig_/cM6k0gq=PlFfK0vyhPpQgAu--

