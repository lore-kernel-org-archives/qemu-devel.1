Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F495C352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B379207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iX0opOWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B379207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPNZm-0004O5-JO
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 05:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jPNYu-0003p5-Cp
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 05:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jPNYt-0004hy-Ab
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 05:45:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46679
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jPNYt-0004fg-60
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 05:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587116726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WHq1NwwMWj8G8N4VyCjqjL9jiKtKGWETa/iZU9gt/h0=;
 b=iX0opOWzpsz4cimr91Rrk6tGDaSg5gtCgiv8o3Hm/pPivl+B0s0Gl2YyBte+hLaoa+aKSN
 q9J+EqMIJJbo6eBPdZobRxDMlPiUoPL4cKvKwhf6man27f+6905Gq9ipcyo1S2V5oJT/dy
 3fTFu+VvBHaPyRlPvf8JNUmE3oNOGQk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-uXu7KJ2bNkqJR6FpCmCK5A-1; Fri, 17 Apr 2020 05:45:24 -0400
X-MC-Unique: uXu7KJ2bNkqJR6FpCmCK5A-1
Received: by mail-wr1-f70.google.com with SMTP id y1so727970wrp.5
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 02:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=mgapimNGf0xqwazhcOkhycxXrrUZlNpSHKK26de4/Ig=;
 b=ewXXRIR4XzjJx4oueCD7ZOlrot7rDioi+1ROu8zYH6c3894pc+thrG4ljbK/UE4qwx
 Ha/voSk+UfkH8GVn+jU5Rtkinc+DnGPzW4Zma9KQwa7EDERjLutCAmVFb7cbGdoIaMfn
 2gpzqmVxf1xcIlaKMLDjp1Rqii+drV/YWM/9kR8iTwss3ewA1mWQZdy8gTmdSK+eDw05
 xyqQVqMraUdPlxzU7TV37+bfn4PuwQn5PksfFhAKL8p0aKhQP2D33IzPNwK0B5l1LCnc
 vxB2gEeDD5/T7B3urNOxV/eU6grwA6NOOESt31lXcujjP1Y1bpL8A30rltMwQUYv1tA7
 QDwQ==
X-Gm-Message-State: AGi0PubyufCxyvw500YbAZIWW7GL5q4F99G7cFQg3vE76PnaZlybG8uX
 Mn640s4d6Uta6ONbbpHEXW755kkKqkslxS4cBFEKiK+AgGlTSMA48tzNRtO90tnCa3nEifU/ADd
 qwIOlIvCaGS+f20M=
X-Received: by 2002:a1c:790e:: with SMTP id l14mr2425443wme.174.1587116723423; 
 Fri, 17 Apr 2020 02:45:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypIT9VfbFxMEEwyWHkZVAJCRdlFEA3DRduQ0snRXXDlaGCDCTAaLANC5ELvXbT7UbtXy9Fvc2Q==
X-Received: by 2002:a1c:790e:: with SMTP id l14mr2425423wme.174.1587116723238; 
 Fri, 17 Apr 2020 02:45:23 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
 by smtp.gmail.com with ESMTPSA id c18sm30386722wrx.5.2020.04.17.02.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 02:45:22 -0700 (PDT)
Date: Fri, 17 Apr 2020 05:45:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Feng <fengli@smartx.com>
Subject: Re: [PATCH 0/4] fix crashes when inject errors to vhost-user-blk
 chardev
Message-ID: <20200417054439-mutt-send-email-mst@kernel.org>
References: <20200415032826.16701-1-fengli@smartx.com>
MIME-Version: 1.0
In-Reply-To: <20200415032826.16701-1-fengli@smartx.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, kyle@smartx.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 15, 2020 at 11:28:22AM +0800, Li Feng wrote:
> The following patches fix various crashes happened when injecting errors =
to
> chardev unix domain socket.

I think these are mostly unrelated fixes right?
If so pls post them separately so I know I can just apply
some and wait for others to get acked.


> The crashes are encountered when the socket is from connected to disconne=
cted at
> vhost-user-blk realize routine.
>=20
> These crashes could be reproduced like this:
> 1. gdb break at vhost_user_write;
> 2. add a vhost-user-blk device through qmp;
> 3. when stop at vhost_user_write, kill the vhost-user-blk target;
> 3. let qemu continue running;
> 4. start vhost-user-blk;
> 5. see crash!
>=20
> The 'CLOSE' event path is core trouble maker.
>=20
> qemu_chr_fe_set_handlers
>    -> vhost_user_blk_event(OPEN)
>        -> vhost_user_blk_connect
>             -> vhost_dev_init
>                 -> vhost_user_blk_event(CLOSE)
>                 -> vhost_dev_cleanup
>=20
>=20
> Li Feng (4):
>   vhost-user-blk: delay vhost_user_blk_disconnect
>   vhost-user-blk: fix invalid memory access
>   char-socket: avoid double call tcp_chr_free_connection
>   vhost-user-blk: fix crash in realize process
>=20
>  chardev/char-socket.c     |  5 ++++
>  hw/block/vhost-user-blk.c | 75 ++++++++++++++++++++++++++++++++---------=
------
>  hw/virtio/vhost.c         |  2 +-
>  3 files changed, 58 insertions(+), 24 deletions(-)
>=20
> --=20
> 2.11.0
>=20
>=20
> --=20
> The SmartX email address is only for business purpose. Any sent message=
=20
> that is not related to the business is not authorized or permitted by=20
> SmartX.
> =E6=9C=AC=E9=82=AE=E7=AE=B1=E4=B8=BA=E5=8C=97=E4=BA=AC=E5=BF=97=E5=87=8C=
=E6=B5=B7=E7=BA=B3=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=EF=
=BC=88SmartX=EF=BC=89=E5=B7=A5=E4=BD=9C=E9=82=AE=E7=AE=B1. =E5=A6=82=E6=9C=
=AC=E9=82=AE=E7=AE=B1=E5=8F=91=E5=87=BA=E7=9A=84=E9=82=AE=E4=BB=B6=E4=B8=8E=
=E5=B7=A5=E4=BD=9C=E6=97=A0=E5=85=B3,=E8=AF=A5=E9=82=AE=E4=BB=B6=E6=9C=AA=
=E5=BE=97=E5=88=B0=E6=9C=AC=E5=85=AC=E5=8F=B8=E4=BB=BB=E4=BD=95=E7=9A=84=E6=
=98=8E=E7=A4=BA=E6=88=96=E9=BB=98=E7=A4=BA=E7=9A=84=E6=8E=88=E6=9D=83.
>=20


