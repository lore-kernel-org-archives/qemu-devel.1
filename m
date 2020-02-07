Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3073C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 19:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A26AE21775
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 19:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9mAIQxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26AE21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j09If-0004QL-QH
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 14:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1j09I5-0003zU-7C
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 14:27:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1j09I2-0005Zq-8G
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 14:27:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52677
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1j09I2-0005Xo-4D
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 14:27:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581103664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dy7YNP4j08Xx7/OkkBl4n5By2SNarg5X8NK5JnGYinE=;
 b=Q9mAIQxTpy52pxeZT+C4tEzXN2rbcFnxgZ2xn3anj+KXDAGiX6PLkqGKteXpCdp0Cjx82D
 9gkGLxNjF0tcvaf8y3/tO4OwGeCe4IS4g8HHorO4a3ZJW5UDLqQdoy0PG2qdwHeD+9q4LW
 TzOr5+ajgCJrAbw2yvvmJnRNgNQo7NM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-GlfF85_DNiqx5E4rDT9HSw-1; Fri, 07 Feb 2020 14:27:40 -0500
X-MC-Unique: GlfF85_DNiqx5E4rDT9HSw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BC46800E21;
 Fri,  7 Feb 2020 19:27:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-208.rdu2.redhat.com
 [10.10.123.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2094C1001B28;
 Fri,  7 Feb 2020 19:27:36 +0000 (UTC)
Date: Fri, 7 Feb 2020 14:27:34 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH 2/2] GitLab CI: crude mapping of PMM's scripts to jobs
Message-ID: <20200207192734.GA13258@localhost.localdomain>
References: <20200203032328.12051-1-crosa@redhat.com>
 <20200203032328.12051-2-crosa@redhat.com>
 <5d0def0e-0943-3345-784d-80f8ccc318b9@redhat.com>
 <CAFEAcA8HPvzaxA1pguscX5FsuWvpJhkDAuFSApofabEWVzzjQQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8HPvzaxA1pguscX5FsuWvpJhkDAuFSApofabEWVzzjQQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2020 at 04:26:53PM +0000, Peter Maydell wrote:
> On Fri, 7 Feb 2020 at 08:37, Thomas Huth <thuth@redhat.com> wrote:
> > Question to Peter/Alex/Stefan/Howevermergespullreqsinthefuture:
> >
> > Should the above jobs really be skipped for pull requests, or would it
> > be ok to include them there, too? (in the latter case, the above change=
s
> > could just be dropped)
>=20
> I don't mind, as long as the CI run doesn't take more than (say)
> 1h to 1h30 elapsed time to complete from kicking it off to getting
> all the results back. The specific set of x86 configs tested don't
> really worry me (as long as we do have a reasonable spread):
> the thing I really care about is that we get the multiple
> host architectures and the BSDs into the test setup. (We already
> have about five different ways of doing CI testing of x86 Linux
> hosts, which is the least likely setup to break. It's the
> other host configs that I'm really keen to see progress on
> automation of, because that's what's really blocking us from
> being able to move off my hand-coded scripting.)
>

I can imagine how important the average runtime of those checks is to
Howevermergespullreqsnoworinthefuture.  Now, being a bit more selfish
or paranoid, I see the importance of separating those different types
of checks (pre-PR and others) until we achieve a stable environment
for the former.  I do see an extended amount of testing at every
stage as one of the later goals of this effort, but we have to match
that with both computing and human capacity.

In short, I'd suggest keeping them separate *for now*.

> In the long run we should probably aim for being consistent about
> what we test between the pull-request tests and whatever the
> 'public-facing CI' part is.
>

Right.  I think this will be an exercise in capacity planning, and
ideally, if there are no resource constraints, all checks could be
performed at all times.

> > > +ubuntu-18.04.3-x86_64-notcg:
> > > + tags:
> > > + - ubuntu_18.04.3
> > > + - x86_64
> > > + rules:
> > > + - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
> > > + script:
> > > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree=
/remake-merge-builds#n35
> > > + - ./configure --disable-libssh --enable-debug --disable-tcg
> > > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree=
/pull-buildtest#n35
> > > + - make
> > > + # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree=
/pull-buildtest#n39
> > > + # Question: check is disabled on the original script, because the m=
achine
> > > + # is said to be running VirtualBox.  Should this be dropped or shou=
ld the
> > > + # machine be tweaked or substituted?
> > > + - make check V=3D1
> >
> > Without TCG, you definitely need a host that can do KVM for running mak=
e
> > check.
> > Question for Peter: Would it be ok to drop this job and simply always
> > use the "build-tcg-disabled" job that is already available in
> > .gitlab-ci.yml ?
>=20
> If we have a CI setup where KVM reliably works then we should
> ideally test a --disable-tcg setup somehow. Right now my pullreq
> tests don't test that because I run them on my work desktop box
> and (as the config says) sometimes I'm running VirtualBox which
> causes KVM to fail -- but that should be irrelevant to our CI
> runners...
>

You got me confused here Peter.  Do you intend to reuse the same
machines you're using now (say your work desktop box) or is there an
expectation for different machines to be introduced and used for these
jobs?

> thanks
> -- PMM
>=20

Thanks for the feedback,
- Cleber.

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl49uiMACgkQZX6NM6Xy
CfNF+RAAsDDe79K+JoyCJ09UCEmlTsFWb2RvtqIqpiNZZmoLpIJgvtrY/1eKE2W0
GUx+ZAxQFyS88t0PejKvqQZJJS1B/h7MRE5rFg7bH9xZFmmIMG8FrqsQ0AIrBWtZ
NG1vBGQxvY6UW56z6o9wWuPL/DgSxzpmZo7jp5OT42do2gc+E3z5j/xb8s7GvO17
RcQQoDsnXya8QYgLmQYAYDKa/SYnjbscdRZQ8BoKIzJnc1eK3RIVJbDb/LiVwels
CT419cm81uM2zZTiRHuxA6Pq0ECMZIH2lGfG9rhQS8RfYAqLE/70Z/bhUAugtsmW
xYkrWXjvC9did+Awf5ulx2G2oPmnMM7140OKcIKjWH5131jNq9FZ8wDh7qRSxEPC
RXU8X3N6YsSVS4NQW7Hr8YYutgT+joOJvJHO2M0o2MTT7e33JnNn9Amva7W5wX/B
8QJmYf+6d0R6PehMMMvmFM5SUPfMa+E0ZCUhGak/TQOft52TBzdEqnM/mlKcHXVt
pcA2L2NsKJvIPoxN1kxGc1e4KruGpCHlazX6XUvI97J6NhELuUjtpipaAhtKG8fj
XuSQx5Lr3bXixzeex4wVtVYoOaJ89T0EhBk8w1qwLZTuyiEOPfs76nqPrKYcRSKQ
NqKx02cj4HiVOHthNCrTcNl39iGDRNu4AkyYqPTrRu9RdTIwXyc=
=nN/0
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--


