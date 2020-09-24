Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F185C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 22:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E69321481
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 22:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVJpaP67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E69321481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLZs1-0007M0-Fw
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 18:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLZrC-0006vM-03
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 18:36:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLZr7-00047O-N0
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 18:36:53 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600987007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ROKQhyQGrDSrxxieCcSLGnfC/PGVtBz+fe05lwQ3z/A=;
 b=EVJpaP67HvLK5/TTM4mBjad8TnTStsTZ9GqNk1Q+L9X0MkAj5Ti14szl4c9BThUKiD20Sm
 fl6Rgu43JKs/6CrkDm/eTXmrffNXz14WtVMcQh//OnxA4mF2nMWS01qqL3FtsC77iYDmFs
 tAYAn65cqWV9aYu58vcU/48KvlaA/tI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-QC6zkqMLOf6ciZsRfAoDbQ-1; Thu, 24 Sep 2020 18:36:43 -0400
X-MC-Unique: QC6zkqMLOf6ciZsRfAoDbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60B5C186DD39;
 Thu, 24 Sep 2020 22:36:42 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A1749CBA;
 Thu, 24 Sep 2020 22:36:41 +0000 (UTC)
Date: Thu, 24 Sep 2020 18:36:39 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH v2 04/38] qapi: Prefer explicit relative imports
Message-ID: <20200924223639.GA347918@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-5-jsnow@redhat.com>
 <20200923131825.GD191229@localhost.localdomain>
 <294a050e-9c8a-952e-b58f-8c11f2e75570@redhat.com>
 <20200924192550.GB347036@localhost.localdomain>
 <20200924221747.mxs56b5inzblu7ui@laptop.redhat>
MIME-Version: 1.0
In-Reply-To: <20200924221747.mxs56b5inzblu7ui@laptop.redhat>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
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
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 07:17:47PM -0300, Beraldo Leal wrote:
> On Thu, Sep 24, 2020 at 03:25:50PM -0400, Cleber Rosa wrote:
> > On Wed, Sep 23, 2020 at 01:12:09PM -0400, John Snow wrote:
> > > On 9/23/20 9:18 AM, Cleber Rosa wrote:
> > > > Relative imports are a source of heated debates, but when properly
> > > > used in a self contained module like here, they are very posititive
> > > > IMO.
> > >=20
> > > Still? I know they were loathed pre-3.5, but in my subjective experie=
nce
> > > they behave the nicest overall in the modern python dialect.
> > >=20
> > > What are the downsides?
> > >=20
> > > --js
> >=20
> > I'll just invite Beraldo to the discussion and let the fun begin :).
>=20
> Nice try, Cleber! ;)
>

C'mon... I was hoping for nothing less than an emacs .vs. vi kind of
discussion.

> Well, relative imports are supported by Guido, so I'm not here to say
> different. There are some use-cases.
>=20
> I'm not fully aware of the qapi context and big picture here, but I
> guess that depends on how you would like to use your package/scripts.
>=20
> Some may say that one "downside" is that relative imports are not as
> readable as absolute ones. But reading the 04/38 PATH description by
> jsnow, yes, looks like using relative imports is one valid option here.
>=20
> I prefer to use my scripts as packages inside venvs, and I use to have a
> setup.py, with absolute imports whenever possible, and when in
> development mode, make use of `python3 setup.py develop` which will
> create the "links" for me.=20
>

Now seriously, these are good point, thanks.  John, I invited Beraldo
to give his take on the subject here because he started this issue
on Avocado land:

  https://github.com/avocado-framework/avocado/issues/3525

So far on Avocado we've kept the relative imports on most places.  We do
have some occurences of "triple upper level" imports that don't look
very nice IMO though:

  https://github.com/avocado-framework/avocado/blob/master/avocado/utils/so=
ftware_manager/backends/rpm.py#L5

> --
> Beraldo
>=20

Anyway, I think we're all in agreement with the approach taken here.

- Cleber.

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9tH3MACgkQZX6NM6Xy
CfP6CA/+IFppcHAQxmqKNuPqQLyi/sXKwqQL0Ob/PzaRl35JkepZd5cx7nVi3Aqj
jVj2bF6+bcd6BiKVgSNoa2OKQm3QYsNj2L8/30uZWxlu128TyaRK2dYcP+c+ZL9B
vyQf/Pg/M98NldImr/tRcnxFOEZwm7XqPAB1TOYKexqMcvIGLOq63OwhK2P3J+OL
mvEV9/I/G1pAhz33u+lBBWzhhkNQsltzjWFtydUHeQYoFU5wH9wrVm4T+Wpl1Zy1
utEj0FYwVNZV10cAnhBisfdwG/I/BEKrz1+qzi21HjEgiK4wbnS93OfHhBErguTj
RNmaCeFynmx1TndarRwk2I7yi9+3cv9dfvydX8asZZyM2zJTbrCmBIp9ijSgqGmc
gpVi2hgG6BRJaOHXUFSP3RGcHOJjhtbCSLVkLAOTaGhr+oColfA6egOui1RyOv1S
lhBr1Blxg6L1CNT57jIdFVDG0fluj94DJn/EcE8gdzvmaHbBZbBwtx1L0HWTfQd1
1jD8ofeIFtDPOPE7ZDkox67btAwneUyNC6YljoB7pcDMDhyDPJ2szzj9LAZseLXI
XLjXqPvWVHMSNSxbO6DJu2e1IiAX9ItO6m7xj/lt/JxCXWfjbTHE9MlvXdDylmxh
O3LBKU/bCSA42FeDn9nIyHuaVNGZw3rA/1V9ugpnKLTHzbgQC10=
=jLSC
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--


