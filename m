Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FC5C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131622399A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPZdJiSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131622399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLO9A-0003YJ-27
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kLNV2-0003Rw-Pp
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:25:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kLNUs-0006IV-5o
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WOj0UoCbyhYx+K0KBG0mqBosqIEqtatBdEFIdAs4yCY=;
 b=CPZdJiSODJXyHL9inbJ9cf+D7lzKeXJWfPd9U0kYwH7pXUSMJfv+J4o5EKID8iDwoxeCFh
 6Q+suKuOhp9frpsUURtMzqDHaAX9i41T938SDvoa8e9OuO+VRtBv16QrSNfL01l9+vr/LX
 5WiEYqQ0GYvreYjFmQMBv4HudFZs2gU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-PQ2GF-dROyGvItMjbA4i6g-1; Thu, 24 Sep 2020 05:24:59 -0400
X-MC-Unique: PQ2GF-dROyGvItMjbA4i6g-1
Received: by mail-wm1-f70.google.com with SMTP id a7so1011331wmc.2
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 02:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WOj0UoCbyhYx+K0KBG0mqBosqIEqtatBdEFIdAs4yCY=;
 b=qpKvnnzlJQv6v3Ebsk79s+ZOcHx6flO2cZx0poLTXza1vtZMska80ZY1UG5VMYkVcU
 e3Bav8LqhhoLMZ6fMqnYr/M5H8YlZhLPQJbaXaBMm/yKm+Z4NnuXSgMKDFgtPGdIGyRJ
 MVEsPEGgAzHVYCFOwCQvm/KNA0trlI+KvFM+k8k8JrYVNFnPyMv7nFwW9fh0bOMxDRJ/
 CeV5za6Nx8Irf8n8PjLV608u1+m3fnXM6ltAn2eArVine5Gd4kgV/bvLwIVp4BArfjAR
 hEruyhJ+6ugPHd2B6Mbfgd8LkObf5gojpTO/CaaeyOt17bQLWIgdL7TCIHUv0AJ3YjYw
 xtvA==
X-Gm-Message-State: AOAM531YE38b8YAMBnpt+P0ca8T+HwQEJW8J34LwaKXy9nRcU39cBeOs
 Qth+N/WYZ2fEZE4TDIrZwGFsp9PrxRqDEV3qpSI9T8yLK6AJGlg7s2rT+tGkI5h1zqR7M+9YfHL
 EqawO5p0C6b52xIE=
X-Received: by 2002:a7b:c359:: with SMTP id l25mr3586019wmj.125.1600939498247; 
 Thu, 24 Sep 2020 02:24:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvn5veaSLw8HLXeovR9GN1g/+kpEDCZsU6VXY8NuXNKZ2fiY2PxMjogmq175AySoHH/WFIFw==
X-Received: by 2002:a7b:c359:: with SMTP id l25mr3585984wmj.125.1600939498044; 
 Thu, 24 Sep 2020 02:24:58 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id t202sm2899634wmt.14.2020.09.24.02.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 02:24:57 -0700 (PDT)
Date: Thu, 24 Sep 2020 05:24:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4] introduce vfio-user protocol specification
Message-ID: <20200924052051-mutt-send-email-mst@kernel.org>
References: <1594984851-59327-1-git-send-email-thanos.makatos@nutanix.com>
 <1600180157-74760-1-git-send-email-thanos.makatos@nutanix.com>
 <20200924082132.GJ62770@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200924082132.GJ62770@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: benjamin.walker@intel.com, elena.ufimtseva@oracle.com,
 tomassetti.andrea@gmail.com, John G Johnson <john.g.johnson@oracle.com>,
 jag.raman@oracle.com, james.r.harris@intel.com, swapnil.ingle@nutanix.com,
 konrad.wilk@oracle.com, yuvalkashtan@gmail.com, felipe@nutanix.com,
 qemu-devel@nongnu.org, raphael.norwitz@nutanix.com, ismael@linux.com,
 alex.williamson@redhat.com, Kanth.Ghatraju@oracle.com,
 marcandre.lureau@redhat.com, xiuchun.lu@intel.com,
 Thanos Makatos <thanos.makatos@nutanix.com>, tina.zhang@intel.com,
 changpeng.liu@intel.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 09:21:32AM +0100, Stefan Hajnoczi wrote:
> On Tue, Sep 15, 2020 at 07:29:17AM -0700, Thanos Makatos wrote:
> > This patch introduces the vfio-user protocol specification (formerly
> > known as VFIO-over-socket), which is designed to allow devices to be
> > emulated outside QEMU, in a separate process. vfio-user reuses the
> > existing VFIO defines, structs and concepts.
> > 
> > It has been earlier discussed as an RFC in:
> > "RFC: use VFIO over a UNIX domain socket to implement device offloading"
> > 
> > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
> 
> The approach looks promising. It's hard to know what changes will be
> required when this is implemented, so let's not worry about getting
> every detail of the spec right.
> 
> Now that there is a spec to start from, the next step is patches
> implementing --device vfio-user-pci,chardev=<chardev> in
> hw/vfio-user/pci.c (mirroring hw/vfio/).
> 
> It should be accompanied by a test in tests/. PCI-level testing APIS for
> BARs, configuration space, interrupts, etc are available in
> tests/qtest/libqos/pci.h. The test case needs to include a vfio-user
> device backend interact with QEMU's vfio-user-pci implementation.
> 
> I think this spec can be merged in docs/devel/ now and marked as
> "subject to change (not a stable public interface)".
> 
> After the details have been proven and any necessary changes have been
> made the spec can be promoted to docs/interop/ as a stable public
> interface. This gives the freedom to make changes discovered when
> figuring out issues like disconnect/reconnect, live migration, etc that
> can be hard to get right without a working implementation.
> 
> Does this approach sound good?
> 
> Also please let us know who is working on what so additional people can
> get involved in areas that need work!
> 
> Stefan

Problem we discovered with e.g. vhost is once you ship a management
interface, people start using it immediately and it does not matter
that you never promised stability.

So I feel a good first step would be to limit this to only allow known
in-tree devices, started/destroyed automatically by qemu when device is
created.  This way lots of reconnect etc issues go away, and we don't
commit to a stable protocol until we have a decent handle on how things
will work in production.

-- 
MST


