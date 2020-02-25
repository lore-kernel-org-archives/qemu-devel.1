Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A47C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3A721744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXtPqJGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3A721744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6WCA-0006Gd-B7
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 04:08:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6WBM-0005R4-Fi
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:07:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6WBL-0006xL-Kx
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:07:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35530
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6WBL-0006xA-Hj
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582621631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LrjhG98Q2CfCLxqVlJJ0yczHQPVK9btkIwazK/tkAUE=;
 b=QXtPqJGxeZ0gQhIQ35niLixwhQxquGUv9L7iNuinRL2EYN9oEJfta6D5JqBr+3O2bqJG9R
 rsnBW5WcQs9SsuA8Ac7YwPmpQiMUUvE3Ts5hopPND3Iq8wxaFBZwBb6BVzRZFQa96+yRjV
 7SqK3nOM8GacoQ29gKgzP9K2g9ZvFT8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-VXxDVyoaN9aeFM4KO7Ferg-1; Tue, 25 Feb 2020 04:07:07 -0500
X-MC-Unique: VXxDVyoaN9aeFM4KO7Ferg-1
Received: by mail-ed1-f72.google.com with SMTP id t20so8610480eds.19
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 01:07:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CmRm8HTroD11NN0frkvSMHOgNvyBzdG2ZicM2ny0gFY=;
 b=FC2TagAkMLaQ5adwH8KAtbESBKGxD02X5Ac+9jSz9BAPZmBGr2hDz4qLF4DHldqlCT
 rZh0z6xW98ced9a2RvBcyUuG0ki0zKmr01xO8dQckVSGhEVAaFbe0DeDz1wbE+hNFj2U
 bEXCdAJvS9OAKE3JPxxgCJONJKG/NXw0OkFkSz8/jtorCJwZSrIQZL1j1MUiupWNdCPR
 0YlybuALn03USyU00feMb9ujwVhCB2O460iimwUn26Sv8wUZFNEC/Ur9NfNTDodqBx19
 IJPPkINIkyyEeYu18s1FN3RZttb+4Oo41UBKTlOIA0u8yI3LeLzWwAzrPZ6cXDWgzMae
 kotA==
X-Gm-Message-State: APjAAAU0F84GhOlmhjaSaS+LjTSXdgd53fIDFQTLsXRPy2qhUKBT5+H8
 ue/+B1YH7/MPdGGFGrT3YS2Smemq+r24foUAZ+zbeEoUMT8fC6MAmbpHA7ZoYDQC+Zp+WwD1L+t
 taEXQteXiTcSMfpc=
X-Received: by 2002:aa7:d811:: with SMTP id v17mr49098192edq.277.1582621626601; 
 Tue, 25 Feb 2020 01:07:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqzOU/5nYOuUg1OoRX7f5ol2KCm0pPzQdYzldSaSh3aVFY8YA+v5foupe8LI3ivKILAx39h/tw==
X-Received: by 2002:aa7:d811:: with SMTP id v17mr49098166edq.277.1582621626373; 
 Tue, 25 Feb 2020 01:07:06 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id v2sm917343ejj.44.2020.02.25.01.07.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 01:07:05 -0800 (PST)
Subject: Re: [PATCH 1/2] qxl: map rom r/o
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200225055920.17261-1-kraxel@redhat.com>
 <20200225055920.17261-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2bdcbe5f-1fa0-386d-a9c4-f0d7c2bebca1@redhat.com>
Date: Tue, 25 Feb 2020 10:07:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225055920.17261-2-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: sstabellini@kernel.org, pmatouse@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, mdroth@linux.vnet.ibm.com,
 ppandit@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 6:59 AM, Gerd Hoffmann wrote:
> Map qxl rom read-only into the guest, so the guest can't tamper with the
> content.  qxl has a shadow copy of the rom to deal with that, but the
> shadow doesn't cover the mode list.  A privilidged user in the guest can
> manipulate the mode list and that to trick qemu into oob reads, leading
> to a DoS via segfault if that read access happens to hit unmapped memory.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/display/qxl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 21a43a1d5ec2..227da69a50d9 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -2136,7 +2136,7 @@ static void qxl_realize_common(PCIQXLDevice *qxl, E=
rror **errp)
>       pci_set_byte(&config[PCI_INTERRUPT_PIN], 1);
>  =20
>       qxl->rom_size =3D qxl_rom_size();
> -    memory_region_init_ram(&qxl->rom_bar, OBJECT(qxl), "qxl.vrom",
> +    memory_region_init_rom(&qxl->rom_bar, OBJECT(qxl), "qxl.vrom",
>                              qxl->rom_size, &error_fatal);
>       init_qxl_rom(qxl);
>       init_qxl_ram(qxl);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


