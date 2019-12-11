Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F87C2D0C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:46:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62FDE2073B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="5QLSunGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FDE2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if4Bs-0001hx-H5
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 10:46:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1if48j-00011z-QY
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:43:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1if48i-0001AM-DS
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:43:01 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:48602)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1if48h-00017p-EP
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:42:59 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id A86AE96EF0;
 Wed, 11 Dec 2019 15:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1576078976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aa+BJe8ikkKPy+0Dfm3AFYyuZezXknokDxA20k+WUqw=;
 b=5QLSunGpZ3eCP4f40hHn0e0gec8bJ8kiN2u82Y8mFTqo+zx+FHiRqm4Ni3YGdUmRZaK2rt
 X1op9fOzNkecjvyL8sUVwLTtEh35uCow1dTL1Eov+FAX9o1PKiFDEdTewot22uifFsceVl
 Z1qeu/1XrehlxzISrVG/ojy2O/xvGIU=
Subject: Re: [PATCH 02/26] qdev: remove duplicated qdev_property_add_static()
 doc
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
 <20191201111531.1136947-3-marcandre.lureau@redhat.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <475fa485-22d0-6f79-de5a-ebb31e779f2f@greensocs.com>
Date: Wed, 11 Dec 2019 16:42:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191201111531.1136947-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1576078977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aa+BJe8ikkKPy+0Dfm3AFYyuZezXknokDxA20k+WUqw=;
 b=Df6ZEKf7mst9SK2VRQrhSGGzrVW21Xg3+nZ7b9CknqDX1uw3zhioFoDd82OCMjJY5TFjnC
 +KOAAAg2pXKpzC1ULdEhA+Oe/ToLrxrZtdRJ8am3NUFLA58/aGv/psHZxN9Le72o5AfcCo
 ZAyFr6f9YqNlm4GP003WsGuYBoGL744=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1576078977; a=rsa-sha256; cv=none;
 b=GqjVPF4pqd5ZdzK1mhXRq+mcQ1ldZdHzSnfSM5Cr3gdTjM7zvBtFndBZpJGKKqYTqfN6fj
 a58oKxSDAXgXtR6nlDqPG2gAauxcEXWaV/oUOQIEb6j/lnRo5ws8CZOaoD4zePD47K+KXU
 6eVc6RBp54pslaF40d7BUay6Iv7RXLM=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/1/19 12:15 PM, Marc-Andr=C3=A9 Lureau wrote:
> The function is already documented in the header.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/core/qdev.c | 10 ----------
>  1 file changed, 10 deletions(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index c7b3f0dec5..8b93b85727 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -717,16 +717,6 @@ static void qdev_property_add_legacy(DeviceState *=
dev, Property *prop,
>      g_free(name);
>  }
> =20
> -/**
> - * qdev_property_add_static:
> - * @dev: Device to add the property to.
> - * @prop: The qdev property definition.
> - * @errp: location to store error information.
> - *
> - * Add a static QOM property to @dev for qdev property @prop.
> - * On error, store error in @errp.  Static properties access data in a=
 struct.
> - * The type of the QOM property is derived from prop->info.
> - */
>  void qdev_property_add_static(DeviceState *dev, Property *prop,
>                                Error **errp)
>  {
>=20

Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>

Regards,
--
Damien

