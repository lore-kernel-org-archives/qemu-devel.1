Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03651C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90333217A0
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Twz7yQRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90333217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3mg-0006vI-L0
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kX3cy-0003MZ-Rk
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kX3cv-0000Wg-Vd
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603723056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lXuRNbVSFOMOuQz3o2Gzb/k3kJKt+47V6Z2hCBFuc8g=;
 b=Twz7yQRWJWW9VuOUucSWj3QACtxBgGMJuIwfmb3hb2UwKtPnyytNFqYdEuC5PD2rKPlfMc
 A9BelqVWgoFrDrmhDosmZDPpBK3QQJAbMe3pg+cGxSPN+SpvNPDLu/7zvEFyOwnTqDQ44C
 yKUfCBeH6Q41ctKvjhfwKynilrdILBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-M5cGUoI6OVKl9I71xK7u4w-1; Mon, 26 Oct 2020 10:37:35 -0400
X-MC-Unique: M5cGUoI6OVKl9I71xK7u4w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E50C2809DC5;
 Mon, 26 Oct 2020 14:37:33 +0000 (UTC)
Received: from [10.3.112.145] (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 46E775D9E4;
 Mon, 26 Oct 2020 14:37:29 +0000 (UTC)
Subject: Re: [PATCH v5 02/12] qapi: Make QAPI_LIST_ADD() public
To: Markus Armbruster <armbru@redhat.com>
References: <20201023183652.478921-1-eblake@redhat.com>
 <20201023183652.478921-3-eblake@redhat.com>
 <87v9ex3vzl.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <19e7105e-534e-7e4e-702f-3227a5f714e7@redhat.com>
Date: Mon, 26 Oct 2020 09:37:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87v9ex3vzl.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 rjones@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 9:25 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> We have a useful macro for inserting at the front of any
>> QAPI-generated list; move it from block.c to qapi/util.h so more
>> places can use it, including one earlier place in block.c.
>>
>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  include/qapi/util.h |  8 ++++++++
>>  block.c             | 15 +++------------
>>  2 files changed, 11 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/qapi/util.h b/include/qapi/util.h
>> index 50201896c7a4..b6083055ce69 100644
>> --- a/include/qapi/util.h
>> +++ b/include/qapi/util.h
>> @@ -30,4 +30,12 @@ int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,
>>
>>  int parse_qapi_name(const char *name, bool complete);
>>
>> +/* For any GenericList @list, insert @element at the front. */
>> +#define QAPI_LIST_ADD(list, element) do { \
>> +    typeof(list) _tmp = g_new(typeof(*(list)), 1); \
> 
> g_new(typeof(*p), 1) is an rather roundabout way to say
> g_malloc(sizeof(*p).  Yes, it returns typeof(p) instead of void *, but
> the chance of this catching mistakes here rounds to zero.
> 
> Not this patch's problem.  Ignore me :)

typeof is a gcc/clang extension; using sizeof makes the code slightly
more portable (but doesn't affect qemu's usage).  I'm happy to change
it, although it would require more commit message finesse since that
becomes more than just code motion.


>> @@ -5221,22 +5222,12 @@ BlockDeviceInfoList *bdrv_named_nodes_list(bool flat,
>>              qapi_free_BlockDeviceInfoList(list);
>>              return NULL;
>>          }
>> -        entry = g_malloc0(sizeof(*entry));
>> -        entry->value = info;
>> -        entry->next = list;
>> -        list = entry;
>> +        QAPI_LIST_ADD(list, info);
>>      }
>>
>>      return list;
>>  }
> 
> PATCH 12 has more.  I wonder whether PATCH 12 should be squashed into
> this one.  You decide.

Patch 12 has a LOT more.  And we're really close to soft freeze.  I kept
them separate to minimize the risk of landing my QAPI changes (4/12)
before 5.2 (that MUST happen, or we've locked in a problematic API with
block-export-add), vs. cleanup changes that may require review from a
lot more areas in the tree.  Given the timeline, I prefer to keep them
separate for v6.

I also still wonder if it is possible to make Coccinelle identify
candidates, rather than my manual audit that produced patch 12.

But for v6, I _will_ update the commit message to mention that more
conversions are possible, and saved for a later patch.

> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks; I think I can keep this even for v6, since all I am changing is
an enhanced commit message.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


