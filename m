Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11A2C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 15:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1DFC20825
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 15:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/kTremi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DFC20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBgRL-0004RU-T2
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 11:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kBgQY-0003zq-UT
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 11:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kBgQW-0000Jk-4k
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 11:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598628986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IQfkV1u2Clrlg3Ol8HzIVWNYEOpwi2PFg5Of+P7CUUE=;
 b=T/kTremiXrqgBc196fewE00KdFdpoEgvsb7HA4Go/TRAHItBHqGS4bT/OPsEc5uPHHovgF
 QFc3UzvG4DyIvlrnKeT/wVDJjZiWpe13RUbLvYB7zUoLjIhgdzQLfj92WyjdIZLgirk+1u
 tf6ZOhLzB9XALN4OM7S31zDywKpVWe0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-kRa-FmSvPZKi-yIuuVxGXQ-1; Fri, 28 Aug 2020 11:36:23 -0400
X-MC-Unique: kRa-FmSvPZKi-yIuuVxGXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A78C81074658;
 Fri, 28 Aug 2020 15:36:22 +0000 (UTC)
Received: from localhost (ovpn-112-204.ams2.redhat.com [10.36.112.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18D795B6B6;
 Fri, 28 Aug 2020 15:36:21 +0000 (UTC)
Date: Fri, 28 Aug 2020 16:36:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/4] tracetool: show trace-events filename/lineno in fmt
 string errors
Message-ID: <20200828153620.GA206776@stefanha-x1.localdomain>
References: <20200827142915.108730-1-stefanha@redhat.com>
 <20200827142915.108730-5-stefanha@redhat.com>
 <CAFEAcA-B_HC-uRBchjtjKx=Zo5fj0Wf3yJA_1h1Rr8-rZm=V0Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-B_HC-uRBchjtjKx=Zo5fj0Wf3yJA_1h1Rr8-rZm=V0Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 11:36:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2020 at 03:59:04PM +0100, Peter Maydell wrote:
> On Thu, 27 Aug 2020 at 15:29, Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
> >
> > The compiler encounters trace event format strings in generated code.
> > Format strings are error-prone and therefore clear compiler errors are
> > important.
> >
> > Use the #line directive to show the trace-events filename and line
> > number in format string errors:
> > https://gcc.gnu.org/onlinedocs/gcc-10.2.0/cpp/Line-Control.html
> >
> > For example, if the cpu_in trace event's %u is changed to %p the
> > following error is reported:
> >
> >   trace-events:29:18: error: format =E2=80=98%p=E2=80=99 expects argume=
nt of type =E2=80=98void *=E2=80=99, but argument 7 has type =E2=80=98unsig=
ned int=E2=80=99 [-Werror=3Dformat=3D]
> >
> > Line 29 in trace-events is where cpu_in is defined. This works for any
> > trace-events file in the QEMU source tree and the correct path is
> > displayed.
> >
> > Unfortunately there does not seem to be a way to set the column, so "18=
"
> > is not the right character on that line.
>=20
> It's been pointed out to me that you could do this by
> making the generated code have suitable line breaks, padding,
> etc, so that the format string in the output ends up starting in
> the same column it was in the input trace file. Whether this is
> worthwhile I leave up to you :-)
>=20
> (The argument number (7 in your example) is also of course off,
> and that I think we're also stuck with. Getting the file and line
> number right is a solid improvement on the current situation.)

Thanks for mentioning that trick. I will leave the patch series as-is
for now.

Stefan

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9JJHQACgkQnKSrs4Gr
c8hiFQf+II+NFeLsjAnv/nyc3Q/ztqHZoMDoK4Go1LnYIhgERySwrmo1KKc5BkGW
t42Dz7ffbdeGx2pjj2yVl4cgD6TolM//7KlYIWfDXe/NqrRC2+vknjJOoZf6RLip
9bjXSRuMZbJmjis4oLFUYfQO0Oin9UcwJ2FXXBFnBetvrEUGqniNO9v0vTb6d5xE
9vrIASi3ZvYxxPUZoYtTkh37NdSV7Ja11X00I52dDkEC+PzXxqtSzPAbVqPphpFF
VbJk9gPy1rnwEjX5tBe10rMg2MTKvwrOxu4qNAREwDmX4v1y0izPsQKqs0dHLLDs
IJEkuciG+ZU6nThujD6nlfSMIGT7gA==
=oe2j
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--


