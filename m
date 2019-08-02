Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595CAC32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 12:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305DC2183F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 12:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305DC2183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34279 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htWQP-0007eZ-Fw
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 08:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35137)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1htWQ0-0007Ed-Us
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 08:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1htWPz-0004AX-Od
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 08:12:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1htWPz-00049p-HE
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 08:12:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BDB55285AE;
 Fri,  2 Aug 2019 12:12:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 767AF5D9D3;
 Fri,  2 Aug 2019 12:12:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D671E1138619; Fri,  2 Aug 2019 14:12:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190802020716.11985-1-richardw.yang@linux.intel.com>
 <87a7csm965.fsf@dusky.pond.sub.org> <20190802054338.GA15295@richard>
Date: Fri, 02 Aug 2019 14:12:16 +0200
In-Reply-To: <20190802054338.GA15295@richard> (Wei Yang's message of "Fri, 2
 Aug 2019 13:43:38 +0800")
Message-ID: <87wofvix5r.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 02 Aug 2019 12:12:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wei Yang <richardw.yang@linux.intel.com> writes:

> On Fri, Aug 02, 2019 at 07:24:34AM +0200, Markus Armbruster wrote:
>>Subject doesn't quite conform to conventions.  Suggest
>>
>>    hmp: Improve how "info migrate" formats capabilities
>
> Thanks
>
>>
>>Wei Yang <richardw.yang@linux.intel.com> writes:
>>
>>> Current we put all migration capability in one line, which make it hard
>>> to read them and someone them are missed due to terminal width.
>>>
>>> This patch formats it to print 4 in one line, which looks like this now:
>>>
>>> capabilities:
>>>               xbzrle: off         rdma-pin-all: off        auto-converge: off          zero-blocks: off
>>>             compress:  on               events: off         postcopy-ram: off               x-colo: off
>>>          release-ram: off                block: off          return-path: off pause-before-switchover: off
>>>              multifd: off        dirty-bitmaps: off   postcopy-blocktime: off  late-block-activate: off
>>>      x-ignore-shared: off
>>>
>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>> ---
>>>  monitor/hmp-cmds.c | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
>>> index 5ca3ebe942..29ce5b73e4 100644
>>> --- a/monitor/hmp-cmds.c
>>> +++ b/monitor/hmp-cmds.c
>>> @@ -229,9 +229,13 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>>>  
>>>      /* do not display parameters during setup */
>>>      if (info->has_status && caps) {
>>> +        int index = 0;
>>>          monitor_printf(mon, "capabilities: ");
>>> -        for (cap = caps; cap; cap = cap->next) {
>>> -            monitor_printf(mon, "%s: %s ",
>>> +        for (cap = caps; cap; cap = cap->next, index++) {
>>> +            if (!(index % 4)) {
>>> +                monitor_printf(mon, "\n");
>>> +            }
>>> +            monitor_printf(mon, "%20s: %3s ",
>>>                             MigrationCapability_str(cap->value->capability),
>>>                             cap->value->state ? "on" : "off");
>>>          }
>>
>>This assumes migration capability names are at most 20 characters long.
>>late-block-activate is pushing it already: 19 characters.
>>
>>It adds up to 104 characters per line, which is rather wide.
>>
>>What about putting each capability on its own line, just like globals,
>>and just like "info migrate_capabilities"?
>>
>>(qemu) info migrate
>>globals:
>>store-global-state: on
>>only-migratable: off
>>send-configuration: on
>>send-section-footer: on
>>decompress-error-check: on
>>clear-bitmap-shift: 18
>>capabilities:
>>xbzrle: off
>>rdma-pin-all: off
>>auto-converge: off
>>[...]
>
> This looks good, while would reader may feel difficult to clarify from which
> one the capabilities stops. 
>
> How about add 4 space at the beginning of each capability?
>
> Would the output be too long? How about wrap two capability into one line?

Perhaps David has a preference.

