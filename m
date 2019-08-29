Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6F5C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 13:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650302189D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 13:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650302189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3K7d-0001O8-MS
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 09:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1i3K6h-0000oF-9L
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 09:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1i3K6b-0007dR-4P
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 09:04:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43326)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1i3K6a-0007cr-Uu
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 09:04:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 103E830832DA;
 Thu, 29 Aug 2019 13:04:48 +0000 (UTC)
Received: from [10.43.2.30] (unknown [10.43.2.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D12D55C221;
 Thu, 29 Aug 2019 13:04:44 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>
References: <f307829a5e64121b5cb8ad1aefff09f41cac9699.1567070002.git.mprivozn@redhat.com>
 <87v9ugrx2k.fsf@dusky.pond.sub.org>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <f6ae646f-620d-964a-dd36-e6f636fc08da@redhat.com>
Date: Thu, 29 Aug 2019 15:04:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87v9ugrx2k.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 29 Aug 2019 13:04:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qapi: Reintroduce CommandDisabled error
 class
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
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, lcapitulino@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/29/19 2:10 PM, Markus Armbruster wrote:
> Michal Privoznik <mprivozn@redhat.com> writes:
> 
>> If there was a disabled command, then qemu-ga used to report
>> CommandDisabled error class (among with human readable
>> description). This changed in v1.2.0-rc0~28^2~16 in favor of
>> GenericError class.
> 
> Really?  I believe it was slightly earlier in the same series:
> 
> 93b91c59db qemu-ga: switch to the new error format on the wire
> de253f1491 qmp: switch to the new error format on the wire

Ah, you're right. It's the first commit that you reference.

> 
> The commit you mention (df1e608a01e) is merely follow-up simplification.
> 
>>                      While the change might work for other
>> classes, this one should not have been dropped because it helps
>> callers distinguish the root cause of the error.
>>
>> A bit of background: up until very recently libvirt used qemu-ga
>> in all or nothing way. It didn't care why a qemu-ga command
>> failed. But very recently a new API was introduced which
>> implements 'best effort' approach (in some cases) and thus
>> libvirt must differentiate between: {CommandNotFound,
>> CommandDisabled} and some generic error. While the former classes
>> mean the API can issue some other commands the latter raises a
>> red flag causing the API to fail.
> 
> Why do you need to distinguish CommandNotFound from CommandDisabled?

I don't. That's why I've put them both in curly braces. Perhaps this 
says its better:

switch (klass) {
  case CommandNotFound:
  case CommandDisabled:
        /* okay */
        break;

  default:
        /* bad, error out */
        break;
}

> 
>> This reverts df1e608a01 partially.
>>
>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>

Michal

