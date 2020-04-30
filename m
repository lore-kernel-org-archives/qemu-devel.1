Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8A0C83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8192520838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHHJDsZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8192520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU3Ny-00013c-O9
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 03:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU3N9-00006t-63
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU3N8-0001EX-I7
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:12:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21372
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jU3N8-0001EO-4w
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588230757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8SCkJlWak2d3bjc+ojdtFvrXQlZuBTGjvRLdl4Bcco=;
 b=EHHJDsZ1lmM1Lmo3BF+wAzzGzCmFhmKniAS32+UslZH+YfNACJeK6nLGOJ9qvqUyPAn+O9
 5spD49Xv8c+csbR0MYEs5u4cG3/a4gCYMR3WcKBKmYtRErdlCeNIXgqt2yABaHqraD8UZz
 g15I70nda3bdvFrZbuo9b1OOc3YStb0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-U9EHPRqOOoqbpaOzxIf-cQ-1; Thu, 30 Apr 2020 03:12:35 -0400
X-MC-Unique: U9EHPRqOOoqbpaOzxIf-cQ-1
Received: by mail-wr1-f72.google.com with SMTP id a12so252903wrv.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 00:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i5+M5C20MqxCUIhHDt+GfhhcD0lh80jyfkY47P02L38=;
 b=AhG0sw2TveSAzK+DGGE5WtPMGPOFJdlEvUXbwGH1kKYuUcQQsq/TRWLPH7ny3QtZT4
 W/Z4WDBDhyixD1sU/CMv7+gzua+We/WcgbkB4bw30jY2cI5s12wOThQdj8K9F3dsvXkX
 OzUPdcHrRRNdILnGCI409PSQ/9KJzjM5Epq+8G7bbGoe8yx2H5VUR8+8D0lCrY1jBmxT
 u6eRHCoDkEvVsMjr1CB6Pp8oI6JhLHDGZ8K952p0PdWJGw9d9f7EHIohAnUF0pf1FpbH
 +Sqd14hE1lHzSu51bxmoEOZ+p3fpSkjXmNnFr1cXWd7GOdtsib+FMvjqM1EfVOsoN602
 QOFQ==
X-Gm-Message-State: AGi0PuaMbxkPhqKP8bKtHDtKLw7Y/ncJ4/HUCCBAnMRGMQyg4E1sfU6t
 WqVJuUcEDk7/wmIbBS1gV+rJDcw8tlFoDZ22AcwSYv67Xdy7/GhrkIy9M8nRPkaKCZiWCWO+EDa
 RdpyPwF01CCRnjPY=
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr2223035wrn.241.1588230754507; 
 Thu, 30 Apr 2020 00:12:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypIaskVt5sp6fQ7Qyvh1G1mDtdSM2oomv4rAeqp+08l5hSgKdBVihcdOEkpYbniduZ6b8UFaIA==
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr2223022wrn.241.1588230754336; 
 Thu, 30 Apr 2020 00:12:34 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id v131sm11493518wmb.19.2020.04.30.00.12.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 00:12:33 -0700 (PDT)
Subject: Re: [PATCH 02/12] stubs: add pci_create_simple
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200429110214.29037-1-kraxel@redhat.com>
 <20200429110214.29037-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <81db0702-28c5-2d85-75cf-70e6ad795952@redhat.com>
Date: Thu, 30 Apr 2020 09:12:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200429110214.29037-3-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/20 1:02 PM, Gerd Hoffmann wrote:
> Needed for -soundhw cleanup.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   stubs/pci-bus.c     | 7 +++++++
>   stubs/Makefile.objs | 1 +
>   2 files changed, 8 insertions(+)
>   create mode 100644 stubs/pci-bus.c
>=20
> diff --git a/stubs/pci-bus.c b/stubs/pci-bus.c
> new file mode 100644
> index 000000000000..e833947f1f41
> --- /dev/null
> +++ b/stubs/pci-bus.c
> @@ -0,0 +1,7 @@
> +#include "qemu/osdep.h"
> +#include "hw/pci/pci.h"
> +
> +PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name)
> +{
> +    return NULL;

We want:

        g_assert_not_reached();

Otherwise:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +}
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index c61ff38cc801..5e7f2b3f061e 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -40,6 +40,7 @@ stub-obj-y +=3D target-get-monitor-def.o
>   stub-obj-y +=3D vmgenid.o
>   stub-obj-y +=3D xen-common.o
>   stub-obj-y +=3D xen-hvm.o
> +stub-obj-y +=3D pci-bus.o
>   stub-obj-y +=3D pci-host-piix.o
>   stub-obj-y +=3D ram-block.o
>   stub-obj-y +=3D ramfb.o
>=20


