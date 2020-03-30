Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9CDC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 08:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACDE4206CC
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 08:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDE4206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIpjB-0006Wd-RG
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 04:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jIpiY-0005nt-Ll
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jIpiX-0003S4-6q
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:24:22 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:2393)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jIpiW-0003Jm-Je
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:24:21 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by
 rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea5e81ac9d4c7-0b563;
 Mon, 30 Mar 2020 16:23:57 +0800 (CST)
X-RM-TRANSID: 2eea5e81ac9d4c7-0b563
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.144.199] (unknown[112.25.154.146])
 by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15e81ac9c974-2943a;
 Mon, 30 Mar 2020 16:23:57 +0800 (CST)
X-RM-TRANSID: 2ee15e81ac9c974-2943a
Subject: Re: [PATCH v2] migration: use "" instead of (null) for tls-authz
To: Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <0a9dc2fcb78da13eb326992384bc4e57de83d9f9.1584797648.git.maozhongyi@cmss.chinamobile.com>
 <20200324100823.GB2645@work-vm> <875zemz4y7.fsf@dusky.pond.sub.org>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <4c37b60d-f296-e813-4395-7414dfcab1ba@cmss.chinamobile.com>
Date: Mon, 30 Mar 2020 16:23:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <875zemz4y7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 221.176.66.81
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Markus,

On 3/30/20 3:18 PM, Markus Armbruster wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> 
>> * Mao Zhongyi (maozhongyi@cmss.chinamobile.com) wrote:
>>> run:
>>> (qemu) info migrate_parameters
>>> announce-initial: 50 ms
>>> ...
>>> announce-max: 550 ms
>>> multifd-compression: none
>>> xbzrle-cache-size: 4194304
>>> max-postcopy-bandwidth: 0
>>>   tls-authz: '(null)'
>>>
>>> Migration parameter 'tls-authz' is used to provide the QOM ID
>>> of a QAuthZ subclass instance that provides the access control
>>> check, default is NULL. But the empty string is not a valid
>>> object ID, so use "" instead of the default. Although it will
>>> fail when lookup an object with ID "", it is harmless, just
>>> consistent with tls_creds.
>>
>> Yes, it's probably the best we can do given Dan's explanation that
>> we can't change tls_authz to be non-null.
> 
> As I explained in Message-ID: <878sjv11xm.fsf@dusky.pond.sub.org>, this
> is actually a crash bug on some systems.  The commit message neglects to
> mention that.  Too late to fix now.  Next time :)

Oops, I will continue to follow up on this issue.
> 
>>> Also fixed the bad indentation on the last line.
>>>
>>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>>> ---
>>>   migration/migration.c | 3 ++-
>>>   monitor/hmp-cmds.c    | 2 +-
>>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index c1d88ace7f..b060153ef7 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -790,7 +790,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>>>       params->has_tls_hostname = true;
>>>       params->tls_hostname = g_strdup(s->parameters.tls_hostname);
>>>       params->has_tls_authz = true;
>>> -    params->tls_authz = g_strdup(s->parameters.tls_authz);
>>> +    params->tls_authz = s->parameters.tls_authz ? \
>>> +                        g_strdup(s->parameters.tls_authz) : g_strdup("");
>>
>> The \ is unneeded; this isn't a macro; it's also a little shorter to do
>> it as:
>>      params->tls_authz = g_strdup(s->parameters.tls_authz ?
>>                                   s->parameters.tls_authz : "");
> 
> Even shorter:
> 
>        params->tls_authz = g_strdup(s->parameters.tls_authz ?: "");
> 
> ?: is a GNU C extension.  We use it all over the place.
> 
> Just FYI.  I'm *not* asking for the code to be changed.

Yes, it does look cooler, thanks for the clarification. I would prefer
to use this syntax in future patches.

Thanks,
Mao

> 
> 



