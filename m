Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B254C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 07:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA19920735
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 07:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="nFILUQ9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA19920735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY2bA-00047y-UG
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 03:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY2YA-0001m4-0L; Mon, 11 May 2020 03:08:30 -0400
Received: from mout.web.de ([217.72.192.78]:54235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY2Y8-00007v-Uc; Mon, 11 May 2020 03:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589180892;
 bh=kdZYXdLjb9N8p3xlWxsGNaLfKYEwisH80Lk4OmkVxUI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=nFILUQ9tVPr7vJUhDwdIoH5wkJySXywYutowTyGxfs0Fzp+FfFKEIZmk+iXMHIclD
 L+YTaRbSroq9aBOmMUtr3Bwa4/AcuWxPIhjcV0ov9/lVoqghi3Q1R4BeBoduJAM+0N
 hK+c5vC8IvG+sjH2MoCtDkUZG7XBTf7zEffQ5GbU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQvsg-1jgBTZ3Yvm-00ULTs; Mon, 11
 May 2020 09:08:11 +0200
Date: Mon, 11 May 2020 09:08:01 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH] block/replication.c: Avoid cancelling the job twice
Message-ID: <20200511090801.7ed5d8f3@luklap>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/37uZL0=cJI=k9Vn_.CeuFNk";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:DWUOH31qynvI8d72VHP7zZ7twTny8RBbbbt1DauTNcuPV9Z/5ao
 e45UU9vf14ClU/1luvBhsbj7YyUEv7hQnozNzjDZyLIIMyVN2oMdUI3yZqqAgfC948qviDB
 +dEC/8Kaia9o981lDE/No74Jb/DKSbXOXW/NWuTzbktQYlTWqY6B7r2eSYc04taf3VQxZxc
 FN6mm2AOEPwejBE4WIeRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CuPCsJw5j7A=:fps0FunEtkfBiHWQmes0wq
 8UIQMYoPZyTNoS7wK6VzGoU5tCXx2gV9WCQYAIOY6DaLf1WKV/zCb126dmvVA83PISmIA/IvY
 Iezi2OlvOCZkIoddXxXV5zwAJv2/Z6/UiL8RHJzrgmMejAAnOvC0l2+1d2AQ40EPmPYeSwion
 WLucvjyPTQFOH5tAEXXClnaDtIxkuKAzsVot6m876i+rkCE2Tmsn6Efd2ytSxlNH4xj5Hr2i4
 y9vJvExsMctB2IG1LU1ZsyXRmn7v3EkYWZssklBpkmEwl8kKJxzQiDwtlx3RkEN0MLNF/vdii
 dY36iYdU+phzmzUeYbIMIUKFWZ+j3O7ZtlQwIjVb5TLol7x0iBH4gIWojQHJyb3FMKhKgYyQF
 ujeMlNGjNXd7UfDFeZ/CxVV0heqjAjMOdQDaMRgJhvlHiZFfD932K7RGAE5cT8VYVFjh6PSAI
 8d1nlVPYq4iLzYI85ZE3vaJ7v2sBzivURn8c2TauRzcrjLDWf69sLeWqXevqRg4l7QNfMCxdp
 YKcLiYn37AEU+cN+D2fugULFtrO8187ChTlXFQZpwaj/u+G4Y0zVzCg6UEs72ZpVzSqPg497A
 v/3u83+Hy3ZgoyNby4Uj+Dcd+FDSmHKsWjhxMAQnPcaqkIOI/z6ubZDhrwMfUQTqVvGpR+v8X
 +dD14C0d2hFLhSXovanfaqBWWlqfgJUQ5+IMTDb161jd7eAw2zz9uvWW6K6BHk9CH3av+DlY2
 e3ccWYckDZu2fkHz4OZwz0xpFBnP/JSxaUl9oN7xPJgCkKWJSYMvUaaOIQnIdXiEuk/wrzml0
 PQz46YWmzXha/dijxWDfsyMhfpSiDmjWTX82e+w/mpmsy33t6ZwTTkpA7gMw+qP/79S33t2Rz
 AZhqXt/UpYBYjj4/auCZTu8P2VxAzD1kpY4n1nQMjW19MfCYxfrypiUWohZm0LWKhDIwwjhzf
 bCJZyEbvee2zVscHJg60Z4L1nZyEy4gL4jnNArYQcAaUCCgXpeNWi9w1BuhgwmYnHbfsVddEX
 I8qa4GooIQjWcmcRlbZ9IPuj/nU0W54iKqrpmx2eHF6SokCzhoCd62+MDh1RQVi+ssFFuwtS9
 tfWDqkm5fsWozgPoRwvf9pdekxMOSjBIMwIDJvtyL3ZhFN/e6DfyJjc+8qJnptaJZweMVNSoW
 Az5sZlMvbK2mfI9xPUI9Aqd/pvN7cPZqqhdDNB9FMlZmSQG7UB8TfRYgvj+Vt4m2v8wHESeCc
 pu9pZR+tT9pe0atTm
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 03:08:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/37uZL0=cJI=k9Vn_.CeuFNk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

