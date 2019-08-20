Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87923C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 03:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8CE214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 03:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8CE214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzvFA-0007qu-KT
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 23:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao.peng@linux.alibaba.com>) id 1hzuOT-00043d-Iq
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 23:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao.peng@linux.alibaba.com>) id 1hzuON-00081z-8I
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 23:01:04 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:56500)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao.peng@linux.alibaba.com>)
 id 1hzuOM-0007zz-TK
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 23:01:03 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=tao.peng@linux.alibaba.com; NM=1;
 PH=DS; RN=4; SR=0; TI=SMTPD_---0TZyVUo8_1566270041; 
Received: from graymalkin.local(mailfrom:tao.peng@linux.alibaba.com
 fp:SMTPD_---0TZyVUo8_1566270041) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 20 Aug 2019 11:00:42 +0800
To: Stefan Hajnoczi <stefanha@redhat.com>, virtio-fs@redhat.com
References: <20190819160426.GB2625@stefanha-x1.localdomain>
From: Peng Tao <tao.peng@linux.alibaba.com>
Message-ID: <335d2ae6-4d06-9fb3-e1f6-fbef8aee946f@linux.alibaba.com>
Date: Tue, 20 Aug 2019 11:00:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190819160426.GB2625@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 47.88.44.36
X-Mailman-Approved-At: Mon, 19 Aug 2019 23:53:53 -0400
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
Cc: qemu-devel@nongnu.org, kata-dev@lists.katacontainers.io
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/8/20 00:04, Stefan Hajnoczi wrote:
> I am delighted to announce the release of virtio-fs v0.3, a shared file
> system that lets virtual machines access a directory tree on the host.
> This release is based on QEMU 4.1.0 and Linux 5.3-rc3.
> 
Good news! As virtio-fs is maturing and stabilizing, what's the plan for 
upstreaming both qemu and kernel part of it?

Cheers,
Tao

> For more information about virtio-fs: https://virtio-fs.gitlab.io/
> 
> This is a development release aimed at early adopters of virtio-fs.  Work is
> being done to upstream the code into Linux and QEMU.  We expect to stop
> publishing virtio-fs releases once the code has been merged by these upstream
> projects.
> 
> Where to get it:
> 
>    https://gitlab.com/virtio-fs/linux/-/tags/virtio-fs-v0.3
>    https://gitlab.com/virtio-fs/qemu/-/tags/virtio-fs-v0.3
> 
> Changes:
> 
>   * Please note that the mount syntax has changed to:
> 
>       # mount -t virtio_fs myfs /mnt -o ...
> 
>     The old syntax was "mount -t virtio_fs none /mnt -o tag=myfs,...".
> 
>   * virtiofsd --fd=FDNUM takes a listen socket file descriptor number.  File
>     descriptor passing is an alternative way to manage the vhost-user UNIX
>     domain socket.  The parent process no longer needs to wait for virtiofsd to
>     create the listen socket before spawning the VM.
> 
>   * virtiofsd --syslog logs to syslog(2) instead of stderr.  Useful for unifying
>     logging and when the virtiofsd process is not being supervised.
> 
>   * virtiofsd --thread-pool-size=NUM sets the maximum number of worker threads
>     for FUSE request processing.  This can be used to control the host queue
>     depth.  The default is 64.
> 
>   * Performance improvements and bug fixes.
> 
> Note for Kata Containers: the new kernel is not compatible with existing
> Kata Containers releases due to the mount syntax change.  To try it out,
> please apply the following kata-runtime patch:
> 
>    https://gitlab.com/virtio-fs/runtime/commit/a2e44de817e438c02a495cf258039774527e3178
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
> _______________________________________________
> kata-dev mailing list
> kata-dev@lists.katacontainers.io
> http://lists.katacontainers.io/cgi-bin/mailman/listinfo/kata-dev
> 

-- 
Into something rich and strange.

