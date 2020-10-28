Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9B9C55179
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 22:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AAC92076B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 22:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYICmvSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AAC92076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXu7M-0002ys-Bb
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 18:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXu61-0002Ho-Of
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 18:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41272)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXu5y-0002QI-8F
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 18:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603924743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QivGIrAYdBORxtvvdF280CK4fH3ORFkNf2+cTKIzTk8=;
 b=GYICmvSmk0Ds5tdlKRLYWp6CxpcabmLTAeLW4z4nrdKssjwfJtLx7vhQJqZS+IAixvNdWK
 zZI3p6FzKpt8/h3V/UtpsEFHupNn3oaAH/23pBiSrhR73WtSuftpGle3Q+glKZJKrXw57C
 j2LXDKhhnSfwErOJdXIMQd8sZWU6XcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-5WqQK7nnNoq6k_iB7TrxDA-1; Wed, 28 Oct 2020 18:38:59 -0400
X-MC-Unique: 5WqQK7nnNoq6k_iB7TrxDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2DF51009E54;
 Wed, 28 Oct 2020 22:38:57 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D4CE06EF4A;
 Wed, 28 Oct 2020 22:38:52 +0000 (UTC)
Date: Wed, 28 Oct 2020 18:38:51 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 08/15] python: add pylint to pipenv
Message-ID: <20201028223851.GA2549351@localhost.localdomain>
References: <20201020193555.1493936-1-jsnow@redhat.com>
 <20201020193555.1493936-9-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201020193555.1493936-9-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
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

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 03:35:48PM -0400, John Snow wrote:
> We are specifying >=3D pylint 2.6.x for two reasons:
>=20
> 1. For setup.cfg support, added in pylint 2.5.x
> 2. To clarify that we are using a version that has incompatibly dropped
> bad-whitespace checks.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

I'm not a huge fan of this level of verbosity that pipenv generates,
but at the same time, I've been bitten too many times by not providing
the entire dep tree in a "requirements.txt"-like style.  And it is
what pipenv uses, so there's no way around that.

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+Z8vgACgkQZX6NM6Xy
CfO64A/+Obf7ykDWKaI2vFdm2ciB4l23QVPOneXsyaAeTdHEL7ws3BHx8zi8hupt
JRblDYrGomzd9EvGoK6AqmyK2z8DmKQGadl1TjErtIeiAJRKvCakP60crN3wJepE
VpqK33mAE1os8h0O9ewM2hjJ4XogKQN5L0tb5rpQ4KTx4EQ1xttRUwwNqetveuAa
aQMAUpSFgHtfD7ced7J5lEpd+LduspEV9PjARrwCGsHFqVlFAlHbndIietVdpiXt
jnJzys9vnVBWUxRjhVCENAbeSLp51ykGH738yGmQtN+T4psm4Cf/qj2X791Lcokj
Pjj1qUfBjN/3W9B2QKh1DyfRgdWECxsA4ZKNSlrgbEMFPEeosaGte2GE15w4OirC
55lfZle5OCIgngdODX9OUK5tzk4Wxeqg26v0zYIsqn5xg1ags2ytVa/ULPrKZAuf
zQJH5Lkl7wNrel75fvdEkRMvx8kyCV9ByEE6SPfuK7Kp7fv1o2wzHdg9RgG/xgvc
rTMjmqVYMLIqDUVttXKtfBjgcchzRxTMrFsMiFZjcozuCxKmJpAyWUhgx5w6Pugg
tMXoVz7RNEZAYxjHkGzZr4FqgwFrM1rMgPqwsz6vLeZobbDDYARdmUVsowbt+0n2
Beze4vyngbHUNCaYGE4ACKXMNWqAaQVt3oI+vcSwHNXnTgpJR5s=
=9BPA
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--


