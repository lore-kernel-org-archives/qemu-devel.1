Return-Path: <SRS0=rO5d=BF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BEEC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 09:31:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F43206E3
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 09:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPoJHwVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F43206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzczq-00012d-8y
	for qemu-devel@archiver.kernel.org; Sun, 26 Jul 2020 05:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jzcz2-0000VV-AU
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 05:30:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32675
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jzcz0-0003Rg-98
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 05:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595755813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G24wWmi+691+LcnaeuQUQXfGggczuGX5jNz1Y0OEfHs=;
 b=gPoJHwVMLKNoWhBmDL9PPw0shxOf7+UuFeuiaDRrRl16Fuf+fYS/5HoW5gO8+36FTglPol
 BoXDcGMu89Pdx7U7oMXasLk4Dd1Clk+Vg8RRbXYsoLCgBlJE8WLtABWqaCDq1XZHqbAxub
 cE+gsD8C/6uBzrHpL6XpZUBbqutqoOE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-6zLXK3-zNj-2VgyMAvhnUg-1; Sun, 26 Jul 2020 05:30:11 -0400
X-MC-Unique: 6zLXK3-zNj-2VgyMAvhnUg-1
Received: by mail-qt1-f198.google.com with SMTP id h10so9391478qtc.4
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2020 02:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=G24wWmi+691+LcnaeuQUQXfGggczuGX5jNz1Y0OEfHs=;
 b=nkXZHmpopJnmQIXFiHQZ4gGQ+QO9matDKbQZj3AOaz6QWZztqmqmZktyfDScRyOlM7
 lhjTLrNDnL73Qp5xUg8ugcZSuE9wxPP+6wSSjmPdI5P45JYFU3w150OM2iT5Jvaz2Y8O
 c92d7/wlhF0nLkUkom/6e8L4cWAJJtUzq6haSSFx725bO+htdiet8MskBA/KEB1/HvUa
 VLq9AOJ0ypzUCSW2J043bkibaynxs9JABMSrMPoGVNqX8VGCon4JSWuYdToJ+dJYEDVp
 29Gd5rCkrflbjpnWLjT4zNbkBuL7s41D76Glm+1kiQGinQLOkJOc1a8Y+mbOitdGBfVc
 bDbg==
X-Gm-Message-State: AOAM530YR8gmoBlp+VMXcWTja8bKO1TW0hz5qDJ62j6RLRerBYqPDmYa
 6/IvGvu0W5UkfZ5womafwe9E0uDIVTce49+zapc0vNVnm6KKewOkglHF8vqRc7TRchOi5cYoyn5
 ITNJFfCs6Zi7No3g=
X-Received: by 2002:ac8:c7:: with SMTP id d7mr17211056qtg.235.1595755810966;
 Sun, 26 Jul 2020 02:30:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqA+DkLiXTd/TpmiWsJK1XPP43w3g6YpGSyFHoIVC7j/sNBaPb9/ZC1MkcUJKcARKKzDFRIg==
X-Received: by 2002:ac8:c7:: with SMTP id d7mr17211042qtg.235.1595755810670;
 Sun, 26 Jul 2020 02:30:10 -0700 (PDT)
Received: from redhat.com (93-172-53-68.bb.netvision.net.il. [93.172.53.68])
 by smtp.gmail.com with ESMTPSA id c70sm13022820qke.109.2020.07.26.02.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2020 02:30:10 -0700 (PDT)
Date: Sun, 26 Jul 2020 05:30:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hogan Wang <hogan.wang@huawei.com>
Subject: Re: [PATCH v3 2/2] hw/pci-host: save/restore pci host config
 register for old ones
Message-ID: <20200726052854-mutt-send-email-mst@kernel.org>
References: <20200725125437.2825-1-hogan.wang@huawei.com>
 <20200725125437.2825-2-hogan.wang@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200725125437.2825-2-hogan.wang@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/26 05:30:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: weidong.huang@huawei.com, wangxinxin.wang@huawei.com, jusual@redhat.com,
 dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 25, 2020 at 08:54:37PM +0800, Hogan Wang wrote:
> The i440fx and q35 machines integrate i440FX or MCH PCI device by default.
> Refer to i440FX and ICH9-LPC spcifications, there are some reserved
> configuration registers can used to save/restore PCIHostState.config_reg.
> It's nasty but friendly to old ones.
> 
> Signed-off-by: Hogan Wang <hogan.wang@huawei.com>

Just to make sure, how was this tested?
Did you test that migration to an old qemu e.g. the last release
with an old machine type works with this patch?


