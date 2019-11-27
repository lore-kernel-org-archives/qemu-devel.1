Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2038AC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 04:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0F0207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 04:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0F0207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZp5e-00048U-17
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 23:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iZp53-0003ji-Dx
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 23:37:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iZp51-0003XY-7t
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 23:37:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:62449)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iZp50-0003V7-V7
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 23:37:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Nov 2019 20:37:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,248,1571727600"; d="scan'208";a="217307712"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.13])
 ([10.239.197.13])
 by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2019 20:37:24 -0800
Subject: Re: [PATCH v17 01/14] util/cutils: Add Add qemu_strtold and
 qemu_strtold_finite
To: Markus Armbruster <armbru@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
References: <20191122074826.1373-1-tao3.xu@intel.com>
 <20191122074826.1373-2-tao3.xu@intel.com>
 <8088b091-8f7c-a637-6333-e7c40935974f@intel.com>
 <87a78ispyc.fsf@dusky.pond.sub.org>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <aaac6a06-0484-ceb7-7230-77b8362744b0@intel.com>
Date: Wed, 27 Nov 2019 12:37:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <87a78ispyc.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "sw@weilnetz.de" <sw@weilnetz.de>, "Du, Fan" <fan.du@intel.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/26/2019 9:54 PM, Markus Armbruster wrote:
> Tao Xu <tao3.xu@intel.com> writes:
> 
>> Hi Markus,
>>
>> Do you have any comments on this patch and 02/14 05/14 06/14.
>> Thank you!
> 
> These provide a new QAPI built-in type 'time'.  It's like 'uint64' with
> an implied nanoseconds unit, and additional convenience syntax in the
> opts visitor and the keyval qobject input visitor.  Patterned after
> 'size'.
> 
> The only use of 'time' so far is member @latency of NumaOptions member
> @hmap-lb.  Uses of that:
> 
> * QMP command set-numa-node
> 
>    The convenience syntax does not apply, as QMP uses the regular qobject
>    input visitor, not the keyval one.
> 
> * CLI option -numa
> 
>    We first parse the option argument with QemuOpts, then convert it to
>    NumaOptions with the opts visitor.
> 
>    The new built-in type 'time' gets used in -numa hmat-lb,...,latency=T
> 
> Questions / observations:
> 
> * The keyval qobject input visitor's support for 'time' appears to be
>    unused for now.
> 
> * What's the anticipated range of values for -numa
>    hmat-lb,...,latency=T?  I'm asking because I wonder whether we really
>    need convenience syntax there.
> 
> * Sure you want fractions?
> 
>    Supporting fractions for byte counts (e.g.  1.5G) has been a mixed
>    blessing, to put it charitably.
> 
>    Use of fractions that aren't representable as double is not advisable.
>    For instance, 1.1G is 1181116006 bytes rounded from
>    1181116006.4000001.  Why would anybody want that?
> 
>    Use of "nice" fractions is unproblematic, but the additional
>    convenience is rather minor.  Is being able to write 1536M as 1.5G
>    worth the trouble?  Meh.
> 
>    With "metric" rather than "binary" suffixes, fractions provide even
>    less convenience: 1.5ms vs. 1500us.
> 
>    The implementation is limited to 53 bits of precision, which has been
>    a source of confusion.  Even that has arguably taken far more patches
>    than it's worth.  We're now talking about more patches to lift the
>    restriction.  Meh.
> 
>    What exactly are we trying to achieve by supporting fractions?
> 
> * What about all the other time-valued things in the QAPI schema?
> 
>    There are many more, and some of them are also visible in CLI or HMP.
>    By providing convenience syntax for just -numa hmat-lb,...,latency=T,
>    we create inconsistency.
> 
>    To avoid it, we'd have to hunt down all the others.  But some of them
>    aren't in nanoseconds.  Your new built-in type 'time' is only
>    applicable to the ones in nanoseconds.  Do we need more built-in
>    types?
> 
> This series is at v17.  I really, really want to tell you it's ready for
> merging.  But as you see, I can't.
> 
> Maybe the convenience syntax is a good idea, maybe it's a bad idea.  But
> it's definitely not a must-have idea.
> 
> If you want to pursue the idea, I recommend to split this series in two:
> one part without the convenience, and a second part adding it.
> Hopefully, we can then merge the first part without too much fuss.  The
> second part will have to deal with the questions above.
> 
> You can also shelve the idea, i.e. do just the first part now.  It's
> what I'd do.
> 
Thank you for your suggestion and support! Considering ACPI HMAT can 
only store unsigned integer data, and for the memory latency nanoseconds 
is enough. So we can use integer for latency data. I am wondering if we 
can use this solution:

* Still add builtin type time, but use qemu_strtou64() to parse.
* Still refactor do_strtosz() to support suffixes list, but add a extra 
parameter to decide use qemu_strtou64() or qemu_strtod_finite(), so time 
use qemu_strtou64() and qemu_strtod_finite()
* Second part dealing with the questions.

Then the only influence on HMAT patch is we need add a comments to tell 
user to input integer.



