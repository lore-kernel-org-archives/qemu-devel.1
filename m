Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59C2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:25:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 745072064B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPCZJoxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745072064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jneFN-0008Vi-Mg
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 04:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jneEB-000752-PA
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:24:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24867
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jneE9-000313-2y
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592900660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kycxWQcVheMKsAAbhb52H7whvmXQ8DSj+TuT3J9mU1g=;
 b=GPCZJoxIj9IEtKBTs8unxggGzlpZuUA2DZSgKvf8gC9foX/H6Vn21yZM9cju9v8XBpoBZW
 4kgonC+iAJwyhhT89VnDcoTGP/iex4uFXf+cgO/JXLRP7M8qXX3O+VTIgJtMhacRM/tpt7
 yYSRNkqIHamp7sfo+TB+n0Xh8OKFKDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-mMOqaCwENtafvFw_vo8ioQ-1; Tue, 23 Jun 2020 04:24:16 -0400
X-MC-Unique: mMOqaCwENtafvFw_vo8ioQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40210800597;
 Tue, 23 Jun 2020 08:24:15 +0000 (UTC)
Received: from localhost (ovpn-112-109.ams2.redhat.com [10.36.112.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9F4519D61;
 Tue, 23 Jun 2020 08:24:11 +0000 (UTC)
Date: Tue, 23 Jun 2020 09:24:10 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/2] checkpatch: Do appropriate kernel->qemu renaming
Message-ID: <20200623082410.GA32718@stefanha-x1.localdomain>
References: <20200620133207.26849-1-aleksandar.qemu.devel@gmail.com>
 <CAFEAcA9C+cJ_2DdNQBckNZJEZXiG4jNPsE1HSh9bU5AOrOGMCQ@mail.gmail.com>
 <CAHiYmc5XehmzTB953JP85zTxoqVJX7Hbuak3W0m0QrB2HsQrVw@mail.gmail.com>
 <CAHiYmc6yuh=dExQKMsn9tfp0BAvS4LaxWCcAu1Lq6bYLE6CJXA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHiYmc6yuh=dExQKMsn9tfp0BAvS4LaxWCcAu1Lq6bYLE6CJXA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 20, 2020 at 05:20:41PM +0200, Aleksandar Markovic wrote:
> =D1=81=D1=83=D0=B1, 20. =D1=98=D1=83=D0=BD 2020. =D1=83 17:09 Aleksandar =
Markovic
> <aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > =D1=81=D1=83=D0=B1, 20. =D1=98=D1=83=D0=BD 2020. =D1=83 16:25 Peter May=
dell <peter.maydell@linaro.org> =D1=98=D0=B5
> > =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > >
> > > On Sat, 20 Jun 2020 at 14:33, Aleksandar Markovic
> > > <aleksandar.qemu.devel@gmail.com> wrote:
> > > > There are several places where 'kernel' is mentioned instead of
> > > > 'qemu' in checkpatch.pl.
> > > >
> > > > This small series corrects this.
> > >
> > > So, the thing about this kind of change is that it's implicitly sayin=
g "we have
> > > forked checkpatch and will not try to update to newer versions of it =
from
> > > the kernel tree", because this sort of no-behavioural-change tends to
> > > get in the way of that kind of update by obscuring the delta between
> > > the kernel version and ours. Effectively I think we *have* ended up
> > > with our own fork,
> > > simply because we haven't cared to do that kind of update from the ke=
rnel's
> > > version and we've gradually added our own changes to our copy. But it=
 seems
> > > like it's worth discussing the general principle.
> > >
> >
> > I do not say (explicitly or implicitly) that we should or should not
> > follow and attempt to mirror changes in checkpatch.pl from kernel. (In
> > fact, I think we should.)
> >
> > However, I don't think that several differences (in this series, I
> > thinks altogether 7 lines) that would originate from difference of
> > names QEMU vs. kernel would not be any significant obstacle for a
> > potential future attempts to do comparison QEMU checkpatch vs kernel
> > chekpatch.
> >
>=20
> Sorry, I meant to say:
>=20
> However, I don't think that several differences (in this series, I
> think, altogether 7 lines) that would originate from difference of
> names (QEMU vs. kernel) would be any significant obstacle for a
> potential future attempts to do comparison QEMU checkpatch vs kernel
> checkpatch.

I looked through the 2020, 2019, and 2018 git log for checkpatch.pl and
found few commits that were directly applied from Linux. Some were
rewritten from scratch for QEMU and inspired by Linux commits. In
practice QEMU maintains a fork rather than a mirror of checkpatch.pl.

Let's encourage improvements to checkpatch.pl, even if that means
diverging further from Linux, because it's a valuable tool for improving
coding style, quality, etc. If there is a feeling that changes to
checkpatch.pl are discouraged there will be more coding style
inconsistencies, reviewers will have to point out trivial issues
manually, etc because we're afraid to touch the script.

Stefan

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7xvCoACgkQnKSrs4Gr
c8jdrQf9F/GrKRJQbSRJQdIZS5ML0s8ixvsPR41PIvRhJND2vIC1b7EKWQeeKkcJ
AbQzJkj/nhQTUXzas50kuf5/Qu2pIwrV+0vlKe+dwft0wJgmaW5GqxweXZdg3unK
NI4NQ9JzmdOpa1a1qfc6fTpx9IsLXwze0HqmXMB2Yg5LVYy/+vhVIDllyikYmQpS
dZwOIjIyZ+halqrlgk08AhgNKWZgdB/8CrV02+hCR5pYx1GoAWvqQEXjGYtMPvHN
o6fZDxUIc9rPoHH66AcLYuX8dg/Pjm76aI3rUzt9PFts+kMtgfzTP59I1BSxbl/8
ptZkQptiIcwdEPRhHDdNwB3bKMJGOw==
=T/R3
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--


