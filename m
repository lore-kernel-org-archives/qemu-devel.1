Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6478AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:03:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD3520734
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHOUrZut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD3520734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlYfM-0005tA-Ae
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jlYdK-0004Jv-Ec
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:01:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30888
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jlYdE-0001ez-T6
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592402492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cKBqQbngca+aMvUB6N3SCSzymVSceakTkeKVpYB3VVw=;
 b=BHOUrZut+x/+femqpxuBG7SUZ4fWG/+5B35/e4oaOQ8ES+n7UXimE5O1W9BBFoM8XxGsI2
 OPVRk39wZmYULKql1M6BKk9crh8ru6v5/4A9tKuYisIaP8FESdC7Hu7axN8eArLb4JxIHf
 JZ1PQ+JV8PH2+7wl3vpK24uLgPhJDNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-0WWoU_KQNFeJLxYreXZ8pA-1; Wed, 17 Jun 2020 10:01:26 -0400
X-MC-Unique: 0WWoU_KQNFeJLxYreXZ8pA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48BCF835BB7
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:01:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-214.rdu2.redhat.com
 [10.10.112.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A21BE7A01A;
 Wed, 17 Jun 2020 14:01:18 +0000 (UTC)
Date: Wed, 17 Jun 2020 10:01:16 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Add an entry to review Avocado based
 acceptance tests
Message-ID: <20200617140116.GA402415@localhost.localdomain>
References: <20200605165656.17578-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200605165656.17578-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2020 at 06:56:56PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Add an entry for to allow reviewers to be notified when acceptance /
> integration tests are added or modified.
> The designated reviewers are not maintainers, subsystem maintainers
> are expected to merge their tests.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---

Thanks for this!

Acked-by: Cleber Rosa <crosa@redhat.com>

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl7qIioACgkQZX6NM6Xy
CfP0rQ//Qb9ZnZkH1iLhnRKMc+H5qPZsPetyCcDXaIkMZrt8WGJ/cv/Y+hVybiAh
MzdmJTcJo9sr5NTuTTcNKEr7j3T70j7f2r7Th6+AfCLw1IzEcPoMM2kDHL0XFSqt
yMQ+ItUunDUnhhS5TuFMbH6JYi6Zil8nslrYmZ9+eIp9lb6XWmZrJQD3b+3plbAg
QCFMJ+Y21TkqDrN2kF3nQLCkleHPAwun6vvEqcTftEbObQKUym6UsH0S28R9DEgW
bsLeTooPMYl+58xeZH3s5XcUPFeOPkwBrw3AfOcmVCBdaSGFkZp3sh5EjGPW6cdB
R6DOWjKCMiGfaxUAAc8tRC1DgXObaAiNTKE12nlsCG5NZ5KW8XRg5SC96YKpW2yA
0OFL5nCfotOMyyKLwRb/fg3Rj/ldRC0RQFPDEVgUxz9C10M7ayugO4xNF8QRk4Z+
QDMDgIAHTkQOpQ85xcfB8MzlkX9ycb+cJOkC1QxTdM5QLl8l8AujWQ7VK9A0+Rg7
Mjym14AkSZVkurbzUpB9yVh3+tj8VtdoT9NaauMpxakdiYl3kpIJeVGd1xuVThmE
whroqYGcUbJcaKKKq/8VCWuc67xSUZ87WCijlZXkSkX7ItntvF8VGN3DV975Rj4U
pnQKIIT7Dwys6J0ZN8RJIlixtKEVbiAUHUAcLGNxOYKuUMRCsGk=
=owo4
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--


