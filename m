Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040A1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 07:38:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A81206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 07:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="fPe2flbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A81206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiCM5-0007Sk-H2
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 03:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jiCAl-0002C0-JD
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 03:26:19 -0400
Received: from mout.web.de ([212.227.15.4]:47777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jiCAk-0006ag-LN
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 03:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591601159;
 bh=EwrajnihFv4N0DOK9TBmwzGJXHWCuX4MLcIThrINQxk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=fPe2flbnQtUDoU8FiHroBb18WAM4B0w6xkN1Z57hQG73JhHYBlx4efMGhpoAuZH2t
 kW6eVVDBGj4P3FOu3SCcOs/L/u1o3/6IeuFSWu3HVCdTNmE6ombpxdlDYBROAB2aoA
 RMiusDPPgj4srDlDsFD03Dxd9CNZpw7BrzvVO9Nk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.119]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECGX-1jpahG0URZ-00AHrp; Mon, 08
 Jun 2020 09:25:59 +0200
Date: Mon, 8 Jun 2020 09:25:57 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Zhang Chen <chen.zhang@intel.com >
Subject: Re: [PATCH V3 3/3] migration/migration.c: Remove
 MIGRATION_STATUS_ACTIVE in migration_iteration_finish
Message-ID: <20200608092557.1d19d03f@luklap>
In-Reply-To: <20200607194611.24763-4-chen.zhang@intel.com>
References: <20200607194611.24763-1-chen.zhang@intel.com>
 <20200607194611.24763-4-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NmNl.9bgpQh1fXf8pchyXay";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:ANp45kc7WvbNtHJ/eb4uwyvbe1WEWonLGnL+LvOxrVHH/UxYA3B
 KS0C5BxBpYaOB071ibel8hqpjLfswDhl+tSe++FOv7nOhPDUhJ4sFSnMOgAzRO8dDA+CA8G
 5HbMT0myiyyD+VJ+DD0rR3t/bY8iciwwin8WhIwPGDzxeGLpPuFmZ2SWdTCPuDxcvvRxDEm
 SlfzsOn3ZDsuNJCkpPXSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QW4jf/b5fAI=:ylKYcwQblDuNdwD/MwFvEU
 nCVg6TgfzG2ryj9NuD2YILbvOsEgPoJ2iQhkp67cS72gBYP7e+8ePQoPHCOQ/Wgagv+yMif8F
 GrtkUkqp5rmxchczOgnGy/8F4LKvYVF1UamwEPWCerq49Ix3AE36qvlkg9Hkk3TWu+P/QatVk
 U8ttSMoVX61Ll8doZzJ3QkOKRDOLNvOvVpwb7ziDTEiuF9v/PJDYzeZM/nyJV1/SuP9TSIF6T
 Z2JSGMAISCHU4d5Ku0tGJTQ0hS21VQ60ffcEmkDT+zGTzl/4iweyn1zFZr298LRe200HMTek6
 AYIFTYWP9Aqv48tEvkUojjg8VDNk6o+cJdA9CcABctZnEx+IiqFMqghSktMQs1PdfbB5Q6jCK
 ifznvlEQ2DjarZFRgeTymhGarF4voHZQD8yO1CfLqsw2N4tm9feYAANbaHqKKN10asjv7Dilk
 iSLF/5/PHPIWpMVgmyK4ayKjpLk9NnQ08+DMl7NemH7cQGHxIStfDB0wlO46wFNCZRF0a5AE0
 jeyNuKPbP5seNptrD75F6vTcLWi5mFP7Ffc1G6xXLz+eKYcNVFgrJ7LpRKIEG+qZnvHgSrufs
 fgiZtnZ8fuUseCAChLZQ+Va3nIFWgamwa/KuniWiNS+NUXSqyuAU2f94y3D7VFXe8obqcudor
 Q8WBs6OF4J0+klpwCL1lCz831ZdqVqd4Gb0l2u3Vimkxg7ZnzXbzcmiC95fGRuB6Isf0/+WoQ
 IS6YqFJ7vn9xT792GahSsqow9vfjHieGjb8RXgcrYtB1rUpKuoVWTuRocgbIsixMsNAdyaRa9
 SM0MoHp8hNW4Vj14VJePjBNhLuA9aArr9FLSeziutfmD0w3fLiZjXraHvCFQQSQ1ggWPmhBbg
 xuX3rwP+PWY0BUzu391kuBjUZY22sE5aOuP7WMgsU0xRix1cXGHSFQyAU1jXXuaTgHRAdn9BG
 9/mvRXIptIfN2Tkiuq8momjrNBc4ruC6yp8PbV3h086Qjo0/mqaSlbVm5GSB9aUO62BBPnOhx
 iN62YtCBh6rV7tV6my1+W5M9Bqin31kQtitljdhrWezuJnA8WYwSsDwNG50REAenf4fO1tfIL
 K6k/H9p4Heos2i+yEx4HcluVM1OOVILGOUNvm+CAkai7CVN5wV/YlDDN/hXnofJacV9TsuFXy
 YJOpJ8ImyrSCEu+mrKWW5ZwXV1KZAYiVOEgn3vZ7PuV/n6PEKBbl/nn/tU93RjCWKp+EK1wgo
 vBal10ah0fDBQmu4I
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 03:26:17
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

--Sig_/NmNl.9bgpQh1fXf8pchyXay
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon,  8 Jun 2020 03:46:11 +0800
Zhang Chen <chen.zhang@intel.com > wrote:

> From: Zhang Chen <chen.zhang@intel.com>
>=20
> MIGRATION_STATUS_ACTIVE is invalid here, handle it by default case.
>=20
> Suggested-by: Lukas Straub <lukasstraub2@web.de>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---

Looks good and works well in my tests.
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>

Regards,
Lukas Straub

--Sig_/NmNl.9bgpQh1fXf8pchyXay
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7d6AUACgkQNasLKJxd
sljyyBAAgOmuYxkDkpjuxJ+Ll1PAhJuu9YyTMZqKyRO0TfEUceFBghYS8M+g1FgL
7aMPvcKcR/XbR7gRgvllMr2xEtxlZu7oseABhiEUln37DvGqjuahJRl2kDO2rBsR
fH6eX/a1wl+PtNokgUYfiPsCHP+QiCPwJpGRTPjZ/yZMz4+VqT7lhNcqvDkjBS9T
xpdUTwLVpG8ywspWeuqMX7C0EYqvv5DnVrqLj4c/aAObNztUm3BYoOSADXtwZUKR
i3SixpKnOk1KLE53Kgnhaw4/4Hx20hNTwS5EzqhCCY65Kt8frWxmO96/N3BP283f
GTmTcx9a4nWE8U3YcQ/2hEyyflT6g0mhrh4S8gIGAHyEtvKTevzzzi854zhw8MU7
AMnVi3MfigMaCabNMXLP5ppoCGQQsmM7Rhq435iNRUC43t1PYgTNat0P2G4LF3XM
ppBMFQznuC+VkQglaCzuQGiZrohIg2gEoHPJ7C1QpTI9om9iSqAkE/2/6IK1Qc07
CwmBemKpCNTYng8zhSfRFb5F+RT+Fc4usF8lX3p4rux+fCAZxhM7zZnljs6ddBrP
/NBtKk8JswSb4GVQhQ7pqZghSAuhPR8aINKT2keKH8pm9ba/75f/BNNmDrmudZY/
vPmkihdcgfQDn4qMVdSrl80uhtS+SZlD3VxEprrbps9NLMvP+Lk=
=k87J
-----END PGP SIGNATURE-----

--Sig_/NmNl.9bgpQh1fXf8pchyXay--

