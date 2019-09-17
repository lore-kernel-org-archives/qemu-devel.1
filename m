Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12072C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3E721670
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3E721670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA92v-00031P-0F
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 04:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iA928-0002Rk-JS
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iA927-0006M4-3y
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:40:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58116)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iA924-0006K2-50; Tue, 17 Sep 2019 04:40:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B66207BDA5;
 Tue, 17 Sep 2019 08:40:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-202.ams2.redhat.com
 [10.36.116.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB9BD60623;
 Tue, 17 Sep 2019 08:40:13 +0000 (UTC)
Date: Tue, 17 Sep 2019 10:40:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190917084012.GA4824@localhost.localdomain>
References: <20190819201851.24418-1-mreitz@redhat.com>
 <20190819201851.24418-7-mreitz@redhat.com>
 <44f97011-4a02-7832-c253-d43474f79d44@redhat.com>
 <a829185c-7c09-5afe-1479-15054ad59807@redhat.com>
 <33f60f4e-8156-e46f-8500-79b0982348b2@redhat.com>
 <c38acedf-d3db-384f-4aea-967ef3f87fdd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <c38acedf-d3db-384f-4aea-967ef3f87fdd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 17 Sep 2019 08:40:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 6/8] iotests: Test driver whitelisting
 in 093
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
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.09.2019 um 10:18 hat Max Reitz geschrieben:
> On 13.09.19 20:30, John Snow wrote:
> >=20
> >=20
> > On 9/13/19 8:47 AM, Max Reitz wrote:
> >> On 20.08.19 23:32, John Snow wrote:
> >>>
> >>>
> >>> On 8/19/19 4:18 PM, Max Reitz wrote:
> >>>> null-aio may not be whitelisted.  Skip all test cases that require i=
t.
> >>>>
> >>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>>> ---
> >>>>  tests/qemu-iotests/093 | 12 +++++++++---
> >>>>  1 file changed, 9 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
> >>>> index 50c1e7f2ec..f03fa24a07 100755
> >>>> --- a/tests/qemu-iotests/093
> >>>> +++ b/tests/qemu-iotests/093
> >>>> @@ -24,7 +24,7 @@ import iotests
> >>>>  nsec_per_sec =3D 1000000000
> >>>> =20
> >>>>  class ThrottleTestCase(iotests.QMPTestCase):
> >>>> -    test_img =3D "null-aio://"
> >>>> +    test_driver =3D "null-aio"
> >>>>      max_drives =3D 3
> >>>> =20
> >>>>      def blockstats(self, device):
> >>>> @@ -35,10 +35,14 @@ class ThrottleTestCase(iotests.QMPTestCase):
> >>>>                  return stat['rd_bytes'], stat['rd_operations'], sta=
t['wr_bytes'], stat['wr_operations']
> >>>>          raise Exception("Device not found for blockstats: %s" % dev=
ice)
> >>>> =20
> >>>> +    def required_drivers(self):
> >>>> +        return [self.test_driver]
> >>>> +
> >>>> +    @iotests.skip_if_unsupported(required_drivers)
> >>>
> >>> Oh, I see why you're passing args[0] back to the callback now. Why not
> >>> just pass self.required_drivers and call it with no arguments instead?
> >>>
> >>> You can get a bound version that way that doesn't need additional
> >>> arguments, and then the callback is free to take generic callables of
> >>> any kind.
> >>
> >> Am I doing something wrong?
> >>
> >> I just get
> >>
> >> +Traceback (most recent call last):
> >> +  File "093", line 26, in <module>
> >> +    class ThrottleTestCase(iotests.QMPTestCase):
> >> +  File "093", line 41, in ThrottleTestCase
> >> +    @iotests.skip_if_unsupported(self.required_drivers)
> >> +NameError: name 'self' is not defined
> >>
> >> this way.
> >>
> >> Max
> >>
> > What was I even talking about? :\ Well.
> >=20
> > I'd still like to define func_wrapper with a nod to the type constraint
> > it has:
> >=20
> > def func_wrapper(instance: iotests.QMPTestCase, *args, **kwargs):
> >     [...]
> >=20
> >=20
> > Then, you'd write:
> >=20
> > if callable(required_formats):
> >     fmts =3D required_formats(instance)
> > else:
> >     fmts =3D required_formats
>=20
> Yep, that anyway.  (Although I didn=E2=80=99t know about the =E2=80=9Cpar=
am: type=E2=80=9D
> syntax and put that constraint in a comment instead.  Thanks again :-))

Note that function annotations are Python 3 only, so we can't use that
syntax yet anyway. If you want to use type hints that are understood by
tools (like mypy) and compatible with Python 2, you have to use
something like this (feel free to be more specific than Any):

    def func_wrapper(instance, *args, **kwargs):
        # type: (iotests.QMPTestCase, Any, Any) -> None
        [...]

Or if you only want to declare the type for one parameter:

    def func_wrapper(instance,  # type: iotests.QMPTestCase
                     *args,
                     **kwargs):
        [...]

Especially the latter syntax might be sufficiently ugly that just doing
a free-form comment that can't be parsed by tools is justifiable.

Kevin

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdgJvsAAoJEH8JsnLIjy/WyIgQAKQyFdK04ZRiimTwZkHLhRhU
LHS+CR4Urd+gk+P2gLhx8Do9e/s3tKkdNG1wglBLLBJ1lGOdhoDoxOFKE+sB8tmY
TLFi8HGvYHArYKcePl93Vgo20wAFGD1tqZoNPO6eECbiY8oXPho1eXWbZDT2Ctj5
ny/fKiEvS0/2Z2upOSMa48IvxRho3zi+0ErA0PHDvFMximl6HtxmbA0zDerE4pWF
EE6NNDzEGs0M3UUSfyX81uNxkf1SGhtTOIPIPLhXZ3PpcfhwNBvris7etejUR8oa
867hxW1rrL6DZ+qSUdGQ7RKBEATNvlLfFj4UUQ6avT37ebF2JesQWyWgAvqqDEjg
MPW9hcnYWzzO4f3aOUec6dmZtAiVtC+6vlFfbkIBP8asOxE2EOClEqA9MrFmEkfF
8u3DyBRNC2QZtBBXIVbibJMmDAxIC7N5Vsub2UggnAQL9kLKOmGbkt6RY8M1A9xZ
AuYlHmjc5e2mRHIGbymlLVdmsxuhHOlIdF/i19TxyIGmT8XddkyE+x20Tfbs9uNW
uCoZAN27zAWjpk27u/wiO0IPlOCNPhmSSvwHVphXd454y/GRrZNKjrJNb/3ENjQa
EaAz6ZWTydDbn0t6EKLVl+DtmTiQ7tws5MkkcKqv2EKXYfw4HSOsO0UbrZqLXOu0
fz7/C6j74jdX5VAcFf6O
=odSk
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--

