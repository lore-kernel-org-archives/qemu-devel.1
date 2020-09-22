Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A554DC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 15:32:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C57214F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 15:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hr7GieKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C57214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKkHF-0007tR-6N
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 11:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kKkFJ-0006ub-HS; Tue, 22 Sep 2020 11:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kKkFH-0007wx-Ig; Tue, 22 Sep 2020 11:30:21 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AAC33214F1;
 Tue, 22 Sep 2020 15:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600788616;
 bh=QdfLePK1MB+TVPpwl2MnvvFSW7R+YnjyE76I+qt7rVQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Hr7GieKINTkjGuY8vBPLyzHvY9YO9gPrgd7oMcY/fZXrkZFc++rwi3l5eNkBsa4VZ
 CeziXSrk5GJFG0u6J//jHYXy/ibzKESZJ9bkpABUg3AzfDUwdz/KFP+/8lmvX+MCmA
 JnKsSrOx/vP9pKZ1iHUq4T06HXItRDATAGlqMGRo=
Date: Tue, 22 Sep 2020 08:30:13 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v6 2/2] nvme: allow cmb and pmr to be enabled on same
 device
Message-ID: <20200922153013.GB4035426@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200729220107.37758-1-andrzej.jakowski@linux.intel.com>
 <20200729220107.37758-3-andrzej.jakowski@linux.intel.com>
 <20200729225019.GA346228@apples.localdomain>
 <20200817062911.GA7412@apples.localdomain>
 <20200922090425.GA1236186@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922090425.GA1236186@apples.localdomain>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 11:30:16
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -85
X-Spam_score: -8.6
X-Spam_bar: --------
X-Spam_report: (-8.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: kwolf@redhat.com, Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 11:04:25AM +0200, Klaus Jensen wrote:
> On Aug 17 08:29, Klaus Jensen wrote:
> > On Jul 30 00:50, Klaus Jensen wrote:
> > > On Jul 29 15:01, Andrzej Jakowski wrote:
> > > > So far it was not possible to have CMB and PMR emulated on the same
> > > > device, because BAR2 was used exclusively either of PMR or CMB. This
> > > > patch places CMB at BAR4 offset so it not conflicts with MSI-X vectors.
> > > > 
> > > > Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
> > > > ---
> > > 
> > > Well, I'm certainly happy now. LGTM!
> > > 
> > > Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> > > 
> > 
> > Are anyone willing to chip in with another review on this?
> > 
> 
> I think this patch is ready (and have been for some time) for inclusion,
> but would really like an additional review on this; preferably from
> Keith, since he is the one that originally mentioned that we could do
> something like this.

Yes, this does look good to me too.

Reviewed-by: Keith Busch <kbusch@kernel.org>

