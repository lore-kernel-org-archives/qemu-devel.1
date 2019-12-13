Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3D2C2D0C9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E245421655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGyAgWXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E245421655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifjKA-0007KL-GI
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 06:41:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ifjIl-00062E-Pv
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ifjIk-0006Lk-6j
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:40:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24573
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ifjIk-0006KR-1E
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576237205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9/SQS0kR7Vm0JJ0sZMxfjNjCZ2IFPpb6kbnnhl0+dHg=;
 b=GGyAgWXDol4vGMuXgAWmNgQYLvg2pRVNC7J8dQZSwn+J0+kE/K56cMUWWlKGtLk1X1/FNu
 VwXnxQhaIIJ3ZB/L9kpW0rcKb49A0hqKzzI36cc8Yq7Y0lNBvhj7ImYgcqjmYFWxcZ7l+V
 2nV+Y6lfYdM+DDwJ1lqB7Wn4er2npQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-ZuTOqXwrMHiCoideIMnQnw-1; Fri, 13 Dec 2019 06:40:02 -0500
X-MC-Unique: ZuTOqXwrMHiCoideIMnQnw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2387ADB2E;
 Fri, 13 Dec 2019 11:40:01 +0000 (UTC)
Received: from localhost (unknown [10.36.118.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 433FA100EBCC;
 Fri, 13 Dec 2019 11:39:58 +0000 (UTC)
Date: Fri, 13 Dec 2019 11:39:57 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: gongsu@us.ibm.com
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
Message-ID: <20191213113957.GB1186952@stefanha-x1.localdomain>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191128165933.GB3295@work-vm>
 <20191129102325.55ee16ea@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191129102325.55ee16ea@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2019 at 10:23:25AM +0100, Igor Mammedov wrote:
> On Thu, 28 Nov 2019 16:59:33 +0000
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>=20
> > * Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> > > Hi,
> > >=20
> > > Setting up shared memory for vhost-user is a bit complicated from
> > > command line, as it requires NUMA setup such as: m 4G -object
> > > memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,share=3Don=
 -numa
> > > node,memdev=3Dmem.
> > >=20
> > > Instead, I suggest to add a -mem-shared option for non-numa setups,
> > > that will make the -mem-path or anonymouse memory shareable.
> > >=20
> > > Comments welcome, =20
> >=20
> > It's worth checking with Igor (cc'd) - he said he was going to work on
> > something similar.
> >=20
> > One other thing this fixes is that it lets you potentially do vhost-use=
r
> > on s390, since it currently has no NUMA.
> Switching to memdev will let vhost-user on s390 work as well.
> This is convenience option and workarounds inability to set main RAM
> properties in current impl.=20

Gong Su asked about virtio-fs (vhost-user) on s390.  This patch series
might be the first step to enabling it.

Stefan

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3zeI0ACgkQnKSrs4Gr
c8heCQf/Tpua65a7VQ+IxGSYTVOd6Q/96lNPKA/slXSeePextNU3gucNpzB/uZ2B
B2QLf/tLHHaci28RdMwoeW9WhTQA4rN0ppQVYuBuTfIQNgATywY0/c+Au/sZqZcB
kNcD+p1b4WjZOkdXkPtsGukzKye9Ek6JOueHPqC2LhC08EixN6Zq5vT3z74srMkL
ItqHKmjUlE0LFH5E4/QNAorFbK7zJHafuenlSUmWPT+gPpFwi87ERsnqke2j2dVX
JJgpeyxShjBYUD3UJX1y0YNuA77ToEBhQlnhDJGMiUWrxoH8qPUvODeVmJIJcfD9
VsUMyMbgyMSVPyeIPpAPJWo/LTvJog==
=x6gH
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--


