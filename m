Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E10C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 07:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9F220936
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 07:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwePXXKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9F220936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaZpI-0002Kl-Bq
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 02:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaZoB-0001s9-KD
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 02:35:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54736)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaZo9-0000JK-El
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 02:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604561742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LWuWkKyNnK4I+AyqUU9mM5NxP9+Vo2Wnw+xi3NcQe+Q=;
 b=GwePXXKVrtnlMQSZb8SE1S0iOR0zW8pTPEftnWSCuDhnvCmxOdhnxCFZKhKd7xcefm236s
 5Id7K2l8EqFJfbHu4AjTzTdy27/ljxkAhdJZu0pzTqyte6MFaxQTdgc5IBXbyakUOypbMZ
 JOqKLhhn2rq9mEPjiC76pP3ZbVctMIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-d02XRjN3PAuRARv1lQ0_dQ-1; Thu, 05 Nov 2020 02:35:38 -0500
X-MC-Unique: d02XRjN3PAuRARv1lQ0_dQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 600B7101F7A4;
 Thu,  5 Nov 2020 07:35:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67DD75DA2A;
 Thu,  5 Nov 2020 07:35:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A515816E18; Thu,  5 Nov 2020 08:35:32 +0100 (CET)
Date: Thu, 5 Nov 2020 08:35:32 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Jiahui Cen <cenjiahui@huawei.com>
Subject: Re: [PATCH v9 0/8] pci_expander_brdige:acpi: Support pxb-pcie for ARM
Message-ID: <20201105073532.xiw77vug52v5gnwm@sirius.home.kraxel.org>
References: <20201103120157.2286-1-cenjiahui@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20201103120157.2286-1-cenjiahui@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: xieyingtai@huawei.com, peter.maydell@linaro.org, berrange@redhat.com,
 mst@redhat.com, qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 shannon.zhaosl@gmail.com, miaoyubo@huawei.com, imammedo@redhat.com,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

Looking at the whole series for the first time after being Cc'ed on one
of the patches.

> Currently pxb-pcie is not supported by arm,
> the reason for it is pxb-pcie is not described in DSDT table
> and only one main host bridge is described in acpi tables,
> which means it is not impossible to present different io numas
> for different devices.

I'm wondering whenever it would be easier to just have multiple
gpex devices (one per numa node)?

Also I think you don't have to use the x86-style crs handling.
Just pick address ranges for the new pci root.  Linux should
cope just fine.  When adding the pci root to the device tree
edk2 can handle this too (might require some firmware tweaks
though).

take care,
  Gerd


