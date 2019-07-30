Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C67C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 00:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6FF206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 00:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6FF206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsGNp-0002rU-Gm
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 20:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33873)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hsGNF-0002On-Ar
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 20:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hsGNE-0000qe-5i
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 20:52:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:58124)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hsGND-0000pr-TB
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 20:52:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jul 2019 17:52:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,324,1559545200"; d="scan'208";a="182955904"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga002.jf.intel.com with ESMTP; 29 Jul 2019 17:52:12 -0700
Date: Tue, 30 Jul 2019 08:51:50 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190730005150.GA27925@richard>
References: <20190724070307.12568-1-richardw.yang@linux.intel.com>
 <20190729135859.GD6771@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729135859.GD6771@stefanha-x1.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
Cc: qemu-devel@nongnu.org, ross.zwisler@linux.intel.com,
 xiaoguangrong.eric@gmail.com, Wei Yang <richardw.yang@linux.intel.com>,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Stefan

Thanks for your comments :-)

On Mon, Jul 29, 2019 at 02:58:59PM +0100, Stefan Hajnoczi wrote:
>On Wed, Jul 24, 2019 at 03:03:07PM +0800, Wei Yang wrote:
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
>> @@ -171,6 +171,32 @@ guest software that this vNVDIMM device contains a region that cannot
>>  accept persistent writes. In result, for example, the guest Linux
>>  NVDIMM driver, marks such vNVDIMM device as read-only.
>>  
>> +Backend File Setup Example
>> +..........................

Here I use '-' because I want to say this is a sub-section of "Guest Data
Persistence".

Actually, I struggled a little to pick up a proper character. Do you think '-'
is the proper one?

>
>For consistency with the rest of the document please use '-' instead of
>'.'.
>
>> +
>> +Here is two examples for how to setup these persistent backend on
>> +linux, which leverages the tool ndctl [3].
>
>Small grammar tweaks:
>
>  Here are two examples showing how to set up persistent backends on
>  Linux using the tool ndctl [3].
>
>> +
>> +It is easy to setup DAX device backend file.
>
>Please move this into the "A. DAX device" section and use it as an
>introduction to explain what this section is about:
>
>  Use the following command to set up /dev/dax0.0 so that the entirety
>  of namespace0.0 can be exposed as an emulated NVDIMM to the guest:
>
>> +
>> +A. DAX device
>> +
>> +    ndctl create-namespace -f -e namespace0.0 -m devdax
>> +
>> +The /dev/dax0.0 could be used directly in "mem-path" option.
>> +
>> +For DAX file, it is more than creating the proper namespace. The
>> +block device should be partitioned and mounted (with dax option).
>
>Please move this into "B. DAX file":
>
>  Individual files on a DAX host file system can be exposed as emulated
>  NVDIMMS.  First an fsdax block device is created, partitioned, and
>  then mounted with the "dax" mount option:
>
>> +
>> +B. DAX file
>> +
>> +    ndctl create-namespace -f -e namespace0.0 -m fsdax
>> +    (partition /dev/pmem0 with name pmem0p1)
>> +    mount -o dax /dev/pmem0p1 /mnt
>> +    (dd a file with proper size in /mnt)
>
>"dd a file" could be "create or copy a disk image file with qemu-img(1),
>cp(1), or dd(1) in /mnt".



-- 
Wei Yang
Help you, Help me

