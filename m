Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897FFC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 03:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55968208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 03:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/31DMZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55968208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBVyv-0002gD-Fi
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 23:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jBVxp-0001iV-MZ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 23:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jBVxn-0002i2-Rq
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 23:53:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22581
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jBVxn-0002eS-HD
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 23:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583812430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jt7cymyYuwMcKPTW19TfZafqDIegC6QQctYzoyMyWeY=;
 b=F/31DMZQTBULoYacIbaiwML8ISaEUDHkHlKh4ETVuZ2p92dcA93hE7weahbgbhkKcQoHxi
 HMiCDqMpUz5RkUBGLAxBwAOdadg4FVXndkRfLaF5DTX4bpC3d3NfFoj0vT7RdxBcngEWuF
 dNf3+wNulu9vO7TeNeJ5uDprS+VtnBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-uOnD1hN8MiOAYNL7nhKRRw-1; Mon, 09 Mar 2020 23:53:47 -0400
X-MC-Unique: uOnD1hN8MiOAYNL7nhKRRw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1460318C35A2;
 Tue, 10 Mar 2020 03:53:46 +0000 (UTC)
Received: from localhost.localdomain (ovpn-121-175.rdu2.redhat.com
 [10.10.121.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 584CE1001B0B;
 Tue, 10 Mar 2020 03:53:45 +0000 (UTC)
Date: Mon, 9 Mar 2020 23:53:43 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH 2/2] GitLab CI: crude mapping of PMM's scripts to jobs
Message-ID: <20200310035343.GA50141@localhost.localdomain>
References: <20200203032328.12051-1-crosa@redhat.com>
 <20200203032328.12051-2-crosa@redhat.com>
 <80f87c73-ed38-cba6-f551-20c7f5a46264@redhat.com>
 <e7aea58f-8ed0-239f-04d8-934c8c00e51d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e7aea58f-8ed0-239f-04d8-934c8c00e51d@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2020 at 02:05:04PM +0100, Philippe Mathieu-Daud=E9 wrote:
> >=20
> > On another thread Thomas said he doesn't want to be responsible of othe=
r
> > tests:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg670132.html
> >=20
> > We could move the set of tests converted from Peter personal testsuite
> > into a separate YAML, so the interested (you Cleber, and Peter) can hav=
e
> > a F: entry in MAINTAINERS for it:
> >=20
> > include:
> >  =A0 - local: '/.gitlab-ci-pm215.yml'

Yep, I agree this is a good idea. I'll be following that pattern.

>=20
> I'm not calling this file "pm215" because Peter owns it, but because it
> would contains all the tests Peter was running manually before we use Git=
Lab
> as a gating CI.
>=20
>=20

One small difference is that I feel that Peter wants this to be
less about him, and more about a established set of jobs to gate on.

So, I'll be using the ".gitlab-ci-gating.yml" file name for now, unless
my perception is badly calibrated. :)

Thanks!
- Cleber.

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl5nD0QACgkQZX6NM6Xy
CfOf4g//aVeu21bLatwdy6tvswXOfN0xs6Rlj79rpuFThOFlA0MyhW30h/84WxYu
TbThp1179mqlOprBWkPtKR/564o3pEtucc6kxR52fM/KEDmvjdLStpCcchwyKRdx
pDP59cYIqsfYUScc2WQ9gPtzTNa3+qhNZZZ1wi03QmX7SdrlQP13AUNx1Cx6yKk9
bjIYMmWbmAiMXhvVFyIFE14JGIFm3oeNKNCcYaDKcz4O7Hw0Q1ZrbK3+dfQO7zVy
6a2DN8NqgdLodEI5YqrH1Isf8aZwWXzK4s6ugHxvR+ztT82j0waGd8xv7G//goqV
TT/jTqx0O0gy98oDlTwrG5S8ZlqOpzVglH7Nr3oi0a74HJrSB1bwBpX3Lv1No/VC
0ac87n6DbAljr93/JlLxJdmALHsCkGfqDk2ID6Qk8bGwWWxdJgMbzKQgF1OTcer1
gdiOr7CLk1Xah0ZOhYsghVIHJIVi8c9wmPBMcazPLgyKxL9gcOI7yHQXvcdt09H8
HWRYCKBpmzB4DheMCJHabD3SM12EfbUeVJU0S/ObujVeQWgr6QGdqmZEfoyrK6hl
dRIRtUwINFSgUwNYbiGTIxmccN92zzuDAdRUyP8T9B7moGPuPEFLj2wbCl6cyvjH
sr3XedYlErXJvFq9gm9re/Om5GGXWbn1JxWq+hlokocuszjOaas=
=vFBk
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--


