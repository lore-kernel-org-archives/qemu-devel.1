Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0CDC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 14:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66FC20880
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 14:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66FC20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51361 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG32N-0002F4-40
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 10:56:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hG2zm-0000Ui-P8
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hG2zl-0007oI-Gx
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:54:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hG2zj-0007nI-H3
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:54:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A24063003BE1;
	Mon, 15 Apr 2019 14:54:01 +0000 (UTC)
Received: from work-vm (ovpn-117-222.ams2.redhat.com [10.36.117.222])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F328B60240;
	Mon, 15 Apr 2019 14:54:00 +0000 (UTC)
Date: Mon, 15 Apr 2019 15:53:58 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: fengyd <fengyd81@gmail.com>
Message-ID: <20190415145358.GA2893@work-vm>
References: <CACnvu8YKqaZA7XSD41=SQrUL7h9YafJMgKPe5cJZd3XZ3zrSNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CACnvu8YKqaZA7XSD41=SQrUL7h9YafJMgKPe5cJZd3XZ3zrSNw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Mon, 15 Apr 2019 14:54:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] How live migration work for vhost-user
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415145358.u2yzEv51ULX6m_yGrDwsyjefp2qwdRPbAFGLpoXMGpY@z>

* fengyd (fengyd81@gmail.com) wrote:
> Hi,
> 
> During live migration,  the folloing log can see in nova-compute.log in my
> environment:
>  ERROR nova.virt.libvirt.driver [req-039a85e1-e7a1-4a63-bc6d-c4b9a044aab6
> 0cdab20dc79f4bc6ae5790e7b4a898ac 3363c319773549178acc67f32c78310e - default
> default] [instance: 5ec719f4-1865-4afe-a207-3d9fae22c410] Live Migration
> failure: internal error: qemu unexpectedly closed the monitor:
> 2019-04-15T02:58:22.213897Z qemu-kvm: VQ 0
> size 0x100 < last_avail_idx 0x1e - used_idx 0x23
> 
> It's OK for standard Linux VM, but not OK for our VM where virtio is
> implemented by ourself.
> KVM version as follow:
> qemu-kvm-common-ev-2.12.0-18.el7_6.3.1.x86_64
> qemu-kvm-ev-2.12.0-18.el7_6.3.1.x86_64
> libvirt-daemon-kvm-3.9.0-14.2.el7.centos.ncir.8.x86_64
> 
> Do you know what's the difference between virtio and vhost-user during
> migration?
> The function virtio_load in Qemu is called for virtio and vhost-user during
> migration.
> For virtio,  last_avail_idx  and used_idx are stored in Qemu, Qemu is
> responsible for updating their values accordingly
> For vhost-user, last_avail_idx  and used_idx are stored in vhost-user app,
> eg. DPDK, not in Qemu?
> How does migration work for vhost-user?

I don't know the details, but my understanding is that vhost-user
tells the vhost-user client about an area of 'log' memory, where the
vhost-user client must mark pages as dirty.

In the qemu source, see docs/interop/vhost-user.txt and see
the VHOST_SET_LOG_BASE and VHOST_USER_SET_LOG_FD calls.

If the client correctly marks the areas as dirty, then qemu
should resend those pages across.


Dave

> Thanks in advance
> Yafeng
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

