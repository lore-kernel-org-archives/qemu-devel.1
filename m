Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82CCC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8242072A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRawGxc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8242072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVepN-0003pQ-CU
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iVeZn-0003hv-0B
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:36:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iVeZl-00076u-S0
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:36:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38618
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iVeZl-00076K-NA
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:36:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573835760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pJWkQq07D9FyveHY6DKhA9fp3MyBnIGG1kulEmk+b2E=;
 b=MRawGxc+i5ou8qiYdBXtbpmquUtn/FQJ7Hcfp82yenMSeaM6FrpTS2FyveQiao+Ls7X/SC
 s+gjgmtNyImHPsyh1oZIGWYj3HaoW6wk1C3XmMHP0/7ovb8tHeMRL2eqh+HZ+xy3s7R7Kr
 UDv01TjXo2GTTl/5e362bB+Oj23I7fg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-kbz2Lt3VN7-j5x6heH90vg-1; Fri, 15 Nov 2019 11:35:57 -0500
X-MC-Unique: kbz2Lt3VN7-j5x6heH90vg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C81AD1005511;
 Fri, 15 Nov 2019 16:35:56 +0000 (UTC)
Received: from localhost (ovpn-116-253.ams2.redhat.com [10.36.116.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B17D67E5F;
 Fri, 15 Nov 2019 16:35:50 +0000 (UTC)
Date: Fri, 15 Nov 2019 16:35:49 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Micky Yun Chan <chanmickyyun@gmail.com>
Subject: Re: [PATCH] Implement backend program convention command for
 vhost-user-blk
Message-ID: <20191115163549.GC47045@stefanha-x1.localdomain>
References: <20191115060925.12346-1-michan@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191115060925.12346-1-michan@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 michan <michan@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 02:09:25PM +0800, Micky Yun Chan wrote:

Thanks for the patch!

> +    context =3D g_option_context_new(NULL);

Missing g_option_context_free() later in this function.  g_auto() is the
easiest way to ensure that.

> +    g_option_context_add_main_entries(context, entries, NULL);
> +    if (!g_option_context_parse(context, &argc, &argv, &error)) {
> +        g_printerr("Option parsing failed: %s\n", error->message);
> +        exit(EXIT_FAILURE);
> +    }
> +    if (opt_print_caps) {
> +        g_print("{\n");
> +        g_print("  \"type\": \"blk\",\n");
> +        g_print("  \"features\": [\n");
> +        g_print("    \"blk-file\",\n");
> +        g_print("    \"read-only\"\n");
> +        g_print("  ]\n");
> +        g_print("}\n");
> +        exit(EXIT_SUCCESS);
>      }
> =20
> -    if (!unix_socket || !blk_file) {
> +    if (!opt_blk_file) {
>          printf("Usage: %s [ -b block device or file, -s UNIX domain sock=
et"
>                 " | -r Enable read-only ] | [ -h ]\n", argv[0]);

g_option_context_get_help() can be used instead.  That way the help text
is consistent.

>          return -1;

A good opportunity to switch to exit(EXIT_FAILURE) since main() should
not return -1.

>      }
> =20
> -    lsock =3D unix_sock_new(unix_socket);
> -    if (lsock < 0) {
> -        goto err;
> +    if (opt_socket_path) {
> +        lsock =3D unix_sock_new(opt_socket_path);
> +        if (lsock < 0) {
> +           exit(EXIT_FAILURE);
> +        }
> +    } else {

  } else if (opt_fd < 0) {
      ...print usage because neither --socket-path nor --fd were given...
  }

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3O0+UACgkQnKSrs4Gr
c8jL1wf/Qp+s2uHiJQiVpULC4qq1z64WhxBmzdipbYuinpbVmV329h31I+H5xchv
jn5n+Lx+otVTm/qCANwzrIJl5R66nhXLa9E/ym1mli8l3zHKkWpkJZAfElNrXEsS
IpxGc72ebwY/un20ud96kTJ+VQRTx5AhEdHkJAIDx65DOx74SwP3OocKZCoRFnh3
oMaU3sxWAyXtRMZID2hhXV612uLB1JkU2o7aGbCg47HYLYFvjBiRmf9e/eV+PVW8
7sm5GEWRFuw6qeM6xFKD2mXQtVETnFzq9Kkp8HtxGsMTAOD/1eyBfqB8JhXbsNsj
i+oJXEzdTGvHnmwHXRj+Z32eVlxpzA==
=XHKD
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--


