Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656D3C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 04:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B2772133F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 04:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2772133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFWYE-0000nK-ES
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 00:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iFWXS-0000Hh-QL
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 00:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iFWXR-0008Lv-9M
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 00:46:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1iFWXL-0008IF-EL; Wed, 02 Oct 2019 00:46:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4E7B481F10;
 Wed,  2 Oct 2019 04:46:50 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-20.ams2.redhat.com [10.36.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BFA75D6A3;
 Wed,  2 Oct 2019 04:46:46 +0000 (UTC)
Subject: Re: [PATCH v5 1/5] iotests: remove 'linux' from default supported
 platforms
To: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
References: <20190917234549.22910-1-jsnow@redhat.com>
 <20190917234549.22910-2-jsnow@redhat.com>
 <a252472e-842a-8401-2743-e4ed948b066b@redhat.com>
 <450a1f52-9589-cb98-88cb-1d3fcd5f506a@redhat.com>
 <778487c5-566e-d133-6395-d3908db66adc@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <62cf912a-8ee9-d023-84c2-1ad6ea94e3b8@redhat.com>
Date: Wed, 2 Oct 2019 06:46:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <778487c5-566e-d133-6395-d3908db66adc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 02 Oct 2019 04:46:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/10/2019 20.44, Max Reitz wrote:
[...]
> As I have said, the conceptual problem is that the iotests now run as
> part of make check.  As such, allowing auto tests to run on non-Linux
> platforms may introduce build failures that I cannot do anything about.

Well, simply run "make vm-build-openbsd", "make vm-build-freebsd", ...
if something fails there, it likely should not be in the auto group.

> And those are very much new failures.
>=20
>> I think that I have demonstrated sufficiently that it's not correct to
>> prohibit python tests from running on other platforms wholesale, so I'=
d
>> prefer we don't do that anymore.
>=20
> You have not.
>=20
> The actual argument to convince me is =E2=80=9CThis does not affect any=
 tests in
> the auto group, so it will not introduce build failures at this time=E2=
=80=9D.

I've applied the patch here and it works fine with FreeBSD and macOS:

 https://cirrus-ci.com/build/5169384718336000
 https://travis-ci.com/huth/qemu/builds/129968676

It also works fine with "make vm-build-openbsd BUILD_TARGET=3Dcheck-block=
"
... so I think you don't have to worry here.

>> Further, iotests on FreeBSD already weren't 100% green, so I'm not
>> causing a regression in that sense, either.
>=20
> My problem is twofold:
>=20
> (1) You claim =E2=80=9CSure, there are failures, but let=E2=80=99s just=
 deal with them=E2=80=9D
> and then you do not deal with them.  Seems wrong to me.
>=20
> I=E2=80=99m fine with the argument =E2=80=9CSorry, royal =E2=80=98we=E2=
=80=99.  But it just doesn=E2=80=99t help
> anyone to hide the errors.  If someone=E2=80=99s on BSD and wants to ru=
n the
> iotests, let them.=E2=80=9D
>=20
> That sounds good to me.
>=20
> (2) Maybe someone adds a Python test in the future that is in auto and
> that does not specify Linux as the only supported platform.  Then I sen=
d
> a pull request and it breaks on macOS.  Now what?  Remove it from auto?
>  Blindly put "macOS" in unsupported platforms?

I think both solutions are good. If a test does not work on all systems,
it either should not be in the "auto" group, or it needs to be modified
to skip testing when running in an unsupported environment.

> In any case, it=E2=80=99ll be a problem for no good reason.

Really? Is "more test coverage" not a good reason?

> More on that in the next chunk.
>=20
>> I'm going to meekly push and ask that we stage this as-is, and when
>> something bad happens you can remind me that I wanted this and make me
>> do it.
>=20
> Make you do what?  Deal with the fact that a pull request is rejected
> because a test fails on macOS?
>=20
> This is precisely the kind of problem I already had with adding the
> iotests to make check, and I=E2=80=99m already very much not happy abou=
t it.
> (In that case it was $DISPLAY not being set on Peter=E2=80=99s test sys=
tem.)
>=20
> I=E2=80=99ll let you make the deduction of =E2=80=9CThe problem isn=E2=80=
=99t allowing the
> iotests to run on non-Linux platforms, but the fact that they run in
> make check=E2=80=9D yourself, so that I no longer feel like I=E2=80=99m=
 the only one who
> considers that having been a mistake.

Max, I can understand that you are a little bit annoyed that this "make
check with iotests" caused some extra hurdles for you. But honestly,
removing that again would be quite egoistic by you. Try to put yourself
into the position of a "normal", non-blocklayer-maintainer QEMU
developer. For me, iotests were a *constant* source of frustration.
Often, when I ran them on top of my latest and greatest patches, to
check whether I caused a regression, the iotests simply failed. Then I
had to start debugging - did my patches cause the break, or is "master"
broken, too? In almost all cases, there was an issue in the master
branch already, either because they were failing on s390x, or because I
was using ext4 instead of xfs, or because I was using an older distro
than you, etc... . So while the iotests likely worked fine for the
limited set of systems that you, Kevin and the other hard-core block
layer developers are using, it's constantly broken for everybody else
who is not using the very same setup as you. The only way of *not*
getting upset about the iotests was to simply completely *ignore* them.
Is it that what you want?

Or maybe let me phrase it differently: Do you consider the iotests as
something that is more or less "private" to the hard-core block layer
developers, and it's ok if others completely ignore them and break them
by accident (and you also don't expect the normal developers to fix the
iotests afterwards)? Then sure, please go ahead and remove the iotests
from "make check" again. Maybe I just understood the idea of having
common tests in the repository wrong (or maybe the iotests should be
moved to a separate repository instead, so that the normal QEMU
developers do not get in touch with them anymore?) ... Otherwise, I
think it was the right step to add them "make check" so that everybody
now *has* to run at least a basic set of the iotests now before they can
their patches merged.

 Thomas


PS: Sorry, if my mail sounded a little bit harsh... but I really had
quite some frustration with the iotests in the past already.

