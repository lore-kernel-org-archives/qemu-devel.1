Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B045C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5104920706
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4BiaJRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5104920706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPJL-00049b-4F
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1joPID-00037L-AU
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:39:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29291
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1joPIA-0003tv-F9
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593081576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kWctq30849pJVR+fH0XbgScPbbyrYYxvYxp/vNe8o4M=;
 b=c4BiaJRfn6wOWY/SjSFb5i0h6Kg0RMV1On0OogipHppNABR2Hhfo2L2litJ5q19EM8FjKS
 Hh1zBuClSedVB4OEncwxWuzpRY4UEiiuF1pYVpraN3XxPtHZ0s0bPvDJOZqcwqJTGJbyCc
 TMGQ0kSJmX3HkqcsGx3XJpsyRKmbQx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-kjw2mTJuO2OkZcVJrO_sjg-1; Thu, 25 Jun 2020 06:39:31 -0400
X-MC-Unique: kjw2mTJuO2OkZcVJrO_sjg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 496AA1800D4A;
 Thu, 25 Jun 2020 10:39:30 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-129.ams2.redhat.com [10.36.113.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 52EFE7C1EE;
 Thu, 25 Jun 2020 10:39:29 +0000 (UTC)
Date: Thu, 25 Jun 2020 12:39:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PULL 00/43] Block layer patches
Message-ID: <20200625103927.GB6878@linux.fritz.box>
References: <20200617144909.192176-1-kwolf@redhat.com>
 <CAFEAcA869qxSMaZiw2Hz-ESFbRL+Mq9Yoq=pGRBbL8oUV7Gj=Q@mail.gmail.com>
 <20200625083911.pb3637si62cztza7@apples.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200625083911.pb3637si62cztza7@apples.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Am 25.06.2020 um 10:39 hat Klaus Jensen geschrieben:
> On Jun 18 15:30, Peter Maydell wrote:
> > On Wed, 17 Jun 2020 at 15:49, Kevin Wolf <kwolf@redhat.com> wrote:
> > >
> > > The following changes since commit 5c24bce3056ff209a1ecc50ff4b7e65b85ad8e74:
> > >
> > >   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-and-plugin-160620-2' into staging (2020-06-16 14:57:15 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://repo.or.cz/qemu/kevin.git tags/for-upstream
> > >
> > > for you to fetch changes up to 3419ec713f04c323b030e0763459435335b25476:
> > >
> > >   iotests: Add copyright line in qcow2.py (2020-06-17 16:21:21 +0200)
> > >
> > > ----------------------------------------------------------------
> > > Block layer patches:
> > >
> > > - enhance handling of size-related BlockConf properties
> > > - nvme: small fixes, refactoring and cleanups
> > > - virtio-blk: On restart, process queued requests in the proper context
> > > - icount: make dma reads deterministic
> > > - iotests: Some fixes for rarely run cases
> > > - .gitignore: Ignore storage-daemon files
> > > - Minor code cleanups
> > >
> > > ----------------------------------------------------------------
> > 
> > 
> > Applied, thanks.
> > 
> > Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
> > for any user-visible changes.
> > 
> 
> Kevin, can you add soemthing like the following to the changelog under
> "Block devices"?
> 
> Emulated NVMe device (hw/block/nvme):
> 
>   * Add the max_ioqpairs device parameter. The parameter specifies the
>     maximum number of supported I/O queue pairs and should be used
>     instead of the num_queues parameter. num_queues is not formally
>     deprecated, but the device will issue a warning if used. If neither
>     num_queues or max_ioqpairs are specified, device behavior is
>     unchanged from the previous default.
> 
>   * Add the msix_qsize parameter. The parameter specifies the maximum
>     number of msix interrupt vectors supported by the device. If not
>     specified, device behavior is unchanged from the previous default.

Sure, I've added this.

If you want to have a wiki account so that you can edit the page
yourself in the future, let me (or anyone else with a wiki account) know
your preferred user name and we can create an account for you. Access is
not supposed to be a privileged thing, we just require manual
registration through an existing account to avoid spam.

Kevin


