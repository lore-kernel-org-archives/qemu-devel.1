Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF99ECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:13:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48D7A206A1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D7A206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7yh6-0005OK-Ux
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 05:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i7yOy-0007dm-63
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i7yOx-0008KN-48
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:55:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40958)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i7yOq-0008BV-CJ; Wed, 11 Sep 2019 04:54:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 655508980F3;
 Wed, 11 Sep 2019 08:54:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-182.ams2.redhat.com
 [10.36.116.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF68819C4F;
 Wed, 11 Sep 2019 08:54:48 +0000 (UTC)
Date: Wed, 11 Sep 2019 10:54:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190911085447.GD4907@localhost.localdomain>
References: <20190910185839.19682-1-thuth@redhat.com>
 <4ce671ea-452b-39ac-ea2e-83b9d75a3b84@redhat.com>
 <20190911065857.GB4907@localhost.localdomain>
 <5711e370-1d92-4868-39c1-3423c2dd9f42@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
In-Reply-To: <5711e370-1d92-4868-39c1-3423c2dd9f42@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Wed, 11 Sep 2019 08:54:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/7] Move qtests to a separate
 folder
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 11.09.2019 um 10:01 hat Thomas Huth geschrieben:
> On 11/09/2019 08.58, Kevin Wolf wrote:
> > Am 10.09.2019 um 21:07 hat Eric Blake geschrieben:
> >> On 9/10/19 1:58 PM, Thomas Huth wrote:
> >>> Our "tests" directory is very overcrowded - we store the qtests,
> >>> unit test and other files there. That makes it difficult to
> >>> determine which file belongs to each test subsystem, and the
> >>> wildcards in the MAINTAINERS file are inaccurate, too.
> >>>
> >>> Let's clean up this mess. The first patches disentangle some
> >>> dependencies, and the last three patches then move the qtests
> >>> and libqos (which is a subsystem of the qtests) to a new folder
> >>> called "tests/qtest/".
> >>
> >> I'd also welcome a rename of tests/qemu-iotests to tests/iotests.
> >=20
> > I might prefer if the directory were named "iotests" rather than
> > "qemu-iotests" if we were only adding the code now.
> >=20
> > However, I'm not so sure if I'd like a rename now because a rename
> > always comes with a cost and the benefits are rather limited in this
> > case.
>=20
> Well, if we all agree that it rather should be renamed, we should maybe
> rather do it now than later. Later the cost might even be higher.

What I'm saying is that I'm not sure that it should be renamed. What
will we gain from the rename apart from saving five redundant characters
in the path?

Kevin

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdeLZXAAoJEH8JsnLIjy/Wy1gQAIIGAOZLS4PqYKXcHyI4We5l
+gJSX1yRYTc8XRtM+/VqtoDKu4pPEv0LA6U3hE12ZbvuZl3O1MNd2JMMK9aeLyd3
oBFV+YFxuJnbrMq1J42tmyG+lAcFQH21tVdkO6SFcs90Zszt7fxj7uQYbagoMZl2
BUVByt0bkpBF4shE9s37goO21/Y1uR0Py9rOpcliUCVQJAoI0L7GA/rc1n39C7O6
ZIY6+M9XzlqekmXVb2z7pmQ1gq9v8e8Y80/AYVWdjh/MdIT/pz2T9vDoBqN9HTnx
tLb6+FhzRi3RnSpoLQJvLBOqCJyoJP+iw19RgAmKVT/yocJGmQKc6AtZGy6u/Mzq
qomkLIfOKAGUNuRlSXnWYzPnSRYyBxA2jIijRNV+vzqqes57OVZMFN58f3errfrt
6eNaGE9Byc5rOhV1TjizaI+NvxQCIQO4kICtUPB5MvHqJTGm1TDa2YntSsOCahO1
fK8V3W4wYO5gmxFZ2jphW7cCHbauiJ9QQBuYKWTBmjfV43/8M31jVshLMIreYgER
r7baUHvUhRU/DzjZvqnJmg6L5erJAVjW6SHob9DmIuEHFKLh5C75eWd5L9LxN7g3
cI5JXkXAdK6uOCkmFLhoyZsmgLkFAr6p5LqNH9JaelxRY4w/zseJm7Q/li25deKU
mWm3rvMR/BvK5WSbv5KK
=lNVH
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--

