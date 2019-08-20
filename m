Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0104FC3A59E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6F0214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6F0214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i04oP-0007WB-V7
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 10:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao.peng@linux.alibaba.com>) id 1i04ni-0006zq-Jv
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao.peng@linux.alibaba.com>) id 1i04nW-0001rg-NV
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:07:47 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:18746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao.peng@linux.alibaba.com>)
 id 1i04nW-0001oK-DR
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:07:42 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=tao.peng@linux.alibaba.com; NM=1;
 PH=DS; RN=5; SR=0; TI=SMTPD_---0Ta-vclZ_1566310031; 
Received: from graymalkin.local(mailfrom:tao.peng@linux.alibaba.com
 fp:SMTPD_---0Ta-vclZ_1566310031) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 20 Aug 2019 22:07:12 +0800
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190819160426.GB2625@stefanha-x1.localdomain>
 <335d2ae6-4d06-9fb3-e1f6-fbef8aee946f@linux.alibaba.com>
 <20190820080952.GA2867@work-vm>
From: Peng Tao <tao.peng@linux.alibaba.com>
Message-ID: <5bd1c212-e74c-ecd2-1472-ae91aaa2061d@linux.alibaba.com>
Date: Tue, 20 Aug 2019 22:07:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190820080952.GA2867@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 47.88.44.36
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



On 2019/8/20 16:09, Dr. David Alan Gilbert wrote:
> * Peng Tao (tao.peng@linux.alibaba.com) wrote:
>>
>>
>> On 2019/8/20 00:04, Stefan Hajnoczi wrote:
>>> I am delighted to announce the release of virtio-fs v0.3, a shared file
>>> system that lets virtual machines access a directory tree on the host.
>>> This release is based on QEMU 4.1.0 and Linux 5.3-rc3.
>>>
>> Good news! As virtio-fs is maturing and stabilizing, what's the plan for
>> upstreaming both qemu and kernel part of it?
> 
> We're working on that.
> A few days ago I sent the core qemu code to qemu-devel marked as
> experiemental;  Vivek is planning on sending another kernel version out.
> 
Cool. Looking forward to seeing them in upstream code base;)

Cheers,
Tao
> Dave
> 
>> Cheers,
>> Tao
>>
>>> For more information about virtio-fs: https://virtio-fs.gitlab.io/
>>>
>>> This is a development release aimed at early adopters of virtio-fs.  Work is
>>> being done to upstream the code into Linux and QEMU.  We expect to stop
>>> publishing virtio-fs releases once the code has been merged by these upstream
>>> projects.
>>>
>>> Where to get it:
>>>
>>>     https://gitlab.com/virtio-fs/linux/-/tags/virtio-fs-v0.3
>>>     https://gitlab.com/virtio-fs/qemu/-/tags/virtio-fs-v0.3
>>>
>>> Changes:
>>>
>>>    * Please note that the mount syntax has changed to:
>>>
>>>        # mount -t virtio_fs myfs /mnt -o ...
>>>
>>>      The old syntax was "mount -t virtio_fs none /mnt -o tag=myfs,...".
>>>
>>>    * virtiofsd --fd=FDNUM takes a listen socket file descriptor number.  File
>>>      descriptor passing is an alternative way to manage the vhost-user UNIX
>>>      domain socket.  The parent process no longer needs to wait for virtiofsd to
>>>      create the listen socket before spawning the VM.
>>>
>>>    * virtiofsd --syslog logs to syslog(2) instead of stderr.  Useful for unifying
>>>      logging and when the virtiofsd process is not being supervised.
>>>
>>>    * virtiofsd --thread-pool-size=NUM sets the maximum number of worker threads
>>>      for FUSE request processing.  This can be used to control the host queue
>>>      depth.  The default is 64.
>>>
>>>    * Performance improvements and bug fixes.
>>>
>>> Note for Kata Containers: the new kernel is not compatible with existing
>>> Kata Containers releases due to the mount syntax change.  To try it out,
>>> please apply the following kata-runtime patch:
>>>
>>>     https://gitlab.com/virtio-fs/runtime/commit/a2e44de817e438c02a495cf258039774527e3178
>>>
>>> Kata Containers patches for virtio-fs v0.3 are under development and will be
>>> submitted to Kata soon.
>>>
>>> Thanks to the following people for contributing code and to many more
>>> for helping the virtio-fs effort:
>>>
>>> Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> Eric Ren <renzhen@linux.alibaba.com>
>>> Eryu Guan <eguan@linux.alibaba.com>
>>> Ganesh Maharaj Mahalingam <ganesh.mahalingam@intel.com>
>>> Jiufei Xue <jiufei.xue@linux.alibaba.com>
>>> Liu Bo <bo.liu@linux.alibaba.com>
>>> Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>>> Miklos Szeredi <mszeredi@redhat.com>
>>> Peng Tao <tao.peng@linux.alibaba.com>
>>> piaojun <piaojun@huawei.com>
>>> Sebastien Boeuf <sebastien.boeuf@intel.com>
>>> Stefan Hajnoczi <stefanha@redhat.com>
>>> Vivek Goyal <vgoyal@redhat.com>
>>> Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
>>>
>>>
>>> _______________________________________________
>>> kata-dev mailing list
>>> kata-dev@lists.katacontainers.io
>>> http://lists.katacontainers.io/cgi-bin/mailman/listinfo/kata-dev
>>>
>>
>> -- 
>> Into something rich and strange.
>>
>> _______________________________________________
>> kata-dev mailing list
>> kata-dev@lists.katacontainers.io
>> http://lists.katacontainers.io/cgi-bin/mailman/listinfo/kata-dev
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

-- 
Into something rich and strange.

