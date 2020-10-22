Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24FEC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 21:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F8521D43
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 21:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5vqzAF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F8521D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVi65-0007tu-0d
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 17:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kVi4z-0006yl-9y; Thu, 22 Oct 2020 17:25:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kVi4x-00007B-I0; Thu, 22 Oct 2020 17:25:00 -0400
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E3A8524630;
 Thu, 22 Oct 2020 21:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603401897;
 bh=aAc7Iy1nZBE+6wBeQrEQvFLBIojLY/ZlizymkxEaGpE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N5vqzAF0n6DS+ojka2+yOJVGP4xHOd/D8xr4Pbzunf1m8F51MhLAXXYtgzf58mCzt
 B0cE2OfGHyGFeEzK/qeGGyX9liHj/YUvh6jOs5HeUl2isvmhdHPTcTVp10AhKq1olX
 obNoSVpWf9RJvt3PsTrTqj6GPB8cZ6zwIo1hMl3Y=
Date: Thu, 22 Oct 2020 14:24:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 2/2] hw/block/nvme: add the dataset management command
Message-ID: <20201022212454.GA1694543@dhcp-10-100-145-180.wdc.com>
References: <20201022184959.240505-1-its@irrelevant.dk>
 <20201022184959.240505-3-its@irrelevant.dk>
 <05c41ab7-039f-f327-c6a0-5864430f5ba6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05c41ab7-039f-f327-c6a0-5864430f5ba6@redhat.com>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 17:24:57
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 22, 2020 at 11:02:04PM +0200, Philippe Mathieu-Daudé wrote:
> On 10/22/20 8:49 PM, Klaus Jensen wrote:
> > +static uint16_t nvme_dsm(NvmeCtrl *n, NvmeRequest *req)
> > +{
> > +    NvmeNamespace *ns = req->ns;
> > +    NvmeDsmCmd *dsm = (NvmeDsmCmd *) &req->cmd;
> > +    NvmeDsmRange *range = NULL;
> 
> g_autofree?

Or just allocate the array on the stack. The upper limit is just 512
entries.

