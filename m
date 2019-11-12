Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC9FC17441
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08ED721783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zbDlHa9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08ED721783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUT8B-0001JR-1C
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 05:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iUT6j-00080W-Nz
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:09:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iUT6i-0004Bg-DA
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:09:09 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38032)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iUT6i-0004B1-5x
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:09:08 -0500
Received: by mail-oi1-x241.google.com with SMTP id a14so14274600oid.5
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 02:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8u5pTIs0r/k8pZ7f9o1J4M5+IYU7smDcKaiFDDthIko=;
 b=zbDlHa9QUOnuRZGvVS1pGDa8BwqtroBZ2ji+Dn3tOEWDU1Dwf5az05c1zIiEHS//RX
 DVRsuQH63oNBfIRj28iiUW2+H8dAik+1eXzXHheSwyu/M9XjHOQ6ltCHeZOdC8m7yGF7
 CYrO7Azr+RlNJrvd3duhINg9jRRYFOKXn5jS1NnP8u+Zpu8O1ZbcgaV1/PZPyn8wSDKu
 AvjZQG52DPnBMDlcPt9xB50qoyeWziolBu90aJ94inHENZImqfWomcgnfowzsTgggiJM
 kBweU9Norca6SM2vr4269pc8+7Zs6xXpr21u9XQz7weKyom0doQgeP2tyVNKitCbKPMs
 FQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8u5pTIs0r/k8pZ7f9o1J4M5+IYU7smDcKaiFDDthIko=;
 b=ZZWlrvIvs8JgmdPDY3RIlsZ+KB1vqE2ngf+w9fdbercOq3/iF/YGOFDHpu0qY5O+B9
 CssRAm14xApN4znDRxu3z8IO+dHiuao4a6cqg7aznR/NVej5CUFP11lISM8Ko7Wt0oIX
 DR/QNqdxV4GWrhYzaVo6IvZTkgyisaavC1K1ASYK+qvE7abC9nG+DZHETUdxXT98WmgB
 rSCFnqm3Pgta/ff6J6m9HNcypddCQ2zBRVpzEiCPkx2gr6QNGeuR01Md5EwWk9KhFFlT
 2CaMyJ6Iokhyq5dUX/Jf/6W/KALMXJizf5DV6t7ENR/u3KBL7kZSlYsI8PsHGIYh5QbH
 KowA==
X-Gm-Message-State: APjAAAXMKeNq7T5KgdVrS5n0a10nKWPL189Q4feN4tu0gOjw8ONZu023
 AfvwhzwYkpRxaIJ9Y3MjC+kqKhBkn2YwJIlUVx4UeA==
X-Google-Smtp-Source: APXvYqzDzShA7xbwCbgo6Cl4x6AqhIsiuqDmgDVVUc08E/HN5IATU/kJ8lNagX1wUrdqG8a3oyJKe4a3qbiWxrvJ99E=
X-Received: by 2002:aca:451:: with SMTP id 78mr3368828oie.170.1573553346913;
 Tue, 12 Nov 2019 02:09:06 -0800 (PST)
MIME-Version: 1.0
References: <20191029225932.14585-1-mst@redhat.com>
 <20191029225932.14585-11-mst@redhat.com>
In-Reply-To: <20191029225932.14585-11-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Nov 2019 10:08:55 +0000
Message-ID: <CAFEAcA_LObSGtSBCd==L-qp4OyH8LgrpAPdBwzOkifk-kx8JSA@mail.gmail.com>
Subject: Re: [PULL 10/14] net/virtio: add failover support
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Jason Wang <jasowang@redhat.com>, Jens Freimann <jfreimann@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 29 Oct 2019 at 23:01, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Jens Freimann <jfreimann@redhat.com>
>
> This patch adds support to handle failover device pairs of a virtio-net
> device and a (vfio-)pci device, where the virtio-net acts as the standby
> device and the (vfio-)pci device as the primary.

Hi; Coverity reports some dereference-before-NULL-check errors
in this commit:




> +static bool failover_replug_primary(VirtIONet *n, Error **errp)
> +{
> +    HotplugHandler *hotplug_ctrl;
> +    PCIDevice *pdev = PCI_DEVICE(n->primary_dev);
> +
> +    if (!pdev->partially_hotplugged) {
> +        return true;
> +    }
> +    if (!n->primary_device_opts) {
> +        n->primary_device_opts = qemu_opts_from_qdict(
> +                qemu_find_opts("device"),
> +                n->primary_device_dict, errp);
> +    }
> +    if (n->primary_device_opts) {
> +        if (n->primary_dev) {

Here we check whether n->primary_dev is NULL...

> +            n->primary_bus = n->primary_dev->parent_bus;
> +        }
> +        qdev_set_parent_bus(n->primary_dev, n->primary_bus);

...but qdev_set_parent_bus unconditionally dereferences
its first argument, so it can't be NULL...

> +        n->primary_should_be_hidden = false;
> +        qemu_opt_set_bool(n->primary_device_opts,
> +                "partially_hotplugged", true, errp);
> +        hotplug_ctrl = qdev_get_hotplug_handler(n->primary_dev);
> +        if (hotplug_ctrl) {
> +            hotplug_handler_pre_plug(hotplug_ctrl, n->primary_dev, errp);
> +            hotplug_handler_plug(hotplug_ctrl, n->primary_dev, errp);
> +        }
> +        if (!n->primary_dev) {

...and we do another NULL check here.

Either we don't need the NULL checks, or we need to avoid
calling qdev_set_parent_bus(NULL, ...).

(This is CID 1407224.)

> +            error_setg(errp, "virtio_net: couldn't find primary device");
> +        }
> +    }
> +    return *errp != NULL;
> +}


> +static int virtio_net_primary_should_be_hidden(DeviceListener *listener,
> +            QemuOpts *device_opts)
> +{
> +    VirtIONet *n = container_of(listener, VirtIONet, primary_listener);
> +    bool match_found;
> +    bool hide;
> +
> +    n->primary_device_dict = qemu_opts_to_qdict(device_opts,
> +            n->primary_device_dict);

Here we pass device_optns to qemu_opts_to_qdict(), which must
take a non-NULL pointer (it always dereferences it)...

> +    if (n->primary_device_dict) {
> +        g_free(n->standby_id);
> +        n->standby_id = g_strdup(qdict_get_try_str(n->primary_device_dict,
> +                    "failover_pair_id"));
> +    }
> +    if (device_opts && g_strcmp0(n->standby_id, n->netclient_name) == 0) {

...but here we check whether device_opts is NULL.

Again, either the check or the call must be wrong.

(This is CID 1407222.)

> +        match_found = true;
> +    } else {
> +        match_found = false;
> +        hide = false;
> +        g_free(n->standby_id);
> +        n->primary_device_dict = NULL;
> +        goto out;
> +    }

thanks
-- PMM

