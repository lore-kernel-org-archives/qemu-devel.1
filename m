Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,HK_RANDOM_REPLYTO,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3ADC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:31:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5CED20882
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CED20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBKsL-00026q-Fb
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <baiyaowei@cmss.chinamobile.com>) id 1iBKo6-0007R1-HV
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <baiyaowei@cmss.chinamobile.com>) id 1iBKo5-0003jx-Ht
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:26:50 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:3852)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <baiyaowei@cmss.chinamobile.com>)
 id 1iBKo1-0003ch-Fw; Fri, 20 Sep 2019 11:26:46 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by
 rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65d84ef91409-afe0f;
 Fri, 20 Sep 2019 23:26:10 +0800 (CST)
X-RM-TRANSID: 2ee65d84ef91409-afe0f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[112.25.65.41])
 by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25d84ef90573-53167;
 Fri, 20 Sep 2019 23:26:09 +0800 (CST)
X-RM-TRANSID: 2ee25d84ef90573-53167
Date: Fri, 20 Sep 2019 23:26:28 +0800
From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: COMPARE_AND_WRITE support for rbd driver
Message-ID: <20190920152627.GA10350@byw>
References: <20190919053623.GA19956@byw>
 <8a304065-b9ec-8245-09ae-e38724f46645@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a304065-b9ec-8245-09ae-e38724f46645@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 221.176.66.80
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
Reply-To: baiyaowei@cmss.chinamobile.com
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, yangjun@cmss.chinamobile.com,
 baiyaowei@cmss.chinamobile.com, dillaman@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 20, 2019 at 01:22:02PM +0200, Paolo Bonzini wrote:
> On 19/09/19 07:36, Yaowei Bai wrote:
> > 
> > Hey guys,
> > 
> > I noticed that COMPARE_AND_WRITE had been supported by CEPH/librbd since
> > v12.1.1. And in my company, we use this COMPARE_AND_WRITE support in
> > CEPH with the ISCSI protocol. More precisely, we use tgt and CEPH with this
> > COMPARE_AND_WRITE support as the SCSI target and export it to the remote
> > hosts. And then VMs on remote hosts can use these SCSI targets through ISCSI
> > initiator support in QEMU directly or as local SCSI disks. But unfortunately,
> > there're some issues with this tgt case. So i think maybe we could also add this
> > COMPARE_AND_WRITE support into the rbd driver in QEMU so we can leave the
> > ISCSI/tgt alone and use this COMPARE_AND_WRITE support with the
> > scsi-disk <--> virtio-scsi <--> rbd driver path. This can also apply to
> > the WRITESAME support in CEPH/librbd.
> > 
> > So is it suitable for doing this?
> 
> Yes, it would be suitable.  In a nutshell you would have to add support
> for COMPARE_AND_WRITE to block/io.c (calling into a new BlockDriver
> function pointer), block/rbd.c and hw/scsi/scsi-disk.c.

OK, i'll try to implement this and send it out for review. Thanks Paolo.

> 
> Paolo



