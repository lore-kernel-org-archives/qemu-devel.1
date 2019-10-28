Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392CDCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 02:06:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB2820717
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 02:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB2820717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOuQG-0005iS-5S
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 22:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iOuPX-0005Bg-7f
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 22:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iOuPV-0004RF-Dl
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 22:05:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:26908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iOuPV-0004Ke-5y
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 22:05:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Oct 2019 19:05:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,238,1569308400"; d="scan'208";a="400677972"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.179])
 ([10.239.196.179])
 by fmsmga006.fm.intel.com with ESMTP; 27 Oct 2019 19:05:22 -0700
Subject: Re: [PATCH v13 06/12] numa: Extend CLI to provide memory latency and
 bandwidth information
To: Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20191020111125.27659-1-tao3.xu@intel.com>
 <20191020111125.27659-7-tao3.xu@intel.com>
 <20191023172854.42c495d5@redhat.com>
 <9e30d8fe-7274-4ee8-3c4b-64c370141358@intel.com>
 <20191025152720.4068bfae@redhat.com> <87wocsobil.fsf@dusky.pond.sub.org>
 <20191025205141.GF6744@habkost.net>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <71543104-7254-c25e-e87c-d73a894bcc2e@intel.com>
Date: Mon, 28 Oct 2019 10:05:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025205141.GF6744@habkost.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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
Cc: "Liu, Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/2019 4:51 AM, Eduardo Habkost wrote:
> On Fri, Oct 25, 2019 at 09:44:50PM +0200, Markus Armbruster wrote:
>> Igor Mammedov <imammedo@redhat.com> writes:
>>
>>> On Fri, 25 Oct 2019 14:33:53 +0800
>>> Tao Xu <tao3.xu@intel.com> wrote:
>>>
>>>> On 10/23/2019 11:28 PM, Igor Mammedov wrote:
>>>>> On Sun, 20 Oct 2019 19:11:19 +0800
>>>>> Tao Xu <tao3.xu@intel.com> wrote:
>>>> [...]
>>>>>> +#
>>>>>> +# @access-bandwidth: access bandwidth (MB/s)
>>>>>> +#
>>>>>> +# @read-bandwidth: read bandwidth (MB/s)
>>>>>> +#
>>>>>> +# @write-bandwidth: write bandwidth (MB/s)
>>>>> I think units here are not appropriate, values stored in fields are
>>>>> minimal base units only and nothing else (i.e. ps and B/s)
>>>>>    
>>>> Eric suggest me to drop picoseconds. So here I can use ns. For
>>>> bandwidth, if we use B/s here, does it let user or developer to
>>>> misunderstand that the smallest unit is B/s ?
>>>
>>> It's not nanoseconds or MB/s stored in theses fields, isn't it?
>>> I'd specify units in which value is stored or drop units altogether.
>>>
>>> Maybe Eric and Markus can suggest a better way to describe fields.
>>
>> This isn't review (yet), just an attempt to advise more quickly on
>> general QAPI/QMP conventions.
>>
>> Unit prefixes like Mebi- are nice for humans, because 1MiB is clearer
>> than 1048576B.
>>
>> QMP is for machines.  We eschew unit prefixes and unit symbols there.
>> The unit is implied.  Unit prefixes only complicate things.  Machines
>> can deal with 1048576 easily.  Also dealing 1024Ki and 1Mi is additional
>> work.  We therefore use JSON numbers for byte counts, not strings with
>> units.
>>
>> The general rule is "always use the plainest implied unit that would
>> do."  There are exceptions, mostly due to review failure.
>>
>> Byte rates should be in bytes per second.
>>
>> For time, we've made a godawful mess.  The plainest unit is clearly the
>> second.  We commonly need sub-second granularity, though.
>> Floating-point seconds are unpopular for some reason :)  Instead we use
>> milli-, micro-, and nanoseconds, and even (seconds, microseconds) pairs.
>>
>> QAPI schema documentation describes both the generated C and the QMP
>> wire protocol.  It must be written with the implied unit.  If you send a
>> byte rate in bytes per second via QMP, that's what you document.  Even
>> if a human interface lets you specify the byte rate in MiB/s.
>>
>> Does this make sense?
> 
> This makes sense for the bandwidth fields.  We still need to
> decide how to represent the latency field, though.
> 
> Seconds would be the obvious choice, if only it didn't risk
> silently losing precision when converting numbers to floats.
> 
Got it. I will use bytes per second for bandwidth here. Usually we use 
nanosecond for memory latency, so if we use second for latency, it may 
lose precision. So can I use nanosecond here, because we now use 
nanosecond as smallest time unit.

