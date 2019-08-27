Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18335C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:13:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E649E214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E649E214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2cEC-0004iS-W5
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 10:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i2cDM-0004GL-8d
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i2cDL-0001KA-2O
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:12:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i2cDK-0001K3-S0
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:12:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 245D443DAF
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 14:12:50 +0000 (UTC)
Received: from localhost (ovpn-116-148.ams2.redhat.com [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F271104B4EB;
 Tue, 27 Aug 2019 14:12:43 +0000 (UTC)
Date: Tue, 27 Aug 2019 15:12:42 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190827141242.GC6901@stefanha-x1.localdomain>
References: <20190823142203.5210-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
Content-Disposition: inline
In-Reply-To: <20190823142203.5210-1-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Tue, 27 Aug 2019 14:12:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] trace: Clarify DTrace/SystemTap help
 message
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2019 at 04:22:03PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Most tracing backends are implemented within QEMU, except the
> DTrace/SystemTap backends.
>=20
> One side effect is when running 'qemu -trace help', an incomplete
> list of trace events is displayed when using the DTrace/SystemTap
> backends.
>=20
> This is partly due to trace events registered as modules with
> trace_init(), and since the events are not used within QEMU,
> the linker optimize and remove the unused modules (which is
> OK in this particular case).
> Currently only the events compiled in trace-root.o and in the
> last trace.o member of libqemuutil.a are linked, resulting in
> an incomplete list of events.
>=20
> To avoid confusion, improve the help message, recommending to
> use the proper systemtap script to display the events list.
>=20
> Before:
>=20
>   $ lm32-softmmu/qemu-system-lm32 -trace help 2>&1 | wc -l
>   70
>=20
> After:
>=20
>   $ lm32-softmmu/qemu-system-lm32 -trace help
>   Run 'qemu-trace-stap list qemu-system-lm32' to print a list
>   of names of trace points with the DTrace/SystemTap backends.
>=20
>   $ qemu-trace-stap list qemu-system-lm32 | wc -l
>   1136
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
> v2: Consider when multiple trace backends are used (Stefan)
> ---
>  trace/control.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1lOloACgkQnKSrs4Gr
c8ifFwf+NxCPQ1gLcb/tsCjNAh+y6I4Cv/dGxoNQRHiDRu4rRYJ4NDNmgW5GhDNO
Yh24LBiJF2OkJIpnQbMhBWptJ+0enAlvD+Sed0vya5VTv2oFYrIUlBlVJLD9Gqoe
lsxRK3UrPHPqT+bb9YqtreRUuE7s1kyUx4qwL51f+ocZ7dwNVjECrDRCtCb8nHwG
t3Nref4FgCLxGwpN1nY40i4ioFjQeMSHhysIR60m098Xy3CXrLQHvX4CSHWCPCCJ
xcUYNTPi2vA7Zk6IJVI0oZoZMb9hgH6jV83kq6XJkBlOCxBnbWQYWpkvARvWbYfL
OOfeLPSqhi64ZAIF78YlnoDhfQEL2g==
=fs1g
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--

