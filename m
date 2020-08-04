Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B150C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 11:30:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66992070A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 11:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQjr3fy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66992070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2v9e-0002FK-27
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 07:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k2v91-0001ji-Ja
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 07:30:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45277
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k2v8z-0008Qp-Gv
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 07:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596540608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IioK+O0mntd1AwoksnmFv2LSTz0AWD/COVVyEvTbErY=;
 b=FQjr3fy8tJqvAZa2ZBahkedNLmdOVJpRku1QmvojB2A37a6CiIRJ2bE923Adt1StLjm5xA
 AkfnIzenKiP8an1gLgbUOxmHp/car++c74bv1kMeOIb2BkE+rVUyJJfNlohtLLKQm7kyEA
 6w59crq1e5gMBsxrqv8J+AeeHo7JHvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-VmGU4AE2MTWrypIatQm8IA-1; Tue, 04 Aug 2020 07:30:04 -0400
X-MC-Unique: VmGU4AE2MTWrypIatQm8IA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8510580183C;
 Tue,  4 Aug 2020 11:30:03 +0000 (UTC)
Received: from work-vm (ovpn-114-108.ams2.redhat.com [10.36.114.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11A4571791;
 Tue,  4 Aug 2020 11:29:53 +0000 (UTC)
Date: Tue, 4 Aug 2020 12:29:50 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/2] Enable virtio-fs on s390x
Message-ID: <20200804112950.GB2659@work-vm>
References: <20200730140731.32912-1-mhartmay@linux.ibm.com>
 <20200802011337-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200802011337-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Thu, Jul 30, 2020 at 04:07:29PM +0200, Marc Hartmayer wrote:
> > This patch series is about enabling virtio-fs on s390x. For that we need
> >  + some shim code (first patch), and we need
> >  + libvhost-user to deal with virtio endiannes for non-legacy virtio
> >    devices as mandated by the spec.
> > 
> > How to use?
> > 
> > For general instructions how to use virtio-fs (on x86) please have a
> > look at https://virtio-fs.gitlab.io/howto-qemu.html. Most of the
> > instructions can also be applied on s390x.
> > 
> > In short:
> > 
> > 1. Install self-compiled QEMU with this patch series applied
> > 2. Prepare host and guest kernel so they support virtio-fs
> > 
> > Start virtiofsd on the host
> > 
> >  $ virtiofsd -f --socket-path=/tmp/vhostqemu -o source=/tmp/shared
> > 
> > Now you can start QEMU in a separate shell on the host:
> > 
> >  $ qemu-system-s390x -machine type=s390-ccw-virtio,accel=kvm,memory-backend=mem \
> >    -object memory-backend-file,id=mem,size=2G,mem-path=/dev/shm/virtiofs,share=on,prealloc=on,prealloc-threads=1 \
> >    -chardev socket,id=char0,path=/tmp/vhostqemu -device vhost-user-fs-ccw,queue-size=1024,chardev=char0,tag=myfs \
> >    -drive if=virtio,file=disk.qcow2 \
> >    -m 2G -smp 2 -nographic
> > 
> > Log into the guest and mount it
> > 
> >  $ mount -t virtiofs myfs /mnt
> 
> Who's merging this? My tree?

I think so; it seems either generic virtio or s390 more than actually
virtiofs specific in most of it.

Dave

> > Changelog:
> >  RFC v2 -> v1:
> >  - patch 1:
> >   + Added `force_revision_1 = true` (Conny)
> >   + I didn't add the r-b from Stefan Hajnoczi as I've added the
> >     changes suggested by Conny
> >  - squashed patches 2 and 3:
> >   + removed assertion in performance critical code path (Stefan)
> >   + dropped all dead code (Stefan)
> >   + removed libvhost-access.h
> >   
> >  RFC v1 -> RFC v2:
> >   + rebased
> >   + drop patch "libvhost-user: print invalid address on vu_panic" as it's not related to this series
> >   + drop patch "[RFC 4/4] HACK: Hard-code the libvhost-user.o-cflags for s390x"
> >   + patch "virtio: add vhost-user-fs-ccw device": replace qdev_set_parent_bus and object_property_set_bool by qdev_realize
> >   + patch "libvhost-user: handle endianness as mandated by the spec":
> >     Drop support for legacy virtio devices
> >   + add patch to fence legacy virtio devices
> > *** BLURB HERE ***
> > 
> > Halil Pasic (1):
> >   virtio: add vhost-user-fs-ccw device
> > 
> > Marc Hartmayer (1):
> >   libvhost-user: handle endianness as mandated by the spec
> > 
> >  contrib/libvhost-user/libvhost-user.c | 77 +++++++++++++++------------
> >  hw/s390x/Makefile.objs                |  1 +
> >  hw/s390x/vhost-user-fs-ccw.c          | 75 ++++++++++++++++++++++++++
> >  3 files changed, 119 insertions(+), 34 deletions(-)
> >  create mode 100644 hw/s390x/vhost-user-fs-ccw.c
> > 
> > -- 
> > 2.25.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


