Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2628ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED6C20854
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED6C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLVVm-0005es-VP
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iLVUu-0004kk-NW
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iLVUt-0001dC-Fb
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:53:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43754)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iLVUp-0001bV-Nm; Fri, 18 Oct 2019 12:52:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4EFA22EF175;
 Fri, 18 Oct 2019 16:52:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-198.ams2.redhat.com
 [10.36.117.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C676F600C4;
 Fri, 18 Oct 2019 16:52:54 +0000 (UTC)
Date: Fri, 18 Oct 2019 18:52:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH] iotests: Skip read-only cases in 118 when run as root
Message-ID: <20191018165253.GI6122@localhost.localdomain>
References: <20191018115127.2671-1-kwolf@redhat.com>
 <a810971a-639e-e7dc-d5e6-6b0bb524079b@redhat.com>
 <20191018142720.GH6122@localhost.localdomain>
 <69055f0f-70a3-2a94-01f8-82fe3e8bca7b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <69055f0f-70a3-2a94-01f8-82fe3e8bca7b@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 18 Oct 2019 16:52:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 18.10.2019 um 17:00 hat Max Reitz geschrieben:
> On 18.10.19 16:27, Kevin Wolf wrote:
> > Am 18.10.2019 um 14:59 hat Philippe Mathieu-Daud=C3=A9 geschrieben:
> >> Hi Kevin,
> >>
> >> On 10/18/19 1:51 PM, Kevin Wolf wrote:
> >>> Some tests in 118 use chmod to remove write permissions from the file
> >>> and assume that the image can indeed not be opened read-write
> >>> afterwards. This doesn't work when the test is run as root, because r=
oot
> >>> can still open the file as writable even when the permission bit isn't
> >>> set.
> >>>
> >>> Introduce a @skip_if_root decorator and use it in 118 to skip the tes=
ts
> >>> in question when the script is run as root.
> >>>
> >>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >>> ---
> >>>   tests/qemu-iotests/118        |  3 +++
> >>>   tests/qemu-iotests/iotests.py | 10 ++++++++++
> >>>   2 files changed, 13 insertions(+)
> >>>
> >>> diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
> >>> index ea0b326ae0..9eff46d189 100755
> >>> --- a/tests/qemu-iotests/118
> >>> +++ b/tests/qemu-iotests/118
> >>> @@ -446,6 +446,7 @@ class TestChangeReadOnly(ChangeBaseClass):
> >>>           self.assert_qmp(result, 'return[0]/inserted/ro', True)
> >>>           self.assert_qmp(result, 'return[0]/inserted/image/filename'=
, new_img)
> >>> +    @iotests.skip_if_root
> >>
> >> Why not have case_notrun() return 'reason' and use:
> >>
> >> @unittest.skipIf(os.getuid() =3D=3D 0, case_notrun("cannot be run as r=
oot"))
> >=20
> > Because we can't skip test cases using unittest functionality, it
> > results in different output (the test is marked as 's' instead of '.'
> > and a message '(skipped=3Dn)' is added), which means failure for
> > qemu-iotests.
>=20
> Not arguing that we should use unittest skipping here, but my =E2=80=9CSe=
lfish
> patches=E2=80=9D series allows it:
>=20
> https://lists.nongnu.org/archive/html/qemu-devel/2019-09/msg03423.html
>=20
> The advantage is that using unittest skipping works in setUp, too.

Ah, good to know. If this had already been in master, I might have
chosen a simple function call iotests.skip_if_root() inside the test
function instead of using a decorator. But in the end, I don't think it
makes a big difference in this case.

Kevin

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdqe3lAAoJEH8JsnLIjy/WWXEP/2AzbqgIORtc1BdIZhHW7769
fWrG0U142x56D3T433YoWuj7lIcfBh3kEJ9IFb0ae1ZnCbgiRq87ce2hngGV65/P
l6byhWdulo7P/J5EqcWW8us1Kd1/sjkOeqEjqQFex13zx0Igsq+f4OXLlrzlISog
7VVwdST6LKcI5Qyti0Opquq3yxxuVeUI1QTYON0dCRQhOS8b3bg4CYWa8Etr09vT
LhN6+OTDaIRcxXLZ7SvMvCRYjGlzBuBSbJM+KnJnGcNb23SPKiuYW97UMhjcy56s
1Gr3nksJg+UMXPh96njuwJFE6TTKwVv5ZadA4nIk4ZMhCpWAXFloas94/pw8uXGH
Ro4cKxGmfoIHCjEIl/UfwH9NYiPR9x4IkTYUySR6kNIo7nwWmIKO7FG+h297l4kF
c+72TaK2yisOSCbsrbxC36GSL1I5bgERcg3k3CWbOVvw/QSPFuMqKRlrqASuJMPO
woxc4N2YZoqPS5c1FDvhKITo4IC+lm76ITOepARqTjWmjDSoI7Scn2MZRtvXbfEz
1sspwRD+wwVICrijRZhJaiXGSxgPTR+DEa6gCgBtHheZ1pfsL1Z8Uyv7aNy/yvlC
JPwHHeIzyQqaQCFiBtGtzWpcCneiz5hm/cnkvboQBx2huj70doAHVliKDB6bocfL
2WKYnbotVa/Js2NqrcEA
=8Uj+
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--

