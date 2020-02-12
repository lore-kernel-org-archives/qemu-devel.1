Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E387FC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:52:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACCB92082F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwD8zBHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCB92082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sQt-0004Sv-S4
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:52:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1j1sGl-0003fl-Fb
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rjones@redhat.com>) id 1j1sGk-0002BN-83
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:41:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56702
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rjones@redhat.com>) id 1j1sGk-0002Ay-41
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581514893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OptecfwUnA3Ryc1Wec8FFJAnQ1YzCfxvleXptvY7IW8=;
 b=EwD8zBHiv2yFSQXduoRVt80NDKxb7/maju17pcP+To9AVZhQVn1VE5pQ0R20FxbkY5yMme
 uMbXqGwEtSwMI46QlHHsOaXdLS/qo4U0ePfxvclvHtL/YMExyIXqJlcHMdzLu0HdOEAmwi
 rb6j1ZBVu7OnmFmZuFk7ry2RFJtchuA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-xMbpzfKsMAyhzdrA-Lq7Rw-1; Wed, 12 Feb 2020 08:41:30 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86F2E10054E3;
 Wed, 12 Feb 2020 13:41:29 +0000 (UTC)
Received: from localhost (unknown [10.36.118.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EAC6719C6A;
 Wed, 12 Feb 2020 13:41:28 +0000 (UTC)
Date: Wed, 12 Feb 2020 13:41:28 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] nbd-client: Support leading / in NBD URI
Message-ID: <20200212134128.GY3888@redhat.com>
References: <20200212023101.1162686-1-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200212023101.1162686-1-eblake@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: xMbpzfKsMAyhzdrA-Lq7Rw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 11, 2020 at 08:31:01PM -0600, Eric Blake wrote:
> The NBD URI specification [1] states that only one leading slash at
> the beginning of the URI path component is stripped, not all such
> slashes.  This becomes important to a patch I just proposed to nbdkit
> [2], which would allow the exportname to select a file embedded within
> an ext2 image: ext2fs demands an absolute pathname beginning with '/',
> and because qemu was inadvertantly stripping it, my nbdkit patch had
> to work around the behavior.
>=20
> [1] https://github.com/NetworkBlockDevice/nbd/blob/master/doc/uri.md
> [2] https://www.redhat.com/archives/libguestfs/2020-February/msg00109.htm=
l
>=20
> Note that the qemu bug only affects handling of URIs such as
> nbd://host:port//abs/path (where '/abs/path' should be the export
> name); it is still possible to use --image-opts and pass the desired
> export name with a leading slash directly through JSON even without
> this patch.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/nbd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/nbd.c b/block/nbd.c
> index d085554f21ea..82f9b7ef50a5 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -1516,8 +1516,10 @@ static int nbd_parse_uri(const char *filename, QDi=
ct *options)
>          goto out;
>      }
>=20
> -    p =3D uri->path ? uri->path : "/";
> -    p +=3D strspn(p, "/");
> +    p =3D uri->path ? uri->path : "";
> +    if (p[0] =3D=3D '/') {
> +        p++;
> +    }
>      if (p[0]) {
>          qdict_put_str(options, "export", p);
>      }

Looks reasonable, ACK.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top


