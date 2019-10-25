Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AECCA9EAF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 01:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECCE22064A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 01:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCE22064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNoT5-0002oA-BA
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 21:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iNoJf-0006Qf-AN
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 21:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iNoJd-0003w0-4q
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 21:22:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:49129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iNoJc-0003u3-SV
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 21:22:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Oct 2019 18:22:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,226,1569308400"; d="scan'208";a="188771367"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.142])
 ([10.239.196.142])
 by orsmga007.jf.intel.com with ESMTP; 24 Oct 2019 18:22:46 -0700
Subject: Re: [PATCH v13 01/12] util/cutils: Add qemu_strtotime_ps()
To: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191020111125.27659-1-tao3.xu@intel.com>
 <20191020111125.27659-2-tao3.xu@intel.com> <20191024095457.GD3700@redhat.com>
 <20191024132007.GP6744@habkost.net>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <a309621a-3572-b413-592a-46565d0cc1a2@intel.com>
Date: Fri, 25 Oct 2019 09:22:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024132007.GP6744@habkost.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: "Liu, Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/2019 9:20 PM, Eduardo Habkost wrote:
> On Thu, Oct 24, 2019 at 10:54:57AM +0100, Daniel P. Berrangé wrote:
>> On Sun, Oct 20, 2019 at 07:11:14PM +0800, Tao Xu wrote:
>>> To convert strings with time suffixes to numbers, support time unit are
>>> "ps" for picosecond, "ns" for nanosecond, "us" for microsecond, "ms"
>>> for millisecond or "s" for second.
>>>
>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>>> ---
>>>
>>> No changes in v13.
>>> ---
>>>   include/qemu/cutils.h |  1 +
>>>   util/cutils.c         | 82 +++++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 83 insertions(+)
>>
>> This really ought to have an addition to the unit tests to validating
>> the parsing, both success and error scenarios, so that we're clear on
>> exactly what strings are accepted & rejected.
> 
> Unit tests are in patch 02/12.  It's a good idea to squash
> patches 01 and 02 together.
> 
Yes it is in 02/12. OK I will squash them.

