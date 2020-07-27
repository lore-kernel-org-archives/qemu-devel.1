Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C91C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0729320729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U27QVmie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0729320729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k08Vn-0000AO-6X
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k08V2-00088n-2H
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 15:09:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34981
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k08Uz-0007u6-JS
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 15:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595876960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+L9bWD9Rp1zywQaxHNOfbEQdpKSZ/8gfiu5uLsraM9A=;
 b=U27QVmie3WWgVOQiVS/vMTD/z1zES50ef7v5phW7OjT+2gO66UmutGz2l11t4RX6wi3XVj
 8eFu4fi5fKxd1omkL1KUPcHWQNVe4AR8RBVxT88q3IjGj5p3Ha5S3scRH5Om5cW8gR/pJQ
 wtJoX535c9UWzn5B8R2NkEh8vRxqEks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-SdKztvAAOS-MGKkydDtRKw-1; Mon, 27 Jul 2020 15:09:13 -0400
X-MC-Unique: SdKztvAAOS-MGKkydDtRKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9026058;
 Mon, 27 Jul 2020 19:09:12 +0000 (UTC)
Received: from work-vm (ovpn-114-135.ams2.redhat.com [10.36.114.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E45E270597;
 Mon, 27 Jul 2020 19:09:11 +0000 (UTC)
Date: Mon, 27 Jul 2020 20:09:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: William Lima Reiznautt <willreli@gmail.com>
Subject: Re: Live Migration (L2 network)
Message-ID: <20200727190909.GA29172@work-vm>
References: <CAO4s5Y90ZTYLbt1M_JDOJx1wmOY43PEu+cFSw0SHY5BOEqk3pA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAO4s5Y90ZTYLbt1M_JDOJx1wmOY43PEu+cFSw0SHY5BOEqk3pA@mail.gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:02:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* William Lima Reiznautt (willreli@gmail.com) wrote:
> Hi folks,
> 
> I hope everything is well.

Hi,

> Sorry about that doubt in this channel.

No, it's the right place to ask!

> I have a doubt about live migration interacting with layer 2 network, when
> the live migration is running. How does the qemu signal the switch network
> that the qemu instance changes port ? Because when the qemu migration to
> another port switch, the switch has a time to understand that flow is
> changed.
> 
> I saw the dump traffic in live migration and I noticed that one packet
> (RARP). "This packet is created by qemu."
> 
> Does anyone know if there is documentation on this?

I'm not sure we have documentation, but the code is in net/announce.c in
recent qemu.
When the migration has finished we send an ARP and then, when it starts
running, we tell the guest to send a RARP;  we send those a few times
to make sure we don't miss it.
Those are normally enough for the switch to realise that the VM
has moved port;  some very complex switch setups are less forgiving - in
recent qemu's you can send the announce again later and/or change the
timing of it.

Dave

> Thanks
> 
> - - -
> William Lima Reiznautt
> willreli@gmail.com
> www.ic.unicamp.br/~william
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


