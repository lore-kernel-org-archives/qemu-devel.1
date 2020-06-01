Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A879C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 11:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28AC920772
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 11:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRrrVC5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AC920772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfiQ8-0007xF-6q
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 07:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jfiP9-0007DD-Lk
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 07:14:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49240
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jfiP8-0001q7-10
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 07:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591010092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DafoXjr9ZhUbbMcdc7pVwz7NRjH26dSLMCnm7/BHek4=;
 b=aRrrVC5SMS/C3cV72aZjVSWZJRnsO3OXHwZzWJfRWZBBBJBODSOEdYpcATm1VqE5QInM3Q
 N8P6D/C+oZqTepZWjpDXjIiTe12RlgPBZ9JphrBe1Pjcu0t3e2n1GR/d07sXXqIamOAV/M
 LKzWtauZ+zr4pbhQpFIWIetV+n4iarQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-lO1KUYcXOTm8-xUTEa2fUg-1; Mon, 01 Jun 2020 07:14:49 -0400
X-MC-Unique: lO1KUYcXOTm8-xUTEa2fUg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A48F461;
 Mon,  1 Jun 2020 11:14:48 +0000 (UTC)
Received: from [10.40.194.230] (unknown [10.40.194.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47DCC61981;
 Mon,  1 Jun 2020 11:14:47 +0000 (UTC)
Subject: Re: [PATCH 0/3] Couple of HMAT fixes
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
References: <cover.1590753455.git.mprivozn@redhat.com>
Message-ID: <54382c31-f33f-17cc-afbf-46e8f20ff80c@redhat.com>
Date: Mon, 1 Jun 2020 13:14:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <cover.1590753455.git.mprivozn@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 02:05:53
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, ehabkost@redhat.com,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 3:33 PM, Michal Privoznik wrote:
> I've started working on libvirt side of this feature. WIP patches can be
> found here:
> 
> https://github.com/zippy2/libvirt/commits/hmat
> 
> I've gotten to a point where libvirt generates cmd line but QEMU refuses
> it. Problem is that I was looking into qemu-options.hx instead of
> qapi/machine.json and thus found some irregularities between these two.
> 
> I'm not necessarily stating that all these patches are correct (I have
> some doubts about 3/3 because nearly identical code can be found in
> machine_set_cpu_numa_node(), but I have no idea if it's a coincidence).
> 
> Michal Privoznik (3):
>    qapi: Make @associativity, @policy and @line of NumaHmatCacheOptions
>      optional
>    numa: Allow HMAT cache to be defined before HMAT latency/bandwidth
>    numa: Initialize node initiator with respect to .has_cpu
> 
>   hw/core/numa.c    | 22 +++++++++-------------
>   qapi/machine.json |  6 +++---
>   2 files changed, 12 insertions(+), 16 deletions(-)
> 

Hey, so as I'm experimenting with this, I have couple of questions. 
Hopefully, you have answers.

1) How can I read HMAT from inside the guest? More specifically, I can 
see cache exposed under sysfs, but not latency/bandwidth. I mean, there is:

/sys/devices/system/node/node0/memory_side_cache/

which appears to contain interesting bits. But there seem to be nothing 
like that for latency/bandwidth. There is:

/sys/devices/system/node/node0/access0/initiators

containing:
read_bandwidth  read_latency  write_bandwidth  write_latency

but they all contain "0".


2) I still don't quite understand what initiator is. The way I read the 
documentation is that if a NUMA node has CPUs, it is initiator to 
itself. But, when I try to start the following command line, I get an error:

-machine 
pc-q35-2.12,accel=kvm,usb=off,vmport=off,dump-guest-core=off,hmat=on \
-cpu host,vmx=off \
-m 4096 \
-overcommit mem-lock=off \
-smp 4,sockets=4,cores=1,threads=1 \
-object memory-backend-ram,id=ram-node0,size=2147483648 \
-numa node,nodeid=0,cpus=0-1,initiator=0,memdev=ram-node0 \
-object memory-backend-ram,id=ram-node1,size=2147483648 \
-numa node,nodeid=1,cpus=2-3,initiator=1,memdev=ram-node1 \
-numa 
hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=1 
\
-numa 
hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=read-latency,latency=2 
\
-numa 
hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=write-latency,latency=4 
\
-numa 
hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=1048576K 
\
-numa 
hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=read-bandwidth,bandwidth=2097152K 
\
-numa 
hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=write-bandwidth,bandwidth=4194304K 
\
-numa 
hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,latency=10 
\
-numa 
hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=read-latency,latency=20 
\
-numa 
hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=write-latency,latency=40 
\
-numa 
hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,bandwidth=1024K 
\
-numa 
hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=read-bandwidth,bandwidth=2048K 
\
-numa 
hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=write-bandwidth,bandwidth=4096K 
\
-numa 
hmat-cache,node-id=0,size=256K,level=1,associativity=direct,policy=write-back,line=8 
\
-numa 
hmat-cache,node-id=0,size=128K,level=2,associativity=complex,policy=write-through,line=16 
\


qemu-system-x86_64: -numa 
node,nodeid=1,cpus=2-3,initiator=1,memdev=ram-node1: The initiator of 
CPU NUMA node 1 should be itself

Firstly, why does "CPU" even appear in the message? Initiator is an 
attribute of a NUMA node not CPU, right? Secondly, as specified on the 
command line, the initiator of the node 1 *is* node 1.


Michal


