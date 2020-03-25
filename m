Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDE1C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B820D20772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUXDa8xQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B820D20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH2go-0005i1-TZ
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 05:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jH2ce-0008En-EZ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jH2cd-0007Nt-9k
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:46:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:53434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jH2cd-0007Nh-3a
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585129610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zMgKUwa7rZhucN9yyhtBZFyKd2ukyBLlcGmXJ3qzJmQ=;
 b=iUXDa8xQwdYHsoK7p61otFzmJchK+7kNWnDJR/KUUXYZkofG1kizhEdSV3X6Z1LUU2CEeo
 SyfhNJqHpkqy4P9bWDOA34VQAji98HT7yQAumz0B+241o5DyiC/lIPpYfwjgmzt8HPUgIK
 NaHQK7yPKiUH/l4nLgaMSleIpwtP1WM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-UIVwiIXgOoKmyblH6Mbg5Q-1; Wed, 25 Mar 2020 05:46:49 -0400
X-MC-Unique: UIVwiIXgOoKmyblH6Mbg5Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 222FB1005509;
 Wed, 25 Mar 2020 09:46:48 +0000 (UTC)
Received: from office.mammed.net (unknown [10.40.195.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FDD0166AE;
 Wed, 25 Mar 2020 09:46:47 +0000 (UTC)
Date: Wed, 25 Mar 2020 10:46:44 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: Qemu master crashing on boot when using file backend for memory
Message-ID: <20200325104644.5ea8d0a6@office.mammed.net>
In-Reply-To: <20200325024924.GA1518@localhost.localdomain>
References: <20200312053648.GA17365@localhost.localdomain>
 <20200312115450.38c88206@redhat.com>
 <20200325024924.GA1518@localhost.localdomain>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

On Tue, 24 Mar 2020 22:50:46 -0400
Raphael Norwitz <raphael.norwitz@nutanix.com> wrote:

> On Thu, Mar 12, 2020 at 11:54:50AM +0100, Igor Mammedov wrote:
> >=20
> > On Thu, 12 Mar 2020 01:36:48 -0400
> > Raphael Norwitz <raphael.norwitz@nutanix.com> wrote:
> >  =20
> > > When I try run master qemu I am hitting a divide by zero error. It se=
ems
> > > to be coming from util/oslib-posix.c in touch_all_pages(). see line 4=
77:
> > >=20
> > > numpages_per_thread =3D numpages / memset_num_threads;
> > >=20
> > > Poking around the crash dumps, I can see that the smp_cpus parameter
> > > passed in to touch_all_pages() is 0. Going up the stack to
> > > host_memory_backend_memory_complete() I see backend->prealloc_threads=
 is
> > > also 0.
> > >=20
> > > Here=E2=80=99s how I am running qemu
> > >=20
> > > ./x86_64-softmmu/qemu-system-x86_64 \
> > > =09-kernel /boot/vmlinuz-3.10.0-1062.el7.x86_64  \
> > >  =09-netdev user,id=3Dnet0,hostfwd=3Dtcp::2250-:22 \
> > > =09-device e1000e,netdev=3Dnet0 \
> > > =09-m 1G \
> > > =09-initrd /boot/initramfs-3.10.0-1062.el7.x86_64.img  \
> > > =09-object memory-backend-file,id=3Dram-node0,prealloc=3Dyes,mem-path=
=3Dmem,share=3Dyes,size=3D1G \
> > > =09-numa node,nodeid=3D0,cpus=3D0,memdev=3Dram-node0=20
> > >=20
> > > I don't see this error on a slightly older qemu, as of commit 105b07f=
1
> > > (January 27th).
> > >=20
> > > Interestingly when I remove the memory-backend-file parameter I don=
=E2=80=99t
> > > see the error, i.e. this works:
> > >=20
> > > ./x86_64-softmmu/qemu-system-x86_64 \
> > > =09-kernel /boot/vmlinuz-3.10.0-1062.el7.x86_64  \
> > >  =09-netdev user,id=3Dnet0,hostfwd=3Dtcp::2250-:22 \
> > > =09-device e1000e,netdev=3Dnet0 \
> > > =09-m 1G \
> > > =09-initrd /boot/initramfs-3.10.0-1062.el7.x86_64.img
> > >=20
> > > Looking at the blame data for backends/hostmem.c I see commit ffac16f=
a
> > > introduced some churn in this part of the code. Has anyone else seen
> > > this issue? Could I be doing something wrong here? =20
> >=20
> > It's know issue, see
> >  "[PATCH] oslib-posix: initialize mutex and condition variable
> > for a fix =20
> > >  =20
> > =20
>=20
> I'm testing on qemu master now. Looks like this patch has been merged
> and I'm still seeing the same crash.

Thanks for report, fix is on the way to qemu-devel


