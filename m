Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257ADC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 07:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E49872064C
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 07:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="jyrfNEZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49872064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiCET-0003wK-WC
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 03:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jiC9y-0001Uz-4l
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 03:25:30 -0400
Received: from mout.web.de ([212.227.17.12]:58753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jiC9w-0006QL-TU
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 03:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591601107;
 bh=D9UR3BEqMEtA6GhskuqAb6KVGXWmPDi1Fno7xKcfTHM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=jyrfNEZSHS+Bt9vGddabDa3OEg81vkPD5nsFQWNL1MJ1PpqNb/zqZhGm0JKvxL07Q
 Ez98xJW8swserBe1rtj8H38EAyfdWMXXCU59FGGbmseHaouKhGRzZnTpcW+SoOY5+n
 EO99iujdyGtnv0LmX9SkiLKKKIVQEZHDDDTpG9LQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.119]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Maayz-1jO3lz47kf-00K78W; Mon, 08
 Jun 2020 09:25:07 +0200
Date: Mon, 8 Jun 2020 09:24:49 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Zhang Chen <chen.zhang@intel.com >
Subject: Re: [PATCH V3 1/3] migration/colo: Optimize COLO boot code path
Message-ID: <20200608092449.6425c1f2@luklap>
In-Reply-To: <20200607194611.24763-2-chen.zhang@intel.com>
References: <20200607194611.24763-1-chen.zhang@intel.com>
 <20200607194611.24763-2-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vSj+b3Gkmn1bLuLPWS8DX68";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:IhGz2iFyTWSOKiPNm5qTF2C+M8vme3ppAt4ZFVdUjTNd7T/iX46
 9j7GVS9dMd3kxtZhOXeoNrdEp24EiJy9hfcerLD147XdoaZ+pZp0SRKNGR57NiJZYisyp32
 ltJB9PyQHOW+Yvv0btqfrDT57ewREW3a+T5Fwi26lO117PkaQRFQtq3IHONFV8eKgcJGkrf
 OF6mTG3qbP/h24pPXT8Zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M1IkBjH3ouQ=:ybEzsntmqiOGJG9Agcwq6y
 iQAuUri2807I0ErjLrD0jtaxkUA/pbiSRAiAEfNSXrTN2SLFgUaFjqLSgamIhtXSY1wF/TKOc
 /maP4umozQDBdLsQvAjyRX/XG/O4IONAttK0gYIb+ih682JX/vERL03G9cSV8z7nJAD4zDhO0
 nXufqvDx0blaUt/ZWgWJcM2dW4Vy4E3H15MC1TI4aJtSSy/mLLcpFDS9p4fboNkz2YvoZSiJV
 EEHN02FrkkcInUXHnCt7yN7oE/Gcc+ROhuAgyJOBTLEDs54cQegh9U7hZNaou4ZbLxT02/PoY
 Q3F1oU4QFWjLbPz7m3s3JFkNcRCHnYikU267zGl0sM70t4+ehuXMBlGEhqZAO5UTOnV/aMkdx
 Th1GhypTSlsUtgH+jEWbPwjOLkXnaov76rhy+rU045XE1hzwHvzkih3qxVPh55tkjztAEyxrk
 afkRzDaPrywydMxDWLWnFr/jYD/5e2rldI792b8pmGBGNKbOwTdco8Frg2WVYCbvRR/0K6pMC
 zFQjtUZ1txzhTUviFMfLzU8UNuibDQo3nXj5g1LpTQglc3QqHEIDyNzMBAUsHYe0TtY0bq/m+
 BhxzACPmwZjCBiBZD66b9BKK4oWCn5OVncIhgc1mBflKTSFw3M8Kwz7UsY72/yEx2pd6A3rQV
 itoxUTiaQ1yfHPYu8SQ6xkkMqqZAw0Nc72bl9NE4l0Tb5mF0xYWuOebKEiX8w6j2X6tMLf2XG
 sh8dTGK/t8QlAq7L2Ql2pYN6IZyrsrt3NEuU8bW++TpD30v/m4hZv4hfypFao6GzYqYrnmPff
 ffEmYlcA2FWNy2OfobSWz3kf3oMWj9t0Vjk/8K3hTO9ltNvpw+7I1nAcJ70iaoAVTyK30XBMj
 g1kCdrHRY6sesrPo6Dhrh+apSspCVxW8mtyDHsE4P1803WBN2L2LSh2EO8wVIT0Y5Rqgw3Ot9
 OCf34ZehesBw2VApjaYIfzF/HXvyAj+9ZXpV7Kv55gPvyxViX+1whFgfkLTS8jkLvdPaMEvPd
 Cxx/PG2v7jBVY+mEHiw6gs3oUXTVQIeHg19h9fhOehdKyIXFoNwEfsNIA/w2Vg4E1Ji/kGj4t
 pmrOJ79n8wUaRhBcKfy1IGlxsF3zdlL14NXq4lWw1eTf0lAg2qLA8sOSiqMASk1UnAXf42KTI
 s0U24N4W2igX6LaTOuWbWm31k7YisdZoWBwVnWnRMNJZpoXBb80fhBcrEcjI0U/RzD48ed7Ja
 QhdIllAjZn4TcLoB/
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 03:25:25
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

--Sig_/vSj+b3Gkmn1bLuLPWS8DX68
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon,  8 Jun 2020 03:46:09 +0800
Zhang Chen <chen.zhang@intel.com > wrote:

> From: Zhang Chen <chen.zhang@intel.com>
>=20
> No need to reuse MIGRATION_STATUS_ACTIVE boot COLO.
>=20
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---

Looks good and works well in my tests.
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>

Regards,
Lukas Straub

--Sig_/vSj+b3Gkmn1bLuLPWS8DX68
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7d58EACgkQNasLKJxd
sliwpBAAuLYeDtH3SAYT+cDwK1ZW9bI9eU7VCIjU8y7lcOhMZ0AWs5Crg9vU/J85
w5mzIk7wcA7KKAM45cqDF0da7ATnMDjoEPQKWS7aFXRdDf3MvCpVRVMI2xKyAHOK
FGCmua1jQOH4sbDA2jsdxr7ixxss6H/nqVznk9mBr8SLF59YetvVO+/PW60IsTaT
ECgSvbjy5ZMCQ0i6ErECAef/91AJ19ccgD+F2eLcgc148skIkeYPpq1xDi3ypCjk
XF2ijtcKvASRoYJmcH95Pqepr6MDLgWWCkX2T72WHe9nTIleM8jxOtvOD00dGM2j
WqLe8fR9XwgeAz2tm/5VADR3Lt7vlpELD+1bfwxwMQq6uG4MQMpUAiaVWI5cZZFY
jVKU4BSYuu1oBDFPd/5nZqbotYfe5f/VA3c5xblN+7AiKhLUTkJZGauw0+XmG3RA
wRsOJ1Y4Rxz2dU67TibZyTZA0fja/vybdFGvW+LWhTeQZr3ccxbV2xrk4GzJRsVz
X5vPObSaT3oo98L+/ZqopLR6krzE2J9Uz2KIw29B6GHTQoc6p1rxwZQ5pWmVx0E2
I4rVt7KkXBe+cr8fgKyxZ7ZkBniy+QbnFwag49uoiFTe5QL41gzR5DNnSaPUP/LL
AhHSUNf2fKImK8oZ0JGgcnTpaxcr6Fnl4rhx2cwLxJy9zv8Fx5M=
=hV8C
-----END PGP SIGNATURE-----

--Sig_/vSj+b3Gkmn1bLuLPWS8DX68--

