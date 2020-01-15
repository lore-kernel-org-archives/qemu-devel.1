Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2E9C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 07:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9190624655
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 07:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9190624655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irdOl-0006tU-N2
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 02:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1irdO5-0005bQ-BN
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 02:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1irdO1-0000ax-Ot
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 02:46:49 -0500
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:56428)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1irdO1-0000ZJ-Ig
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 02:46:45 -0500
Received: from player774.ha.ovh.net (unknown [10.108.16.135])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 2EAC212A8F1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 08:46:42 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player774.ha.ovh.net (Postfix) with ESMTPSA id 794D1E4CF170;
 Wed, 15 Jan 2020 07:46:22 +0000 (UTC)
Date: Wed, 15 Jan 2020 08:46:21 +0100
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v6 01/11] qapi/error: add (Error **errp) cleaning APIs
Message-ID: <20200115084621.5f8d1b10@bahia.lan>
In-Reply-To: <20200110194158.14190-2-vsementsov@virtuozzo.com>
References: <20200110194158.14190-1-vsementsov@virtuozzo.com>
 <20200110194158.14190-2-vsementsov@virtuozzo.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 14078815388168395091
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrtddvgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.34.1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jan 2020 22:41:48 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20

Reviewed-by: Greg Kurz <groug@kaod.org>

> CC: Cornelia Huck <cohuck@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Greg Kurz <groug@kaod.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Stefano Stabellini <sstabellini@kernel.org>
> CC: Anthony Perard <anthony.perard@citrix.com>
> CC: Paul Durrant <paul@xen.org>
> CC: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> CC: Laszlo Ersek <lersek@redhat.com>
> CC: Gerd Hoffmann <kraxel@redhat.com>
> CC: Stefan Berger <stefanb@linux.ibm.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Michael Roth <mdroth@linux.vnet.ibm.com>
> CC: qemu-block@nongnu.org
> CC: xen-devel@lists.xenproject.org
>=20
>  include/qapi/error.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index ad5b6e896d..fa8d51fd6d 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -309,6 +309,32 @@ void warn_reportf_err(Error *err, const char *fmt, .=
..)
>  void error_reportf_err(Error *err, const char *fmt, ...)
>      GCC_FMT_ATTR(2, 3);
> =20
> +/*
> + * Functions to clean Error **errp: call corresponding Error *err cleani=
ng
> + * function an set pointer to NULL
> + */
> +static inline void error_free_errp(Error **errp)
> +{
> +    assert(errp && *errp);
> +    error_free(*errp);
> +    *errp =3D NULL;
> +}
> +
> +static inline void error_report_errp(Error **errp)
> +{
> +    assert(errp && *errp);
> +    error_report_err(*errp);
> +    *errp =3D NULL;
> +}
> +
> +static inline void warn_report_errp(Error **errp)
> +{
> +    assert(errp && *errp);
> +    warn_report_err(*errp);
> +    *errp =3D NULL;
> +}
> +
> +
>  /*
>   * Just like error_setg(), except you get to specify the error class.
>   * Note: use of error classes other than ERROR_CLASS_GENERIC_ERROR is


