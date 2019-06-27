Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D865C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 15:00:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04BE42086D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 15:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BE42086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgVtP-0002gW-49
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 11:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55379)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hgVrj-0001cs-T1
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 10:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hgVrh-0007Az-TA
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 10:59:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41894)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1hgVrc-00070B-2M; Thu, 27 Jun 2019 10:59:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 735A481E05;
 Thu, 27 Jun 2019 14:58:54 +0000 (UTC)
Received: from redhat.com (ovpn-112-68.ams2.redhat.com [10.36.112.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 363855D9E2;
 Thu, 27 Jun 2019 14:58:53 +0000 (UTC)
Date: Thu, 27 Jun 2019 15:58:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190627145850.GN12358@redhat.com>
References: <20190626024942.29758-1-eblake@redhat.com>
 <20190626082251.GA29008@redhat.com>
 <a3418db6-4bb4-029e-8a5d-d9e6b1185f22@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3418db6-4bb4-029e-8a5d-d9e6b1185f22@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 27 Jun 2019 14:58:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qemu-nbd: Permit TLS with Unix sockets
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>, rjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 09:49:13AM -0500, Eric Blake wrote:
> On 6/26/19 3:22 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Jun 25, 2019 at 09:49:42PM -0500, Eric Blake wrote:
> >> Although you generally won't use encryption with a Unix socket (afte=
r
> >> all, everything is local, so why waste the CPU power), there are
> >> situations in testsuites where Unix sockets are much nicer than TCP
> >> sockets.  Since nbdkit allows encryption over both types of sockets,
> >> it makes sense for qemu-nbd to do likewise.
> >>
> >> Signed-off-by: Eric Blake <eblake@redhat.com>
> >> ---
> >>  qemu-nbd.c | 4 ----
> >>  1 file changed, 4 deletions(-)
> >=20
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >=20
> >=20
> > Do you need something on the client side too ?
>=20
> The proposal that Rich is working on for standardized NBD URIs [1] says
> that we need a patch to support nbds://host/export and
> nbds+unix://export?socket=3D/path as ways to request an encrypted clien=
t
> connection with default encryption parameters. For anything more
> complex, we have to use --imageopts and request an encrypted connection
> by parts - but the QAPI schema already permits us to pass in an
> 'tls-creds' parameter for both TCP and Unix sockets, so no, I don't
> think we need any client side changes at this point.

The QAPI schema isn't what I was thinking about....  in block/nbd.c
we have the same restriction you lifted here

        tlscreds =3D nbd_get_tls_creds(s->tlscredsid, errp);
        if (!tlscreds) {
            goto error;
        }

        /* TODO SOCKET_ADDRESS_KIND_FD where fd has AF_INET or AF_INET6 *=
/
        if (s->saddr->type !=3D SOCKET_ADDRESS_TYPE_INET) {
            error_setg(errp, "TLS only supported over IP sockets");
            goto error;
        }

For client side we would also need to allow a 'tls-hostname' parameter
in BlockdevOptionsNbd, so that the client can pass a hostname to use
for validating the x509 certificate, the same way we allow for live
migration.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

