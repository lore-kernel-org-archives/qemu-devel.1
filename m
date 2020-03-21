Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA2CC4332D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BAE520658
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAE520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFcF0-00045h-Ai
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 07:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jFcEN-0003gc-Ov
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jFcEM-0004V0-Aq
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:23:55 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:37502)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jFcEL-0004Mx-Ns
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:23:54 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by
 rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5e75f91e457-52226;
 Sat, 21 Mar 2020 19:23:12 +0800 (CST)
X-RM-TRANSID: 2eeb5e75f91e457-52226
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.43.82] (unknown[117.136.68.181])
 by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25e75f91fcea-6b2dc;
 Sat, 21 Mar 2020 19:23:12 +0800 (CST)
X-RM-TRANSID: 2ee25e75f91fcea-6b2dc
Subject: Re: [PATCH] monitor/hmp-cmds: fix bad indentation in 'info
 migrate_parameters' cmd output
To: Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200320130013.418557-1-maozhongyi@cmss.chinamobile.com>
 <878sjv11xm.fsf@dusky.pond.sub.org> <20200320173117.GE3464@work-vm>
 <20200320174901.GO2608355@redhat.com> <20200320180700.GF3464@work-vm>
 <87mu8auqlc.fsf@dusky.pond.sub.org>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <bb6a4634-f38c-a8f0-0a8c-fcf193b818db@cmss.chinamobile.com>
Date: Sat, 21 Mar 2020 19:23:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87mu8auqlc.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 3/21/20 3:14 PM, Markus Armbruster wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>
>> * Daniel P. Berrangé (berrange@redhat.com) wrote:
>>> On Fri, Mar 20, 2020 at 05:31:17PM +0000, Dr. David Alan Gilbert wrote:
>>>> (Rearranging the text a bit)
>>>>
>>>> * Markus Armbruster (armbru@redhat.com) wrote:
>>>>
>>>>> David (cc'ed) should be able to tell us which fix is right.
>>>>>
>>>>> @tls_creds and @tls_hostname look like they could have the same issue.
>>>> A certain Markus removed the Null checks in 8cc99dc because 4af245d
>>>> guaranteed they would be None-Null for tls-creds/hostname - so we
>>>> should be OK for those.
>>>>
>>>> But tls-authz came along a lot later in d2f1d29 and doesn't
>>>> seem to have the initialisation, which is now in
>>>> migration_instance_init.
>>>>
>>>> So I *think* the fix for this is to do the modern equivalent of 4af245d
>>>> :
>>>>
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index c1d88ace7f..0bc1b93277 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -3686,6 +3686,7 @@ static void migration_instance_init(Object *obj)
>>>>   
>>>>       params->tls_hostname = g_strdup("");
>>>>       params->tls_creds = g_strdup("");
>>>> +    params->tls_authz = g_strdup("");
>>>>   
>>>>       /* Set has_* up only for parameter checks */
>>>>       params->has_compress_level = true;
>>>>
>>>> Copying in Dan to check that wouldn't break tls.
>>> It *will* break TLS, because it will cause the TLS code to lookup
>>> an object with the ID of "".  NULL must be preserved when calling
>>> the TLS APIs.
>> OK, good I asked...
>>
>>> The assignment of "" to tls_hostname would also have broken TLS,
>>> so the migration_tls_channel_connect method had to turn it back
>>> into a real NULL.
>>>
>>> The use of "" for tls_creds will similarly cause it to try and
>>> lookup an object with ID of "", and fail. That one's harmless
>>> though, because it would also fail if it were NULL.
>> OK.
>>
>> It looks like the output of query-migrate-parameters though already
>> turns it into "", so I don't think you can tell it's NULL from that:
>>
>> {"QMP": {"version": {"qemu": {"micro": 0, "minor": 2, "major": 4}, "package": "qemu-4.2.0-4.fc31"}, "capabilities": ["oob"]}}
>> { "execute": "qmp_capabilities" }
>> {"return": {}}
>> { "execute": "query-migrate-parameters" }
>> {"return": {"xbzrle-cache-size": 67108864, "cpu-throttle-initial": 20, "announce-max": 550, "decompress-threads": 2, "compress-threads": 8, "compress-level": 1, "multifd-channels": 2, "announce-initial": 50, "block-incremental": false, "compress-wait-thread": true, "downtime-limit": 300, "tls-authz": "", "announce-rounds": 5, "announce-step": 100, "tls-creds": "", "max-cpu-throttle": 99, "max-postcopy-bandwidth": 0, "tls-hostname": "", "max-bandwidth": 33554432, "x-checkpoint-delay": 20000, "cpu-throttle-increment": 10}}
>>
>> I'm not sure who turns a Null into a "" but I guess it's somewhere in
>> the json output iterator.
> It's this wart:
>
>      static void qobject_output_type_str(Visitor *v, const char *name, char **obj,
>                                          Error **errp)
>      {
>          QObjectOutputVisitor *qov = to_qov(v);
>          if (*obj) {
>              qobject_output_add(qov, name, qstring_from_str(*obj));
>          } else {
>              qobject_output_add(qov, name, qstring_from_str(""));
>          }
>      }
>
> Warty since day 1.
>
> In theory, !*obj should not happen, since QAPI type 'str' is not
> nullable.
>
> In practice, it handwritten code can easily make it happen.
>
>> So we can fix this problem either in qmp_query_migrate_parameters
>> and just strdup a "", or substitute it in hmp_info_migrate_parameters.
> Fixing it in qmp_query_migrate_parameters() is cleaner: it avoids null
> 'str', and bypasses the wart.
>
OK,  thanks for the kind reply, will fix it in v2.

Thanks,
Mao



