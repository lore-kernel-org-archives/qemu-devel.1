Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69D2C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 07:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD466207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 07:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD466207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56041 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYn8R-00011c-Nt
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 03:48:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hYn7Q-0000fq-5G
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 03:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hYn7P-0007Fm-7n
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 03:47:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:2333)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hYn7O-00077i-Vr
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 03:47:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 Jun 2019 00:47:18 -0700
X-ExtLoop1: 1
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.163])
	([10.239.196.163])
	by orsmga004.jf.intel.com with ESMTP; 06 Jun 2019 00:47:15 -0700
To: Igor Mammedov <imammedo@redhat.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
	<20190508061726.27631-9-tao3.xu@intel.com>
	<20190605164045.12bf194c@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <58e8adc3-18f1-04a6-2c92-baa234293a6f@intel.com>
Date: Thu, 6 Jun 2019 15:47:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605164045.12bf194c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.115
Subject: Re: [Qemu-devel] [PATCH v4 08/11] numa: Extend the command-line to
 provide memory latency and bandwidth information
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
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, jingqi.liu@intel.com,
	qemu-devel@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/2019 10:40 PM, Igor Mammedov wrote:
> On Wed,  8 May 2019 14:17:23 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
> 
>> From: Liu Jingqi <jingqi.liu@intel.com>
>>
>> Add -numa hmat-lb option to provide System Locality Latency and
>> Bandwidth Information. These memory attributes help to build
>> System Locality Latency and Bandwidth Information Structure(s)
>> in ACPI Heterogeneous Memory Attribute Table (HMAT).
>>
>> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
...
>> +##
>> +{ 'struct': 'NumaHmatLBOptions',
>> +  'data': {
>> +   'initiator': 'uint16',
>> +   'target': 'uint16',
>> +   'hierarchy': 'HmatLBMemoryHierarchy',
>> +   'data-type': 'HmatLBDataType',
> I think union will be better here with data-type used as discriminator,
> on top of that you'll be able to drop a bit of error checking above since
> QAPI's union will not allow user to mix latency and bandwidth.
> 
Hi Igor,

I have quesion here, the 'hmat-lb' is a member of a union 'NumaOptions', 
it seems can' use a union as a member of union.

