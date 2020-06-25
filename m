Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EBCC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 08:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4A9207FC
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 08:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4A9207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joNQI-0004Ms-Qk
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 04:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1joNPk-0003s9-OO; Thu, 25 Jun 2020 04:39:20 -0400
Received: from charlie.dont.surf ([128.199.63.193]:38630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1joNPi-0000MD-Mx; Thu, 25 Jun 2020 04:39:20 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 8BC02BF432;
 Thu, 25 Jun 2020 08:39:14 +0000 (UTC)
Date: Thu, 25 Jun 2020 10:39:11 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PULL 00/43] Block layer patches
Message-ID: <20200625083911.pb3637si62cztza7@apples.localdomain>
References: <20200617144909.192176-1-kwolf@redhat.com>
 <CAFEAcA869qxSMaZiw2Hz-ESFbRL+Mq9Yoq=pGRBbL8oUV7Gj=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA869qxSMaZiw2Hz-ESFbRL+Mq9Yoq=pGRBbL8oUV7Gj=Q@mail.gmail.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 04:39:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 18 15:30, Peter Maydell wrote:
> On Wed, 17 Jun 2020 at 15:49, Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > The following changes since commit 5c24bce3056ff209a1ecc50ff4b7e65b85ad8e74:
> >
> >   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-and-plugin-160620-2' into staging (2020-06-16 14:57:15 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://repo.or.cz/qemu/kevin.git tags/for-upstream
> >
> > for you to fetch changes up to 3419ec713f04c323b030e0763459435335b25476:
> >
> >   iotests: Add copyright line in qcow2.py (2020-06-17 16:21:21 +0200)
> >
> > ----------------------------------------------------------------
> > Block layer patches:
> >
> > - enhance handling of size-related BlockConf properties
> > - nvme: small fixes, refactoring and cleanups
> > - virtio-blk: On restart, process queued requests in the proper context
> > - icount: make dma reads deterministic
> > - iotests: Some fixes for rarely run cases
> > - .gitignore: Ignore storage-daemon files
> > - Minor code cleanups
> >
> > ----------------------------------------------------------------
> 
> 
> Applied, thanks.
> 
> Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
> for any user-visible changes.
> 

Kevin, can you add soemthing like the following to the changelog under
"Block devices"?

Emulated NVMe device (hw/block/nvme):

  * Add the max_ioqpairs device parameter. The parameter specifies the
    maximum number of supported I/O queue pairs and should be used
    instead of the num_queues parameter. num_queues is not formally
    deprecated, but the device will issue a warning if used. If neither
    num_queues or max_ioqpairs are specified, device behavior is
    unchanged from the previous default.

  * Add the msix_qsize parameter. The parameter specifies the maximum
    number of msix interrupt vectors supported by the device. If not
    specified, device behavior is unchanged from the previous default.