If qemu in colo secondary mode is stopped, it crashes because
s->backup_job is canceled twice: First with job_cancel_sync_all()
in qemu_cleanup() and then in replication_stop().

Fix this by assigning NULL to s->backup_job when the job completes
so replication_stop() and replication_do_checkpoint() won't touch
the job.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 block/replication.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/replication.c b/block/replication.c
index da013c2041..33f2f62a44 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -398,6 +398,8 @@ static void backup_job_cleanup(BlockDriverState *bs)
     BDRVReplicationState *s =3D bs->opaque;
     BlockDriverState *top_bs;
=20
+    s->backup_job =3D NULL;
+
     top_bs =3D bdrv_lookup_bs(s->top_id, s->top_id, NULL);
     if (!top_bs) {
         return;
--=20
2.20.1

--Sig_/37uZL0=cJI=k9Vn_.CeuFNk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl64+dEACgkQNasLKJxd
slg+/w/9FNT9vGcPTDVQo9faWQzNMFgKVvlWNvcquY5Kz5Lw/Tk7eu6H5jNjqauQ
XvbCayKBQBgKayAUf9bcikZ+8Pg4xF4K/VRWzQ135qV9p8VASSuN91QK3o7brk8A
JtrX89R4el56y207174kR44+/24k+DCrXPlpB6H/YhL8rsL2hDYFKmuSNrBPsoek
OhaYyvi9qlXPSFDIF18mrI7olqvK7e6pN6TfHmd/47YedEGtVqhXzurDKDUuUFLu
nQTlkb+gRHRNnA/bCMizZ60Ku0r2bcUuOvBqWBImyobvaWxWVB4iHkciwcpu/6wW
UzlOem2VXurDOCe3aoDayj8Rg7fz2g9koBKyLvsYehFdIX70uwm2HO47GvkBxgmZ
fh7PemMTa+JvP93+5PRBVfMVyAWMXxmH+GCgeibQ0WgP77E7zQ6LarOtLSOIA12N
Yp7lqRnYlrEU+Psh7EieA0y0nA8m4aZBDNBv4HuIR/4xYybmWHKkgBNi4wVAszpd
FVdq2tRieJOrNlpP2sdIcXIYEdWN6zC9MI03bg2rUFCV7Y/V2DSxkEsPnxuYCe4O
ffwM4HmLUIPMP+Rtc1KF8TzBwtO00eHkUb79z1uNS7V9O9WRgDV6Ac0qL+ZfkAmg
+mKwPIZwquIw3U9mWuJLhe0fIkyiKVKl/KScy6k0RsCB7ocrsrA=
=9Q56
-----END PGP SIGNATURE-----

--Sig_/37uZL0=cJI=k9Vn_.CeuFNk--

