Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598D8C3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 23:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D7EA20842
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 23:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hga0dWII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7EA20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9dS2-0000XX-BK
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 18:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1j9dRM-00008D-9v
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 18:28:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1j9dRK-0002s1-Cp
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 18:28:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35069
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1j9dRK-0002rk-8a
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 18:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583364513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dbkKVEchh5xt+vaUiHZVuwsYFkjH8deOOCrPSa8W3yA=;
 b=Hga0dWIIwUgUdZ4YQZxIRmHFPs3jXDVFcoJZn961LVstqRGhjViTcYGg/s19zuuygwTMZM
 uqVvHQAzmbhUGeq5/F1MY6OUpbGNOgTskOWibQi+qFKL/0M1ay3MJHXf+q0lWv9xys1mVI
 A2tfLRBL7TbgCYn7Ydxryk83lcYzQeA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-RnZzIjCfMrO3G2E0AUfIhQ-1; Wed, 04 Mar 2020 18:28:29 -0500
X-MC-Unique: RnZzIjCfMrO3G2E0AUfIhQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CD5F18A5502
 for <qemu-devel@nongnu.org>; Wed,  4 Mar 2020 23:28:28 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-23.ams2.redhat.com
 [10.36.116.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97ADF5C1D8;
 Wed,  4 Mar 2020 23:28:24 +0000 (UTC)
Subject: Re: [PULL 1/1] qxl: introduce hardware revision 5
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20200213090627.2181-1-kraxel@redhat.com>
 <20200213090627.2181-2-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <bb1f9cbb-7f98-e955-c55d-abc36e788902@redhat.com>
Date: Thu, 5 Mar 2020 00:28:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200213090627.2181-2-kraxel@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Yan Vugenfirer <yvugenfi@redhat.com>,
 Yuri Benditovich <ybendito@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

On 02/13/20 10:06, Gerd Hoffmann wrote:
> The only difference to hardware revision 4 is that the device doesn't
> switch to VGA mode in case someone happens to touch a VGA register,
> which should make things more robust in configurations with multiple
> vga devices.
>
> Swtiching back to VGA mode happens on reset, either full machine
> reset or qxl device reset (QXL_IO_RESET ioport command).
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Message-id: 20200206074358.4274-1-kraxel@redhat.com
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
>
>  /* qxl.c */
>  void *qxl_phys2virt(PCIQXLDevice *qxl, QXLPHYSICAL phys, int group_id);
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index d8e30e4895d8..84812a1d1cc1 100644
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
>

this patch -- commit ed71c09ffd6f -- disables ACPI S3 in the Windows 10
guest for me, using OVMF and QXL.

The "Sleep" menu entry disappears from the power button icon/menu at the
login screen, and "psshutdown -d -t 3" (from the pstools package) also
stops working (it reports that the computer does not support S3).

At the parent commit (e18e5501d8ac), S3 suspend/resume works.

Here's the bisection log:

> git bisect start
> # good: [928173659d6e5dc368284f73f90ea1d129e1f57d] Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200130' into staging
> git bisect good 928173659d6e5dc368284f73f90ea1d129e1f57d
> # good: [93c86fff53a267f657e79ec07dcd04b63882e330] Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200207' into staging
> git bisect good 93c86fff53a267f657e79ec07dcd04b63882e330
> # bad: [db736e0437aa6fd7c1b7e4599c17f9619ab6b837] Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging
> git bisect bad db736e0437aa6fd7c1b7e4599c17f9619ab6b837
> # bad: [8ee06e4ccb0f447caf9dc884b98986c155915e5c] ppc/mac_oldworld: use memdev for RAM
> git bisect bad 8ee06e4ccb0f447caf9dc884b98986c155915e5c
> # good: [dc7a88d0810ad272bdcd2e0869359af78fdd9114] target/arm: Implement ARMv8.1-VMID16 extension
> git bisect good dc7a88d0810ad272bdcd2e0869359af78fdd9114
> # bad: [652c5bbd7e7d3cb3d27a2e0590118dc79fb6f4d8] Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.0-pull-request' into staging
> git bisect bad 652c5bbd7e7d3cb3d27a2e0590118dc79fb6f4d8
> # bad: [e050e426782ec4ae6bf84e5ec75ca502187f69cb] qapi: Use explicit bulleted lists
> git bisect bad e050e426782ec4ae6bf84e5ec75ca502187f69cb
> # good: [5d6542bea780ad443c4f7f1496e64706101f525c] Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20200212' into staging
> git bisect good 5d6542bea780ad443c4f7f1496e64706101f525c
> # bad: [72ec8bf362b24ebbd45452c298a3b14fb617eebb] qga/qapi-schema.json: Fix missing '-' in GuestDiskBusType doc comment
> git bisect bad 72ec8bf362b24ebbd45452c298a3b14fb617eebb
> # bad: [2eb054c237d0b5427f62499f3c31e90cf87821d7] configure: Allow user to specify sphinx-build binary
> git bisect bad 2eb054c237d0b5427f62499f3c31e90cf87821d7
> # bad: [517c84cef759a453cfb8f51498aebc909a5f3b39] Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200213-pull-request' into staging
> git bisect bad 517c84cef759a453cfb8f51498aebc909a5f3b39
> # bad: [ed71c09ffd6fbd01c2a487d47291ae57b08671ea] qxl: introduce hardware revision 5
> git bisect bad ed71c09ffd6fbd01c2a487d47291ae57b08671ea
> # first bad commit: [ed71c09ffd6fbd01c2a487d47291ae57b08671ea] qxl: introduce hardware revision 5

OVMF is built at current edk2 master: e63d54db9526.

In the Windows 10 guest, the installed driver has the following
properties (per Device Manager):

- driver date: 7/28/2015
- driver version: 22.33.46.473

I tried upgrading the QXL driver in the Windows 10 guest, using the
latest package at
<https://fedorapeople.org/groups/virt/virtio-win/repo/latest/?C=M;O=D>,
namely "virtio-win-0.1.173-7.noarch.rpm". But Device Manager said that
the currently installed driver was already the best / most recent for
the device.

For now I'll force the revision back to 4 using <qemu:arg> elements in
my domain XML. (I'd like to use pc-q35-5.0.)

    <qemu:arg value='-global'/>
    <qemu:arg value='qxl-vga.revision=4'/>

Thanks
Laszlo


