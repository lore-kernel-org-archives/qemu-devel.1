Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B679DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 17:23:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B2D822482
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 17:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3tpm2ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2D822482
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxZVV-0004oJ-Gx
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 13:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jxZUf-00046r-RH
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 13:22:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39060
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jxZUc-0003fD-OS
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 13:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595265740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6NpO5cdY36RCAjFtLyhIu/1RYFuVXeT2crrRsHrb6WU=;
 b=e3tpm2ffaLh31vMIibzMiF7akn7pqoRDSSpejfLjQKiq/3vCIuArU+P/Ovip30ZM+r3R7U
 JwTuKUgUWR7tugHPFOE4zJc5NefFJ2aY9gUzUixO3W0WVhh6Zz8OtSAFrP7wSOID2swfX8
 3ddPSClWmGZ+6sZaCTN2QbbqSiSdHZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-2uMVUiGjNb2kNQaW55upMw-1; Mon, 20 Jul 2020 13:22:17 -0400
X-MC-Unique: 2uMVUiGjNb2kNQaW55upMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37C2C8014D4;
 Mon, 20 Jul 2020 17:22:16 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-247.rdu2.redhat.com
 [10.10.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C2E057849A;
 Mon, 20 Jul 2020 17:22:11 +0000 (UTC)
Date: Mon, 20 Jul 2020 13:22:10 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 0/2] QEMU Gating CI
Message-ID: <20200720172210.GA3987025@localhost.localdomain>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <CAFEAcA9qdYm+a-PTPE-Vbhmp4iZ5Bo0Gt-2RcCrO7CS2yp9_CA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9qdYm+a-PTPE-Vbhmp4iZ5Bo0Gt-2RcCrO7CS2yp9_CA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 02:11:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2020 at 05:18:54PM +0100, Peter Maydell wrote:
> On Thu, 9 Jul 2020 at 03:47, Cleber Rosa <crosa@redhat.com> wrote:
> >
> > The idea about a public facing Gating CI for QEMU was summarized in an
> > RFC[1].  Since then, it was decided that a simpler version should be
> > attempted first.
> >
> > At this point, there are two specific runners (an aarch64 and an s390)
> > registered with GitLab, at https://gitlab.com/qemu-project, currently
> > setup to the "qemu" repository.
>=20
> Could I have a simple "this is the command you need to run to
> test your staging branch with the project gitlab" set of
> getting-started instructions, please?
>=20
> thanks
> -- PMM
>=20

Hi Peter,

Sure.  It's important that PATCH 2/2 in this series is included in a
branch that you need to push to the "staging" branch on the
https://gitlab.com/qemu-project/qemu repo (it could be just that one
patch).  Then, you can run:

  ./scripts/ci/gitlab-pipeline-status --verbose -w

And that should be it.  You can drop '--verbose' if you just want the
final outcome as the result.

A longer explanation: that command defaults to checking for the
pipeline associated with the commit for the *local* staging branch.
You can check the pipeline results on other commits, such as the
latest master (by the time I write this):

  $ ./scripts/ci/gitlab-pipeline-status --verbose -c 1e6c50ad8559c18b21041e=
f69d8fff781a8db0bb
  success

Please let me if anything goes wrong, as I wasn't able to submit jobs
to those two machines (did so on emulated ones) and the devil lies
in the details.

Thanks,
- Cleber.

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8V0r8ACgkQZX6NM6Xy
CfNVuA//cIN7sVR6naCTQPluJdsOPPRXEeO3Q8jH1zYJvBVKEkvbaSu6WZUWHhlM
OeWav8ilzjnFR507MlE4hGYiG7BcMcDLx1gweYI5mEoqDlsS+9QRBMexgphbhV1a
UCiZdF0tV0tgB7U2xGCPGPEke5nPzE0z8X4LdQRh9skxtXsWFHPL7Q/mzWKGsY5F
rPCtkDSYcBmBL78RmDB02JobzPwMsDxXodWiLoALW/c92HG6bCJ9HV9BTGNSGfId
TjAX5so2ffSXxd8tzcRp+H5a2Sx8VJf8/boAoS1xJ172Q3eJCPBQfh5A/tAEnaz1
pFAJGtlUcTtiTS63bHEiT5HoxbxSsznjs89E6NzqxrgSpO134d7yBcRdkK3BTsd5
Xh92TbZAr90Sgq/vxMinLMM/Mq9x4RKdG8bTjTlGtY26RYU7iPXelFUxQr1XTXn4
Ndt4d4gw2wD/EInTrNJi/9X4MdGt4TJwY9artv50f9Icctzyq5JglIhoJbR31J4w
O2Q5tk7ieYD4MzU+pO9+LldLBRgEOqy9Rkb1Wpb8FZRa+kSSPb9vEsHmAK4XyEo1
GCAYgFgyP+yFiyDLZKT4UEYvFk9zyD+RcvbAXgFkKmEcmIGkLxoRuN8ag0ASSHRX
jRxaX0hfbZTZU6pWBMaRzEP78WVxprBY1HkQ84AjD6F+jpXsS0M=
=wZ8l
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--


