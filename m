Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6789CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 16:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D6321835
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 16:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ehs3xYMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D6321835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuISC-0007XD-Mh
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 11:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iuIQi-0006fp-7s
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 11:00:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iuIQg-0006Uw-Ay
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 11:00:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59853
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iuIQb-0006Qr-0N
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 11:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579708823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VqUNSgbhE22hUpOLRJhiuuQgXaAMfVpNpIQ5Y4olWvg=;
 b=Ehs3xYMe8SckrNB/dlN5lrBV/mnliAw0uVtE2TWchcjqoXbnUcJn8SKI2j/rJ2FBIL3IYC
 1oxkK+UNWzrfplKHxkSn/B/6kPTEFoHODOyZBujsqUx3aBXOxcq5HHuAfkI7vxhCNIsxLJ
 d6+qklVuoP+wmPoXEv5TX3wvNEZGa6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-EYXFNAR4NkKZ6lYc697ypg-1; Wed, 22 Jan 2020 11:00:22 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 175218017CC;
 Wed, 22 Jan 2020 16:00:21 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6ED7D858BE;
 Wed, 22 Jan 2020 16:00:11 +0000 (UTC)
Date: Wed, 22 Jan 2020 16:00:08 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 066/109] vhost-user: Print unexpected slave message
 types
Message-ID: <20200122160008.GL3263@work-vm>
References: <20200121122433.50803-1-dgilbert@redhat.com>
 <20200121122433.50803-67-dgilbert@redhat.com>
 <9d878315-e282-9ac3-e7e4-8549e9b2ec22@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9d878315-e282-9ac3-e7e4-8549e9b2ec22@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: EYXFNAR4NkKZ6lYc697ypg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
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
Cc: m.mizuma@jp.fujitsu.com, berrange@redhat.com, slp@redhat.com,
 qemu-devel@nongnu.org, misono.tomohiro@jp.fujitsu.com, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> On 1/21/20 1:23 PM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > When we receive an unexpected message type on the slave fd, print
> > the type.
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > ---
> >   hw/virtio/vhost-user.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index d27a10fcc6..9ec8c2a27c 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -1061,7 +1061,7 @@ static void slave_read(void *opaque)
> >                                                             fd[0]);
> >           break;
> >       default:
> > -        error_report("Received unexpected msg type.");
> > +        error_report("Received unexpected msg type. (%d)", hdr.request=
);
>=20
> With either "Received unexpected msg type (%d)."
> or "Received unexpected msg type: %d." instead:

OK.

> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Thanks.

> >           ret =3D -EINVAL;
> >       }
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


