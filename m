Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC5DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 01:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96BDF20679
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 01:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96BDF20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN5k2-0005BC-JP
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 21:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iN5jH-0004VG-5w
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 21:46:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iN5jF-0002RU-Hg
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 21:46:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:44630)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iN5jF-0002PP-8R
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 21:46:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Oct 2019 18:46:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,218,1569308400"; d="scan'208";a="188097350"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.6])
 ([10.239.197.6])
 by orsmga007.jf.intel.com with ESMTP; 22 Oct 2019 18:46:14 -0700
Subject: Re: [PATCH v13 00/12] Build ACPI Heterogeneous Memory Attribute Table
 (HMAT)
To: Markus Armbruster <armbru@redhat.com>
References: <20191020111125.27659-1-tao3.xu@intel.com>
 <87v9sh10tx.fsf@dusky.pond.sub.org>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <8be8daa7-fad8-cf7a-28a0-a52ef2ab83fc@intel.com>
Date: Wed, 23 Oct 2019 09:46:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87v9sh10tx.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/2019 7:22 PM, Markus Armbruster wrote:
> I just stumbled over this series.  It touches the QAPI visitors and even
> the generator, without cc'ing its maintainers.  Such changes require
> review.  There's precious little time until the soft freeze now.  I'll
> try, but no promises.
> 
> Please cc me and Michael Roth <mdroth@linux.vnet.ibm.com> on future
> revisions.
> 
> In general, peruse output of scripts/get_maintainer.pl to find relevant
> maintainers.

[...]
>> v10:
>>      - Add qemu_strtotime_ps() to convert strings with time suffixes
>>      to numbers, and add some tests for it.
>>      - Add qapi buildin type time, and add some tests for it.
>>      - Add machine oprion properties "-machine hmat=on|off" for
>> 	  enabling or disabling HMAT in QEMU.
> 
> I guess this is where you started messing with QAPI.  Seven weeks ago.
> The time crunch is of your own making, I'm afraid.
> 

I am sorry. I will cc all related maintainers next time.

