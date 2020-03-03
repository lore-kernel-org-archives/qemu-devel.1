Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A757C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1CE2467E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1CE2467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vHj-0000W1-5p
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:19:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1j8vH9-00006m-Vl
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:19:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1j8vH8-0002Xl-5f
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:19:07 -0500
Received: from mga17.intel.com ([192.55.52.151]:39107)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1j8vH7-0002XL-Tf
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:19:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Mar 2020 16:19:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,509,1574150400"; d="scan'208";a="233392153"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.238.4.86])
 ([10.238.4.86])
 by orsmga008.jf.intel.com with ESMTP; 02 Mar 2020 16:19:00 -0800
Subject: Re: [PATCH v3 2/4] target/i386: Remove monitor from some CPU models
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200212081328.7385-1-tao3.xu@intel.com>
 <20200212081328.7385-3-tao3.xu@intel.com>
 <20200228213909.GA481504@habkost.net>
 <06a6cd99-7d11-7eee-c337-c71e756fc53f@intel.com>
 <20200302171901.GI4440@habkost.net>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <37b090a9-234d-834f-0c48-70c62787d517@intel.com>
Date: Tue, 3 Mar 2020 08:18:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302171901.GI4440@habkost.net>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/3/2020 1:19 AM, Eduardo Habkost wrote:
> On Mon, Mar 02, 2020 at 07:47:28PM +0800, Tao Xu wrote:
>> On 2/29/2020 5:39 AM, Eduardo Habkost wrote:
>>> On Wed, Feb 12, 2020 at 04:13:26PM +0800, Tao Xu wrote:
>>>> Add new version of Snowridge, Denverton, Opteron_G3, EPYC, and Dhyana
>>>> CPU model to uremove MONITOR/MWAIT featre.
>>>>
>>>> After QEMU/KVM use "-overcommit cpu-pm=on" to expose MONITOR/MWAIT
>>>> (commit id 6f131f13e68d648a8e4f083c667ab1acd88ce4cd), the MONITOR/MWAIT
>>>> feature in these CPU model is unused.
>>>>
>>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>>>
>>> What exactly is the problem you are trying to fix?
>>>
>>> No CPU model will ever have monitor=on set by default with KVM,
>>> because kvm_default_props has a monitor=off element.
>>>
>>
>> Maybe it is not a fix. For example, when we boot a guest with Denverton
>> cpu model, guest cannot detect MONITOR/MWAIT and boot with no warning,
>> because of "monitor=off" by default. The MONITOR/MWAIT feature in these CPU
>> model is unused,but no harm. I am wondering if we should remove it from
>> existing CPU models.
> 
> As monitor=off is on kvm_default_props, changing the CPU model
> table will only affect other accelerators (e.g. TCG, where
> MONITOR/MWAIT support is advertised as supported).
> 
> We shouldn't be dictating policy for other accelerators just
> because KVM doesn't support it.  Removing the feature on
> kvm_default_props is sufficient.
> 
I understand, thanks.

