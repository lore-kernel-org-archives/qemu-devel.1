Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4FCC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 08:24:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16AC32074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 08:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CI4TGom5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AC32074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh7ed-0006QZ-CL
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 04:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jh7dw-0005Yq-Cb
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 04:24:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55102
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jh7du-0006mI-Q4
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 04:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591345437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JbH9DclmICh+BO3JYUSVx7K+K2CwA4HXD76aZFrgSrM=;
 b=CI4TGom5qGi+fKwL/zK5xwWdUtszLMbmmaIaM9kmNPpT5bSq97PUtfUgjVtWLsJMAAwS6/
 F2FUPzG28LK4EiAv+8oWT16gyj7TmnLhxBtVaZSqxlmV3pYKYH05bhxTbOM+G+Ym7N1VgC
 X4ROetGxK6iG6hK23pycYc1/sd9dgg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-iRkMdvQXOZyQdIByEXNjJw-1; Fri, 05 Jun 2020 04:23:55 -0400
X-MC-Unique: iRkMdvQXOZyQdIByEXNjJw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42493835B41;
 Fri,  5 Jun 2020 08:23:54 +0000 (UTC)
Received: from localhost (unknown [10.40.208.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE01D10016E8;
 Fri,  5 Jun 2020 08:23:46 +0000 (UTC)
Date: Fri, 5 Jun 2020 10:23:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [PATCH v4 2/3] hw/acpi/nvdimm: add a helper to augment SRAT
 generation
Message-ID: <20200605102345.52b2008a@redhat.com>
In-Reply-To: <73b11cd452acffc18f7083f1ea7e5ca22cade31f.camel@intel.com>
References: <20200528223437.12568-1-vishal.l.verma@intel.com>
 <20200528223437.12568-3-vishal.l.verma@intel.com>
 <20200604123326.38f7a368@redhat.com>
 <73b11cd452acffc18f7083f1ea7e5ca22cade31f.camel@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 "mst@redhat.com" <mst@redhat.com>, "Liu, Jingqi" <jingqi.liu@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 00:54:28 +0000
"Verma, Vishal L" <vishal.l.verma@intel.com> wrote:

> On Thu, 2020-06-04 at 12:33 +0200, Igor Mammedov wrote:
> > On Thu, 28 May 2020 16:34:36 -0600
> > Vishal Verma <vishal.l.verma@intel.com> wrote:
> >   
> > > NVDIMMs can belong to their own proximity domains, as described by the
> > > NFIT. In such cases, the SRAT needs to have Memory Affinity structures
> > > in the SRAT for these NVDIMMs, otherwise Linux doesn't populate node
> > > data structures properly during NUMA initialization. See the following
> > > for an example failure case.
> > > 
> > > https://lore.kernel.org/linux-nvdimm/20200416225438.15208-1-vishal.l.verma@intel.com/
> > > 
> > > Introduce a new helper, nvdimm_build_srat(), and call it for both the
> > > i386 and arm versions of 'build_srat()' to augment the SRAT with
> > > memory affinity information for NVDIMMs.
> > > 
> > > The relevant command line options to exercise this are below. Nodes 0-1
> > > contain CPUs and regular memory, and nodes 2-3 are the NVDIMM address
> > > space.
> > > 
> > >   -numa node,nodeid=0,mem=2048M,
> > >   -numa node,nodeid=1,mem=2048M,  
> > 
> > pls note that 'mem' is about to be disabled for new machine types in favor of memdev
> > so this CLI won't work.
> > It would be nice to update commit message with memdev variant of CLI  
> 
> I saw the warnings printed - I did try to use memdevs, but it didn't
> quite work with my use case. I'm supplying mem=0 for the pmem/nvdimm
> devices that I want to give a specific numa node, but not give them any
> more regular memory aside from the nvdimm itself (see nodes 4 and 5
> below). And for some reason I couldn't do that with memdevs.
it should work since 4.1

here is example 
qemu-system-x86_64 -object memory-backend-ram,id=mem0,size=1G -m 1G \
 -numa node,memdev=mem0 -numa node -monitor stdio

QEMU 5.0.50 monitor - type 'help' for more information
(qemu) VNC server running on ::1:5900
info numa
2 nodes
node 0 cpus: 0
node 0 size: 1024 MB
node 0 plugged: 0 MB
node 1 cpus:
node 1 size: 0 MB
node 1 plugged: 0 MB
(qemu)
> 
> Here is the full command line I'm using for example. I'd appreciate any
> pointers on converting over to memdevs fully.
> 
>    qemu-system-x86_64 
>    -machine pc,accel=kvm,nvdimm, 
>    -m 8192M,slots=4,maxmem=40960M 
>    -smp 8,sockets=2,cores=2,threads=2 
>    -enable-kvm 
>    -display none 
>    -nographic 
>    -drive file=root.img,format=raw,media=disk 
>    -kernel ./mkosi.extra/boot/vmlinuz-5.7.0-00001-g87ad963bac23 
>    -initrd mkosi.extra/boot/initramfs-5.7.0-00001-g87ad963bac23.img 
>    -append selinux=0 audit=0 console=tty0 console=ttyS0 root=/dev/sda2 ignore_loglevel rw 
>    -device e1000,netdev=net0 
>    -netdev user,id=net0,hostfwd=tcp::10022-:22 
>    -snapshot 
>    -numa node,nodeid=0,mem=2048M, 
>    -numa cpu,node-id=0,socket-id=0 
>    -numa node,nodeid=1,mem=2048M, 
>    -numa cpu,node-id=1,socket-id=1 
>    -numa node,nodeid=2,mem=2048M, 
>    -numa node,nodeid=3,mem=2048M, 
>    -numa node,nodeid=4,mem=0, 
>    -object memory-backend-file,id=nvmem0,share,mem-path=nvdimm-0,size=16384M,align=1G 
>    -device nvdimm,memdev=nvmem0,id=nv0,label-size=2M,node=4 
>    -numa node,nodeid=5,mem=0, 
>    -object memory-backend-file,id=nvmem1,share,mem-path=nvdimm-1,size=16384M,align=1G 
>    -device nvdimm,memdev=nvmem1,id=nv1,label-size=2M,node=5 
> 
> >   
> > >   -numa node,nodeid=2,mem=0,
> > >   -object memory-backend-file,id=nvmem0,share,mem-path=nvdimm-0,size=16384M,align=128M
> > >   -device nvdimm,memdev=nvmem0,id=nv0,label-size=2M,node=2
> > >   -numa node,nodeid=3,mem=0,
> > >   -object memory-backend-file,id=nvmem1,share,mem-path=nvdimm-1,size=16384M,align=128M
> > >   -device nvdimm,memdev=nvmem1,id=nv1,label-size=2M,node=3
> > > 
> > > Cc: Jingqi Liu <jingqi.liu@intel.com>
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Reviewed-by: Jingqi Liu <jingqi.liu@intel.com>
> > > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>  
> > 
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>  
> 
> Thanks for the review Igor - I'm pretty unfamiliar with qemu development
> - what are the next steps? Is there a certain maintainer/tree I could
> watch for the inclusion of this?
> 
> >   
> > > ---
> > >  hw/acpi/nvdimm.c         | 23 +++++++++++++++++++++++
> > >  hw/arm/virt-acpi-build.c |  4 ++++
> > >  hw/i386/acpi-build.c     |  5 +++++
> > >  include/hw/mem/nvdimm.h  |  1 +
> > >  4 files changed, 33 insertions(+)
> > > 
> > >   


