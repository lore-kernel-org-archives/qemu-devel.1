Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE892C28CC5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 03:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96928206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 03:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96928206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53454 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYih0-0000X7-PM
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 23:03:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hYidu-0006pe-14
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 23:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hYids-00041E-RF
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 23:00:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:42357)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hYids-0003tm-JT
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 23:00:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 Jun 2019 20:00:36 -0700
X-ExtLoop1: 1
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.163])
	([10.239.196.163])
	by orsmga004.jf.intel.com with ESMTP; 05 Jun 2019 20:00:34 -0700
To: Igor Mammedov <imammedo@redhat.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
	<20190508061726.27631-8-tao3.xu@intel.com>
	<20190604170456.5b3c198e@redhat.com>
	<729bde4a-bcb9-dac5-3a8a-04cc5f4d2bf9@intel.com>
	<20190605140841.63e8aa85@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <02c9615a-fb59-664f-e878-124c9f43e54a@intel.com>
Date: Thu, 6 Jun 2019 11:00:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605140841.63e8aa85@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [PATCH v4 07/11] hmat acpi: Build Memory Side
 Cache Information Structure(s) in ACPI HMAT
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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

On 6/5/2019 8:12 PM, Igor Mammedov wrote:
> On Wed, 5 Jun 2019 14:04:10 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
> 
>> On 6/4/2019 11:04 PM, Igor Mammedov wrote:
>>> On Wed,  8 May 2019 14:17:22 +0800
>>> Tao Xu <tao3.xu@intel.com> wrote:
>>>    
...
>>>> +
>>>> +                /* SMBIOS Handles */
>>>> +                /* TBD: set smbios handles */
>>>> +                build_append_int_noprefix(table_data, 0, 2 * n);
>>> Is memory side cache structure useful at all without pointing to SMBIOS entries?
>>>    
>> They are not useful yet, and the kernel 5.1 HMAT sysfs doesn't show
>> SMBIOS entries. We can update it if it useful in the future.
> 
> In that case I'd suggest to drop it for now until this table is properly
> populated and ready for consumption. (i.e. drop this patch and corresponding
> CLI 9/11 patch).
> 

But the kernel HMAT can read othe Memory Side Cache Information except 
SMBIOS entries and the host HMAT tables also haven’t SMBIOS Handles it 
also shows Number of SMBIOS handles (n) as 0. So I am wondering if it is 
better to setting "SMBIOS handles (n)" as 0, remove TODO and comment the 
reason why set it 0?

