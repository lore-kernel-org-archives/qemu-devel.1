Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A9BCA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 18:10:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B06B217F9
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 18:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B06B217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQbNA-0004gi-OZ
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 14:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iQbMZ-0004Gu-E1
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 14:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iQbMX-0007Sg-Ox
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 14:09:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3534)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iQbMX-0007Rv-Ip
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 14:09:29 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 259BEA836
 for <qemu-devel@nongnu.org>; Fri,  1 Nov 2019 18:09:28 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id p6so5928353wrs.5
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 11:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=moDkDlUhxfJhmtHJeueY/UnIk6Z5ALI8m+SrJOHk+eI=;
 b=lqhoDnp1rIjwgm+EP5/hBsSfW+zlv/QBK0RBmMANtxp4Vv0YHyLeD0jUMr3QY8n1mo
 3KbY8VWLTBIU1LDRoOt1Ygln+voklXJakjXCVnEu4tRh+pWECUMVLdfaX7Mz/F5CrRe5
 ARej8+oLroi5L4H0J35oG61qZT2BTEl9IoJVj+f28p7Eq1EIoWLugqX9WVz/k0Qz30KL
 3ESWsheTBj1C6HCXMaK8eNNRGOlc3fMYw4g9gckOIbN3Czme69D71Bml/ECSdz27GgHs
 7K7jj4oSEfKLAXfi5ZwfQg26Q021Y81NyxlsyCE5hfxTGusRCzj/osHqDgM/QsGBPEv6
 xaJA==
X-Gm-Message-State: APjAAAULx60X18OnDesCN2QZB7BSnQs6ICDtlmH36XdTs0X9jAjYEiYN
 w3KnqttmFUNYu2VS7rz/Uf5NhEvHw5OMC8KdUyprOewvjDKR50zn6kYVdeRkKYkVR0YjC5xQzmx
 5dtnKX/y3IDBZJ5U=
X-Received: by 2002:adf:f905:: with SMTP id b5mr11795776wrr.122.1572631766869; 
 Fri, 01 Nov 2019 11:09:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxiDGch/xVNxtqV43qVHrL6TwudUG5rxeu9lr80qXRYAZbkhvjpjLsf7yZBWkwy1mt5fm8TPw==
X-Received: by 2002:adf:f905:: with SMTP id b5mr11795760wrr.122.1572631766712; 
 Fri, 01 Nov 2019 11:09:26 -0700 (PDT)
Received: from xz-x1.metropole.lan (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id u7sm8313190wre.59.2019.11.01.11.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 11:09:25 -0700 (PDT)
Date: Fri, 1 Nov 2019 19:09:23 +0100
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC v2 06/22] hw/pci: modify pci_setup_iommu() to set PCIIOMMUOps
Message-ID: <20191101180923.GG8888@xz-x1.metropole.lan>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-7-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1571920483-3382-7-git-send-email-yi.l.liu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, yi.y.sun@intel.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 08:34:27AM -0400, Liu Yi L wrote:
> This patch modifies pci_setup_iommu() to set PCIIOMMUOps instead of only
> setting PCIIOMMUFunc. PCIIOMMUFunc is previously used to get an address
> space for a device in vendor specific way. The PCIIOMMUOps still offers
> this functionality. Use PCIIOMMUOps leaves space to add more iommu related
> vendor specific operations.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

