Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F85C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 176822068F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Es3f6xwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176822068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihupJ-0005Ld-6a
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:22:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ihuof-0004RZ-AR
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ihuoe-0004aT-6Y
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:22:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40920
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ihuoe-0004Vn-0G
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:22:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Ht4xqZ3f80DGNrWGzGa4+GwX1kQvkBSb9km/FUCRzk=;
 b=Es3f6xwbdHPn0JTQmzT86OetEr9ns3QVzGCTha3r0fCakys/X8thoP7yqjRQ4El1CeZDlX
 sCZpZwtK7ml5KLEWor34OHJJSpULvnAE4kEPDbq6jFbdcTOaOSiEhg5KqwM6/d+o+zDPlk
 mvxYJN9ykW7k9BB+8xlKhygf7gxR498=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-I-ANPH8iPNOVl3UiEeNF9A-1; Thu, 19 Dec 2019 07:22:01 -0500
Received: by mail-qv1-f72.google.com with SMTP id c22so3529977qvc.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 04:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=NXui19PzcjC71zCulM1IJPucMPXEXQvwPvwuDLhGzdM=;
 b=T0xBrTKi+xetq5GLpfBUUGxj13f0SUm8SiSLigzzbNFcOW3R1XKIDeXsNNqEhB1xZT
 5eQdXqRxbaTRb7VbfJDbT+TOmDf2p/bNCkjezF7EWdDh2kh014HeAn5rUzB/vrXdG6A/
 zo78CFg8DLWE+gRsO80wNMwLSNtXO06NY5j4GMtqa/L04cLdiZpf7JZQiHK4qAm5Noo7
 ICMBOO6/DnOdXEdSvLLqQOtb5jlNhszoT/2e5rsymCNz3oObK0/MhlOTUs+5dsdjU0sm
 5OP8kli+hqWJgHJ4v2Y/TVoORSEqFRHRGeK4qe3+jHO5kaO5I9QhekoqlL1Dn9D8PXhe
 ZLyA==
X-Gm-Message-State: APjAAAXW62qdhslbiSk35hmmO20OJfQXLjM1njrpKcpn2W+NvroIhUbS
 GZG8aVD/4Jo4oMKyH8wWfqMDUjqwZQNdE/OyExXnQHpeYhZDiq1VuzB9csOzZz4etb10J3xID2R
 r2EbPtSm4HCq4V3o=
X-Received: by 2002:ae9:c317:: with SMTP id n23mr7832872qkg.356.1576758121444; 
 Thu, 19 Dec 2019 04:22:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqzULj0a1x9tkYMm7MJi/b9Xlv/AKNalOhKvj08nXsezHd5VwM1TRNkSXd/QqIqAswGCw9nr5Q==
X-Received: by 2002:ae9:c317:: with SMTP id n23mr7832852qkg.356.1576758121204; 
 Thu, 19 Dec 2019 04:22:01 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id q34sm1831012qtc.33.2019.12.19.04.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 04:22:00 -0800 (PST)
Date: Thu, 19 Dec 2019 07:21:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v2 08/14] vhost-user-net: Explicit we ignore few
 QEMUChrEvent in IOEventHandler
Message-ID: <20191219072144-mutt-send-email-mst@kernel.org>
References: <20191218172009.8868-1-philmd@redhat.com>
 <20191218172009.8868-9-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191218172009.8868-9-philmd@redhat.com>
X-MC-Unique: I-ANPH8iPNOVl3UiEeNF9A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 18, 2019 at 06:20:03PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> The Chardev events are listed in the QEMUChrEvent enum. To be
> able to use this enum in the IOEventHandler typedef, we need to
> explicit all the events ignored by this frontend, to silent the
> following GCC warning:
>=20
>     CC      net/vhost-user.o
>   net/vhost-user.c: In function =E2=80=98net_vhost_user_event=E2=80=99:
>   net/vhost-user.c:269:5: error: enumeration value =E2=80=98CHR_EVENT_BRE=
AK=E2=80=99 not handled in switch [-Werror=3Dswitch]
>     269 |     switch (event) {
>         |     ^~~~~~
>   net/vhost-user.c:269:5: error: enumeration value =E2=80=98CHR_EVENT_MUX=
_IN=E2=80=99 not handled in switch [-Werror=3Dswitch]
>   net/vhost-user.c:269:5: error: enumeration value =E2=80=98CHR_EVENT_MUX=
_OUT=E2=80=99 not handled in switch [-Werror=3Dswitch]
>   cc1: all warnings being treated as errors
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Add all missing enums
>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  net/vhost-user.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index 014199d600..c54c9c7d4c 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -294,6 +294,11 @@ static void net_vhost_user_event(void *opaque, int e=
vent)
>              aio_bh_schedule_oneshot(ctx, chr_closed_bh, opaque);
>          }
>          break;
> +    case CHR_EVENT_BREAK:
> +    case CHR_EVENT_MUX_IN:
> +    case CHR_EVENT_MUX_OUT:
> +        /* Ignore */
> +        break;
>      }
> =20
>      if (err) {
> --=20
> 2.21.0


