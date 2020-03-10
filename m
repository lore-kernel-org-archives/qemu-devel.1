Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B405FC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 05:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C4592467C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 05:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQO2A13+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4592467C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBX1p-0002kH-MN
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 01:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jBX14-0002La-G2
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 01:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jBX12-0005M8-SO
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 01:01:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24053
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jBX12-0005Ku-NX
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 01:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583816476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+5fOmMgoPjhPFO1zi+uleB8nSaXAyQQnS7JjAADGUy0=;
 b=hQO2A13+KDqZ5kzANNpqszapiUJYpAaORB5tdZB4bwOBvBNrGkWSGxhyOhOq5qOP5MUpaG
 b9XznP8tVz5VMcQp39vUYyZ9ysqSvntWmTgr/ri/nfoC+72syqfFh9S6yr6adgxvyeWZlM
 v2KdGUMpFw+w+gDNtS5VnjaS/OrrlR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-S3xLnxghPmqaButfSXSN9w-1; Tue, 10 Mar 2020 01:01:12 -0400
X-MC-Unique: S3xLnxghPmqaButfSXSN9w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED4F1800EBD;
 Tue, 10 Mar 2020 05:01:10 +0000 (UTC)
Received: from localhost.localdomain (ovpn-121-175.rdu2.redhat.com
 [10.10.121.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C081A9008F;
 Tue, 10 Mar 2020 05:01:07 +0000 (UTC)
Date: Tue, 10 Mar 2020 01:01:06 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH 2/2] GitLab CI: crude mapping of PMM's scripts to jobs
Message-ID: <20200310050106.GB50141@localhost.localdomain>
References: <20200203032328.12051-1-crosa@redhat.com>
 <20200203032328.12051-2-crosa@redhat.com>
 <a87e5634-903d-2ad5-4f33-b65f77703302@redhat.com>
 <20200207193429.GB13258@localhost.localdomain>
 <CAFEAcA8dF+1a3zjw2MBVfD5k5U4EeU21iOik1mhKqg1ubicA6Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8dF+1a3zjw2MBVfD5k5U4EeU21iOik1mhKqg1ubicA6Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2020 at 01:02:41PM +0000, Peter Maydell wrote:
> On Fri, 7 Feb 2020 at 19:34, Cleber Rosa <crosa@redhat.com> wrote:
> > Also, the build and make steps worked fine without `--disable-gnutls`.
> > I was trying to not carry over any "exception" type of arguments,
> > unless they proved to be necessary.  Maybe Peter can give some more
> > info about this (should it be kept or not)?
>=20
> A lot of those config options are random historical accident:
> I probably added in the configure option to work around something
> years back and then never bothered to undo it. I agree that if we
> don't need to pass that option to run on whatever OS the CI
> job is running on we shouldn't keep it.
>=20
> More generally, I don't think we should worry much about
> exactly replicating the fine detail of the various configurations I

OK, good to hear that.

> currently run on x86. If we basically cover:
>  * a debug build

Which should be covered by the following job (relevant snippets only):

ubuntu-18.04.3-x86_64-alldbg:
 ...
 - ./configure --enable-debug --disable-libssh
 - make clean
 - make
 - make check V=3D1

>  * a non-debug build

I assume the following is a suitable non-debug build:

ubuntu-18.04.3-x86_64-all:
 ...
 script:
 - ./configure --disable-libssh
 - make
 - make check V=3D1

>  * a linux-user --static build

This is roughly the job to fulfill this requirement:

ubuntu-18.04.3-x86_64-all-linux-static:
 ...
 # --disable-libssh is needed because of https://bugs.launchpad.net/qemu/+b=
ug/1838763
 # --disable-glusterfs is needed because there's no static version of those=
 libs in distro supplied packages
 - ./configure --enable-debug --static --disable-system --disable-glusterfs=
 --disable-libssh
 - make
 - make check V=3D1
 - make check-tcg V=3D1

>  * a clang build with the sanitizers enabled [+]

I've tested the following which includes the sanitizers but drops the
'--enable-gtk' option:

ubuntu-18.04.3-x86_64-clang:
 ...
 - ./configure --disable-libssh --cc=3Dclang --cxx=3Dclang++ --enable-sanit=
izers
 - make
 - make check V=3D1

>  * windows crossbuilds

OK, there weren't any windows crossbuilds jobs in this version but I'm
adding them (32 and 64 bits).

>  * a --disable-tcg build

Which should be covered by the following job definition:

ubuntu-18.04.3-x86_64-notcg:
 ...
 - ./configure --disable-libssh --disable-tcg
 - make
 - make check V=3D1

>  * an --enable-tci-interpreter build

Which should be covered by:

ubuntu-18.04.3-x86_64-tci:
 ...
 - ./configure --disable-libssh --enable-tcg-interpreter
 - make

>  * and at least one of the above is done as an "incremental"
>    build and one as a "make clean and then build"

I'm not sure yet how to cleanly accomplish this.  IIRC it suggests
working with different versions of the code in a single job.
GitLab will usually give you the code matching the commit you're
testing.  I believe I could do something like:

 - git reset --hard HEAD~X
 - configure ...
 - make
 - git checkout $PREVIOUS_HEAD
 - make

But I'll have to experiment a bit more with it.

> then that's the same coverage we have today.
>=20
> [+] my scripts do this by hand by passing a lot of extra cflags,
> but IIRC configure now supports a simple 'enable sanitizers'
> option of some kind, which would be OK too
>=20
> thanks
> -- PMM
>=20

Thanks for the very straight answers here.  I'll work
on those two remaining points (windows cross builds, and
incremental builds).

Please let me know if I misunderstood any of your points.

Thanks,
- Cleber.

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl5nHw8ACgkQZX6NM6Xy
CfPqdQ//aXSh2o/f4ZWaLOhjvADaPxTR8ux0VaX5r60FhDTnY/unfeLK8Bpv98B7
aGc8H0KL0EytydHV/EVWR2VCAwyJrnied7W1GyUd7yHH2ptYJkLTl9opJj1cWxNp
8fgmvAQmdrGcYNo1n/db8UwhFD+uljrYscdzp2kpX8nTdK9Rp+4SwWpPRCdaOB+v
0MV4ehzlMwQ+thCro2+2G5Hr88n2SrXS39T7iNXzDyxlcC4Dhblkwc+23IixYIR9
DtHcImgHfXLGv/Q7Ix9bZ9XUQ42twFnnzqpjuOvGq4/b4RkA9ccIbBGDcDWUkZ6W
zfnihGXqvhYKMyb4mIGd8X8PreAYZrUMkZNu9urVt4moUhRBNhCQZ2scOakBBn5f
xkzWUZmVtHGDGqEuBJs/zyY0DdMP4uhGOwwtceEpG959rE/fKNg1IpCFPc4fPQcR
vDB8lvXWDXuBsH7z2Dut6Y0gpPPTnL8KsIUncek+OT77K8IF/oWe5MGfz3WRZSrn
+1Zfet4smG+ZjaXgqVpw7iltxm/+++/823LsF8eJ+n2BhgndAb+zCP4DqlIkjHxc
LTRxoGTuWuhM6c8XTKVAkgN3GfEBkPqU4hxz33ORr5gGzwrjjLMxnusNjXxrE8dp
EO4PhzG4zPO6n/7XMWK2RGjfcPsuqiucfXfwMlaOB9RCnb1yPH8=
=VEGF
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--


