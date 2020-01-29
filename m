Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190B2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 13:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D0020716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 13:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdjyjFTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D0020716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwn1X-00012D-3T
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 08:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iwn0e-0000Tz-6d
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:03:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iwn0d-000506-7p
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:03:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30178
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iwn0d-0004zP-4o
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580303034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=EueI91FbOgkHi8wP3kk+3jcFx8Ohx4d0oG+ulpN4JQA=;
 b=GdjyjFTgOAr9vqeVRGzK95ctGLBR6x8ftTBzBsfib9a+unhQwWy/OBYyyE24PusqyPz73T
 FKC0fGXmvfkzQSwrguFzEt5JhH/vvWjjExO9Wu+Eje9+dg8+YPggNO3wuGHDXZp/5zCEdl
 Os4mygzeyKGlTQwH6hCjhnoV1o8Ptcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-p8X4YY3JPySa06cxdtyV7A-1; Wed, 29 Jan 2020 08:03:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9ADB81050944;
 Wed, 29 Jan 2020 13:03:45 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-210.ams2.redhat.com [10.36.116.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED6C210841ED;
 Wed, 29 Jan 2020 13:03:43 +0000 (UTC)
Subject: Re: [PATCH] ppc/pnv: change the PowerNV machine devices to be non
 user creatable
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200129113720.7404-1-clg@kaod.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <714aaf3e-91e5-9a5b-9024-b9bd189b8258@redhat.com>
Date: Wed, 29 Jan 2020 14:03:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200129113720.7404-1-clg@kaod.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: p8X4YY3JPySa06cxdtyV7A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/01/2020 12.37, C=C3=A9dric Le Goater wrote:
> The PowerNV machine emulates an OpenPOWER system and the PowerNV chip
> devices are models of the internal logic of the POWER processor. They
> can not be instantiated by the user on the QEMU command line.

Maybe mention that QEMU currently abort()s if the user tries to do it
anyway.

> The PHB3/PHB4 devices could be an exception in the future after some
> rework on how the device tree is built. For the moment, exclude them
> also.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/pci-host/pnv_phb3.c      | 2 ++
>  hw/pci-host/pnv_phb3_pbcq.c | 1 +
>  hw/pci-host/pnv_phb4.c      | 3 ++-
>  hw/pci-host/pnv_phb4_pec.c  | 2 ++
>  hw/ppc/pnv_core.c           | 2 ++
>  hw/ppc/pnv_homer.c          | 1 +
>  hw/ppc/pnv_lpc.c            | 1 +
>  hw/ppc/pnv_occ.c            | 1 +
>  8 files changed, 12 insertions(+), 1 deletion(-)

Thanks, this fixes the abort()s that have been reported by
scripts/device-crash-test.

Tested-by: Thomas Huth <thuth@redhat.com>


