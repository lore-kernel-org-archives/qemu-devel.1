Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18B9C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 05:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B026E2073D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 05:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B026E2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htQMk-0001MF-Rd
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 01:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40606)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1htQMI-0000wQ-6e
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 01:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1htQMH-0007BM-84
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 01:44:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:15822)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1htQMG-0007Am-Vy
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 01:44:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Aug 2019 22:44:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,337,1559545200"; d="scan'208";a="175480436"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga003.jf.intel.com with ESMTP; 01 Aug 2019 22:44:01 -0700
Date: Fri, 2 Aug 2019 13:43:38 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190802054338.GA15295@richard>
References: <20190802020716.11985-1-richardw.yang@linux.intel.com>
 <87a7csm965.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7csm965.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: Re: [Qemu-devel] [PATCH] hmp/info_migration: formatting migration
 capability output
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
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 02, 2019 at 07:24:34AM +0200, Markus Armbruster wrote:
>Subject doesn't quite conform to conventions.  Suggest
>
>    hmp: Improve how "info migrate" formats capabilities

Thanks

>
>Wei Yang <richardw.yang@linux.intel.com> writes:
>
>> Current we put all migration capability in one line, which make it hard
>> to read them and someone them are missed due to terminal width.
>>
>> This patch formats it to print 4 in one line, which looks like this now:
>>
>> capabilities:
>>               xbzrle: off         rdma-pin-all: off        auto-converge: off          zero-blocks: off
>>             compress:  on               events: off         postcopy-ram: off               x-colo: off
>>          release-ram: off                block: off          return-path: off pause-before-switchover: off
>>              multifd: off        dirty-bitmaps: off   postcopy-blocktime: off  late-block-activate: off
>>      x-ignore-shared: off
>>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  monitor/hmp-cmds.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
>> index 5ca3ebe942..29ce5b73e4 100644
>> --- a/monitor/hmp-cmds.c
>> +++ b/monitor/hmp-cmds.c
>> @@ -229,9 +229,13 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>>  
>>      /* do not display parameters during setup */
>>      if (info->has_status && caps) {
>> +        int index = 0;
>>          monitor_printf(mon, "capabilities: ");
>> -        for (cap = caps; cap; cap = cap->next) {
>> -            monitor_printf(mon, "%s: %s ",
>> +        for (cap = caps; cap; cap = cap->next, index++) {
>> +            if (!(index % 4)) {
>> +                monitor_printf(mon, "\n");
>> +            }
>> +            monitor_printf(mon, "%20s: %3s ",
>>                             MigrationCapability_str(cap->value->capability),
>>                             cap->value->state ? "on" : "off");
>>          }
>
>This assumes migration capability names are at most 20 characters long.
>late-block-activate is pushing it already: 19 characters.
>
>It adds up to 104 characters per line, which is rather wide.
>
>What about putting each capability on its own line, just like globals,
>and just like "info migrate_capabilities"?
>
>(qemu) info migrate
>globals:
>store-global-state: on
>only-migratable: off
>send-configuration: on
>send-section-footer: on
>decompress-error-check: on
>clear-bitmap-shift: 18
>capabilities:
>xbzrle: off
>rdma-pin-all: off
>auto-converge: off
>[...]

This looks good, while would reader may feel difficult to clarify from which
one the capabilities stops. 

How about add 4 space at the beginning of each capability?

Would the output be too long? How about wrap two capability into one line?

-- 
Wei Yang
Help you, Help me

