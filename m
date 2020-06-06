Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EE2C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06AFD20663
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="NE0UsnCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06AFD20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhewX-00011l-04
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 15:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jhetS-0000Cy-My
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:54:14 -0400
Received: from mout.web.de ([212.227.17.12]:57125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jhetR-0003xy-Ng
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591473236;
 bh=3DjQjfScOQ5/CeZOAoVMlM8w+NsR1XjaarAcLZF+pec=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=NE0UsnCXpPh+qNiafq0RnoKiDNraaZYbkdngXqbAO9GmMbtQlAunqpu/pYUG0Ibu4
 VZsITcF6AkUouv8qvna3ayMUVJF625dgwvAlLBktSHQQoZBfOXP10WbrzkxtDkH7ng
 nA8aF1U8jwa1QMflHdUWtPsL/lIgXJRa8T+NnuZU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.73]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQelV-1jXO0n0fFd-00U3ea; Sat, 06
 Jun 2020 21:53:56 +0200
Date: Sat, 6 Jun 2020 21:53:46 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Zhang Chen <chen.zhang@intel.com >
Subject: Re: [PATCH V2 2/2] migration/colo: Update checkpoint time lately
Message-ID: <20200606215346.310d61ac@luklap>
In-Reply-To: <20200604085533.7769-3-chen.zhang@intel.com>
References: <20200604085533.7769-1-chen.zhang@intel.com>
 <20200604085533.7769-3-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RkMD40nKS=GQDd8nzaJUjYc";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:9cguObx84rxfhAGKDTXAs+8r5lDx7I9ksasdAHCXm5LBqJNfCfw
 402EJnMlymsAKK6HRcruO8L1bXMZdFOsF1LdQZ+3yUaB/RTCL6oXMEj4k2b+Ci9Tf+BPRrH
 Uv2Zksda9FQEiAb6Xkmt6wfYG70Tdk1w40dbi0c4XZJVZ9TxldfvzS7FlzrLUUsj4fc6FSj
 aqlcTXVSbq+TAaQU+6zkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0z6CF8/79jM=:c672mrUB9iJDSI5WxJNNrn
 g20qFi6bnPxxJSwcyZXRxet0o3ypMbYFMCxB3mqTxA1LYDdsSp5HmFxQK+5P/V9+aZ5cRuxgn
 ac1CL3k/bhkCntLaY/dHPRtVUhMFwesSsY1XdtkJxIPD5PE2WqdlK8fnZJz2q3D2kuDcbSvpC
 wCLZ0eRnOLFkAj5Bv4sBRtrYl6XQJ1GR8xA90t7gAUuU2Nloll/cVPOc9NyeNkgX5KNfo0xMo
 vrJ93IygsjoW3GDIYZ998shjqo4pn/TCYu7hAbzH/Qi12rqDrZEP/VMgQMDHlVcJhDAcciXOm
 J1vlaeX0BA0CGMRwS09Rk5LxQnxtI/gpToCQmMfwoRFij1G+jPX9H2OuCUttYTFeOLH+vvigO
 /0ocOzwdWanRs68QlTyLHDrPVVJ45OsVVYUibXKDDRlBhc5xF6dPbg+mRNff+9SqIF/xOoKW9
 m8z5sUsdH0+tB8961hNIP2Hqi3nvAqGuTjX4ecu99CMmbh5f949CJT90Ah5lULTMuvROiyGCD
 ExlhdC5UWvP0lY5e1OanY66VJYxZAMticHxh2iLZiLqC4oiD9oLaxj+/S8x4A9vL2SCr4uLIo
 IuAb80RXWQlUfuTpG93JOIW6MklNdAYMyCGek6JVhohGVuwRKL6BMX3rRo7M36BbzXkDfPtMy
 WvGxGX+RRLUGzY1IQAXZBgBqOAHbXz7/IqZPSLSJWMGA1VTv61QiUVxpcVJmubNvL+1s10/8O
 9ryb3YoLl70pivAATpmYt58c1cJEIb6IAw6f29ISBYejCNCJ8zhcYZLDxg2pQ2ns7aTEi8pft
 DTGWg2eRAX01JL5LOsfF5C0S/IoOIrsRtZsCCHm3RSJZbqDffjR5VQrhS3gAkp5XPCkYnl4uk
 GBMCbSxGpeXuo1z2PY5Dw+Wsx9UwdyARdb1p9RTtqn7QpYkNq3LqnZSjRs1yCVzsC3f266nZx
 KfCXYPybafw6xf4PDtTRbdxGWBovfoOkzT23RwSfdiKNlJB33BJxritb6JHqgv3gxrZUPSE2I
 LmEu13sxR15vRZ9iXhFE2ovIe2tXz7dm98f6mkUTbJWm2Ep+YT2iF0kycMrn5ntGsPJCVPFYs
 gp6yJ/3/L5NLAc9SYuD+qdic1KJxjZJjAsjIRaJA5eEAkYpzSEN97uEtz/g4Ggda6PXMD8ACr
 8Vtx+jh0xu0nDgWUWpsM7HZNtmfBhrBk1bDQrMyW8q3jr+F9G4imyNMrKu+Mlo3cfopd/TZ5P
 ahAcHRSq8W+nKHnE9
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/RkMD40nKS=GQDd8nzaJUjYc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu,  4 Jun 2020 16:55:33 +0800
Zhang Chen <chen.zhang@intel.com > wrote:

> From: Zhang Chen <chen.zhang@intel.com>
>=20
> Previous operation(like vm_start and replication_start_all) will consume
> extra time for first forced synchronization, so reduce it in this patch.
>=20
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---

Hi,
Looks good and works well in my tests.
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>

Regards,
Lukas Straub

--Sig_/RkMD40nKS=GQDd8nzaJUjYc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7b9EoACgkQNasLKJxd
slgvIBAArZFSyyrkpALRAc9hf8HtYcthUiP0aiB2s4UBhNQ5k4qAheGwiaqK3Rb2
jjSBHy6q4SAHWbgi48cgNFkN692Dymlx+XuiBG0W+WqWk9DsX5roWLAU4MYUk8Ie
iHD9qPPdNLW6eDB0uWVghpJcKjlEq0zJSRmEE3QmEMsndcnO6UZ4EcRsmZmnpfow
R/1q91lYKblukLVTHWeGoYr/v67JSlUOmaGYuII4OaPiO/KpJsS50juGyaolbGU4
FdJQ10Au2S0smkq8OS04eWZFgDxanhz/pCWHNwG5GlO/IGE2DdcuvnIlu/dhKCWR
M+0eLsXfwTBBPV29g9uwhdVcXE459wpwZVAHpO1MbCe9fkEoUD7Mw12YeuLOXg4c
Bvscuj2Axl2bMltOORMB8N5UmYDC0Zral03ZnozNTVRW+TEQwOn+MAjvNXqaHNLK
yAzppZPuVKGIBDfTqtHpCWYCfVYIOtG5VYjRg1f48TbNvbcoCuUweyq2QPqrbc3p
nvneJN5cPjaIa/YuLCTSQU74jkfbQdayu404KuRJofSthKPKYB5GrCjvqm6xzO7V
66wH02wwTl0FaUzWrznivRlfay8i8qakIMZtYJ4AamKb7lXyxeSOhi3EY4va/Arf
mOPDlJLvjs/qon2KAtZqibyGb7aRjc1WY3q8tAsmmWoH1HQB6/M=
=RmF1
-----END PGP SIGNATURE-----

--Sig_/RkMD40nKS=GQDd8nzaJUjYc--

