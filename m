Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E02C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F62205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhPNfB1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F62205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jECyu-00058r-9y
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 10:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jECy3-0004Xz-9n
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jECy1-0005hb-SV
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:13:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24925)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jECy1-0005ed-NI
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584454393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WaxJQScd3Zk21rf7Xu3I7yi9+2aJYAFts8hQzgk2fNs=;
 b=YhPNfB1gfaQwFGMkG3/u8NTpnVGE9H/LAQfQBBESCXU3riVUPO6NtjCimuIRCbfinx8nwt
 wKdlopGUAg7qCvDSCUbqqLv/K6Zb78hOK+PQ7y0Ik3mM4wRDEP9yAzkfqHWBP++5D1m0P8
 RnvYNBV4H0h2odl6vum4FwkXngsNKVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-bLldfXJ-MaC5ZpEiDLpcEw-1; Tue, 17 Mar 2020 10:13:05 -0400
X-MC-Unique: bLldfXJ-MaC5ZpEiDLpcEw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B9FA800D50;
 Tue, 17 Mar 2020 14:13:04 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-2.rdu2.redhat.com [10.10.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9812D7E317;
 Tue, 17 Mar 2020 14:12:59 +0000 (UTC)
Date: Tue, 17 Mar 2020 10:12:57 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/5] QEMU Gating CI
Message-ID: <20200317141257.GA5724@localhost.localdomain>
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA_PiX7LffcT9+1Bdn764fsqsSzUZib-yp=Og0Vpa3oOrw@mail.gmail.com>
 <20200312221619.GA483011@dhcp-17-173.bos.redhat.com>
 <CAFEAcA8=3zcffu8FYEenyNR5O=kHh8OJmMCJj6Uwh5HJw_b-WA@mail.gmail.com>
 <1367332727.1329619.1584360253413.JavaMail.zimbra@redhat.com>
 <CAFEAcA-jiZ=Pv7Co6gdkqKans=m6-9RwKAQuB9mri-baM5Gssw@mail.gmail.com>
 <849930679.1334346.1584361606961.JavaMail.zimbra@redhat.com>
 <CAFEAcA8Lw94_=kY+Fv-cFW2Tk5RD62EjODjKdGf2-mLdDw7FuQ@mail.gmail.com>
 <1182067639.1655516.1584421185287.JavaMail.zimbra@redhat.com>
 <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Wainer Moschetta <wmoschet@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 09:29:32AM +0000, Peter Maydell wrote:
> On Tue, 17 Mar 2020 at 04:59, Cleber Rosa <crosa@redhat.com> wrote:
> > Yes, that did the trick and I can now see the configuration.  What I ca=
n
> > *not* see is any "Specific Runner" configured.  So maybe:
> >
> > 1) The documentation I included is not clear enough about the fact that
> > setup steps need to be done on a machine so that it becomes a "Runner"
> >
> > 2) The (Ansible) playbooks (especially contrib/ci/orgs/qemu/gitlab-runn=
er.yml)
> > is not working as intended
> >
> > 3) Some expectations misalignment on machines that would be available t=
o run
> > those jobs
> >
> > In any case, none of those should be big problems.  Please let me know =
what
> > you did/experienced/expected up to this point, and we can continue from=
 there.
>=20
> Ah, I see. My assumption was that this was all stuff that you were
> working on, so that I would then be able to test that it worked correctly=
,
> not that I would need to do configuration of the gitlab.com setup.

Hi Peter,

So, I had to use temporary hardware resources to set this up (and set
it up countless times TBH).  I had the understanding based on the list
of machines you documented[1] that at least some of them would be used
for the permanent setup.

> I thought all the stuff about "how to set up runners" was only for
> people who wanted to set up some 3rd-party CI for non-official
> forks or for when we wanted to add extra runners in future (eg for
> architectures not yet covered). So the only thing I did was follow
> your "just push to staging" instructions.
>

OK, I see it, now it makes more sense.  So we're "only" missing the
setup for the machines we'll use for the more permanent setup.  Would
you like to do a staged setup/migration using one or some of the
machines you documented?  I'm 100% onboard to help with this, meaning
that I can assist you with instructions, or do "pair setup" of the
machines if needed.  I think a good part of the evaluation here comes
down to how manageable/reproducible the setup is, so it'd make sense
for one to be part of the setup itself.

FIY there's also the possibility of grabbing some free VMs on GCP,
Azure, etc and setting them up as GitLab runners in a temporary way
(because of the temporarily free and VM nature).  I have a few
problems with this approach, including the fact that it doesn't yield
the complete experience wrt using hardware one owns and will have to
manage, besides the hardware limitations themselves.

Please let me know how you want to move on from here.

Cheers,
- Cleber.

> thanks
> -- PMM
>=20

[1] https://wiki.qemu.org/Requirements/GatingCI#Current_Tests

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl5w2uUACgkQZX6NM6Xy
CfNnERAApKFlDSnkXnGqbt3Uclb5qEAhjtxVAFlp83OHnntinkBbFFMRWr9eLGzg
dMUgiqSGGMZie5AcSyEeBwh/VYnDFgnODSh5NlRjLBhJUTe4n9db50N6yXmmE2ON
OJ+QYY7i/vsnsoljYOuDylVYF8JbL7e+dKLCCVotq96WC3fV7b8WgJ1CjyIfo+yj
Xxo6JWc+H1Jzt64YT0vRNl5LrMpg2p46F2+lo21TOGPR+uSyeh63rZUz+dXk9hkB
t5K17Oa8X89axKMMjbQmHtBvoyrVnccPzX3xH1hHznnD/Xhe58VtDn6FESc/uKzH
MGe2bcQXtuivYGfheyXH6DOvNHN/iD9ERH0DNv3eewBiw6iReqAP25xK14DmWy3F
f6r5N86uhE0h44/AHhAFr85NSANfWu8CwSdOzx6J665q6feuBcANsqCfw5Nnqq6G
caEONZB4c57KqA8dj8eBotj/GScof5l4RDXjz99hLg+mcofFGg+ThRahzaLlvV16
g+Fuag2YUkvHYA9x7QbRzZa6rIB+R3id7grZl7rDq4ZcTqlI1tVs2u5uf5Xni28b
zyVhiTGBtR/sSS4G/ROka9nqPM9NJrV0H3fKX5kEbWo0cCrecnlLJs7MTLeecymY
+9qA2jVZI5JZoOgQ8ZVBL9rkj602pRPYtqcbSta7VWdBh1I702E=
=N9Kl
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--


