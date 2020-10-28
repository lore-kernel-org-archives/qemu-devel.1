Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F48C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 22:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 313072072C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 22:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJ5zjC/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313072072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXuBb-0005Tx-3z
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 18:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXu95-0004Ak-0Z
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 18:42:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXu90-0002qm-Oh
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 18:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603924932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aKrj6EHtKdqmYWZCREnSs0RCf0iccIdYV/v7FLfWSws=;
 b=RJ5zjC/6HKyIoxfusoJrT1r1FXJhmmqTHNd1JH0Gquu7w+Dk0pev3HbuhfKiaCMc2GSAR8
 gXrLXJxsPIsQJ9/El3/bJ1+IbNsC04iI3MJHtM1Cx7LkC91F01vI+npixXeuQf96ysyplQ
 H5fXHG9x4JnqiNskcjJYYXm8mNMTzUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-jj1hzBmkNdu4Sy9BdhkI-A-1; Wed, 28 Oct 2020 18:42:07 -0400
X-MC-Unique: jj1hzBmkNdu4Sy9BdhkI-A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDFF31007464;
 Wed, 28 Oct 2020 22:42:05 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BBBB5C1D0;
 Wed, 28 Oct 2020 22:41:58 +0000 (UTC)
Date: Wed, 28 Oct 2020 18:41:56 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 10/15] python: Add flake8 to pipenv
Message-ID: <20201028224156.GC2549351@localhost.localdomain>
References: <20201020193555.1493936-1-jsnow@redhat.com>
 <20201020193555.1493936-11-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201020193555.1493936-11-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ben Widawsky <ben@bwidawsk.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Rohit Shinde <rohit.shinde12194@gmail.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 03:35:50PM -0400, John Snow wrote:
> flake8 3.5.x does not support the --extend-ignore syntax used in the
> .flake8 file to gracefully extend default ignores, so 3.6.x is our
> minimum requirement. There is no known upper bound.
>=20
> flake8 can be run from the python/ directory with no arguments.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+Z87QACgkQZX6NM6Xy
CfNGbg/6Ao15WNiB4S5T5SXcnPgjHKGfh2VbYqAP6hVxHeRVhWSNuD48Q0j1OMe8
u+actrCq1igXUALAtSOzVjQFKXKsYUiHGx8RJalN7fQpKd4cX46e/PSk9h+epGdq
YL5K3KDN3G2yTo7XeMA9AArGYvuFnOvd3uM8YreV3ZWM4qWdJE3hpDAXMwaAHnrY
OsQjyiNddZSjD3o8HWjNv8q6qOb1edUxQNXgilqEkoTMvS2QoJMOsEqCvo4wCgZ3
XowQ9DUIJptkkJJhr0ok2MccpvJrKXOE2cTHFIJ9LxNn2aa4QatUSC7N/bk4wKob
c1FZbU6oE79xe9S5gVxZSyJ9NtyjBglpS1a6HYshPjN28Q6g5i5sK1JB6smiD77I
Ayx8VmCobCYac+F20S0KfSC8YEQxio5xZjk338tsVb3lAvjajg7OWsquKPwlwLnN
HTM7pX2J0RrSv0PX8UVMCbvs7h1XVqcQ/DADMkszI+Ao1SKcE2R7uyXx2yW1TFw9
k7ocvd/PLDjVT854AqNYHcDOEjo8YFjxWnoR2VyyUMa5smAQ7iKCeuytoIOPs5/a
AGd4/nQxQDrj4g3sblOI8vpolyPW686NYd2V1CiznH0z+L0UZhGKDbOmp6RRBFWD
RzrRINizkqB6lOshnAxoXk2sPZdW9Lv521f78FhUw76pMuElvoU=
=Eg8t
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--


