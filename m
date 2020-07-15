Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440B6C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC9120658
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgmOrMsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC9120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvi0a-0005KQ-8v
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 10:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jvi01-0004tg-4V
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:03:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30925
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jvhzz-00072E-6r
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594821781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Emw2YgIRz2FKdOmzzPIki5N5g9IjY83QOnXLIsQ0MZA=;
 b=XgmOrMsBchYClIAu+2FCVzE9p2qZVEhU+S6t/MG7zYkd5Yl38yq4rbAKXgauU4N1gcaPJB
 cp0WHud1Wvr+H5u7kgmQ1evdj2H0iNcAkjpNFSjs7cIdFtQyHfTXKFWWx879zaaA/1Z/DJ
 zI8suyMDbpl5q9xrgnUYWPobWzreE7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-wvcu17j5PRyOyHGpFtWkBg-1; Wed, 15 Jul 2020 10:03:00 -0400
X-MC-Unique: wvcu17j5PRyOyHGpFtWkBg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 319F21005269;
 Wed, 15 Jul 2020 14:02:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F41A972E74;
 Wed, 15 Jul 2020 14:02:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D4F6A9D57; Wed, 15 Jul 2020 16:02:51 +0200 (CEST)
Date: Wed, 15 Jul 2020 16:02:51 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [RFC PATCH 3/5] hw/i386/acpi-build: Add ACPI PCI hot-plug
 methods to q35
Message-ID: <20200715140251.duv5j7uxqlqitfrn@sirius.home.kraxel.org>
References: <20200708224615.114077-1-jusual@redhat.com>
 <20200708224615.114077-4-jusual@redhat.com>
 <20200713163954.565722a5@redhat.com>
 <20200715065751.ogchtdqmnn7cxsyi@sirius.home.kraxel.org>
 <20200715151720.21789077@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200715151720.21789077@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:03
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
Cc: Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > While being at it:  Shouldn't we reserve these port ranges somehow?
> > Using an acpi device for example, simliar to fw_cfg?  The guest OS
> > should better know there is something at those ports ...
> 
> we do it at ACPI level in DSDT, look for comment
> /* reserve PCIHP resources */

Ah, good.

> It should make Windows trip over in case of another range overlap with
> reserved ports. (linux kernel is more tolerant and may silently ignore
> or print a warning) 

Hmm, linux doesn't list the device, can't see it neither in the kernel
log nor in /proc/ioports ...

take care,
  Gerd


