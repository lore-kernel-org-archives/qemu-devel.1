Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E4EC47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D8922133F
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8922133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGLe5-00076X-BZ
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 07:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iGKgv-0007GH-P0
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 06:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iGKgt-0002K1-GW
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 06:20:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3419)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iGKgp-0002CS-Fa; Fri, 04 Oct 2019 06:19:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EC91E335DC;
 Fri,  4 Oct 2019 10:19:57 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C5696060D;
 Fri,  4 Oct 2019 10:19:54 +0000 (UTC)
Date: Fri, 4 Oct 2019 12:19:52 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v5 1/5] iotests: remove 'linux' from default supported
 platforms
Message-ID: <20191004101952.GC5491@linux.fritz.box>
References: <20190917234549.22910-1-jsnow@redhat.com>
 <20190917234549.22910-2-jsnow@redhat.com>
 <a252472e-842a-8401-2743-e4ed948b066b@redhat.com>
 <450a1f52-9589-cb98-88cb-1d3fcd5f506a@redhat.com>
 <778487c5-566e-d133-6395-d3908db66adc@redhat.com>
 <62cf912a-8ee9-d023-84c2-1ad6ea94e3b8@redhat.com>
 <16eef993-c16e-3fd7-c60d-6d3c7bfb5148@redhat.com>
 <20191002164438.GD5819@localhost.localdomain>
 <a7f532cc-68cb-175e-6c8f-930401221ef9@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <a7f532cc-68cb-175e-6c8f-930401221ef9@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 04 Oct 2019 10:19:57 +0000 (UTC)
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
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 02.10.2019 um 19:47 hat Max Reitz geschrieben:
> On 02.10.19 18:44, Kevin Wolf wrote:
> > Am 02.10.2019 um 13:57 hat Max Reitz geschrieben:
> >> It usually worked fine for me because it=E2=80=99s rather rare that no=
n-block
> >> patches broke the iotests.
> >=20
> > I disagree. It happened all the time that someone else broke the iotests
> > in master and we needed to fix it up.
>=20
> OK.
>=20
> (In my experience, it=E2=80=99s still mostly block patches, only that the=
y tend
> to go through non-block trees.)

Fair enough, it's usually code that touches block code. I assumed "block
patches" to mean patches that go through one of the block trees and for
which iotests are run before sending a pull request.

In the end, I don't care what code these patches touched. I do an
innocent git pull, and when I finally see that it's master that breaks
iotests and not my patches on top of it, I'm annoyed.

> >> Maybe my main problem is that I feel like now I have to deal with all =
of
> >> the fallout, even though adding the iotests to make check wasn=E2=80=
=99t my idea
> >> and neither me nor Kevin ever consented.  (I don=E2=80=99t know whethe=
r Kevin
> >> consented implicitly, but I don=E2=80=99t see his name in bdd95e47844f=
2d8b.)
> >>
> >> You can=E2=80=99t just give me more responsibility without my consent =
and then
> >> call me egoistic for not liking it.
> >=20
> > I think I may have implicitly consented by helping Alex with the changes
> > to 'check' that made its output fit better in 'make check'.
> >=20
> > Basically, my stance is that I share your dislike for the effects on me
> > personally (also, I can't run 'make check' any more before a pull
> > request without testing half of the iotests twice because I still need a
> > full iotests run), but I also think that having iotests in 'make check'
> > is really the right thing for the project despite the inconvenience it
> > means for me.
>=20
> Then I expect you to NACK Thomas=E2=80=99s patch, and I take it to mean t=
hat I
> can rely on you to handle basically all make check iotests failures that
> are not caused by my own pull requests.
>=20
> Works for me.

Ah, we can also play this game the other way round.

So if you merge that revert, when iotests break in master, I take it I
can rely on you to fix it up before it impacts my working branch?

> >> I know you=E2=80=99ll say that we just need to ensure we can add more =
tests,
> >> then.  But for one thing, the most important tests are the ones that
> >> take the longest, like 041.  And the other of course is that adding any
> >> more tests to make check just brings me more pain, so I won=E2=80=99t =
do it.
> >=20
> > That's something that can be fixed by tweaking the auto group.
> >=20
> > Can we run tests in 'auto' that require the system emulator? If so,
> > let's add 030 040 041 to the default set. They take long, but they are
> > among the most valuable tests we have. If this makes the tests take too
> > much time, let's remove some less important ones instead.
> >=20
> >> [1] There is the recent case of Kevin=E2=80=99s pull request having be=
en
> >> rejected because his test failed on anything but x64.  I=E2=80=99m tor=
n here,
> >> because I would have seen that failure on my -m32 build.  So it isn=E2=
=80=99t
> >> like it would have evaded our view for long.
> >=20
> > I messed up, so this pull request was rightly stopped. I consider this
> > one a feature, not a bug.
>=20
> Sure, that was a good thing.  I just wonder whether that instance is
> enough to justify the pain.

Yes, making iotests stable on CI probably involves some pain, especially
initially. However, if we don't fix them upstream, they'll end up on our
desk again downstream because people run tests neither on your nor on my
laptop.

I think we might actually save time by fixing them once and for all,
even if they are problems in the test cases and not in QEMU, and making
new test cases portable from the start, instead of getting individual
reports one at a time and having to look at the same test cases again
and again.

Kevin

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdlxzIAAoJEH8JsnLIjy/WLX4P/0oT0ZqAGxNqgs25eRRy5UCs
vKH/Bpj84TP52/PmuPvyp16AJqknOQ1Rk4A8HCWK6MqM5dcfYKT0/X2A2Gr0DJp1
JSYEckzOdwMlv80c9wdaB/Vj3c3LNRualnZi+LNA555u2ByCg7pwhxdrDSdpdjxG
5ffsUCAQJ+HLSbTIJcRuIUJlnEHDdfaT9aGNJ8ti9dudN2fSARxQ1Tn7WruAbN0U
eAE7UvlzW3jpsj8vNATxd1VE9wobMin/EgeszejMFvkMsBoiG8Y+2U2Wc21Cnt7D
OJmSxBrN7PyN2atVJXGBRhW4/Z0aqezviPFGxY0/OnOehiWzC5mUX8o8l7IFxp2V
75boweamxQgwkB7q7h7oWgLaLsDKqIY5n6D1vwv96Bsmt/9cKPQPWaSopiKtdelZ
m+6Xuc9uGZMPLKmTI0yzIGagabGmGJWi3KJZmkP1b6mErrArN+tgRh7+Mt2rxnqt
E0dZ+ULhJmySGaBylhfChzpyDIKnSZdQgAOkVGSsbV9uWVOEY5j5VgscJolrQh+7
H0cuD7CCSfL3cuVRi69AYeWHGk4gj6BiOC4d9q1WYYSwfqB63MPd6K44aszpSKGU
vJckcvF2qpkxiZctahFKbUiZF9W/KwjJICIFCkNLfxWDai86NwmNmkBuRsFaYSgK
mDd3ndyd56TuKuWX16Fn
=SKs8
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

