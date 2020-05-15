Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAD9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F62205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="DcnakZf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F62205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZYZC-0004aJ-Qz
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 07:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZYG7-0001qB-0I
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:12:07 -0400
Received: from mout.web.de ([212.227.15.3]:35033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZYG4-0008FF-Pj
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589541111;
 bh=wBcV0KTNVjkOjzoVc/HnBrcbobfirSONvjAmAMH59EA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=DcnakZf5DL8FyC+me7a4HLEm8v9TAYVFm9k4gsdPVqW9fmfpoZu95K3LxG+2Zl3Wu
 Ku7ozF/vHJwNp4GX4jlsrBKM9PKULZ94l8u/3soyrPATs7SlSjDtWUQ6nnskboMpFd
 vHyZJKH1EP7x292ji5VV7gFBcPrkYnQePSAlZpSE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.164]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MA5ZB-1jOmkA0Lij-00BNbd; Fri, 15
 May 2020 13:11:51 +0200
Date: Fri, 15 May 2020 13:11:50 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v5 4/6] net/colo-compare.c: Only hexdump packets if tracing
 is enabled
Message-ID: <5876e4047ee97f19616694130fb9c0cb3bb51a67.1589540787.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589540787.git.lukasstraub2@web.de>
References: <cover.1589540787.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6Pgl9T6NHLJYUfIRhIOlcCw";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:nQ9gPbioOUCQGxCE4LRKcFuYrDdyqDN3Y16hO75KoEsOGsKfsZv
 SOENOFlXjwQ1JhTz4PIlni0iqXT/g8+ZJMgUGrGqq4nRsM709LFbCVkpSWw/Vfl71yDTqxo
 QJ0YEwZQrRXvt/HzFV7EcXKxMLxb5dwOhVH/hMscEAsca06rAjleDtNeAGRQjRsYo9C/n+z
 NqmY5DrlsRAh5jfKUJE0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7ZVpVjwH3XA=:lhJcCHSaYrS9tSflBYEqlV
 rrxW+zDCiEwoBl8aSUtZjJ+vZBhoUQv7PYZpBAJHaEZHKPXNJCSn311+Tlb1tdeUd2uC3o12z
 LgVn4u7/oyunwn/HDcwEg7yuDHiV05Ii6UHDav6mSG5+hJfhinVLn4USw/R3RQw74FwpmBQqz
 +fVuMshbe0iJyZHoovoFfIqe3z1j+Rd6EuNcW/oG5UeODNX/ZxK0zpjd0YKfRNprmaWpqqGqP
 HqqRxjjNGf9EfAMAIqS8lW5PfIC9v06If41QgO0PqFL87BdYlpPb+4exW9T1dVcebAsBxvxQc
 R9pZx/e31MwG8XlWhQQoRYtEIexmJLJM/9JRN7HtDle5aNCRBqd/z4F7BSPkfGzskmHYr5VNI
 FeIy/bwvNK1rVELzS28pFp4pZEadI019VJNGVGUysuAJYGa6QGXQejmaZRAw3qA3tPk8zrtoM
 zaZSbeAywrVV0EXGEiDXxl6ZAw/oWuU0ggowZAZe55aWhNCn/0jg2tJ0KGLI7riIY1crCRzXx
 Sbjls9PmNU4jNMto1WEZ58tgGTRNn4OrGB/VR28X267Nk2tzUh63f1uW5LwHUR1izx8Z1ynJr
 xLCbroJpNLK5qkzJQcDo8iWFkrJ2fc3nR/bSrIM0KAQdUNk7beMT9TH9L6QXuquvk8ZnLOBc2
 yfvqVILh4iGUI2tC2As6STwKy6jnwPyST5BRXPhM/QiL4Cigj8coquwTx+4GzzgPTIOWsQnLz
 DgUCHkVi0bgyws91Ql9Vuu+28eGAWUFaZN6nkMPKi2RfHyz6zDjcdPeSuwORuAJ9t6L7Ep5Py
 idbnEYsiBbylDI8zWjQASgcbWdgj2QkPcqKf+RG0NN0DcosiJvWz4kH9ljFVWhntdo5H6yu3+
 ITaElRyvJnNvCgkqOSTJDZ2fj0F3FEk9EXdALuGJj4xjROsA9ThQ7F+R+AD/W2FzyktEX7sG0
 t1J6T9Bd9LshzPhx07a1QCtGINQpRMmow/QAXFQqO+ceclm8n0nhupSxRw+4FRIj0IY+jx5mi
 Uqz0dOcnrobv2xQOIqyhQHzb6fmfGaOFS2RcBTeTu0vIUPlnX3b4VzdZ6x3OkWj5JBInxb1Zl
 uB4id1g1QUJqux2IjtVyaFa0/i6v8h+wFx0gCwBNBOcUlha0R7Kfn/zwtADvn6Ne+z6gvdXQj
 DtN0ReNE/VOoo+fFMhlnu2V0vUEei2gcOIFCu+u8oWAgB1fUuePKLj6IvigbiKoHnkdWAmYpC
 BAiixvd2CMOadsKVc
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 05:48:32
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/6Pgl9T6NHLJYUfIRhIOlcCw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Else the log will be flooded if there is a lot of network
traffic.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 net/colo-compare.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index e47c8c6049..7886444cdf 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -483,10 +483,12 @@ sec:
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


--Sig_/6Pgl9T6NHLJYUfIRhIOlcCw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6+ePYACgkQNasLKJxd
slhI8w/+P+dP3TcNEpW/8HJzJvZhM3Xyl/41c8+rfjWbBej/0axYbsof7dNXlKn2
vsj6kK/lE3WgDsISmDXSlVJt6ZtStMXeF3LyU5ez9vAgMPObhRXEdBPRSsk26lnp
SAMOZIbyziK1cQln/2DTA1u3Nv7wYt9DjZu1IBpJS86FB2oPRvj4qfjkHnAKJFmV
m5YOOFtqwALvgbbRW1QlvPmIzkfKgLCs5wav+3aiDHwp9xPioDmEZoTeO5YfkKCY
oojUiuDdjFBBz0b3w/cg7xLQ95nmGkxiVhpt4BB9NC6+dEPNDMGUca61rZo7/8PI
gj8VVFWYy1Mg+aYgDpITn23Ou+kyWBSj8pYElJ/+fECzAJgqhtlAYRL4G9w4HhAE
y8ifhxiera/zfC3vKwkSoDkjf8CFe3hOtQ8dchaJQfrtz9tzupZDWXIYnYP+b7JU
bLyceasT1EBN8LBBf/jlfTEg/uQ9N539CBPLU/cBpvuU8EMIUroHiigWZ4UBfYAS
N6bQ1jp3Hqf8qBUQB0OMdq8p4e9BrsTX5vOvlVVd3BBDJF7c8Y3R/s96+A/13cTD
HkiLgy6N8nrXZcz1n+F7UqzLVuHyJ0/IjtkypZuo2DybeO4OyDOaTGdXVYXqJwKc
7dXUgvEYpS+yS+WkLxjihxVL6ykmS+tsXxgmI4NkRVBCFen4sTw=
=Cgzl
-----END PGP SIGNATURE-----

--Sig_/6Pgl9T6NHLJYUfIRhIOlcCw--

