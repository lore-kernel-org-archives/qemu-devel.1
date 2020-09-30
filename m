Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5C2C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2183A20709
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="cHN6E77c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2183A20709
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNaWN-0005QU-7Q
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 07:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kNaVT-0004z1-Fc
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 07:42:47 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:54379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kNaVQ-0004l9-OJ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 07:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1601466164;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mdXgkOu3ylqnn1zoExFL9VmyUXl2+ZCZhLSNKounvE0=;
 b=cHN6E77c6MSS9Ud3GVBfMz97xMNIun9EtQcjxnWSMvDDgm0RMC4Gzjvn
 k9LtFe+PRbmVuzrmqtEdRuyve+EjQe58CsW8UKNOTF/mAaFCl3akfhEmw
 blt3t/DcN00eGpIHp1RklpN0Pb5XotEKlVJioJuhSDx+2FAaEVQsuNHDx M=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: KZcH2yqEPGmYgpzCTQcnwziklCfV47GiZR8knMGcUdCcnTps/6KmpdcJ622fhTxdV82dJAis3J
 2h8YJqGkF6XeXtdjDeoAvXkVaMoD3BZua/wq0b4bOLKp0EqmXGR1E/Re5SmzzdbDVRO00olDxp
 n2puov22Mo+pb15T1y6U8wsCF0LJOB2Lr4rCT75MECzfp8em1LGtzr7cjm045GJ2e0V1LL+4or
 Oe82Ph0iCoysiNr0mwQwAzK2MvXEHjgVLnsjdS9mCw+L47c/mG3ctCZ8Pw0mSG3vKNXlnL3Njq
 u5k=
X-SBRS: None
X-MesageID: 28964510
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,322,1596513600"; d="scan'208";a="28964510"
Date: Wed, 30 Sep 2020 12:42:35 +0100
To: Paul Durrant <paul@xen.org>
CC: <xen-devel@lists.xenproject.org>, <qemu-devel@nongnu.org>, Paul Durrant
 <pdurrant@amazon.com>, Jerome Leseinne <jerome.leseinne@gmail.com>, "Edwin
 Torok" <edvin.torok@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH] xen-bus: reduce scope of backend watch
Message-ID: <20200930114235.GL2024@perard.uk.xensource.com>
References: <20200923155731.29528-1-paul@xen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200923155731.29528-1-paul@xen.org>
Received-SPF: pass client-ip=216.71.155.144;
 envelope-from=anthony.perard@citrix.com; helo=esa4.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 07:42:41
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Anthony PERARD <anthony.perard@citrix.com>
From: Anthony PERARD via <qemu-devel@nongnu.org>

On Wed, Sep 23, 2020 at 04:57:31PM +0100, Paul Durrant wrote:
> From: Paul Durrant <pdurrant@amazon.com>
> 
> Currently a single watch on /local/domain/X/backend is registered by each
> QEMU process running in service domain X (where X is usually 0). The purpose
> of this watch is to ensure that QEMU is notified when the Xen toolstack
> creates a new device backend area.
> Such a backend area is specific to a single frontend area created for a
> specific guest domain and, since each QEMU process is also created to service
> a specfic guest domain, it is unnecessary and inefficient to notify all QEMU
> processes.
> Only the QEMU process associated with the same guest domain need
> receive the notification. This patch re-factors the watch registration code
> such that notifications are targetted appropriately.
> 
> Reported-by: Jerome Leseinne <jerome.leseinne@gmail.com>
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> 
> diff --git a/hw/xen/xen-backend.c b/hw/xen/xen-backend.c
> index 10199fb58d..f2711fe4a7 100644
> --- a/hw/xen/xen-backend.c
> +++ b/hw/xen/xen-backend.c
> @@ -41,6 +41,11 @@ static void xen_backend_table_add(XenBackendImpl *impl)
>      g_hash_table_insert(xen_backend_table_get(), (void *)impl->type, impl);
>  }
>  
> +static void **xen_backend_table_keys(unsigned int *count)
> +{
> +    return g_hash_table_get_keys_as_array(xen_backend_table_get(), count);

That could be cast to (const gchar **) as the GLib doc suggest, or (const
char **) since gchar and char are the same.
https://developer.gnome.org/glib/stable/glib-Hash-Tables.html#g-hash-table-get-keys-as-array

> +}
> +
>  static const XenBackendImpl *xen_backend_table_lookup(const char *type)
>  {
>      return g_hash_table_lookup(xen_backend_table_get(), type);
> diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> index 9ce1c9540b..c83da93bf3 100644
> --- a/hw/xen/xen-bus.c
> +++ b/hw/xen/xen-bus.c
> @@ -430,7 +430,13 @@ static void xen_bus_unrealize(BusState *bus)
>      trace_xen_bus_unrealize();
>  
>      if (xenbus->backend_watch) {
> -        xen_bus_remove_watch(xenbus, xenbus->backend_watch, NULL);
> +        unsigned int i;
> +
> +        for (i = 0; i < xenbus->backend_types; i++) {
> +            xen_bus_remove_watch(xenbus, xenbus->backend_watch[i], NULL);

We should check if backend_watch[i] is NULL.

> +        }
> +
> +        g_free(xenbus->backend_watch);
>          xenbus->backend_watch = NULL;
>      }
>  

The rest of the patch looks fine. Next improvement is to only look at
only one backend type in xen_bus_backend_changed() since there is now a
watch per backend type :-), but that would be for another day.

Cheers,

-- 
Anthony PERARD

