Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862DFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 10:16:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FCCF2072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 10:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fl24tvSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCCF2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbiFQ-0000pM-Fa
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 06:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbiEP-0007bh-5R
 for qemu-devel@nongnu.org; Thu, 21 May 2020 06:15:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31876
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbiEO-0000iJ-Gg
 for qemu-devel@nongnu.org; Thu, 21 May 2020 06:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590056115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CbanrbsgnzNrBG0ZOoBhiLSlOSNfBucffzZ2jPnkCeM=;
 b=Fl24tvSfDGE6b8Ahee4l47gCiOvKFzYeQ6Niu1k0ESaekpQd7FqJHvrtRruV1uIPJXVZGb
 9px2UlZHIwroaoCfjIfZiN7QsC8fFaEr2af/YI6VluSFPmyZPKf9MQ4a56LhEpP3LCcoz9
 CZP8zQeW+ZtXB0AiRpu92NTHqGkzr9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-KRtaBEUUMSmz6RUFP6tE_Q-1; Thu, 21 May 2020 06:15:11 -0400
X-MC-Unique: KRtaBEUUMSmz6RUFP6tE_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 880788005AA;
 Thu, 21 May 2020 10:15:10 +0000 (UTC)
Received: from localhost (unknown [10.40.208.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AA5E62932;
 Thu, 21 May 2020 10:14:58 +0000 (UTC)
Date: Thu, 21 May 2020 12:14:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 19/22] microvm/acpi: use seabios with acpi=on
Message-ID: <20200521121457.39192559@redhat.com>
In-Reply-To: <20200520132003.9492-20-kraxel@redhat.com>
References: <20200520132003.9492-1-kraxel@redhat.com>
 <20200520132003.9492-20-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 May 2020 15:20:00 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> With acpi=off continue to use qboot.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/microvm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 7d8174809ae1..ddb8570a2915 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -52,6 +52,7 @@
>  #include "hw/xen/start_info.h"
>  
>  #define MICROVM_QBOOT_FILENAME "qboot.bin"
> +#define MICROVM_BIOS_FILENAME  "bios-microvm.bin"
>  
>  static void microvm_set_rtc(MicrovmMachineState *mms, ISADevice *s)
>  {
> @@ -174,7 +175,9 @@ static void microvm_devices_init(MicrovmMachineState *mms)
>      }
>  
>      if (bios_name == NULL) {
> -        bios_name = MICROVM_QBOOT_FILENAME;
> +        bios_name = x86_machine_is_acpi_enabled(x86ms)
> +            ? MICROVM_BIOS_FILENAME
> +            : MICROVM_QBOOT_FILENAME;
>      }
>      x86_bios_rom_init(get_system_memory(), true);
>  }


