Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25F3C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A3F9206F0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LeqdQ8t7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3F9206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ionu8-0003H5-Qq
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iomp9-0006jY-L1
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:15:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iomp8-0000ws-9g
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:14:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43704
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iomp8-0000wU-5N
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578395697;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DcvyOKMkq5SQbaALlUwQKkx/2v85hZSxZ6GeCHcPCYE=;
 b=LeqdQ8t7GW06KhvwDqKhA6kLx8fCFe+aUlYAWpmooOXXm1CRwzuRaf5kZP+JCdODDv/JY2
 zxRMQp2GU8ttKyubZvK77LyPFpqiet+rCmSzigpHZcav4oQdF2VmqZxWKb9/EeU3AUNz0V
 wRp1esZaRJpF9thhPy8jWULh5KtrYXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-YVuYzyZqMAKWF7tZ-Bi05A-1; Tue, 07 Jan 2020 06:14:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2771100551A
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 11:14:45 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 470461084381;
 Tue,  7 Jan 2020 11:14:40 +0000 (UTC)
Date: Tue, 7 Jan 2020 11:14:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 062/104] virtiofsd: Handle hard reboot
Message-ID: <20200107111437.GF3368802@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-63-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-63-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: YVuYzyZqMAKWF7tZ-Bi05A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:38:22PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Handle a
>   mount
>   hard reboot (without unmount)
>   mount
>=20
> we get another 'init' which FUSE doesn't normally expect.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tools/virtiofsd/fuse_lowlevel.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowle=
vel.c
> index 2d1d1a2e59..45125ef66a 100644
> --- a/tools/virtiofsd/fuse_lowlevel.c
> +++ b/tools/virtiofsd/fuse_lowlevel.c
> @@ -2436,7 +2436,21 @@ void fuse_session_process_buf_int(struct fuse_sess=
ion *se,
>              goto reply_err;
>          }
>      } else if (in->opcode =3D=3D FUSE_INIT || in->opcode =3D=3D CUSE_INI=
T) {
> -        goto reply_err;
> +        if (fuse_lowlevel_is_virtio(se)) {
> +            /*
> +             * TODO: This is after a hard reboot typically, we need to d=
o
> +             * a destroy, but we can't reply to this request yet so
> +             * we can't use do_destroy
> +             */
> +            fuse_log(FUSE_LOG_DEBUG, "%s: reinit\n", __func__);
> +            se->got_destroy =3D 1;
> +            se->got_init =3D 0;
> +            if (se->op.destroy) {
> +                se->op.destroy(se->userdata);
> +            }
> +        } else {
> +            goto reply_err;
> +        }

In doing this, is there any danger we're exposed to from a malicious
guest which does

   mount
   mount

without a reboot in between ?

I'm thinking not so if its ok, then

 Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


