Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77D0C2BB55
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 08:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5C32054F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 08:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEnC576k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5C32054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPMgC-0006kD-SG
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 04:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jPMfZ-0006LG-Bn
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 04:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jPMfY-00059H-CO
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 04:48:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49132
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jPMfY-00058p-8q
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 04:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587113295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8E+nm11YdAsO86LKXyh2CzizoQpJbjL0Pod/At/9euA=;
 b=FEnC576kjuVBfIIlBIj1MVVRYiNu8H/ccIUXZX/bysyAdYwADKoRJYXxSB1/rVvax79Kqp
 aXSUr/WoMMrbmBj5IOAWqGDtPa8M4YVcNpuKfiBMOPczpDzXqkZICbVeX26xkefznfATY7
 PFBhMO4avTM9phKfkrv/+irBNpBAyjA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-_R_Xt77HMNKHiLR5c0Tpig-1; Fri, 17 Apr 2020 04:48:11 -0400
X-MC-Unique: _R_Xt77HMNKHiLR5c0Tpig-1
Received: by mail-ej1-f71.google.com with SMTP id v3so737328ejx.8
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 01:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EJyFD+7HP8DXjfsXXoXIzrh528yWG04HEuJslhOW4xU=;
 b=k81ydoX5ydOSo7hz8Le+CFBLAhnCbeV4fveShJpMiQGAInwDPXu050zb/s650ZLQd+
 NBqub5iIPqiTDj2gjb1ysXdI7SmDF7VGCWYwl9TLXWhrSqn1KlMNLushsRjVwiOgUd1Y
 y8jsI+GmSM09MC7AKohqrBJAtrHWqj419DcckAw6FfZAg8D4JAsbiEjT/eCuG9Q6KL2L
 +EL0rXpVpDBkkEzKOgc9el7FMtj3gsVDVbryckz5dYgoDEemzdSqCBnoatT8egKLHHoW
 vMwvXGa+mxAOQYq7M0NiMMvt4wm1TVYKNehKEF3/cRb5W+3CSwyT4qOE4bhp2kh5A5qw
 QRkg==
X-Gm-Message-State: AGi0PubAmTehUi5u6wxCSa2UBdwLvFz1J4BjXzZBQuqMfBe52NegSeRW
 zySG8TOKmVXblddR3wGAA7RpkEVIm3cpL5vIjEJJKBx5ZMaTf3o6S/mzV8Z3k5oMJaCeACCYKvD
 dGFEil5dY+ekpe2I=
X-Received: by 2002:a17:906:4356:: with SMTP id
 z22mr1931031ejm.334.1587113290277; 
 Fri, 17 Apr 2020 01:48:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypLBfSX3LBUwoZ6rjtBCGXBqEXihz+K1RLOZ+wImeTKrPhvsXLLABHTDJNu8lykFMx7x5PmUjg==
X-Received: by 2002:a17:906:4356:: with SMTP id
 z22mr1931016ejm.334.1587113290098; 
 Fri, 17 Apr 2020 01:48:10 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id j12sm687923edv.47.2020.04.17.01.48.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2020 01:48:09 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] memory: drop guest writes to read-only ram device
 regions
To: Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com,
 alex.williamson@redhat.com
References: <20200417074437.28526-1-yan.y.zhao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8c8dfeaa-c710-4ca9-a72f-77f32a4537df@redhat.com>
Date: Fri, 17 Apr 2020 10:48:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200417074437.28526-1-yan.y.zhao@intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: xin.zeng@intel.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/17/20 9:44 AM, Yan Zhao wrote:
> for ram device regions, drop guest writes if the regions is read-only.
>=20
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> ---
>   memory.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>=20
> diff --git a/memory.c b/memory.c
> index 601b749906..9576dd6807 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -34,6 +34,7 @@
>   #include "sysemu/accel.h"
>   #include "hw/boards.h"
>   #include "migration/vmstate.h"
> +#include "qemu/log.h"
>  =20
>   //#define DEBUG_UNASSIGNED
>  =20
> @@ -1313,6 +1314,12 @@ static void memory_region_ram_device_write(void *o=
paque, hwaddr addr,
>       MemoryRegion *mr =3D opaque;
>  =20
>       trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, dat=
a, size);
> +    if (mr->readonly) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Invalid write to read only ram device region 0x%"
> +                       HWADDR_PRIx" size %u\n", addr, size);
> +        return;
> +    }
>  =20
>       switch (size) {
>       case 1:
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


