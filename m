Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20829FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:19:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E03C3218AE
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a47Iw95r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03C3218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT2II-0007VB-2I
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 06:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iT2HE-0006wB-Hd
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:18:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iT2HC-0007nE-Sy
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:18:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31981
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iT2HC-0007me-Jd
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573211881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O30XvPmD1xzd/WgmHWTywiIdxafZnMu8VHd+VV8vWwk=;
 b=a47Iw95rWRiGIJ+HoK9AC+36r77SMVr81TwKxkbe4mJ0ERio6ac4egaS1vZODPybjWRghn
 9er1Bfp3io6qi9sR10FK64Os9Xib19Ilt+H0BUzfLG0Fv2Lxu8yO113ODBaTOpZIA7l9ez
 Mmy0uCXUUns7zKb3vahlrupJHCYgxYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-WvT4wvb4MvSFdn3jmkIiTw-1; Fri, 08 Nov 2019 06:17:57 -0500
X-MC-Unique: WvT4wvb4MvSFdn3jmkIiTw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1047477;
 Fri,  8 Nov 2019 11:17:55 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E32DE2CDFA;
 Fri,  8 Nov 2019 11:17:42 +0000 (UTC)
Date: Fri, 8 Nov 2019 12:17:41 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC v4 PATCH 49/49] multi-process: add configure and usage
 information
Message-ID: <20191108111741.GD402228@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <2736d12f29d2c9051966864b5d865ab0f392b8d1.1571905346.git.jag.raman@oracle.com>
 <20191107140220.GI365089@stefanha-x1.localdomain>
 <20191107093059-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191107093059-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, kraxel@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>, quintela@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com,
 mreitz@redhat.com, ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2019 at 09:33:45AM -0500, Michael S. Tsirkin wrote:
> On Thu, Nov 07, 2019 at 03:02:20PM +0100, Stefan Hajnoczi wrote:
> > This documentation suggests that QEMU spawns the remote processes.  How
> > do this work with unprivileged QEMU?  Is there an additional step where
> > QEMU drops privileges after having spawned remote processes?
> >=20
> > Remote processes require accesses to resources that the main QEMU
> > process does not need access to, so I'm wondering how this process mode=
l
> > ensures that each process has only the privileges it needs.
>=20
> I guess you have something like capabilities in mind?

Or namespaces (unshare(2)).

> When using something like selinux, priviledges are per binary
> so the order of startup doesn't matter.

For static SELinux policies that make sense, thanks for explaining.

Does libvirt also perform dynamic (i.e. per-instance) SELinux
configuration?  I guess that cannot be associated with a specific binary
because multiple QEMU instances launch the same binary yet need to be
differentiated.

Stefan

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3FTtUACgkQnKSrs4Gr
c8i7Fwf/c5V2iIiVcbdBt5XthTk9EODu7H8R+6Glz8DoRG4CE5QEmzrOe/0q1v3g
nYybaQErnkX4RQcRAbPQHRzgeX7l63sjNKSsvhBu2srMqyxIrxIJLe6/bac3GdkV
Je81hK1plSB2VtBNCx97UhXBYNSS0/1fsYv6pFeYFbTAKrVlgeI94Lkq7BoYvGqm
Spua8lthtb9CovV5ZtN3o+z+SJ7LdfSoLa6r8ajZSQ+3iNRmrOQnsi6Yw8B2XKji
rczp9xoUMccdW3rKZR2ogzdbiyxvtVZaAIKbS14fEI1zuR9gz3Us0ufp9pJ3qNiN
62wV0ycJHkxjHdTXpOsvG3GLN+06/A==
=MHl0
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--


