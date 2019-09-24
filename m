Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0BDC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:20:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70BF0214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BF0214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iClgR-000644-Rs
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iCkra-00088K-41
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iCkrZ-0001JE-1N
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57696)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iCkrY-0001J4-Q0
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:16 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1931658
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 13:28:16 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id r15so1912684qtn.12
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 06:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0siV7+IiGRtmpsjCKKKrKw8qwzwFcfU/O5o31oDtQNM=;
 b=hIttuOIJz4ulgCSYNkiD8V+uFu8Fwr12YFlbE9YmewKXDRekkfiJcZIaqqgHutGlvP
 y2k2odQejG1VJxl68IhgPS0p6Ozne+CXVtyCzprnEgqqh7zQDhXoKX5tb3hjynksvnQ9
 x5RRNb8f+tRDOLr2VitS+VZuJpNzQlLXpHjauDWqtngiHcSKatgq0WeOnMzGKNZ8qJh0
 1eSzn1UPtMpdf5Als0QxCaTq9zJlU6oFnfQ8i52LNsE/7ZH590v+h2zzw0A387WIY6Rd
 fjRWKiHwbiwwaYW68F2aPG7m8qtkIIDQK5eAdYSJUM4sNCPefarzYcBKuyWg7k6h8Z9H
 Bumg==
X-Gm-Message-State: APjAAAU7dGy8HZk+wwOE6iHjlAGv/JMaRf4PEQ+tni2z7t/0m+vvDEMb
 bib4OaO9zjNzLUK7IMHPn4//arjkqms3QMhowYGtx3p7+gs55WXiAxml8vSMmj5ns2sFTijSo70
 7Gh0jm9K+9eQUZsU=
X-Received: by 2002:a37:af81:: with SMTP id y123mr2346000qke.145.1569331695453; 
 Tue, 24 Sep 2019 06:28:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy8IETc94LHUvszYZmbbVF9ufeHqsjMgwcWGWqmPhUsAF9oomZniLkKp52I24u6LE51VHqlag==
X-Received: by 2002:a37:af81:: with SMTP id y123mr2345985qke.145.1569331695302; 
 Tue, 24 Sep 2019 06:28:15 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id z72sm956187qka.115.2019.09.24.06.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 06:28:14 -0700 (PDT)
Date: Tue, 24 Sep 2019 09:28:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v4 8/8] hw/i386: Introduce the microvm machine type
Message-ID: <20190924092435-mutt-send-email-mst@kernel.org>
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-9-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924124433.96810-9-slp@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, lersek@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 pbonzini@redhat.com, imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 24, 2019 at 02:44:33PM +0200, Sergio Lopez wrote:
> +static void microvm_fix_kernel_cmdline(MachineState *machine)
> +{
> +    X86MachineState *x86ms = X86_MACHINE(machine);
> +    BusState *bus;
> +    BusChild *kid;
> +    char *cmdline;
> +
> +    /*
> +     * Find MMIO transports with attached devices, and add them to the kernel
> +     * command line.
> +     *
> +     * Yes, this is a hack, but one that heavily improves the UX without
> +     * introducing any significant issues.
> +     */
> +    cmdline = g_strdup(machine->kernel_cmdline);
> +    bus = sysbus_get_default();
> +    QTAILQ_FOREACH(kid, &bus->children, sibling) {
> +        DeviceState *dev = kid->child;
> +        ObjectClass *class = object_get_class(OBJECT(dev));
> +
> +        if (class == object_class_by_name(TYPE_VIRTIO_MMIO)) {
> +            VirtIOMMIOProxy *mmio = VIRTIO_MMIO(OBJECT(dev));
> +            VirtioBusState *mmio_virtio_bus = &mmio->bus;
> +            BusState *mmio_bus = &mmio_virtio_bus->parent_obj;
> +
> +            if (!QTAILQ_EMPTY(&mmio_bus->children)) {
> +                gchar *mmio_cmdline = microvm_get_mmio_cmdline(mmio_bus->name);
> +                if (mmio_cmdline) {
> +                    char *newcmd = g_strjoin(NULL, cmdline, mmio_cmdline, NULL);
> +                    g_free(mmio_cmdline);
> +                    g_free(cmdline);
> +                    cmdline = newcmd;
> +                }
> +            }
> +        }
> +    }
> +
> +    fw_cfg_modify_i32(x86ms->fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(cmdline) + 1);
> +    fw_cfg_modify_string(x86ms->fw_cfg, FW_CFG_CMDLINE_DATA, cmdline);
> +}

Can we rearrange this somewhat? Maybe the mmio constructor
would format the device description and add to some list,
and then microvm would just get stuff from that list
and add it to kernel command line?
This way it can also be controlled by a virtio-mmio property, so
e.g. you can disable it per device if you like.
In particular, this seems like a handy trick for any machine type
using mmio.

-- 
MST

