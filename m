Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D22C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25E8223EA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRVBLKw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25E8223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUbkC-00021d-V2
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 16:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kUbiz-0001Dz-Vd
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 16:25:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34857)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kUbiy-0003PA-A5
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 16:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603139143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gkrYv94pvV2hwa2qdYpvb14r3FB+aT6V7MhtaIAX+xs=;
 b=iRVBLKw17N2dr0Zi/YDooX6coI3B8i00LYW1zWtVSAk0i/xa1QMh9gr/54Vx35/VrZNnFh
 sQoKi9KsU7ha9ZpVy/nJoH5jmK0uqANmiRe1QNol99cG8iA9zlVO3FD3iD8Af6QCYDEAO4
 NIrvsiz4cmumlowcJIhamWA9ktlHgoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-maexN2RDMwS9xzp20UbFuw-1; Mon, 19 Oct 2020 16:25:39 -0400
X-MC-Unique: maexN2RDMwS9xzp20UbFuw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4DCA1009E22;
 Mon, 19 Oct 2020 20:25:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76FC010013D0;
 Mon, 19 Oct 2020 20:25:33 +0000 (UTC)
Date: Mon, 19 Oct 2020 16:25:31 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Erik Skultety <eskultet@redhat.com>
Subject: Re: [PATCH v4 2/4] Jobs based on custom runners: build environment
 docs and playbook
Message-ID: <20201019202531.GB1617151@localhost.localdomain>
References: <20201019015003.1527746-1-crosa@redhat.com>
 <20201019015003.1527746-3-crosa@redhat.com>
 <20201019102741.GC495479@nautilus>
MIME-Version: 1.0
In-Reply-To: <20201019102741.GC495479@nautilus>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 15:28:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>, Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2020 at 12:27:41PM +0200, Erik Skultety wrote:
> ...
>=20
> > diff --git a/scripts/ci/setup/inventory b/scripts/ci/setup/inventory
> > new file mode 100644
> > index 0000000000..8bb7ba6b33
> > --- /dev/null
> > +++ b/scripts/ci/setup/inventory
> > @@ -0,0 +1,2 @@
> > +[local]
>=20
> Nit pick, is a group for localhost actually needed?
>

You're right, it's not needed... I just thought it gave the
"localhost" entry some "shelter" and "context". :)

And, I think a mostly "ini-like" file without a section triggers an OCD
reaction in me.  I can remove it if it does something similar to you! :)

Thanks!
- Cleber.

> Regards,
> Erik

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+N9jgACgkQZX6NM6Xy
CfPEXw//Z/xu/R23urBXpJnt8hwCU57ldkkS3owuJ+gkghHzLHM84uOzuLTQllL1
rL0ZpPpsr3GmHzD60vebHwj/zcwkFf+/d6HRfw1+hJaCFOANnzvayQf3GVTW2r97
50qhjvpa9DOVtibo02Ie/m38Hr0y0uWup5KDCiO3Xs0V/XWvaj7YmAvUKrf0NV81
q6jdpETijuOYiij5Dr42NHFeAfdttdipbEX2CTPAq/xz6NRgt+hiPq3H4xwsi4Fx
6e9vwtcbmvGSQjJvyk0L21l8sRKAIe4OOani8yXybf1LjJTVyK+StWC9cXbWO0Tf
x0asbkl6+pJTDgVqQi45VEj9D7L8couC4THbkquKvPn8cDmkrWgU2NsH5a48pXf6
F2PEeVdgZ/jLgcZuil79b8eEI8XcLmgzM1JLgwpAsNvlCEAWcIvGVRg9fAWzwonC
iu0noM601ONWvpCafKk3hOWKzkG+kV0JV8vxMKQ2xQO+gnYjIPnq7/I+t9rIwzCA
e8+sYiP/AEl6Qhj1GzqTIBq14QJKAmX9PRVa1hETTNeB2FljM5uUkd299WZzV0VO
qxo2tUEYT/EJ46o1LsxMLmCZ2k9uogLSt6+D5KJaL2W42+ACIIG6e3HMX9f2kGLP
p+5WTXsd7BdS4UypuPNwm1vs7M+6rgqROXFnYWzelMKO1ZS9FeA=
=AiXH
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--


