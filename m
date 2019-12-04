Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE20CC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C1712077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zf5Wq74A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1712077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icU4h-0001Ns-KO
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1icTfP-00029E-5z
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 07:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1icTfE-0000Tl-Ec
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 07:21:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39289
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1icTfE-0000C4-9S
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 07:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575462108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3OnM5eaSxNefQQlb69I5DoqeGRL34Usqzt0Ta6j9ao=;
 b=Zf5Wq74AvTgIBBw792efu4hCYgKTQ+mgs5Hn1TYJj2mG6oVzFqxRNhQpFPfuFeXX7Ibys5
 Zj18HY9/Vo5ayYX8zX8ncNpeDRoQAADAnS65tgzZhsKlNvlWHFkqNCDGN9WX58arAo0z95
 vjXKNhWg6GhdrO+OMKkHr8lllDBNszA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-uw02SxsnNk6Lj4z_w0su_A-1; Wed, 04 Dec 2019 07:21:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DA5C1005300;
 Wed,  4 Dec 2019 12:21:44 +0000 (UTC)
Received: from work-vm (ovpn-117-217.ams2.redhat.com [10.36.117.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04C711001B0B;
 Wed,  4 Dec 2019 12:21:42 +0000 (UTC)
Date: Wed, 4 Dec 2019 12:21:40 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Han Han <hhan@redhat.com>
Subject: Re: [PATCH] Revert "qemu-options.hx: Update for reboot-timeout
 parameter"
Message-ID: <20191204122140.GI3325@work-vm>
References: <20191204085628.2892-1-hhan@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191204085628.2892-1-hhan@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: uw02SxsnNk6Lj4z_w0su_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Han Han (hhan@redhat.com) wrote:
> This reverts commit bbd9e6985ff342cbe15b9cb7eb30e842796fbbe8.

Patchew spotted you're missing the signed-off-by; please send one.

Dave

> In 20a1922032 we allowed reboot-timeout=3D-1 again, so update the doc
> accordingly.
> ---
>  qemu-options.hx | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 65c9473b73..e14d88e9b2 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -327,8 +327,8 @@ format(true color). The resolution should be supporte=
d by the SVGA mode, so
>  the recommended is 320x240, 640x480, 800x640.
> =20
>  A timeout could be passed to bios, guest will pause for @var{rb_timeout}=
 ms
> -when boot failed, then reboot. If @option{reboot-timeout} is not set,
> -guest will not reboot by default. Currently Seabios for X86
> +when boot failed, then reboot. If @var{rb_timeout} is '-1', guest will n=
ot
> +reboot, qemu passes '-1' to bios by default. Currently Seabios for X86
>  system support it.
> =20
>  Do strict boot via @option{strict=3Don} as far as firmware/BIOS
> --=20
> 2.24.0.rc1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


