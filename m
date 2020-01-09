Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F06C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C672C20661
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1I9j3GX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C672C20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWYQ-00050v-E5
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ipWWC-0002Hi-PV
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:02:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ipWWB-0001TX-Cs
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:02:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36006
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ipWWB-0001QW-6L
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578571346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/m/DPPmOtvxFMiS2XBx7cvLdh9f++FiEBXDX3B9vo4=;
 b=J1I9j3GX3oPrloPz5f3f4WmjqNW5m4G7R7Plpe8WA7ae6o2l0Lx/cgadWuhftqQkBKxFJt
 iU2XNY1EmIqy03KWGVGpr42qYePq6oVC3pF7noJa2nQxjm2QS72bdXXVo0WlN3YgZrd9u4
 FUZI3BSaNH6+nNlqClVQsCivI/7iGYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-XCXwtP68MPuwLj1iBAOAgw-1; Thu, 09 Jan 2020 07:02:23 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F3BF107ACC9
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 12:02:22 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CEC7D5C241;
 Thu,  9 Jan 2020 12:02:18 +0000 (UTC)
Date: Thu, 9 Jan 2020 12:02:16 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/2] exclude hyperv synic sections from vhost
Message-ID: <20200109120216.GA6795@work-vm>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <53359208-3cd9-b0b6-f424-a5135e770fca@redhat.com>
MIME-Version: 1.0
In-Reply-To: <53359208-3cd9-b0b6-f424-a5135e770fca@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: XCXwtP68MPuwLj1iBAOAgw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: vkuznets@redhat.com, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jason Wang (jasowang@redhat.com) wrote:
>=20
> On 2020/1/8 =E4=B8=8B=E5=8D=889:53, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Hyperv's synic (that we emulate) is a feature that allows the guest
> > to place some magic (4k) pages of RAM anywhere it likes in GPA.
> > This confuses vhost's RAM section merging when these pages
> > land over the top of hugepages.
>=20
>=20
> Hi David:
>=20
> A silly question, is this because the alignment when adding sections? If
> yes, what's the reason for doing alignment which is not a must for vhost
> memory table.

Page alignment is a bit odd with vhost-user - it ends up having to mmap
each of the sections itself; and still has to map them as hugepages
to be able to mmap - in the old world you could sometimes have
the daemon mmaping the same chunk of memory twice into the vhost-user
process; without the aggregation  you'd get a hugepage mapping for the
0-2MB chunk for the 0-512K mapping, and then maybe another 0-2MB chunk
for some of the other parts over 512K.
With postcopy we can't have the multiple mappings of the same part of
guest memory; we need to have one mapping for userfault.

Also, given the 16 separate synic regions, you'd probably end up having
a lot of wasted vhost-sections.

Dave




> Thanks
>=20
>=20
> >=20
> > Since they're not normal RAM, and they shouldn't have vhost DMAing
> > into them, exclude them from the vhost set.
> >=20
> > I do that by marking them as device-ram and then excluding device-ram
> > from vhost.
> >=20
> > bz: https://bugzilla.redhat.com/show_bug.cgi?id=3D1779041
> >=20
> > Dr. David Alan Gilbert (2):
> >    vhost: Don't pass ram device sections
> >    hyperv/synic: Allocate as ram_device
> >=20
> >   hw/hyperv/hyperv.c | 14 ++++++++------
> >   hw/virtio/vhost.c  |  1 +
> >   2 files changed, 9 insertions(+), 6 deletions(-)
> >=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


