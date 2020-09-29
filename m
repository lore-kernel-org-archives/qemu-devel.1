Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6035CC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 972D9206CA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7CwCxad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972D9206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNODR-00037N-8i
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 18:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNOCb-0002Ea-Vd; Tue, 29 Sep 2020 18:34:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNOCa-0003Qq-4C; Tue, 29 Sep 2020 18:34:29 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 542AE206CA;
 Tue, 29 Sep 2020 22:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601418864;
 bh=GexQJZvV06wcJrcMGMP7YV2JkpletSFrkifwIUnjJHg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J7CwCxadbUA1kFBFm3OkF73AP1M7aOjGb7yBuCBJvJjMpuN6G1yaBDbz94tr+KQt0
 ROBwhF3e81fyzvxQx7lq4MnYLGX903pKMg9kWd8xkpMvPOk+76Uez12hrmw3XXD+Kx
 itqGpUVsWY8/BNcBlzAWEmZ9MulwA0c7YRNmNtJA=
Date: Tue, 29 Sep 2020 15:34:20 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v3 07/18] hw/block/nvme: add support for the get log page
 command
Message-ID: <20200929223420.GB508696@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-8-its@irrelevant.dk>
 <CAFEAcA8dqNBm1YqLPjoJ=79K=6z=SxYHvcvnZiY3MJMvv1n1BQ@mail.gmail.com>
 <20200929214600.GA377237@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929214600.GA377237@apples.localdomain>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 18:34:24
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -77
X-Spam_score: -7.8
X-Spam_bar: -------
X-Spam_report: (-7.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 11:46:00PM +0200, Klaus Jensen wrote:
> On Sep 29 14:11, Peter Maydell wrote:
> > > +static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> > > +                                 uint64_t off, NvmeRequest *req)
> > > +{
> > > +    uint32_t trans_len;
> > > +    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> > > +    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
> > > +    NvmeFwSlotInfoLog fw_log = {
> > > +        .afi = 0x1,
> > > +    };
> > > +
> > > +    strpadcpy((char *)&fw_log.frs1, sizeof(fw_log.frs1), "1.0", ' ');
> > > +
> > > +    if (off > sizeof(fw_log)) {
> > > +        return NVME_INVALID_FIELD | NVME_DNR;
> > > +    }
> > > +
> > > +    trans_len = MIN(sizeof(fw_log) - off, buf_len);
> > > +
> > > +    return nvme_dma_read_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1,
> > > +                             prp2);
> > 
> > Coverity warns about the same structure here (CID 1432411).
> > 
> > thanks
> > -- PMM
> 
> Hi Peter,
> 
> Thanks. This is somewhere in the middle of a bunch of patches I got
> merged I think, commit 94a7897c41db? I just requested Coverity access.
> 
> What happens is that nvme_dma_read_prp will call into nvme_map_prp which
> wont map anything because len is 0. This will cause the statically
> allocated QEMUSGList and QEMUIOVector in the request to be
> uninitialized. Returning from nvme_map_prp, nvme_dma_read_prp will
> notice that req->qsg.nsg is zero so it will default to the iov and move
> into qemu_iovec_{to,from}_buf(&req->iov, ...). In there we actually pass
> the NULL struct iovec, but since there is a __builtin_constant_p(bytes)
> condition at the end of it all, we never follow it.
> 
> Not "serious" I think, but definitely not good. We will of course fix
> this up.
> 
> @keith, do you agree with my analysis?

Yeah, looks safe as-is, but we're missing out on returning the spec
required 'Invalid Field'.

