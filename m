Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2392FC3A5A0
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 00:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71FA206DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 00:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71FA206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzryE-0001ZV-1q
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 20:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <piaojun@huawei.com>) id 1hzrxZ-0000y9-H2
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 20:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <piaojun@huawei.com>) id 1hzrxW-0007Co-VP
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 20:25:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41778 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <piaojun@huawei.com>) id 1hzrxW-000785-Kd
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 20:25:10 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id CE2CD44C6CE83090EDC9;
 Tue, 20 Aug 2019 08:25:01 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 20 Aug 2019
 08:25:00 +0800
To: Stefan Hajnoczi <stefanha@redhat.com>, <virtio-fs@redhat.com>
References: <20190819160426.GB2625@stefanha-x1.localdomain>
From: piaojun <piaojun@huawei.com>
Message-ID: <5D5B3DDC.9070204@huawei.com>
Date: Tue, 20 Aug 2019 08:25:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20190819160426.GB2625@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
Subject: Re: [Qemu-devel] [Virtio-fs] [ANNOUNCE] virtio-fs v0.3 release
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
Cc: qemu-devel@nongnu.org, kata-dev@lists.katacontainers.io
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A big step for virtio-fs!

Jun

On 2019/8/20 0:04, Stefan Hajnoczi wrote:
> I am delighted to announce the release of virtio-fs v0.3, a shared file
> system that lets virtual machines access a directory tree on the host.
> This release is based on QEMU 4.1.0 and Linux 5.3-rc3.
> 
> For more information about virtio-fs: https://virtio-fs.gitlab.io/
> 
> This is a development release aimed at early adopters of virtio-fs.  Work is
> being done to upstream the code into Linux and QEMU.  We expect to stop
> publishing virtio-fs releases once the code has been merged by these upstream
> projects.
> 
> Where to get it:
> 
>   https://gitlab.com/virtio-fs/linux/-/tags/virtio-fs-v0.3
>   https://gitlab.com/virtio-fs/qemu/-/tags/virtio-fs-v0.3
> 
> Changes:
> 
>  * Please note that the mount syntax has changed to:
> 
>      # mount -t virtio_fs myfs /mnt -o ...
> 
>    The old syntax was "mount -t virtio_fs none /mnt -o tag=myfs,...".
> 
>  * virtiofsd --fd=FDNUM takes a listen socket file descriptor number.  File
>    descriptor passing is an alternative way to manage the vhost-user UNIX
>    domain socket.  The parent process no longer needs to wait for virtiofsd to
>    create the listen socket before spawning the VM.
> 
>  * virtiofsd --syslog logs to syslog(2) instead of stderr.  Useful for unifying
>    logging and when the virtiofsd process is not being supervised.
> 
>  * virtiofsd --thread-pool-size=NUM sets the maximum number of worker threads
>    for FUSE request processing.  This can be used to control the host queue
>    depth.  The default is 64.
> 
>  * Performance improvements and bug fixes.
> 
> Note for Kata Containers: the new kernel is not compatible with existing
> Kata Containers releases due to the mount syntax change.  To try it out,
> please apply the following kata-runtime patch:
> 
>   https://gitlab.com/virtio-fs/runtime/commit/a2e44de817e438c02a495cf258039774527e3178
> 
> Kata Containers patches for virtio-fs v0.3 are under development and will be
> submitted to Kata soon.
> 
> Thanks to the following people for contributing code and to many more
> for helping the virtio-fs effort:
> 
> Dr. David Alan Gilbert <dgilbert@redhat.com>
> Eric Ren <renzhen@linux.alibaba.com>
> Eryu Guan <eguan@linux.alibaba.com>
> Ganesh Maharaj Mahalingam <ganesh.mahalingam@intel.com>
> Jiufei Xue <jiufei.xue@linux.alibaba.com>
> Liu Bo <bo.liu@linux.alibaba.com>
> Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Miklos Szeredi <mszeredi@redhat.com>
> Peng Tao <tao.peng@linux.alibaba.com>
> piaojun <piaojun@huawei.com>
> Sebastien Boeuf <sebastien.boeuf@intel.com>
> Stefan Hajnoczi <stefanha@redhat.com>
> Vivek Goyal <vgoyal@redhat.com>
> Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
> 
> 
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs
> 

