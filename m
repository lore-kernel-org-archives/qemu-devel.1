Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5703C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 05:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8983220B1F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 05:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8983220B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43842 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdpzd-000884-PG
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 01:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56340)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hdpw5-0006Hf-5Z
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 01:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hdpw3-0002I9-6q
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 01:48:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59714)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>)
 id 1hdpvz-0002EM-Mu; Thu, 20 Jun 2019 01:48:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 92EFF3082E40;
 Thu, 20 Jun 2019 05:48:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-212.ams2.redhat.com
 [10.36.116.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61CA35D9C6;
 Thu, 20 Jun 2019 05:48:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4C3A816E19; Thu, 20 Jun 2019 07:48:28 +0200 (CEST)
Date: Thu, 20 Jun 2019 07:48:28 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-ID: <20190620054828.yhicxaac3myfilub@sirius.home.kraxel.org>
References: <20190619092905.24029-1-shmuel.eiderman@oracle.com>
 <20190619092905.24029-8-shmuel.eiderman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619092905.24029-8-shmuel.eiderman@oracle.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 20 Jun 2019 05:48:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [QEMU] [PATCH v4 7/8] bootdevice: FW_CFG interface
 for LCHS values
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 kevin@koconnor.net, liran.alon@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 12:29:04PM +0300, Sam Eiderman wrote:
> Using fw_cfg, supply logical CHS values directly from QEMU to the BIOS.
> 
> Non-standard logical geometries break under QEMU.
> 
> A virtual disk which contains an operating system which depends on
> logical geometries (consistent values being reported from BIOS INT13
> AH=08) will most likely break under QEMU/SeaBIOS if it has non-standard
> logical geometries - for example 56 SPT (sectors per track).
> No matter what QEMU will report - SeaBIOS, for large enough disks - will
> use LBA translation, which will report 63 SPT instead.
> 
> In addition we cannot force SeaBIOS to rely on physical geometries at
> all. A virtio-blk-pci virtual disk with 255 phyiscal heads cannot
> report more than 16 physical heads when moved to an IDE controller,
> since the ATA spec allows a maximum of 16 heads - this is an artifact of
> virtualization.
> 
> By supplying the logical geometries directly we are able to support such
> "exotic" disks.
> 
> We serialize this information in a similar way to the "bootorder"
> interface.
> The new fw_cfg entry is "bios-geometry".
> 
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
> ---
>  bootdevice.c            | 32 ++++++++++++++++++++++++++++++++
>  hw/nvram/fw_cfg.c       | 14 +++++++++++---
>  include/sysemu/sysemu.h |  1 +
>  3 files changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/bootdevice.c b/bootdevice.c
> index 2b12fb85a4..b034ad7bdc 100644
> --- a/bootdevice.c
> +++ b/bootdevice.c
> @@ -405,3 +405,35 @@ void del_boot_device_lchs(DeviceState *dev, const char *suffix)
>          }
>      }
>  }
> +
> +/* Serialized as: (device name\0 + lchs struct) x devices */

Comment is outdated.

> +    if (!mc->legacy_fw_cfg_order) {
> +        buf = get_boot_devices_lchs_list(&len);
> +        ptr = fw_cfg_modify_file(s, "bios-geometry", (uint8_t *)buf, len);

Can fw_cfg_modify_file handle buf == NULL?

cheers,
  Gerd


