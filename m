Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2144C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 02:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8918420692
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 02:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbW6pZcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8918420692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieVkc-0000Ey-IK
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 21:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1ieVjx-0008Eq-9N
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 21:59:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1ieVjt-0008Ba-OY
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 21:59:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25987
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ieVjt-0008B3-Hc
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 21:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575946744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C8SU/1P3ZcYjHsqNtZJZJMml2VHhYJD8cZxXzgm3EIY=;
 b=bbW6pZcsQA9zDpHveWxT13qps6QhomFm0T9J1dfr5Hj6WHqCk9bYzlIhQRbIQO1ae3xfji
 /uJrabsVZe+KrxVMmCEKZOHTPGxwKDMFlZVFZssy194Duu6TqnCk/OqdUIsPJ5PTkVCJY8
 bw8QzK4+iV0vM/4GSF7p5NzYHHi1LIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-QtJQJl1eOjOk42tY1NmUHw-1; Mon, 09 Dec 2019 21:59:02 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CE52800D4C
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 02:59:01 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92BA25C219;
 Tue, 10 Dec 2019 02:58:58 +0000 (UTC)
Date: Mon, 9 Dec 2019 23:58:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH 2/2] analyze-migration.py: replace numpy with python 3.2
Message-ID: <20191210025857.GQ498046@habkost.net>
References: <20191127101038.327080-1-marcandre.lureau@redhat.com>
 <20191127101038.327080-3-marcandre.lureau@redhat.com>
 <20191206142723.GA5020@dhcp-17-72.bos.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191206142723.GA5020@dhcp-17-72.bos.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: QtJQJl1eOjOk42tY1NmUHw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 06, 2019 at 09:27:23AM -0500, Cleber Rosa wrote:
> On Wed, Nov 27, 2019 at 02:10:38PM +0400, Marc-Andr=E9 Lureau wrote:
> > Use int.from_bytes() from python 3.2 instead.
> >=20
> > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/analyze-migration.py | 35 +++++++++++++++++++----------------
> >  1 file changed, 19 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.p=
y
> > index 2b835d9b70..96a31d3974 100755
> > --- a/scripts/analyze-migration.py
> > +++ b/scripts/analyze-migration.py
> > @@ -1,4 +1,4 @@
> > -#!/usr/bin/env python
> > +#!/usr/bin/env python3
[...]
>=20
> Marc-Andr=E9, I couldn't yet pinpoint the reason yet, but this patch
> changes the parsing of bool fields.  This is a diff between the output
> pre/post this patch on the same images:
>=20
> $ diff -u out_x8664_pre out_x8664_post=20
> --- out_x8664_pre       2019-12-06 09:14:16.128943264 -0500
> +++ out_x8664_post      2019-12-06 09:23:35.861378600 -0500
> @@ -3039,7 +3039,7 @@
>              "mac_reg[RADV]": "0x00000000",
>              "mac_reg[TADV]": "0x00000000",
>              "mac_reg[ITR]": "0x00000000",
> -            "mit_irq_level": true
> +            "mit_irq_level": false
>          },
>          "e1000/full_mac_state": {
>              "mac_reg": [
> @@ -36010,10 +36010,10 @@
>              ],
>              "smb_auxctl": "0x02",
>              "smb_blkdata": "0x00",
> -            "i2c_enable": true,
> +            "i2c_enable": false,
>              "op_done": true,
> -            "in_i2c_block_read": true,
> -            "start_transaction_on_status_read": true
> +            "in_i2c_block_read": false,
> +            "start_transaction_on_status_read": false
>          },
>          "ar.tmr.timer": "ff ff ff ff ff ff ff ff",
>          "ar.tmr.overflow_time": "0x0000000000000000",
>=20
> This true/false flipping is consistent across various images (tried on
> images generated on a few other targets).

It looks like moving to python3 accidentally fixes a bug.

This is VMSDFieldBool.read:

    def read(self):
        super(VMSDFieldBool, self).read()
        if self.data[0] =3D=3D 0:
            self.data =3D False
        else:
            self.data =3D True
        return self.data

On python2, MigrationFile.readvar() returned a string, so the
(self.data[0] =3D=3D 0) check was never true.  This means all boolean
fields were always initialized to True.

On python3, MigrationFile.readvar() returns a bytearray, so the
(self.data[0] =3D=3D 0) check now works as expected.

--=20
Eduardo


