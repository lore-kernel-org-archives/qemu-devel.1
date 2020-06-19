Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFF9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285F8206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1PjN5fq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285F8206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmFuL-0007lq-EY
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFtO-00063F-Ko
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:13:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37708
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFtM-0000Y9-6k
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592568787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q3aXHyom7wb+5ESHwBbR2J4lFDqHDbKov4JAIw/RDqk=;
 b=J1PjN5fqvR8WV7q1/nUeWKlSGMoHsWzOEzD/NzxI89lxXigyIq9xdehlSqfDHaEi5jdXZW
 kaaOKQEOm2pxlnxgg3MlbHS8jUwurCkUgU/IW4PLvi7w2QiAlgNd4EgM93FKjKuTlC8cpf
 7gYow2IvrFT/Hjbq/JURKH9F1cSDod0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-Rlrelv42NoOWX5cPMzIgMg-1; Fri, 19 Jun 2020 08:13:04 -0400
X-MC-Unique: Rlrelv42NoOWX5cPMzIgMg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF6198015CB;
 Fri, 19 Jun 2020 12:13:03 +0000 (UTC)
Received: from localhost (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7649C5BAD4;
 Fri, 19 Jun 2020 12:13:03 +0000 (UTC)
Date: Fri, 19 Jun 2020 13:13:00 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v9 2/5] generic vhost user server
Message-ID: <20200619121300.GB2422025@stefanha-x1.localdomain>
References: <20200614183907.514282-1-coiby.xu@gmail.com>
 <20200614183907.514282-3-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200614183907.514282-3-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 03:15:03
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2020 at 02:39:04AM +0800, Coiby Xu wrote:
> +/*
> + * a wrapper for vu_kick_cb
> + *
> + * since aio_dispatch can only pass one user data pointer to the
> + * callback function, pack VuDev and pvt into a struct. Then unpack it
> + * and pass them to vu_kick_cb
> + */
> +static void kick_handler(void *opaque)
> +{
> +    KickInfo *kick_info = opaque;
> +    kick_info->cb(kick_info->vu_dev, 0, (void *) kick_info->index);

Where is kick_info->index assigned? It appears to be NULL in all cases.

> +}
> +
> +
> +static void
> +set_watch(VuDev *vu_dev, int fd, int vu_evt,
> +          vu_watch_cb cb, void *pvt)
> +{
> +
> +    VuServer *server = container_of(vu_dev, VuServer, vu_dev);
> +    g_assert(vu_dev);
> +    g_assert(fd >= 0);
> +    long index = (intptr_t) pvt;

The meaning of the pvt argument is not defined in the library interface.
set_watch() callbacks shouldn't interpret pvt.

You could modify libvhost-user to explicitly pass the virtqueue index
(or -1 if the fd is not associated with a virtqueue), but it's nice to
avoid libvhost-user API changes so that existing libvhost-user
applications don't require modifications.

What I would do here is to change the ->kick_info[] data struct. How
about a linked list of VuFdWatch objects? That way the code can handle
any number of fd watches and doesn't make assumptions about virtqueues.
set_watch() is a generic fd monitoring interface and doesn't need to be
tied to virtqueues.

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7sq8wACgkQnKSrs4Gr
c8g7zQf9Gy5CDeAhWmGcI6lXy6oGWqFWwOY1dHBMLNPFSzU7UxE9wP5SNY+PeiJx
yHy0neGtytH/PJ9hnRQAC8IUpRKvP8KFlb7UPjVVv9oX9/s4XZhArEfbluYxfyUJ
3dE2OeqAkaBKbX7hWG68HHoMgUG5qt/6zZ8H0T5FUzdNqwlF/Nx+AT+ckZ4vmI2W
z7C2NX4pIiF66A+4JoqGyf95Il+Sh811m0GiwMxx7j9Z5UvhgiicmtsS5hFUdktI
leUFtXhR6RfTPHbha8APjKunN5Bs7eUBndr4AwgSIVpUVPiHLlqrHfQRKEiYjaCc
sGJzM35DkDSA2uEp/h3ng00Q9YAAvA==
=8dZD
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--


