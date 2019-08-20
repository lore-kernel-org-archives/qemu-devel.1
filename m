Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9CAC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 08:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4106F23A6A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 08:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4106F23A6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzzE6-0004vM-Ep
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 04:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hzzDT-0004R1-W8
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 04:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hzzDQ-0007WK-T5
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 04:10:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58124)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hzzDQ-0007Vw-Iz
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 04:10:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 15CD13003715;
 Tue, 20 Aug 2019 08:10:03 +0000 (UTC)
Received: from work-vm (ovpn-117-33.ams2.redhat.com [10.36.117.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96DD718C70;
 Tue, 20 Aug 2019 08:09:54 +0000 (UTC)
Date: Tue, 20 Aug 2019 09:09:52 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peng Tao <tao.peng@linux.alibaba.com>
Message-ID: <20190820080952.GA2867@work-vm>
References: <20190819160426.GB2625@stefanha-x1.localdomain>
 <335d2ae6-4d06-9fb3-e1f6-fbef8aee946f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <335d2ae6-4d06-9fb3-e1f6-fbef8aee946f@linux.alibaba.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 20 Aug 2019 08:10:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [kata-dev] [ANNOUNCE] virtio-fs v0.3 release
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, kata-dev@lists.katacontainers.io
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peng Tao (tao.peng@linux.alibaba.com) wrote:
> 
> 
> On 2019/8/20 00:04, Stefan Hajnoczi wrote:
> > I am delighted to announce the release of virtio-fs v0.3, a shared file
> > system that lets virtual machines access a directory tree on the host.
> > This release is based on QEMU 4.1.0 and Linux 5.3-rc3.
> > 
> Good news! As virtio-fs is maturing and stabilizing, what's the plan for
> upstreaming both qemu and kernel part of it?

We're working on that.
A few days ago I sent the core qemu code to qemu-devel marked as
experiemental;  Vivek is planning on sending another kernel version out.

Dave

> Cheers,
> Tao
> 
> > For more information about virtio-fs: https://virtio-fs.gitlab.io/
> > 
> > This is a development release aimed at early adopters of virtio-fs.  Work is
> > being done to upstream the code into Linux and QEMU.  We expect to stop
> > publishing virtio-fs releases once the code has been merged by these upstream
> > projects.
> > 
> > Where to get it:
> > 
> >    https://gitlab.com/virtio-fs/linux/-/tags/virtio-fs-v0.3
> >    https://gitlab.com/virtio-fs/qemu/-/tags/virtio-fs-v0.3
> > 
> > Changes:
> > 
> >   * Please note that the mount syntax has changed to:
> > 
> >       # mount -t virtio_fs myfs /mnt -o ...
> > 
> >     The old syntax was "mount -t virtio_fs none /mnt -o tag=myfs,...".
> > 
> >   * virtiofsd --fd=FDNUM takes a listen socket file descriptor number.  File
> >     descriptor passing is an alternative way to manage the vhost-user UNIX
> >     domain socket.  The parent process no longer needs to wait for virtiofsd to
> >     create the listen socket before spawning the VM.
> > 
> >   * virtiofsd --syslog logs to syslog(2) instead of stderr.  Useful for unifying
> >     logging and when the virtiofsd process is not being supervised.
> > 
> >   * virtiofsd --thread-pool-size=NUM sets the maximum number of worker threads
> >     for FUSE request processing.  This can be used to control the host queue
> >     depth.  The default is 64.
> > 
> >   * Performance improvements and bug fixes.
> > 
> > Note for Kata Containers: the new kernel is not compatible with existing
> > Kata Containers releases due to the mount syntax change.  To try it out,
> > please apply the following kata-runtime patch:
> > 
> >    https://gitlab.com/virtio-fs/runtime/commit/a2e44de817e438c02a495cf258039774527e3178
> > 
> > Kata Containers patches for virtio-fs v0.3 are under development and will be
> > submitted to Kata soon.
> > 
> > Thanks to the following people for contributing code and to many more
> > for helping the virtio-fs effort:
> > 
> > Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Eric Ren <renzhen@linux.alibaba.com>
> > Eryu Guan <eguan@linux.alibaba.com>
> > Ganesh Maharaj Mahalingam <ganesh.mahalingam@intel.com>
> > Jiufei Xue <jiufei.xue@linux.alibaba.com>
> > Liu Bo <bo.liu@linux.alibaba.com>
> > Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > Miklos Szeredi <mszeredi@redhat.com>
> > Peng Tao <tao.peng@linux.alibaba.com>
> > piaojun <piaojun@huawei.com>
> > Sebastien Boeuf <sebastien.boeuf@intel.com>
> > Stefan Hajnoczi <stefanha@redhat.com>
> > Vivek Goyal <vgoyal@redhat.com>
> > Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
> > 
> > 
> > _______________________________________________
> > kata-dev mailing list
> > kata-dev@lists.katacontainers.io
> > http://lists.katacontainers.io/cgi-bin/mailman/listinfo/kata-dev
> > 
> 
> -- 
> Into something rich and strange.
> 
> _______________________________________________
> kata-dev mailing list
> kata-dev@lists.katacontainers.io
> http://lists.katacontainers.io/cgi-bin/mailman/listinfo/kata-dev
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

