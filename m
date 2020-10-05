Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AA9C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16DD12078D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Txaqv5ow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16DD12078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPNS0-0004j3-2C
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 06:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kPNR0-0003qV-Rp
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kPNQy-0004db-W3
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601892571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XjJEAwaaqqX1fpHrhlnOUque+C3pqB8R//nDBLWXB7o=;
 b=Txaqv5owoxYnikDCKDxXojHm1jrYEzgY/nvRqwTKDcTDL4ZhN3vikXPbg63G5GDX0QQLxY
 yv6aB/3aL01E6rgtcmMOefp36lw4Zl7JZpZ1Mfn84S8JFsK8Ls6sk/gLQXBU9QJKDZCL3w
 8bns0nyM+oUCeSLFIYtZr02ge0xHZkA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-yrbNTvxcMMKRKNGv23NbOg-1; Mon, 05 Oct 2020 06:09:27 -0400
X-MC-Unique: yrbNTvxcMMKRKNGv23NbOg-1
Received: by mail-wr1-f71.google.com with SMTP id v12so3808836wrm.9
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 03:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XjJEAwaaqqX1fpHrhlnOUque+C3pqB8R//nDBLWXB7o=;
 b=XGnK8qwtm7n8WMOwIumK2Fd1StRWZa3Eo9MU9vRJtpP+4eAgILx/0/X2TnsmA7xOVz
 FENVUTYop6X3oD85SIkQ1TlDYi13LWSh5bDjabmS9pdg1W1gOX0QisG2IncHHYJ3MD02
 Iog2Oejb176lCXIqwQ8Huht364SfCykZSrpE4NKDR4EkgFiN0Eh3IRQZdodj6HxzN6zv
 uDgAh11zTkGqdjFvAVNx6+sGErh/LP1gmMJuzwYfzqNZ7Y5b4AU7Kgu/CEo2mV9vWbk5
 nRUC/IzHrKyX6VIkDhFo0L2IRRYILsPqVdjugHOmk1SnhYBSBdpkOqe02oU+cDkeAl/b
 hnkw==
X-Gm-Message-State: AOAM5303XQCuLwMyNQH+Sc4JWnJXoIYw1RDtD1oeQZhF3ukvM2Ln2Si3
 DfGhPmrWy/jk9cpk2DgIPXvndQc3i/VekREEixPuUsTXR32bCPT1ao2gkFOGd2iJxZgmwuaSJ0x
 1q3FAF8BCWzKq+MY=
X-Received: by 2002:adf:fa0e:: with SMTP id m14mr6027893wrr.134.1601892566573; 
 Mon, 05 Oct 2020 03:09:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFLLlm57KETJ5jrQ8kc7iTHx/EI8dqNmKNVnpi3lqIupPYfOHMf/2uZz5vGRqGV0laSDyNzg==
X-Received: by 2002:adf:fa0e:: with SMTP id m14mr6027886wrr.134.1601892566395; 
 Mon, 05 Oct 2020 03:09:26 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id x15sm1540141wrr.36.2020.10.05.03.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 03:09:25 -0700 (PDT)
Date: Mon, 5 Oct 2020 06:09:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: andrew@daynix.com
Subject: Re: [PATCH v2 0/2] hw/virtio-pci: AER capability
Message-ID: <20201005060907-mutt-send-email-mst@kernel.org>
References: <20201005090140.90461-1-andrew@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20201005090140.90461-1-andrew@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.745,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 05, 2020 at 12:01:38PM +0300, andrew@daynix.com wrote:
> From: Andrew Melnychenko <andrew@daynix.com>
> 
> Now, AER capability for virtio-pci is disabled by default.
> AER capability is only for PCI with PCIe interface on PCIe bus.
> During migration - device "realize" should initialize AER
> if requested by device properties.

Could you add motivation to individual patches please?

> Andrew (2):
>   hw/virtio-pci Added counter for pcie capabilities offsets.
>   hw/virtio-pci Added AER capability.
> 
>  hw/virtio/virtio-pci.c | 20 +++++++++++++++++++-
>  hw/virtio/virtio-pci.h |  4 ++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> -- 
> 2.28.0


