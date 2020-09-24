Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E3BC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:28:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BE6221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbuBKeCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BE6221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWuv-00012c-O6
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWsT-0007Xj-Ah
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:26:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36609)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWsR-0006PV-5O
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:26:01 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600975556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TBwcdOX6blhjg9DV2B1mqjW/7fSeWqIbxBLy2N5cpTw=;
 b=cbuBKeCA+e4llkKn5zi4JOF0SUYC9dQ29cSThY2cid1ebKhN8x9IDnr1fOXKxfz/2YkufZ
 mWKrcDcgMYrkuKrl1e8zQVaOuaPaIrN9nMDDDxVOWM/zko6GZqUcfSP/HkcZK7G9Zx8Clb
 MGgWK3Pp5wmqYHqdoyQ4oCxoEbKDc1k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-uZiSmcgPNg-J34TEEcf1ZA-1; Thu, 24 Sep 2020 15:25:54 -0400
X-MC-Unique: uZiSmcgPNg-J34TEEcf1ZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1F3510066FC;
 Thu, 24 Sep 2020 19:25:52 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA2055C1C7;
 Thu, 24 Sep 2020 19:25:51 +0000 (UTC)
Date: Thu, 24 Sep 2020 15:25:50 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 04/38] qapi: Prefer explicit relative imports
Message-ID: <20200924192550.GB347036@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-5-jsnow@redhat.com>
 <20200923131825.GD191229@localhost.localdomain>
 <294a050e-9c8a-952e-b58f-8c11f2e75570@redhat.com>
MIME-Version: 1.0
In-Reply-To: <294a050e-9c8a-952e-b58f-8c11f2e75570@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2020 at 01:12:09PM -0400, John Snow wrote:
> On 9/23/20 9:18 AM, Cleber Rosa wrote:
> > Relative imports are a source of heated debates, but when properly
> > used in a self contained module like here, they are very posititive
> > IMO.
>=20
> Still? I know they were loathed pre-3.5, but in my subjective experience
> they behave the nicest overall in the modern python dialect.
>=20
> What are the downsides?
>=20
> --js

I'll just invite Beraldo to the discussion and let the fun begin :).

- Cleber.

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9s8r0ACgkQZX6NM6Xy
CfOiJxAAk3eM9pFloJL4W4gqK3VFU9utGBdloBcUwXm4+KLArUjX3sKf1aHPnyEC
OmpogjsVx0BdDRnVoUh4vAY1zwAhDF7t+vbKwKZdYM5qEEw2F2w6sfhAVMjQGIZO
4cgGH29U/vrpI4F9SzJlR0eoBmvwunxBiknopvudyOk0R/S6D2CoKP+9F1RYNS0+
VndsnXxEcjwQnSIh635bcDOIhPMsIsKyZ8Kiu3Rv3A8pMz38eh33Q7IUQLLTxWJd
hIW6llnvhNIdTqjKpq5XNYlxkJalDdCymgWs/dLPjPDR10AQPrVaDDoyV1QWKl5z
/wGf7/+g9ngKfV/HaXXvEUF/8tKf/oPLxEzrK6kq0EbqcJoXvDotS1T0T9+efNuj
GoZQYpDWQADKDQwWr65qVDRYuuXhHJ/esuO3SAOEMhwg++FQoh9xmj7BG8wfCbb3
uo7lDHCWwNUKZs1QO0Z4aAuSI7ECfk8bArJvAECj2Vk4yi03W2tVCxPHtonPP5cw
hwzNLOYy4FeoDwpojbSD6lYrJVzxkwR6S2T50ZzSdBB5xy87Yut/TD7YmK3XY4m3
/CD8TMGutEWMpLzR9maE87lSP1LeEGL4U7lt8aEXuCMhy7WBqZ8B994SltWapctF
3VBT8y7H0cjm7W+lUEQJjrtm9O9+VHiIjFZU41t3O+7KEjhq2uk=
=Z8uy
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--


