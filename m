Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB31C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 08:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CC32083B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 08:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CC32083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqD1u-0001OW-JP
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 04:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36747)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hqD1k-000107-AH
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hqD1j-0000h7-1z
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:53:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:64576)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hqD1i-0000g1-Q3
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:53:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jul 2019 01:53:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,302,1559545200"; d="scan'208";a="197429486"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2019 01:53:32 -0700
Date: Wed, 24 Jul 2019 16:53:08 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <20190724085308.GA12530@richard>
References: <20190724070307.12568-1-richardw.yang@linux.intel.com>
 <1382557614.4041474.1563953302894.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1382557614.4041474.1563953302894.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
Subject: Re: [Qemu-devel] [PATCH] docs/nvdimm: add example on persistent
 backend setup
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, mst@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 24, 2019 at 03:28:22AM -0400, Pankaj Gupta wrote:
>
>> 
>> Persistent backend setup requires some knowledge about nvdimm and ndctl
>> tool. Some users report they may struggle to gather these knowledge and
>> have difficulty to setup it properly.
>> 
>> Here we provide two examples for persistent backend and gives the link
>> to ndctl. By doing so, user could try it directly and do more
>> investigation on persistent backend setup with ndctl.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  docs/nvdimm.txt | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>> 
>> diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
>> index b531cacd35..baba7a940d 100644
>> --- a/docs/nvdimm.txt
>> +++ b/docs/nvdimm.txt
>> @@ -171,6 +171,32 @@ guest software that this vNVDIMM device contains a
>> region that cannot
>>  accept persistent writes. In result, for example, the guest Linux
>>  NVDIMM driver, marks such vNVDIMM device as read-only.
>>  
>> +Backend File Setup Example
>> +..........................
>> +
>> +Here is two examples for how to setup these persistent backend on
>> +linux, which leverages the tool ndctl [3].
>> +
>> +It is easy to setup DAX device backend file.
>> +
>> +A. DAX device
>> +
>> +    ndctl create-namespace -f -e namespace0.0 -m devdax
>> +
>> +The /dev/dax0.0 could be used directly in "mem-path" option.
>> +
>> +For DAX file, it is more than creating the proper namespace. The
>> +block device should be partitioned and mounted (with dax option).
>> +
>> +B. DAX file
>> +
>> +    ndctl create-namespace -f -e namespace0.0 -m fsdax
>> +    (partition /dev/pmem0 with name pmem0p1)
>> +    mount -o dax /dev/pmem0p1 /mnt
>> +    (dd a file with proper size in /mnt)
>

Hi, Pankaj

Thanks for your comment.

>This namespace is for filesystem DAX? What if user wants to create namespace for
>device DAX to be used as persistent backend?
>

User could choose the type (devdax/fsdax) in ndctl command line with -m
option.

>Does this makes sense to mention about by default namespace created on persistent
>backend?
>

I don't get your point. Here is an example to let user know how to create
persistent backend. In case they want to get more control about the backend,
they can refer to the ndctl link. 

You mean it is not proper to mention the backend setup example in the
document? We found many users come to us for how to setup it, so we decide to
add this section.

Do you have other option?

>Thanks,
>Pankaj
>
>> +
>> +Then the new file in /mnt could be used in "mem-path" option.
>> +
>>  NVDIMM Persistence
>>  ------------------
>>  
>> @@ -212,3 +238,5 @@ References
>>      https://www.snia.org/sites/default/files/technical_work/final/NVMProgrammingModel_v1.2.pdf
>>  [2] Persistent Memory Development Kit (PMDK), formerly known as NVML
>>  project, home page:
>>      http://pmem.io/pmdk/
>> +[3] ndctl-create-namespace - provision or reconfigure a namespace
>> +    http://pmem.io/ndctl/ndctl-create-namespace.html
>> --
>> 2.17.1
>> 
>> 
>> 

-- 
Wei Yang
Help you, Help me

