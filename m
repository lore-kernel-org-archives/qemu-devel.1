Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBDDC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A782E2065F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsVIk/se"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A782E2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDm7h-0004VU-PB
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kDm79-0003zg-Op
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:05:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36476
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kDm77-0005Dr-6g
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599127503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q6s9v7z4xanodk0T6B2R5YoPnA+04R7W00qVhjRi4cs=;
 b=QsVIk/serH9nL2oMtJHMCZIsou/f5srIMbXWF4RD47kRe7dAKZe9/j9fJ0iZYqaa2xDbLq
 ILrpMBlK+m4aJHBTNQDmVARIjlaHX+ec0qiXM0rPfSmrFeQmeB5puQDnl+FOwxmVP6A97a
 vjUZ4SjvUNQuQLgt825wCFLH2TsmEMQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-LYQ1ZZDmM0CUm0La29KKKw-1; Thu, 03 Sep 2020 06:05:01 -0400
X-MC-Unique: LYQ1ZZDmM0CUm0La29KKKw-1
Received: by mail-wr1-f69.google.com with SMTP id m7so873640wrb.20
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 03:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Q6s9v7z4xanodk0T6B2R5YoPnA+04R7W00qVhjRi4cs=;
 b=iyxS7vBjxqeCTOBtJopU5pbima9k6kVziDtsR+zSOT213OHSpJ7EZphXRpCiRUrKfe
 n4iQOtljh2TV50Sec9tuDAY0qBrIV0TAuudEBnTmv3x9fzaYa4zeJWhiGzI7VF4YGQ9Y
 jys5tgkcfVN7TI5K4prwckeJKs5vCiTzOK6kcH9MR3OqYoqt73nxdAfebMuApI0JepqG
 ix2ARzRkklbn5xdRpBcXJ4cqdppuzDQRcp0jjb6SvluYAEEH8ya2sOtLDD6LPFQ6tbCE
 IK0is3AMb5JYJTbw6YFrlW+XS12Njx5KpWCpAUwYZFB1t/ocaT+W5DFnRFsIsa91TvLD
 A+AA==
X-Gm-Message-State: AOAM531XRnbwgMccagWoD7vwOwOSolrGiHwFLTkzOEoQvc+TZZ20SHqT
 +ty0sz4/Jeipgem6P72uovH6OjNslPkkYzoEu+lWa0CxVY9a33O9NMOK/27mazZKm8i1V5pelPI
 0tNCO0AxySWZUJ2w=
X-Received: by 2002:adf:db8b:: with SMTP id u11mr1660838wri.143.1599127497508; 
 Thu, 03 Sep 2020 03:04:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHbQk5bm9cWHh0A2AkhBcy6+Q3rUj4SNd7XIeRbo4uuhpZ6qd1kvfKpJNmnl0KwhWGliap3Q==
X-Received: by 2002:adf:db8b:: with SMTP id u11mr1660824wri.143.1599127497283; 
 Thu, 03 Sep 2020 03:04:57 -0700 (PDT)
Received: from redhat.com (bzq-79-177-107-202.red.bezeqint.net.
 [79.177.107.202])
 by smtp.gmail.com with ESMTPSA id i1sm3843397wrc.49.2020.09.03.03.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 03:04:56 -0700 (PDT)
Date: Thu, 3 Sep 2020 06:04:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH] Fix a gap where acpi_pcihp_find_hotplug_bus() returns a
 non-hotpluggable bus
Message-ID: <20200903060332-mutt-send-email-mst@kernel.org>
References: <20200829081233.10120-1-ani@anisinha.ca>
MIME-Version: 1.0
In-Reply-To: <20200829081233.10120-1-ani@anisinha.ca>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Igor Mammedov <imammedo@redhat.com>, jusual@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 29, 2020 at 01:42:33PM +0530, Ani Sinha wrote:
> When ACPI hotplug for the root bus is disabled, the bsel property for that
> bus is not set. Please see the following commit:
> 
> 3d7e78aa7777f ("Introduce a new flag for i440fx to disable PCI hotplug on the root bus").
> 
> As a result, when acpi_pcihp_find_hotplug_bus() is called
> with bsel set to 0, it may return the root bus. This would be wrong since the
> root bus is not hotpluggable. In general, this can potentially happen to other
> buses as well.
> In this patch, we fix the issue in this function by checking if the bus returned
> by the function is actually hotpluggable. If not, we simply return NULL. This
> avoids the scenario where we are actually returning a non-hotpluggable bus.
> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>

What exactly are the consequences though?


> ---
>  hw/acpi/pcihp.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 39b1f74442..f148e73c89 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -147,6 +147,21 @@ static PCIBus *acpi_pcihp_find_hotplug_bus(AcpiPciHpState *s, int bsel)
>      if (!bsel && !find.bus) {
>          find.bus = s->root;
>      }
> +
> +    /*
> +     * Check if find.bus is actually hotpluggable. If bsel is set to
> +     * NULL for example on the root bus in order to make it
> +     * non-hotpluggable, find.bus will match the root bus when bsel
> +     * is 0. See acpi_pcihp_test_hotplug_bus() above. Since the
> +     * bus is not hotpluggable however, we should not select the bus.
> +     * Instead, we should set find.bus to NULL in that case. In the check
> +     * below, we generalize this case for all buses, not just the root bus.
> +     * The callers of this function check for a null return value and
> +     * handle them appropriately.
> +     */
> +    if (!qbus_is_hotpluggable(BUS(find.bus))) {
> +        find.bus = NULL;
> +    }
>      return find.bus;
>  }
>  
> -- 
> 2.17.1


