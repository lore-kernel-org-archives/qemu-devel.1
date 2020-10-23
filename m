Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51B0C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 19:04:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B2520BED
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 19:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BY1wvt2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B2520BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW2M3-0004wu-55
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 15:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kW2KY-00038p-Ma
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 15:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kW2KW-0004oG-Iu
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 15:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603479743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gr67vGkiFvdQR6+TXfIGus8sjL+UGkYN4gfj3tusYgc=;
 b=BY1wvt2PuVe6ltsvKbJ4DGLD9r9CvbcMy8JF+YJcXOFJ9jCP7j/pAMC9cPL7iYEbG8y44q
 Xqu8NhTuH52VGlm1D1Cyvc0NYXEOglC6fW6TwhP68Mx8jgkE/2JLzDZUZA/P2c8PAcX7Np
 REgQmoB1GTl40EBNF0cfWNJv1kW1Cis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-HWxkxwoDOMO1jEHjrn_Sng-1; Fri, 23 Oct 2020 15:02:20 -0400
X-MC-Unique: HWxkxwoDOMO1jEHjrn_Sng-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 026851074668;
 Fri, 23 Oct 2020 19:02:19 +0000 (UTC)
Received: from work-vm (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0190F50B44;
 Fri, 23 Oct 2020 19:02:16 +0000 (UTC)
Date: Fri, 23 Oct 2020 20:02:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zheng Chuan <zhengchuan@huawei.com>
Subject: Re: [PATCH v3 00/18] Support Multifd for RDMA migration
Message-ID: <20201023190214.GR3038@work-vm>
References: <1602908748-43335-1-git-send-email-zhengchuan@huawei.com>
 <2ea09ca2cc8c494390b506877f6e5e2c@huawei.com>
 <d9a87b5a-f524-fd79-6e11-f95430a4c29f@huawei.com>
MIME-Version: 1.0
In-Reply-To: <d9a87b5a-f524-fd79-6e11-f95430a4c29f@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
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
Cc: yubihong <yubihong@huawei.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Xiexiangyou <xiexiangyou@huawei.com>,
 "Chenzhendong \(alex\)" <alex.chen@huawei.com>,
 "wanghao \(O\)" <wanghao232@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Zheng Chuan (zhengchuan@huawei.com) wrote:
> 
> 
> On 2020/10/21 17:25, Zhanghailiang wrote:
> > Hi zhengchuan,
> > 
> >> -----Original Message-----
> >> From: zhengchuan
> >> Sent: Saturday, October 17, 2020 12:26 PM
> >> To: quintela@redhat.com; dgilbert@redhat.com
> >> Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>; Chenzhendong (alex)
> >> <alex.chen@huawei.com>; Xiexiangyou <xiexiangyou@huawei.com>; wanghao
> >> (O) <wanghao232@huawei.com>; yubihong <yubihong@huawei.com>;
> >> fengzhimin1@huawei.com; qemu-devel@nongnu.org
> >> Subject: [PATCH v3 00/18] Support Multifd for RDMA migration
> >>
> >> Now I continue to support multifd for RDMA migration based on my colleague
> >> zhiming's work:)
> >>
> >> The previous RFC patches is listed below:
> >> v1:
> >> https://www.mail-archive.com/qemu-devel@nongnu.org/msg669455.html
> >> v2:
> >> https://www.mail-archive.com/qemu-devel@nongnu.org/msg679188.html
> >>
> >> As descried in previous RFC, the RDMA bandwidth is not fully utilized for over
> >> 25Gigabit NIC because of single channel for RDMA migration.
> >> This patch series is going to support multifd for RDMA migration based on multifd
> >> framework.
> >>
> >> Comparsion is between origion and multifd RDMA migration is re-tested for v3.
> >> The VM specifications for migration are as follows:
> >> - VM use 4k page;
> >> - the number of VCPU is 4;
> >> - the total memory is 16Gigabit;
> >> - use 'mempress' tool to pressurize VM(mempress 8000 500);
> >> - use 25Gigabit network card to migrate;
> >>
> >> For origin RDMA and MultiRDMA migration, the total migration times of VM are
> >> as follows:
> >> +++++++++++++++++++++++++++++++++++++++++++++++++
> >> |             | NOT rdma-pin-all | rdma-pin-all |
> >> +++++++++++++++++++++++++++++++++++++++++++++++++
> >> | origin RDMA |       26 s       |     29 s     |
> >> -------------------------------------------------
> >> |  MultiRDMA  |       16 s       |     17 s     |
> >> +++++++++++++++++++++++++++++++++++++++++++++++++
> >>
> >> Test the multifd RDMA migration like this:
> >> virsh migrate --live --multiFd --migrateuri
> > 
> > There is no option '--multiFd' for virsh commands, It seems that, we added this private option for internal usage.
> > It's better to provide testing method by using qemu commands.
> > 
> > 
> Hi, Hailiang
> Yes, it should be, will update in V4.
> 
> Also, Ping.
> 
> Dave, Juan.
> 
> Any suggestion and comment about this series? Hope this feature could catch up with qemu 5.2.

It's a bit close; I'm not sure if I'll have time to review it on Monday
before the pull.

Dave

> > Thanks.
> > 
> >> rdma://192.168.1.100 [VM] --listen-address 0.0.0.0
> >> qemu+tcp://192.168.1.100/system --verbose
> >>
> >> v2 -> v3:
> >>     create multifd ops for both tcp and rdma
> >>     do not export rdma to avoid multifd code in mess
> >>     fix build issue for non-rdma
> >>     fix some codestyle and buggy code
> >>
> >> Chuan Zheng (18):
> >>   migration/rdma: add the 'migrate_use_rdma_pin_all' function
> >>   migration/rdma: judge whether or not the RDMA is used for migration
> >>   migration/rdma: create multifd_setup_ops for Tx/Rx thread
> >>   migration/rdma: add multifd_setup_ops for rdma
> >>   migration/rdma: do not need sync main for rdma
> >>   migration/rdma: export MultiFDSendParams/MultiFDRecvParams
> >>   migration/rdma: add rdma field into multifd send/recv param
> >>   migration/rdma: export getQIOChannel to get QIOchannel in rdma
> >>   migration/rdma: add multifd_rdma_load_setup() to setup multifd rdma
> >>   migration/rdma: Create the multifd recv channels for RDMA
> >>   migration/rdma: record host_port for multifd RDMA
> >>   migration/rdma: Create the multifd send channels for RDMA
> >>   migration/rdma: Add the function for dynamic page registration
> >>   migration/rdma: register memory for multifd RDMA channels
> >>   migration/rdma: only register the memory for multifd channels
> >>   migration/rdma: add rdma_channel into Migrationstate field
> >>   migration/rdma: send data for both rdma-pin-all and NOT rdma-pin-all
> >>     mode
> >>   migration/rdma: RDMA cleanup for multifd migration
> >>
> >>  migration/migration.c |  24 +++
> >>  migration/migration.h |  11 ++
> >>  migration/multifd.c   |  97 +++++++++-
> >>  migration/multifd.h   |  24 +++
> >>  migration/qemu-file.c |   5 +
> >>  migration/qemu-file.h |   1 +
> >>  migration/rdma.c      | 503
> >> +++++++++++++++++++++++++++++++++++++++++++++++++-
> >>  7 files changed, 653 insertions(+), 12 deletions(-)
> >>
> >> --
> >> 1.8.3.1
> > 
> > .
> > 
> 
> -- 
> Regards.
> Chuan
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


