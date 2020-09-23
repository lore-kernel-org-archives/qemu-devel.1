Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A386C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 22:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD66214F1
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 22:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaMJxMRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD66214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLDTv-00055F-5s
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 18:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLDSf-0004ZA-T6
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 18:42:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLDSe-0005Ek-FD
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 18:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600900920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L4DnpC2RNRmpJuD+daUwyL6PiYRdYR1iSuvRkK7jTGQ=;
 b=iaMJxMRe04JB4QSQMktzKCOWvbUTDQB5qbaQPx2VGz6c39UGCnYq3559AH3aA6fPy48tX1
 wked8U6rezWkersVPLp4fSiOByc2KTW3T9ng4HRWVb32O6hZyk77LEvwmWuKSxntQHrD2b
 bLPo6kBkit2uab4n15kWrmK+GLDjoRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-7-WdhpxYMkKyFm8Q6_Z4oA-1; Wed, 23 Sep 2020 18:41:56 -0400
X-MC-Unique: 7-WdhpxYMkKyFm8Q6_Z4oA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70AF41074652;
 Wed, 23 Sep 2020 22:41:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B268F19D7C;
 Wed, 23 Sep 2020 22:41:54 +0000 (UTC)
Date: Wed, 23 Sep 2020 18:41:53 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 23/38] qapi/source.py: delint with pylint
Message-ID: <20200923224153.GW191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-24-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-24-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KH9S6eoVXLBawpUJ"
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

--KH9S6eoVXLBawpUJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:46PM -0400, John Snow wrote:
> Shush an error and leave a hint for future cleanups when we're allowed
> to use Python 3.7+.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--KH9S6eoVXLBawpUJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9rzy0ACgkQZX6NM6Xy
CfOnRxAAn9t5Do1JlUvbPTU5QpVS+OGVtm/yjV6gfWMotgFeRqfzJ7SHaIRf0P95
lj+O8qzkUuyLDGowvBYbmpSBu+FauxvatiqOk8uRXlhX7gtvGauVkJP1xaavZ46w
uf6WI3kMVtq2RS/Odr4oOa0uwCQ/fgeWzYnuwnroIkE3xDAMvm/GlXhoWH/sAD8f
1lVXZCX9XwaclnoINvfNdKdEkZ/pxrDnIAiTuSUkXzV3nsUlC/7bRj05a5sgZhno
u0Ijf0hRWPuVdNavy3I5qUFmcZRHq4JLJaNA03UC7PvhwasevXJU6fLDpd9qfGQL
UgwKqPbdk70LkVJyW3u0Gbi55RsF1LQMNA2JOpZsL0k7dwgIJc4r1NE/2IV/zdNY
0tNgZ4WqqSq+N7cejscvHUfGjHVhJ6qfrLexRBOSBTHdscCjryu0VSOelGZmmWFi
GSYhdioB6tM8ecJKrnxNyJ4UNRVsxY9URVtyhG7ELfq/06mj6z+gyRBhLSlOKaCE
CxBtrONStyrELdfsO+JbbOXrre3ZGkCbEb961OpAHOh+qiBLU9O4g6+Aa54PSUfH
/1vy5vGsjOl3GCknBFq7LtN3RvEstGQSyT6V3zJ/YAuBCZxuVv7qS2wD6B0gDYy9
VrqahavzrbtE2/pvrMqcixShq/2sYKasHUzIHcRIHKuN1goQfuE=
=SPpr
-----END PGP SIGNATURE-----

--KH9S6eoVXLBawpUJ--


