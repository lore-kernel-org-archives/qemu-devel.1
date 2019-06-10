Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7901CC28CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BA420859
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BA420859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46576 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haKWw-0002GF-Fs
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 09:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48413)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1haKWD-0001p4-RE
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1haKWC-0002rY-IH
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:39:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:45744)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1haKWC-0002mp-AC
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:39:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jun 2019 06:39:14 -0700
X-ExtLoop1: 1
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.249.170.251])
 ([10.249.170.251])
 by fmsmga001.fm.intel.com with ESMTP; 10 Jun 2019 06:39:13 -0700
From: Tao Xu <tao3.xu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
 <20190508061726.27631-8-tao3.xu@intel.com>
 <20190604170456.5b3c198e@redhat.com>
 <729bde4a-bcb9-dac5-3a8a-04cc5f4d2bf9@intel.com>
 <20190605140841.63e8aa85@redhat.com>
 <02c9615a-fb59-664f-e878-124c9f43e54a@intel.com>
 <20190606184507.2c52cd41@redhat.com>
Message-ID: <9159f119-0a98-bb6b-93c1-de64a3b1580a@intel.com>
Date: Mon, 10 Jun 2019 21:39:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606184507.2c52cd41@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
Subject: Re: [Qemu-devel] [PATCH v4 07/11] hmat acpi: Build Memory Side
 Cache Information Structure(s) in ACPI HMAT
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
Cc: "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 "mst@redhat.com" <mst@redhat.com>, "Liu, Jingqi" <jingqi.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/2019 12:45 AM, Igor Mammedov wrote:
> On Thu, 6 Jun 2019 11:00:33 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
> 
...
>>
>> But the kernel HMAT can read othe Memory Side Cache Information except
>> SMBIOS entries and the host HMAT tables also haven’t SMBIOS Handles it
>> also shows Number of SMBIOS handles (n) as 0. So I am wondering if it is
>> better to setting "SMBIOS handles (n)" as 0, remove TODO and comment the
>> reason why set it 0?
> 
> My understanding is that SMBIOS handles are used to associate side cache
> descriptions with RAM pointed by SMBIOS handles, so that OS would be
> able to figure out what RAM modules are cached by what cache.
> Hence I suspect that side cache table is useless in the best case without
> valid references to SMBIOS handles.
> (I might be totally mistaken but the matter requires clarification before
> we commit to it)
> 

I am sorry for not providing a detailed description for Memory Side 
Cache use case. I will add more detailed description in next version of 
patch.

As the commit message and /Documentation/admin-guide/mm/numaperf.rst of 
Kernel HMAT(listed blow), Memory Side Cache Structure is used to provide 
the cache information about System memory for the software to use. Then 
the software can maximize the performance because it can choose the best 
node to use.

Memory Side Cache Information Structure and System Locality Latency and 
Bandwidth Information Structure can both provide more information than 
numa distance for software to see. So back to the SMBIOS, in spec, 
SMBIOS handles point to the memory side cache physical devices, but they 
are also information and not contribute to the performance of the 
described memory. The field "Proximity Domain for the Memory" can show 
the described memory.

I am wondering if this explanation is clear? Thank you.

"System memory may be constructed in a hierarchy of elements with 
various performance characteristics in order to provide large address 
space of slower performing memory cached by a smaller higher performing 
memory."

"An application does not need to know about caching attributes in order
to use the system. Software may optionally query the memory cache
attributes in order to maximize the performance out of such a setup.
If the system provides a way for the kernel to discover this 
information, for example with ACPI HMAT (Heterogeneous Memory Attribute 
Table), the kernel will append these attributes to the NUMA node memory 
target."

"Each cache level's directory provides its attributes. For example, the
following shows a single cache level and the attributes available for
software to query::

	# tree sys/devices/system/node/node0/memory_side_cache/
	/sys/devices/system/node/node0/memory_side_cache/
	|-- index1
	|   |-- indexing
	|   |-- line_size
	|   |-- size
	|   `-- write_policy
"

