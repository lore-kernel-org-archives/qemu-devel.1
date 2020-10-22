Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C4CC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 17:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52693208B3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 17:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6WD3Y5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52693208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVelT-0004AS-Gt
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 13:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kVejO-0002yn-44; Thu, 22 Oct 2020 13:50:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kVejM-0007XT-7Y; Thu, 22 Oct 2020 13:50:29 -0400
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A5AB0205CA;
 Thu, 22 Oct 2020 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603389026;
 bh=iukqOXR1ytAdOAgWHMg7MB5cR2YLLvLB7UGOch+V8GE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Y6WD3Y5N0agLGU6lx4N2AJPEzQk/ccM0etbEtLHJ9MhQmaTHf4C3pmZ+rpoW1EiXw
 r/AF04VXR0gAsEB0zSxd4JAcGljWPY2u5bY0m7HwDvGfGQj8DbJjv0yN6VMkbPCygA
 tqMYcpykul1I96ZuHnQ7BAVhXeQ74VclcXoGJ08A=
Date: Thu, 22 Oct 2020 10:50:23 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v4 2/2] hw/block/nvme: add the dataset management command
Message-ID: <20201022175023.GA1694294@dhcp-10-100-145-180.wdc.com>
References: <20201022073313.143794-1-its@irrelevant.dk>
 <20201022073313.143794-3-its@irrelevant.dk>
 <20201022150103.GA1665151@dhcp-10-100-145-180.wdc.com>
 <20201022174333.GA209677@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022174333.GA209677@apples.localdomain>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 13:50:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 22, 2020 at 07:43:33PM +0200, Klaus Jensen wrote:
> On Oct 22 08:01, Keith Busch wrote:
> > On Thu, Oct 22, 2020 at 09:33:13AM +0200, Klaus Jensen wrote:
> > > +        if (--(*discards)) {
> > > +            status = NVME_NO_COMPLETE;
> > > +        } else {
> > > +            g_free(discards);
> > > +            req->opaque = NULL;
> > 
> > This case needs a
> > 
> >             status = req->status;
> > 
> > So that we get the error set in the callback.
> > 
> 
> There are no cases that result in a non-zero status code here.

Your callback has a case that sets NVME_INTERNAL_DEV_ERROR status. That
would get ignored if the final discard reference is dropped from the
submission side.

+static void nvme_aio_discard_cb(void *opaque, int ret)
+{
+    NvmeRequest *req = opaque;
+    int *discards = req->opaque;
+
+    trace_pci_nvme_aio_discard_cb(nvme_cid(req));
+
+    if (ret) {
+        req->status = NVME_INTERNAL_DEV_ERROR;
+        trace_pci_nvme_err_aio(nvme_cid(req), strerror(ret),
+                               req->status);
+    }

