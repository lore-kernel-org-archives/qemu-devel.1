Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D8AC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:09:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED93A20786
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSpjvL9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED93A20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBCxz-0002Yb-95
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 04:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1kBCx8-0001Y8-TP
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:08:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32855
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1kBCx6-0002VQ-V4
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598515687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6OEFQl4NltVJYsOI9J7EQaf6eTa+1Onx0awIW4cMnUU=;
 b=ZSpjvL9RqolNyFtLsyo9jcaHMZXoWS0vuP/8w0arsnRIFu8nIMMwQ94AC+mRezUescgsJS
 dRIn9Iv2pMjnAWrDeKfBRViAZwRsarWOmxaTk3sr5jRjChipKFcqHcnmaQsXWf9VipbOwF
 nz3xSAvplRo2duKJP5Lw5ShpShpjhtg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-PDwt6bqyOAafFbhpntbnlQ-1; Thu, 27 Aug 2020 04:08:04 -0400
X-MC-Unique: PDwt6bqyOAafFbhpntbnlQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2336873155;
 Thu, 27 Aug 2020 08:08:02 +0000 (UTC)
Received: from localhost (ovpn-113-131.rdu2.redhat.com [10.10.113.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E163757DC;
 Thu, 27 Aug 2020 08:08:01 +0000 (UTC)
Date: Thu, 27 Aug 2020 10:08:01 +0200
From: Sergio Lopez <slp@redhat.com>
To: Alex Carter <alex.j.carter@gmail.com>
Subject: Re: Why QEMU should move from C to Rust (clickbait alert ;))
Message-ID: <20200827080720.6eks7eoj4m2zlp6e@mhamilton>
References: <CAB12sgLhsgu282Ye=m2pjhdq7BE-zy2LHEdfxuxDdDLEas5+Gg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAB12sgLhsgu282Ye=m2pjhdq7BE-zy2LHEdfxuxDdDLEas5+Gg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=slp@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3wrsltxs25lunnmz"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:42:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, stefanha@gmail.com,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Alexander <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dave Gilbert <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--3wrsltxs25lunnmz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2020 at 04:18:03PM -0400, Alex Carter wrote:
> Hi everyone,
>=20
> My name is Alex, I=E2=80=99m a student at the University of Michigan and =
I just
> completed an internship at IBM Research. There, I have been working on a
> project very related to this topic. I tested using Cloud Hypervisor=E2=80=
=99s
> Rust-based vhost-user virtiofs and block devices with QEMU. Bigger pictur=
e,
> I wanted to explore the implications of using Rust for vhost-user devices
> in QEMU.
>=20
>=20
>=20
> I agree with the points from the original post, namely:
>=20
> =C2=B7      C programming bugs are responsible for a large number of CVEs=
, and
> specifically CVEs coming from the implementations of virtual devices.
>=20
> =C2=B7      As a programming language, Rust has matured to a point where =
it is
> worth considering it more seriously for production use. It has extensive
> libraries and community support. Many big players in the industry are
> already using Rust for production workloads.
>=20
>=20
>=20
> Full Transparency: the Drawbacks:
>=20
> It would be deceptive to only showcase Rust in an ideal light.
>=20
> =C2=B7      The benchmarks I ran show a noticeable performance hit from
> switching to a RustVMM implementation of a virtiofsd device.

I think it'd be interesting to be able to repeat those tests in a
different environment. I ran multiple benchmarks in the past comparing
vhost-user-blk (Rust) vs. qemu/contrib/vhost-user-blk (C) and
vhost-user-fs (Rust) vs virtiofsd (C) and never found that performance
hit.

Much on contrary, I found Rust's zero-cost abstractions promise to
live up even with very idiomatic chunks of code (such as
vm-virtio::Queue).

> =C2=B7      While Rust has matured greatly, it still is missing a bit. On=
e
> example of this that came up was that the rust compiler does not have
> Control Flow Integrity (CFI) features. While these are not as important a=
s
> in =E2=80=9Cunsafe=E2=80=9D languages such as C, the ability to express u=
nsafe portions of
> code does allow for some types of memory bugs =E2=80=93 although to a muc=
h lesser
> extent (an interesting case of this surfaced from Firecracker, and the
> handling of mmio [1]). So further protections such as Control Flow
> Integrity can still be desirable, even with rust code.
>=20
> =C2=B7      There have been years of optimization work put into the C
> implementations of these devices, and it=E2=80=99s hard to evaluate how o=
ptimized
> the relatively novel rust implementations are.
>=20
> A piece of exciting news is that many of these drawbacks show a pathway f=
or
> future improvement. Improvements to rust infrastructure are very realisti=
c.
> Rust boils down to LLVM just like C, so porting over C=E2=80=99s CFI feat=
ures
> should be feasible. If more development resources are put into the RustVM=
M
> project, there is no reason their implementations can=E2=80=99t be as opt=
imized as
> the C versions, and this could be greatly aided by expertise coming from
> the QEMU communities familiarity with these topics.
>=20
>=20
>=20
> I believe vhost-user devices are an excellent place to start since It
> lowers the entry barrier for developing in Rust. The device only has to
> interface with the C-based QEMU binary through a standardized protocol. I=
t
> removes many worries of moving entirely away from C, since adding a set o=
f
> Rust devices would simply be giving more options and room to explore.
>=20
>=20
>=20
> I am putting together the scripts I used for all of the tests at this rep=
o:
>=20
> https://github.com/Alex-Carter01/Qemu-Rust-Testing
>=20
> I am working to standardize everything to make it easier to replicate. I
> would love any community involvement if people wanted to see how results
> differ based on the hardware setup, build configuration of the devices et=
c.

Sounds good. What kind of help would you need?

Thanks!
Sergio.

> The repo also has links to a recording of my original presentation and th=
e
> slides I was using if you would like to look at that format or see the
> discussion which came out of it.

--3wrsltxs25lunnmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl9HaeAACgkQ9GknjS8M
AjVhMA//VuTR16kJO5TQjapdiZ1/3N6U2H/qoA924saTTiSRAe5zmGxqMf5+ZVX8
M3ZmgtFPy0kjRCnmeWc6jXzCd/dxn5dhEpkKeFgxmgQI5OG3OI2Tf5tFQMrPRy0T
qv6o3RlvUJSNpikxpS01zqRfn2yC8QFpebXjYhkiT17pzg0ljxoQ9ZVD5lhfRUQ4
JUsG8BKye56bHozw8YKtZCwQ8ftMxn9GmT8ugsHSmhkr1kMZJA0MiSAUwoyTQFg7
Q60dE+aO6p6EFQ19DG6ZBsA8dmb/FQAgjE70HP2n4yFBEmRTkJ/K0BumHSRU6TM1
ZnozUv6H8Pgg+F9Vehg9Osr0uJllNxDLXOoM2azdRvIukndPKPLVUEvkjx9XIwc+
rw8eQro8f57dckVEcJfzqD+Ek7Om+hlhb3TRDG3rfQcvrIzDrbhH8NgfN1pVrzn/
7Zkbja8Sszp5GjY1B75FU7NPRofl6iRUhmdhpuKTx7ytoYFWurQrGgimf5MC41br
tk883mr0Cml2OS4jeM17wXj+kQY7/uEpZchpBYubjZm3zZcFTj5lQXGZoHHLlurR
DBdBzX3KUGfyUIdKP8aFEneEe21c77DtRyJzEPcPU833x4jC3H9U7nIyKV1WaJ3w
XZxHzFsJvlPMzsvysj+FVPPAjW+d5A8OciY8TFEiulTdOMLKN/M=
=XHby
-----END PGP SIGNATURE-----

--3wrsltxs25lunnmz--


