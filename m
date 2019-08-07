Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E45C31E40
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 01:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622C521738
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 01:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622C521738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvAiS-0003r8-Im
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 21:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41676)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hvAi0-0003RU-94
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 21:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hvAhz-0008S0-6J
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 21:25:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:35941)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hvAhy-0008Qd-TK
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 21:25:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Aug 2019 18:25:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; d="scan'208";a="373604277"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.216])
 ([10.239.196.216])
 by fmsmga005.fm.intel.com with ESMTP; 06 Aug 2019 18:25:36 -0700
To: Daniel Black <daniel@linux.ibm.com>, jingqi.liu@intel.com
References: <20190731011209.22538-1-tao3.xu@intel.com>
 <20190731011209.22538-10-tao3.xu@intel.com>
 <20190807091449.2e88b175@volution.ozlabs.ibm.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <331fa517-6264-7b13-d0c7-3c36be36f10c@intel.com>
Date: Wed, 7 Aug 2019 09:25:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807091449.2e88b175@volution.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
Subject: Re: [Qemu-devel] [PATCH RESEND v8 09/11] numa: Extend the CLI to
 provide memory latency and bandwidth information
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
Cc: ehabkost@redhat.com, fan.du@intel.com, qemu-devel@nongnu.org,
 jonathan.cameron@huawei.com, imammedo@redhat.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/2019 7:14 AM, Daniel Black wrote:
> 
> Liu Jingqi, Tao Xu,
> 
> Apologies to the late response on a patch on what is already a v8 patch.
> 
> The specification of latency and bandwidth is very much following the
> ACPI specification.
> 
> For a qemu interface I think this should be in more human measurements
> (time for latency and a bandwidth rate for the bandwidth).
> 
> e.g rather than
>   -object memory-backend-ram,size=64M,id=m0
>   -object memory-backend-ram,size=64M,id=m1geosync
>   -numa node,nodeid=0,memdev=m0
>   -numa node,nodeid=1,memdev=m1geosync,initiator=0
>   -numa cpu,node-id=0,socket-id=0
>   -numa cpu,node-id=0,socket-id=1
>   -numa
> hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,base-lat=1000,latency=5
>   -numa
> hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=5
>   -numa
> hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,base-lat=100,latency=10
>   -numa
>   hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=10
> 
> 
> Suggest a form like:
> 
>   -numa
> hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=NUM[fpnm[s]]
>   -numa
> hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=NUM[KMGP][Bb[ps]]
> 
> So:
> 
>   -numa
> hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=5ns
>   -numa
> hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=5Gb
> 
> 
> So this would remove the base-[lt,bw] settings and compute those internally in qemu based on latency/bandwidth specified with real units.
> 
> Also note the linux kernel HMAT latency display doesn't match up with the parameters passed in this patch series. Not sure which is at fault.
> 
> Test and results:
> 
> x86_64-softmmu/qemu-system-x86_64 -machine pc -nographic   -smp
> 2,sockets=2 -m 128M,slots=2,maxmem=1G
> -kernel /home/dan/repos/linux/vmlinux  -append "console=ttyS0"
> -object memory-backend-ram,size=64M,id=m0 -object
> memory-backend-ram,size=64M,id=m1geosync -numa node,nodeid=0,memdev=m0
> -numa node,nodeid=1,memdev=m1geosync,initiator=0 -numa
> cpu,node-id=0,socket-id=0 -numa cpu,node-id=0,socket-id=1 -numa
> hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,base-lat=1000,latency=5
> -numa
> hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=5
> -numa
> hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,base-lat=100,latency=10
> -numa
> hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=10
> 
> The Booting from ROM..[    0.000000] Linux version 5.3.0-rc2+
> (dan@volution) (gcc version 9.1.1 20190503 (Red Hat 9.1.1-1) (GCC)) #21
> SMP Tue Aug 6 17:15:49 AEST 2019
> 
> 
> [    0.419303] HMAT: Memory Flags:0001 Processor Domain:0 Memory Domain:0
> [    0.419648] HMAT: Memory Flags:0001 Processor Domain:0 Memory Domain:1
> [    0.419956] HMAT: Locality: Flags:00 Type:Access Latency Initiator Domains:1 Target Domains:2 Base:1000
> [    0.420527]   Initiator-Target[0-0]:5 nsec
> [    0.420791]   Initiator-Target[0-1]:10 nsec
> [    0.421068] HMAT: Locality: Flags:00 Type:Access Bandwidth Initiator Domains:1 Target Domains:2 Base:20
> [    0.421447]   Initiator-Target[0-0]:100 MB/s
> [    0.421635]   Initiator-Target[0-1]:200 MB/s
> 
> 
This is because the base-lat is only first set is valid, so if we input 
different base-lat like the test case, we follow the first 1000, so 
result is 5000 ps = 5 ns. but your suggestion is reasonable, this is not 
user-friendly. So we will refer to your suggestions. Thank you!


