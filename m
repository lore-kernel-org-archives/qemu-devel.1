Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3ADC4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79F5D23977
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8Tr9FBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F5D23977
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLbSt-0005JT-AR
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 20:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLbSJ-0004tB-8F
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:19:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLbSH-0007YC-Hq
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:19:18 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600993156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gYNBuaY5RtRr4rHlNanalGQ9NtwiaYttJNiT5oeeGx0=;
 b=P8Tr9FBfxspPBq5h9s5zrVJLAxsChKx3syqsULQhRm3UCNOMlhttcYmG82mzu2L8IWf2qN
 U0Ng4uZUu3KQlFQ+pZQinFpresuQKmpkJttGr3iD8GRsG8WMEAXljVl+vH1TlFWmaXCIss
 axis8lykA2CEaIWdYdLmwGa6hRQ+hC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-mUdj5yM0M_-wtYXWvcR1gA-1; Thu, 24 Sep 2020 20:19:13 -0400
X-MC-Unique: mUdj5yM0M_-wtYXWvcR1gA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88B54393B1;
 Fri, 25 Sep 2020 00:19:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D475B55760;
 Fri, 25 Sep 2020 00:19:11 +0000 (UTC)
Date: Thu, 24 Sep 2020 20:19:10 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 04/16] qapi/expr.py: Add assertion for union type
 'check_dict'
Message-ID: <20200925001910.GG347918@localhost.localdomain>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-5-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922211313.4082880-5-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eVzOFob/8UvintSX"
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--eVzOFob/8UvintSX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:13:01PM -0400, John Snow wrote:
> mypy isn't fond of allowing you to check for bool membership in a
> collection of str elements. Guard this lookup for precisely when we were
> given a name.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--eVzOFob/8UvintSX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9tN3sACgkQZX6NM6Xy
CfP8jw//TUJoiegepMEG1T8Ji7lIlG4T544IIh3P4Mpitv4+Or6SPWxLzZOkq9Mn
lODY1WkeCttGcFsfLESn1sbZSOX9e8Ka3ma3DjhF3kFa58/it+fhCe6K771W0aLH
n6jVejh7GD6s34bsRMGwKPHO6uLgrRHQeQlmhLMDBCmIM7K3vjaayGR9cFE+0P1w
6K0SJLF9waUE1HoETHeF9SjkMpABclA6V80iPcqsUYJUIFGHRkABdB/ToHPwpxjZ
y0qKZYbzh6uCOlbaso7xVjMaFd4ye7qU+61/fuVeawOiQi0j/pHW5AmhIYrLgHdl
1dsttzv+F0dQBa4cjOBYguMWh/G8bwfJnWrQY2LbOwV0UHbuvz59JcN6Axz7sDgr
5w8mwR1e7z8/dWHGvCcn5cHWh+nX5ZEXxZSGxKP6fx0kQ9An0NNZ5/N4wfQEbQ7w
Txq4LZhD42RbpKdPTxZCvPy5Bqo7LfX11JuAcwzMMEXmMlVWcKJyvyaFqoUHNAGL
p1wjz5lm6c0NFJ3kkb6EPNLchXc1GAIninib6t8DtTRLTzc34l3t90aeih7rwwdo
brc/Vvc0Q+Kvwy7O2smtLzlqGARODfE29dcIttOOvgXvUb5sIvSUXJzH6HRnlyiB
W0DXokgXMvZpEyhs1ljp3UnQyjWUbXYBfIf4/Q/Z086Cw16Oo6k=
=87t6
-----END PGP SIGNATURE-----

--eVzOFob/8UvintSX--


