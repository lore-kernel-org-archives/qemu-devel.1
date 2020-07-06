Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1213BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 09:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE9A20724
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 09:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gx+SvOTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE9A20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsNPJ-0001Sx-4v
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 05:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsNOU-0000Cd-BQ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 05:26:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24400
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsNOS-0006qO-OP
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 05:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594027591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W56f7ix5gyi2YB8ygyaww4TIsgqFaXJc+apV+c0F7A0=;
 b=Gx+SvOTNPvU9zyNax6+CDXG6mwx6Em6uUSwNzA+Km6HIe4dN9fuKKFRb27kYAupoV3oQXx
 INfUX5omywLf44tVTgbIpqz5+HNLYDY7CKWnpCbZdMUr2ff+M5rK4LSObdZLBlEmXK0sk6
 6zdVpb3cVbsFSkPBGqsygM0TtV4UtQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-r3mwrlyIPiCKUtiBuV6nBg-1; Mon, 06 Jul 2020 05:26:29 -0400
X-MC-Unique: r3mwrlyIPiCKUtiBuV6nBg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0B6710059A5;
 Mon,  6 Jul 2020 09:26:27 +0000 (UTC)
Received: from localhost (ovpn-114-217.ams2.redhat.com [10.36.114.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4C8A60BF3;
 Mon,  6 Jul 2020 09:26:18 +0000 (UTC)
Date: Mon, 6 Jul 2020 10:26:17 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 3/7] docs: document non-net VHOST_USER_GET_FEATURES
 behavior
Message-ID: <20200706092617.GA328186@stefanha-x1.localdomain>
References: <20200609170218.246468-1-stefanha@redhat.com>
 <20200609170218.246468-4-stefanha@redhat.com>
 <20200610005129-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200610005129-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:59:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 jasowang@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Ben Walker <benjamin.walker@intel.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Sebastien Boeuf <sebastien.boeuf@intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2020 at 01:01:26AM -0400, Michael S. Tsirkin wrote:
> On Tue, Jun 09, 2020 at 06:02:14PM +0100, Stefan Hajnoczi wrote:
> > +For devices other than the networking device, masters may assume the f=
ollowing
> > +feature bits are always set in ``VHOST_USER_GET_FEATURES`` for compati=
bility
> > +with legacy backend implementations that do not report them correctly:
> > +* ``VIRTIO_F_RING_INDIRECT_DESC``
> > +* ``VIRTIO_F_RING_EVENT_IDX``
> > +* ``VIRTIO_F_VERSION_1``
> > +* ``VIRTIO_F_NOTIFY_ON_EMPTY``
> > +* ``VIRTIO_F_ANY_LAYOUT``
> > +
> >  Starting and stopping rings
> >  ---------------------------
>=20
> How common are these backends? Anything shipped for a while?  IIUC we
> are not talking about years of history here, so I really think we should
> just enforce what spec always said, rather than work around some broken
> clients.

QEMU didn't include some device backends in feature negotiation. This is
why we didn't notice that libvhost-user does not advertise some feature
bits. Therefore the chance of third-party device backends missing
feature negotiation seems high too.

I will move this section into the VHOST_USER_GET_FEATURES description.

Stefan

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8C7gkACgkQnKSrs4Gr
c8jBdAf+LHJgwgXYV+U1jPqJtZ9YsERvS6u79QXGMLOvE6e3snrqQAFp6HtHoah4
c47x/ErbsW8afciTGqlGim7uYPBa6uyeOXvVugeWlyKneM+WwVjBYkZLBDsFRK4F
oFITpFenNqEG2f3mpPbsQ61T6ivAKjGoVAqru7vJPXzQf1VC5L8uwCoHxwxFWvqR
x+KtkvvfvDxTllKUtiExlGI2wpEhTBCQBjPvR7uXqVy5nNnhVgka5beZRPd4iZ2h
M2TYk7uvGSne03slsbGSB8/ygPZfpD5fNEhSWKO9W9gS56qpmpROp1V1UPzXQ/JA
mvuE2bzTxjtW5gOeJVYvC6p5nVlNMQ==
=7AjH
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--


