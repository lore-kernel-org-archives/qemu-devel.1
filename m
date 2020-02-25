Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CE4C35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB3721556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3btD7A2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB3721556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6WQ0-0007AH-Lr
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 04:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6WPE-0006Bf-99
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:21:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6WPD-0005dU-8L
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:21:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45188
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6WPD-0005dG-4W
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582622490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Fqhqm3HFKlHy693d0PfaiJUMpLdr82MnN67Vl/qAHY=;
 b=U3btD7A2d8YF6y+bMariswj4pPv4dSHFLK6HwRQafOE0pofhvjHauH2L/BLwALvP/4pN8m
 qsgWiiLANtXEpR8eLt5/03vFQ3++vPZvKCR1gyqBg87q8ABtwa/IqpSNDIuAFfCy9j3oR9
 xmrpcfojEn4ZRXjR/tjq7XRoBcVj9fY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-CB41b9w7MJGHEultQzyA5A-1; Tue, 25 Feb 2020 04:21:26 -0500
X-MC-Unique: CB41b9w7MJGHEultQzyA5A-1
Received: by mail-ed1-f72.google.com with SMTP id t20so8639058eds.19
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 01:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Qolc7f88M5U78uKiHGafxjKtE7PoGg7cQ46aHnpLEdk=;
 b=KSih8C7Kuk90oiyZjhekR9m0SU4ccjwYoaGZcCrzwyk1IfF9RHyWj1cBJacP14uCVx
 T1rk4dUPNwsjwmhiVUM4AOumKyZpo5UdaExAymn7m1SoRnS/d9K8xxjS8irQ1KXNyG6Y
 zLWrn6WsP+SCWBUnqeWCmtXeq7ILYwbLHIUtCMX6Mfbm78YL1qHBcPomTP0x8CNBgL0M
 E9yAxCA3xSVeZTgqhUGIXnR8r7qupz2PmGGdhup/QCI6yMUS1PgoHBj43qf1Xd2FNAax
 lwULNeuatyxwAdqW5O0LamGlsp+DLUOIIYqfBigX1/5hQ7rF3q7CocIVJKCmu4lcvwz9
 7mYQ==
X-Gm-Message-State: APjAAAVSlzJl+BtY5kr7NItSxKi4GXVcwe9b/Jcra50Kn6DSsWN5TTYe
 rjuI24KBW62NFwLwPG0xcmP1oOQK3nGJtn1uz4BxxnecvfVEiL+DCedpLf4fw0BJ2LfTccYcpqU
 bgtLChZk4Mxh2uQI=
X-Received: by 2002:a17:906:a44d:: with SMTP id
 cb13mr51387132ejb.258.1582622485474; 
 Tue, 25 Feb 2020 01:21:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqzIuhbZl2p2DXKRgnBwzH7VAG1F+IhyAmA69LpSDwerRJhK/iIeGmbmIrwv78rNunQuUnVknw==
X-Received: by 2002:a17:906:a44d:: with SMTP id
 cb13mr51387105ejb.258.1582622485235; 
 Tue, 25 Feb 2020 01:21:25 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id i21sm1131996edj.33.2020.02.25.01.21.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 01:21:24 -0800 (PST)
Subject: Re: [PATCH 3/4] virtio-pmem: do delete rq_vq in virtio_pmem_unrealize
To: Pan Nengyuan <pannengyuan@huawei.com>, mst@redhat.com
References: <20200225075554.10835-1-pannengyuan@huawei.com>
 <20200225075554.10835-4-pannengyuan@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b14afc54-6cf1-a99c-7612-b9b6c4f70816@redhat.com>
Date: Tue, 25 Feb 2020 10:21:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225075554.10835-4-pannengyuan@huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 8:55 AM, Pan Nengyuan wrote:
> Similar to other virtio-deivces, rq_vq forgot to delete in virtio_pmem_un=
realize, this patch fix it.

"devices"

> This device has aleardy maintained a vq pointer, thus we use the new virt=
io_delete_queue function directly to do the cleanup.

"already"

>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   hw/virtio/virtio-pmem.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
> index 97287e923b..43399522f5 100644
> --- a/hw/virtio/virtio-pmem.c
> +++ b/hw/virtio/virtio-pmem.c
> @@ -130,6 +130,7 @@ static void virtio_pmem_unrealize(DeviceState *dev, E=
rror **errp)
>       VirtIOPMEM *pmem =3D VIRTIO_PMEM(dev);
>  =20
>       host_memory_backend_set_mapped(pmem->memdev, false);
> +    virtio_delete_queue(pmem->rq_vq);
>       virtio_cleanup(vdev);
>   }
>  =20
>=20


