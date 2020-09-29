Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B16C2D0A8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 02:49:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B96A208FE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 02:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfK8NF/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B96A208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN5hO-0007b7-CF
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 22:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN5gN-0006g1-H6
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 22:48:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31051)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN5gL-0003lh-1a
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 22:47:59 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601347675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hwwG+zXfefBfICzzunLmLp8+eNU3nIdvpsz1Hqg0EPI=;
 b=MfK8NF/EjXYcUHbsxO+g68HoHrAMYXqHKlpC8JwUyD+SKyjecddQBVvaf+brhOETmP7e47
 qC7pFNF9Z4A7GNkCBttiabMAH0Mh4eR/z5z3X+4Z/Vlumk5dSDyKUg7xzkh2hwiKE0GPhQ
 Bk4Fi/ydMBRin4JF9P4yP8OCTGrc+Ew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-UAsy2oqsMxO40kmQpj23jQ-1; Mon, 28 Sep 2020 22:47:52 -0400
X-MC-Unique: UAsy2oqsMxO40kmQpj23jQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4070801ADF
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 02:47:51 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 16ECF55774;
 Tue, 29 Sep 2020 02:47:51 +0000 (UTC)
Date: Mon, 28 Sep 2020 22:47:49 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 01/47] [DO-NOT-MERGE] docs: replace single backtick
 (`) with double-backtick (``)
Message-ID: <20200929024749.GA700868@localhost.localdomain>
References: <20200925002900.465855-1-jsnow@redhat.com>
 <20200925002900.465855-2-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200925002900.465855-2-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 08:28:14PM -0400, John Snow wrote:
> The single backtick in ReST is the "default role". Currently, Sphinx's
> default role is called "content". Sphinx suggests you can use the "Any"
> role instead to turn any single-backtick enclosed item into a
> cross-reference.
>=20
> Before we do that, though, we'll need to turn all existing usages of the
> "content" role to inline verbatim markup by using double backticks
> instead.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

While reviewing this, looking for broken usage of single backticks, I
also found what you found on the next patch, and nothing else.

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9yoE8ACgkQZX6NM6Xy
CfM7hg//Qd7GlbroZSTYh8LQEz+tzqilM6TjeRC9qudz2g5FZftcCBFJNQ4AbXX3
gRYSa/1pt/r4zx5SZQP8qzXyHvFhPWy2nWO1iLQFZKAvkDti7cIM0WPsuKKHyoPa
ErVq9fIi69WU44bE1gnoM7w6Ik4ozDFxXfmBwvq98iTNJvkBii1ltC1GyuJdxkmJ
2ZPWcv4/rRBJ5eE7edfGu3ypL2q9gX53hYek2ZcmPnIIqzDZXOonXxpyem4v9lcN
pnzqfMinbx/WzY5Ile4XKPNaA4Nw+XVykfx8eErLTnMM50DZCoLeOoq25p0+IPIv
aSHwxLcLQQNF2bS/vFKvoukTOA+xAz7u7adNlZ9taD0CdX4BIIptC+VP4qUuI9de
EzQFTx5Ahueyc+c/VZB6OJjIEXLd1x9N3wzs1JPodYB0J/x+B8lIps5iNxwr+OND
AVgYjaZK2pGcr13ofUrLdyrzkTk0KWJoYlcD0oLWCQe5j0Asbs5i6pLYZIy2emMk
GejufaUlTuYpNWtiP/jl0Z5MeFeyExOM76uDMi3tm8l0/kvZm56SWLHIAXX7z57m
Q0bduKEWBPMlWpl6Q2tj/1xp+SuyuIjWhP1BZ0UY/zOGCrNQCpchZWMEpyoyOu5I
gOgDgoEoxi1RtqXrr2Ua4NrAylcPt1/3lqrn1GLByTrxiayuQBc=
=l5bV
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--


