Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A161CC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C332065E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVV7AIXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C332065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7YT-000107-BS
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kL7QV-0000Qr-BA
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kL7QR-0007Fv-UF
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600877723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pJuMDU21P/y548s/k0O91QWF1/fQeBlQTIK42sdR0Us=;
 b=fVV7AIXPOWltgPBrqD4Z/XEew+U4KnRGAzGhJ7eUy/lqzdbh/YW6Cynr355HJ25zLTWV1x
 PLmBB/snvD1Y2gm8b9ATZz3uGw0xQER/UeZFnK2VnlhehG6g38tCBZ5ubYH07ZovBPRmZk
 Rb0MOncxQBoZcrJbdP0bgHz/L//A88U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-WodxrsHDOzOQWuKHkNneEQ-1; Wed, 23 Sep 2020 12:15:18 -0400
X-MC-Unique: WodxrsHDOzOQWuKHkNneEQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79135801AFA;
 Wed, 23 Sep 2020 16:15:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2CC35D993;
 Wed, 23 Sep 2020 16:15:16 +0000 (UTC)
Date: Wed, 23 Sep 2020 12:15:14 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 11/38] qapi/common.py: Replace one-letter 'c' variable
Message-ID: <20200923161514.GK191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-12-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-12-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KjSGHOmKKB2VUiQn"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--KjSGHOmKKB2VUiQn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2020 at 05:00:34PM -0400, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--KjSGHOmKKB2VUiQn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9rdJAACgkQZX6NM6Xy
CfMNMhAAgOIR6gl1VkFU5tsPrSlEZrIMr7P+21KjrKVR5WDFGxYq0z/AEAc2GoQm
fOHg2Bh998gH9jHpuKsvbZaxRj2l9Z47ZlNk7ee8WTD2t59jCekVoXs8q8GBgOX1
ejRF0bqP2whezvg7M9NFIzcEavJSlVmR/LeeOEN+G3ot9pSIEI1YOYvL6yRMkwWb
szZ2eEgn09NUi0qiCBd9Pu25jh2HKbgnlhXdj8O3SWteI322rKxnkM4O9kzuN9Zp
fmo5Y4RkQTjBf2GdSiTmxpJY6dNrF7GfUyNQbnTSsEMBBcDjnRpD3HM2kR/McHlI
BlFeLd85TdCvO2xH996tR6umTo0lCtjm5WY8Wo6k5DLhpZxyr0nfgIokUxXZf/dx
WcleskKwdQZTGFiITQ36Et8Ap837sDjMYYYgCOpitBxH5RPv12/X4XDG98b9IwpF
SYbiryO3IuJXbpzpDyGucQaEtd8JXa2efVAA7K+sS95zEfhl42AQqNZMmXKg03Bz
GZTxkg1F5Y/Z9EGDztRKnKibw5OX/RnGUYzBPc7OTxpueCITW/qNiDrXZIEayiEh
dAigEJcMQJJnldKl/SoiN55GkBnSGkr8s6JN4f7B9FBIXDdh+8ZskG7mlFyIOtkN
EfcnnH70VSxqtNw65YHpWCbVb4RVHWlCy9GiE8yKP1fWY2qbuVs=
=KNx9
-----END PGP SIGNATURE-----

--KjSGHOmKKB2VUiQn--


