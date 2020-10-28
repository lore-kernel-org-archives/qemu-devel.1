Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760A6C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 23:01:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE7820756
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 23:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYmntIQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE7820756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXuRt-0005Wt-GP
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 19:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXuQF-0004pk-F7
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 19:00:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59011)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXuQC-00055W-Da
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 19:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603925998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aMXFi0+BguMdqlXJs3KuGON843iHN90nKizHuyqIUkM=;
 b=BYmntIQL5jw/Cus4HRroOlTH4wU+pHjyB8+8FIg1HaK1WG445USbOfWPLe6MdBbertz3DV
 hR5kfLg3++gzVNQUoyZtLpo/InFnzPWDo2Yq1/Y7lT0neSaL5LSZIeaVWQe5JEXjOmfqUg
 IXhpaARjd/XsikV7rfJVD2WwuW8abfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-ERvrYBH7PmmzmJYmD_5_iQ-1; Wed, 28 Oct 2020 18:59:56 -0400
X-MC-Unique: ERvrYBH7PmmzmJYmD_5_iQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 926196D580;
 Wed, 28 Oct 2020 22:59:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 458D119D61;
 Wed, 28 Oct 2020 22:59:50 +0000 (UTC)
Date: Wed, 28 Oct 2020 18:59:48 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 15/15] python/qemu: add qemu package itself to pipenv
Message-ID: <20201028225948.GH2549351@localhost.localdomain>
References: <20201020193555.1493936-1-jsnow@redhat.com>
 <20201020193555.1493936-16-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201020193555.1493936-16-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0XhtP95kHFp3KGBe"
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

--0XhtP95kHFp3KGBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 03:35:55PM -0400, John Snow wrote:
> This adds the python qemu packages themselves to the pipenv manifest.
> 'pipenv sync' will create a virtual environment sufficient to use the SDK=
.
> 'pipenv sync --dev' will create a virtual environment sufficient to use
> and test the SDK (with pylint, mypy, isort, flake8, etc.)
>=20
> The qemu packages are installed in 'editable' mode; all changes made to
> the python package inside the git tree will be reflected in the
> installed package without reinstallation. This includes changes made
> via git pull and so on.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--0XhtP95kHFp3KGBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+Z9+IACgkQZX6NM6Xy
CfMPMg//V2GGcgbCH/umEcweMu7NTRr+nfv7TBbWwj2kyFhaI4bGE3owH0MjzjGW
PTBsnMMW5p/zgq692/CMbw9ZHwox13OnRUATWw0q/lw0AbFG8Z+nJw+DhR2UbPk6
4vh94/MdLCRoXg3FuTrRjAd4OQP+JdA60qU3kwW2ftIKhgSZgZYaDaBYGKKlz4I4
ge+nIiuhhD6onqW5zqjAjQFUZAjNb4l54sqGtBOmDXba1Xkd13bjoaCoIMPy9BZE
aCN6JjQVqGh/wfJBULGTZacciE6WPSzejvG6BYdVMvsHwYEIQTt1Tqk9diCkTdr3
Jqac90UyCXUTFswmJ9mwYcgMLlZn9ZneakPstI/rEVljVMsO4VdDhZTBvGluip9X
9/lK5il+ZBUjjNqPUSNhVTihssqg2syDBrAJCsPKCh1OhSVsTk4jmPvm4fg2MksA
S1eW6sOKE72OvKK+7wTPzLd/i0s0DAAghQ/ZV2zfAXFoLh0Ds0AW1Gzn4dw1ymLt
KoFVBJNbJWnAVoMaCr2xQZ1x5bYnqsc8F37VvUP3rbJJCYHGf6urCQaLS3YwZOJG
Re9Pql8I6bNMtfl+n8eELaAKQP3dQBn9MHlBMKHon8XL4dUMioJy/X5N0hTeDVcj
2gWRySyVwbPdUtccmnR0HA5G7Ce/LK2Btr92A/rQx5NvfD7VYVQ=
=cVq5
-----END PGP SIGNATURE-----

--0XhtP95kHFp3KGBe--


