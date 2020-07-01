Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB01C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:30:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9099206BE
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMxk0szJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9099206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqcof-0005De-0T
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 09:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jqcnu-0004d7-At
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:29:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44831
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jqcns-0001Lh-6S
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593610170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J2w/6UvpmKjsq69jkLKWPGK/5Np1k2jC8YVnm4emm6c=;
 b=dMxk0szJwACtO1mJclaPhjoWov/QYOFnMA3J055EdprG8YEvq45UZRxkZuvte4GPGPk+9q
 hg13r8G33/LpJUp67FCKX4YSxfbGvR80bC1RvEonqfFt0W0b5hc12rjlhpB5QRl237sSSf
 dlU7sBTHJSM4u1W5P54hKHctKCEk+Ag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-9Chl_9uwMMKKBw6-EC_zfA-1; Wed, 01 Jul 2020 09:29:29 -0400
X-MC-Unique: 9Chl_9uwMMKKBw6-EC_zfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 338C818A0760;
 Wed,  1 Jul 2020 13:29:27 +0000 (UTC)
Received: from starship (unknown [10.35.206.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A48B77F5F;
 Wed,  1 Jul 2020 13:29:16 +0000 (UTC)
Message-ID: <ea1f0c4323885bb8986517ba75b1e8a2f8196156.camel@redhat.com>
Subject: Re: nvme emulation merge process (was: Re: [PATCH 00/10]
 hw/block/nvme: namespace types and zoned namespaces)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, Kevin Wolf <kwolf@redhat.com>
Date: Wed, 01 Jul 2020 16:29:15 +0300
In-Reply-To: <20200701131820.l4gb2ewjmnm6ysmt@apples.localdomain>
References: <20200630100139.1483002-1-its@irrelevant.dk>
 <20200630125932.GA553472@localhost.localdomain>
 <c10b18a8-44f3-7dab-b9bb-7d017f210934@redhat.com>
 <20200630154228.GB1987534@dhcp-10-100-145-180.wdl.wdc.com>
 <20200630203630.am3a3bc5ze5m2r3k@apples.localdomain>
 <20200701103407.GA11634@linux.fritz.box>
 <20200701131820.l4gb2ewjmnm6ysmt@apples.localdomain>
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-07-01 at 15:18 +0200, Klaus Jensen wrote:
> On Jul  1 12:34, Kevin Wolf wrote:
> > Am 30.06.2020 um 22:36 hat Klaus Jensen geschrieben:
> > > On Jun 30 08:42, Keith Busch wrote:
> > > > On Tue, Jun 30, 2020 at 04:09:46PM +0200, Philippe Mathieu-DaudÃ© wrote:
> > > > > What I see doable for the following days is:
> > > > > - hw/block/nvme: Fix I/O BAR structure [3]
> > > > > - hw/block/nvme: handle transient dma errors
> > > > > - hw/block/nvme: bump to v1.3
> > > > 
> > > > These look like sensible patches to rebase future work on, IMO. The 1.3
> > > > updates had been prepared a while ago, at least.
> > > 
> > > I think Philippe's "hw/block/nvme: Fix I/O BAR structure" series is a
> > > no-brainer. It just needs to get in asap.
> > 
> > I think we need to talk about how nvme patches are supposed to get
> > merged. I'm not familiar with the hardware nor the code, so the model
> > was that I just blindly merge patches that Keith has reviewed/acked,
> > just to spare him the work to prepare a pull request. But obviously, we
> > started doing things this way when there was a lot less activity around
> > the nvme emulation.
> > 
> > If we find that this doesn't scale any more, maybe we need to change
> > something.
> 
> Honestly, I do not think the current model has worked very well for some
> time; especially for larger series where I, for one, has felt that my
> work was largely ignored due to a lack of designated reviewers. Things
> only picked up when Beata, Maxim and Philippe started reviewing my
> series - maybe out of pity or because I was bombing the list, I don't
> know ;)
> 
> We've also seen good patches from Andrzej linger on the list for quite a
> while, prompting a number of RESENDs. I only recently allocated more
> time and upped my review game, but I hope that contributors feel that
> stuff gets reviewed in a timely fashion by now.
> 
> Please understand that this is in NO WAY a criticism of Keith who
> already made it very clear to me that he did not have a lot time to
> review, but only ack the odd patch.
> 
> > Depending on how much time Keith can spend on review in the
> > near future and how much control he wants to keep over the development,
> > I could imagine adding Klaus to MAINTAINERS, either as a co-maintainer
> > or as a reviewer. Then I could rely on reviews/acks from either of you
> > for merging series.
> > 
> 
> I would be happy to step up (officially) to help maintain the device
> with Keith and review on a daily basis, and my position can support
> this.
> 
> > Of course, the patches don't necessarily have to go through my tree
> > either if this only serves to complicate things these days. If sending
> > separate pull requests directly to Peter would make things easier, I
> > certainly wouldn't object.
> > 
> 
> I don't think there is any reason to by-pass your tree. I think the
> volume would need to increase even further for that to make sense.
> 
It my fault as well - I need to get back to reviewing these.
(I'll review few of them today I hope)

Best regards,
	Maxim Levitsky