> ---
>  hw/pci-host/i440fx.c | 31 +++++++++++++++++++++++++++++++
>  hw/pci-host/q35.c    | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
> index c662903dbb..9e2cfdb052 100644
> --- a/hw/pci-host/i440fx.c
> +++ b/hw/pci-host/i440fx.c
> @@ -65,6 +65,14 @@ typedef struct I440FXState {
>   */
>  #define I440FX_COREBOOT_RAM_SIZE 0x57
>  
> +/* Older I440FX machines (5.0 and older) not support i440FX-pcihost state
> + * migration, use some reserved INTEL 82441 configuration registers to
> + * save/restore i440FX-pcihost config register. Refer to [INTEL 440FX PCISET
> + * 82441FX PCI AND MEMORY CONTROLLER (PMC) AND 82442FX DATA BUS ACCELERATOR
> + * (DBX) Table 1. PMC Configuration Space]
> + */
> +#define I440FX_PCI_HOST_CONFIG_REG 0x94
> +
>  static void i440fx_update_memory_mappings(PCII440FXState *d)
>  {
>      int i;
> @@ -99,8 +107,30 @@ static void i440fx_write_config(PCIDevice *dev,
>  static int i440fx_post_load(void *opaque, int version_id)
>  {
>      PCII440FXState *d = opaque;
> +    uint8_t *config;
> +    I440FXState *s = OBJECT_CHECK(I440FXState,
> +                                  object_resolve_path("/machine/i440fx", NULL),
> +                                  TYPE_PCI_HOST_BRIDGE);
>  
>      i440fx_update_memory_mappings(d);
> +
> +    if (!s->migration_enabled) {
> +        config = &d->parent_obj.config[I440FX_PCI_HOST_CONFIG_REG];
> +        s->parent_obj.config_reg = pci_get_long(config);
> +    }
> +    return 0;
> +}
> +
> +static int i440fx_pre_save(void *opaque)
> +{
> +    PCIDevice *d = opaque;
> +    I440FXState *s = OBJECT_CHECK(I440FXState,
> +                                  object_resolve_path("/machine/i440fx", NULL),
> +                                  TYPE_PCI_HOST_BRIDGE);
> +    if (!s->migration_enabled) {
> +        pci_set_long(&d->config[I440FX_PCI_HOST_CONFIG_REG],
> +                     s->parent_obj.config_reg);
> +    }
>      return 0;
>  }
>  
> @@ -108,6 +138,7 @@ static const VMStateDescription vmstate_i440fx = {
>      .name = "I440FX",
>      .version_id = 3,
>      .minimum_version_id = 3,
> +    .pre_save = i440fx_pre_save,
>      .post_load = i440fx_post_load,
>      .fields = (VMStateField[]) {
>          VMSTATE_PCI_DEVICE(parent_obj, PCII440FXState),
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index bb41665da4..67e08dedc5 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -43,6 +43,15 @@
>  
>  #define Q35_PCI_HOST_HOLE64_SIZE_DEFAULT (1ULL << 35)
>  
> +/* Older Q35 machines (5.0 and older) not support q35-pcihost state
> + * migration, use some reserved INTEL MCH configuration registers to
> + * save/restore q35-pcihost config register. Refer to [Intel 3 Series
> + * Chipset Family Datasheet Table 5-1. DRAM Controller Register Address
> + * Map (D0:F0)]
> + */
> +#define Q35_PCI_HOST_CONFIG_REG 0x70
> +
> +
>  static void q35_host_realize(DeviceState *dev, Error **errp)
>  {
>      PCIHostState *pci = PCI_HOST_BRIDGE(dev);
> @@ -532,7 +541,34 @@ static void mch_update(MCHPCIState *mch)
>  static int mch_post_load(void *opaque, int version_id)
>  {
>      MCHPCIState *mch = opaque;
> +    uint8_t *config;
> +    Q35PCIHost *s = OBJECT_CHECK(Q35PCIHost,
> +                                 object_resolve_path("/machine/q35", NULL),
> +                                 TYPE_PCI_HOST_BRIDGE);
> +    PCIHostState *pci = PCI_HOST_BRIDGE(s);
> +
>      mch_update(mch);
> +    if (!s->migration_enabled) {
> +        config = &mch->parent_obj.config[Q35_PCI_HOST_CONFIG_REG];
> +        pci->config_reg = pci_get_long(config);
> +    }
> +
> +    return 0;
> +}
> +
> +static int mch_pre_save(void *opaque)
> +{
> +    MCHPCIState *mch = opaque;
> +    uint8_t *config;
> +    Q35PCIHost *s = OBJECT_CHECK(Q35PCIHost,
> +                                 object_resolve_path("/machine/q35", NULL),
> +                                 TYPE_PCI_HOST_BRIDGE);
> +    PCIHostState *pci = PCI_HOST_BRIDGE(s);
> +
> +    if (!s->migration_enabled) {
> +        config = &mch->parent_obj.config[Q35_PCI_HOST_CONFIG_REG];
> +        pci_set_long(config, pci->config_reg);
> +    }
>      return 0;
>  }
>  
> @@ -540,6 +576,7 @@ static const VMStateDescription vmstate_mch = {
>      .name = "mch",
>      .version_id = 1,
>      .minimum_version_id = 1,
> +    .pre_save = mch_pre_save,
>      .post_load = mch_post_load,
>      .fields = (VMStateField[]) {
>          VMSTATE_PCI_DEVICE(parent_obj, MCHPCIState),
> -- 
> 2.27.0
> 


