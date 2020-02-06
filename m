Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523DCC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 08:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C54E217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 08:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OgzfyeS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C54E217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izcVR-0007u3-9n
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 03:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1izcUd-0007Q5-8b
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:26:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1izcUc-0006rm-5n
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:26:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21286
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1izcUc-0006qj-1p
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580977593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=22+wLulA6WRHncQJZeLIDGAdvuvwWKpzzSY3Q7u/X9A=;
 b=OgzfyeS8/pPB4JGkO3HolRVn+5DZFhGA5OSnD0kqDEv+yhphFufy8QnI4AO9NWVenQRKb7
 JgdAduDhqCTXNWNH6VAGMeGk/eTY1hILLD4ncTVIG+p6Q5LEpEpZMv9sQQ9ebjgFizgG1c
 bGTkpuw4R1rDBByLdOxiqSuxHVBmSSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-DpFaVEIhNMqRZspB2omuYQ-1; Thu, 06 Feb 2020 03:26:31 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6152D1088382
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 08:26:30 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AC1548;
 Thu,  6 Feb 2020 08:26:26 +0000 (UTC)
Message-ID: <898c9791b1b60e590da3eb6e3347f03a880daa9b.camel@redhat.com>
Subject: Re: [PATCH v2] qxl: introduce hardware revision 5
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Date: Thu, 06 Feb 2020 10:26:26 +0200
In-Reply-To: <20200206074358.4274-1-kraxel@redhat.com>
References: <20200206074358.4274-1-kraxel@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: DpFaVEIhNMqRZspB2omuYQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
Cc: Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-02-06 at 08:43 +0100, Gerd Hoffmann wrote:
> The only difference to hardware revision 4 is that the device doesn't
> switch to VGA mode in case someone happens to touch a VGA register,
> which should make things more robust in configurations with multiple
> vga devices.
> 
> Swtiching back to VGA mode happens on reset, either full machine
> reset or qxl device reset (QXL_IO_RESET ioport command).
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/qxl.h  | 2 +-
>  hw/core/machine.c | 2 ++
>  hw/display/qxl.c  | 7 ++++++-
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/qxl.h b/hw/display/qxl.h
> index 80eb0d267269..707631a1f573 100644
> --- a/hw/display/qxl.h
> +++ b/hw/display/qxl.h
> @@ -144,7 +144,7 @@ typedef struct PCIQXLDevice {
>          }                                                               \
>      } while (0)
>  
> -#define QXL_DEFAULT_REVISION QXL_REVISION_STABLE_V12
> +#define QXL_DEFAULT_REVISION (QXL_REVISION_STABLE_V12 + 1)
Minor nitpick: Maybe add a #define instead of +1?

>  
>  /* qxl.c */
>  void *qxl_phys2virt(PCIQXLDevice *qxl, QXLPHYSICAL phys, int group_id);
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 3e288bfceb7f..13a3b2c9c425 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -34,6 +34,8 @@ GlobalProperty hw_compat_4_2[] = {
>      { "vhost-blk-device", "seg_max_adjust", "off"},
>      { "usb-host", "suppress-remote-wake", "off" },
>      { "usb-redir", "suppress-remote-wake", "off" },
> +    { "qxl", "revision", "4" },
> +    { "qxl-vga", "revision", "4" },
>  };
>  const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
>  
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index c33b1915a52c..64884da70857 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -1309,7 +1309,8 @@ static void qxl_vga_ioport_write(void *opaque, uint32_t addr, uint32_t val)
>      PCIQXLDevice *qxl = container_of(vga, PCIQXLDevice, vga);
>  
>      trace_qxl_io_write_vga(qxl->id, qxl_mode_to_string(qxl->mode), addr, val);
> -    if (qxl->mode != QXL_MODE_VGA) {
> +    if (qxl->mode != QXL_MODE_VGA &&
> +        qxl->revision <= QXL_REVISION_STABLE_V12) {
>          qxl_destroy_primary(qxl, QXL_SYNC);
>          qxl_soft_reset(qxl);
>      }
> @@ -2121,6 +2122,10 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
>          pci_device_rev = QXL_REVISION_STABLE_V12;
>          io_size = pow2ceil(QXL_IO_RANGE_SIZE);
>          break;
> +    case 5: /* qxl-5 */
> +        pci_device_rev = QXL_REVISION_STABLE_V12 + 1;
> +        io_size = pow2ceil(QXL_IO_RANGE_SIZE);
> +        break;
>      default:
>          error_setg(errp, "Invalid revision %d for qxl device (max %d)",
>                     qxl->revision, QXL_DEFAULT_REVISION);

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


