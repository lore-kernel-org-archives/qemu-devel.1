Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88FCC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1C3C21D81
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C3C21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFhkz-0002ct-PR
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 12:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iFhk6-000211-ST
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iFhk5-00075t-I8
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:44:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60654)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iFhk1-000747-VS; Wed, 02 Oct 2019 12:44:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2AB8C10A8137;
 Wed,  2 Oct 2019 16:44:41 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-198.ams2.redhat.com
 [10.36.117.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB7F45B69A;
 Wed,  2 Oct 2019 16:44:39 +0000 (UTC)
Date: Wed, 2 Oct 2019 18:44:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v5 1/5] iotests: remove 'linux' from default supported
 platforms
Message-ID: <20191002164438.GD5819@localhost.localdomain>
References: <20190917234549.22910-1-jsnow@redhat.com>
 <20190917234549.22910-2-jsnow@redhat.com>
 <a252472e-842a-8401-2743-e4ed948b066b@redhat.com>
 <450a1f52-9589-cb98-88cb-1d3fcd5f506a@redhat.com>
 <778487c5-566e-d133-6395-d3908db66adc@redhat.com>
 <62cf912a-8ee9-d023-84c2-1ad6ea94e3b8@redhat.com>
 <16eef993-c16e-3fd7-c60d-6d3c7bfb5148@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <16eef993-c16e-3fd7-c60d-6d3c7bfb5148@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Wed, 02 Oct 2019 16:44:41 +0000 (UTC)
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


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Not sure where in this thread to reply, but since my name is mentioned
in this mail, it might at least be not the worst one.

Am 02.10.2019 um 13:57 hat Max Reitz geschrieben:
> On 02.10.19 06:46, Thomas Huth wrote:
> > On 01/10/2019 20.44, Max Reitz wrote:
> > [...]
> >> As I have said, the conceptual problem is that the iotests now run as
> >> part of make check.  As such, allowing auto tests to run on non-Linux
> >> platforms may introduce build failures that I cannot do anything about.
> >=20
> > Well, simply run "make vm-build-openbsd", "make vm-build-freebsd", ...
> > if something fails there, it likely should not be in the auto group.
>=20
> Then we come to Windows and macOS.
>=20
> What I=E2=80=99ve proposed to John on IRC was to simply skip the iotests =
in make
> check for non-Linux systems.

I think this really makes sense. Or at least have a blacklist of OSes
that we can't support iotests on, which would contain at least Windows
and OS X. Windows because I'm pretty sure that it doesn't work anyway,
and OS X because if something fails there, we have no way to reproduce.
The occasional build failures on OS X that must be fixed by blindly
guessing what could work without any way to test the fix are already bad
enough.

> > Max, I can understand that you are a little bit annoyed that this "make
> > check with iotests" caused some extra hurdles for you. But honestly,
> > removing that again would be quite egoistic by you. Try to put yourself
> > into the position of a "normal", non-blocklayer-maintainer QEMU
> > developer. For me, iotests were a *constant* source of frustration.
> > Often, when I ran them on top of my latest and greatest patches, to
> > check whether I caused a regression, the iotests simply failed. Then I
> > had to start debugging - did my patches cause the break, or is "master"
> > broken, too? In almost all cases, there was an issue in the master
> > branch already, either because they were failing on s390x, or because I
> > was using ext4 instead of xfs, or because I was using an older distro
> > than you, etc... . So while the iotests likely worked fine for the
> > limited set of systems that you, Kevin and the other hard-core block
> > layer developers are using, it's constantly broken for everybody else
> > who is not using the very same setup as you. The only way of *not*
> > getting upset about the iotests was to simply completely *ignore* them.
> > Is it that what you want?
>=20
> It usually worked fine for me because it=E2=80=99s rather rare that non-b=
lock
> patches broke the iotests.

I disagree. It happened all the time that someone else broke the iotests
in master and we needed to fix it up.

> Maybe my main problem is that I feel like now I have to deal with all of
> the fallout, even though adding the iotests to make check wasn=E2=80=99t =
my idea
> and neither me nor Kevin ever consented.  (I don=E2=80=99t know whether K=
evin
> consented implicitly, but I don=E2=80=99t see his name in bdd95e47844f2d8=
b.)
>=20
> You can=E2=80=99t just give me more responsibility without my consent and=
 then
> call me egoistic for not liking it.

I think I may have implicitly consented by helping Alex with the changes
to 'check' that made its output fit better in 'make check'.

Basically, my stance is that I share your dislike for the effects on me
personally (also, I can't run 'make check' any more before a pull
request without testing half of the iotests twice because I still need a
full iotests run), but I also think that having iotests in 'make check'
is really the right thing for the project despite the inconvenience it
means for me.

> I know you=E2=80=99ll say that we just need to ensure we can add more tes=
ts,
> then.  But for one thing, the most important tests are the ones that
> take the longest, like 041.  And the other of course is that adding any
> more tests to make check just brings me more pain, so I won=E2=80=99t do =
it.

That's something that can be fixed by tweaking the auto group.

Can we run tests in 'auto' that require the system emulator? If so,
let's add 030 040 041 to the default set. They take long, but they are
among the most valuable tests we have. If this makes the tests take too
much time, let's remove some less important ones instead.

> [1] There is the recent case of Kevin=E2=80=99s pull request having been
> rejected because his test failed on anything but x64.  I=E2=80=99m torn h=
ere,
> because I would have seen that failure on my -m32 build.  So it isn=E2=80=
=99t
> like it would have evaded our view for long.

I messed up, so this pull request was rightly stopped. I consider this
one a feature, not a bug.

Kevin

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdlNP2AAoJEH8JsnLIjy/WlJYQAILgLHnt80aigacuBaYMPIof
e7Ll/3YVaHaub3KZV+SgNxsVrvxKG2uW+9GnRQ+m87e+QvHrzNHxwyIEnm0Rffpw
RThGs0DSgfTyeQzCBGE/TNQoD9JJ3TQrVXgKKvoAPX8nngz4zFxYhyWwukn8uQId
errhX8whpacC6Cy9V0hSiGxkk0KLjQFK8CVcb/13LJSj3KDMU8+fCJU6NF0jv6IA
siRcqCKi3WwFbZXuniGF5jP1NAIdTb3sWJj0xGIWGsUnmb7T06pbD7BZxAQC8zHO
GLJH9yi5lcTdzjlGs0oJxCZ52D776YyhlQRdB7Jxz40s0yA1GYr9lKDnK69eP4uF
k9NJd8f5aXklZ9Uwu8QJCDUjOcPz1OdHKRczx/4/SDfIq8aPWXDfdV+6D7hEvoOB
Sje9OvR8p10i6acwmfYopM6Hic2UM4qLcJJLxrhnltTWpPHnShpsUR9/s5wDv8q/
XFs7zxYzApyxbH2wONg7u0f1Ti2anEG1prEJ+q6s8sNfcSYKXwyqzAhsFcqNIbwR
me31FehUBtpa2ps2AnPuAjWMghfDa9vm6HJ1f1ynksiCU5uD7H5WkuswGSfB9PiL
xdsmzlTQXSr+5PYy4bpG3yH+1mCjUdWFqJt/fwyC9e+4QhjO3gPZrK66WLvplFlX
FBy4r3LPw6BBOx56iYWV
=fYQT
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--

