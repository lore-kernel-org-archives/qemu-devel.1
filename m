Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A34C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 812B720734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfpgK53K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 812B720734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj11I-0005D5-Kk
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jj0wr-0006W0-6m
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 09:39:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60256
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jj0wp-0002Ze-DV
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 09:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591796357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R9yM/vimBTrGy0ToxSJZ758QhqcLxosiKbfMZXSWhq4=;
 b=bfpgK53KMnk0n7vbteWSiquEKCPfqnOsrBuvs7PGZZCo2ngMZn5uz10wKmUHEgWdYo6TPH
 Z8qMK+qFAOH2GJCVWwSDQfmoH/O7Xf+1069CDXBkatPRczdJp8Hq7YgVmqrlYqI5MPBM8w
 Pk3CSpXAmFBxVmST+d1z+KGg/zBp394=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-spwqjRdqMyOGRkqxQkcDGQ-1; Wed, 10 Jun 2020 09:39:13 -0400
X-MC-Unique: spwqjRdqMyOGRkqxQkcDGQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9342B100CCC0;
 Wed, 10 Jun 2020 13:39:12 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9E377F0BE;
 Wed, 10 Jun 2020 13:39:11 +0000 (UTC)
Subject: Re: [PATCH 1/2] nbd/server: Avoid long error message assertions
 CVE-2020-10761
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200608182638.3256473-1-eblake@redhat.com>
 <20200608182638.3256473-2-eblake@redhat.com>
 <678021fb-d34d-4067-31b3-f864efe13dbd@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5a8ce391-a16e-1af9-78bb-8e1aab5b213c@redhat.com>
Date: Wed, 10 Jun 2020 08:39:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <678021fb-d34d-4067-31b3-f864efe13dbd@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, ppandit@redhat.com,
 xuwei@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/20 3:57 AM, Vladimir Sementsov-Ogievskiy wrote:
> 08.06.2020 21:26, Eric Blake wrote:
>> Ever since commit 36683283 (v2.8), the server code asserts that error
>> strings sent to the client are well-formed per the protocol by not
>> exceeding the maximum string length of 4096.  At the time the server
>> first started sending error messages, the assertion could not be
>> triggered, because messages were completely under our control.
>> However, over the years, we have added latent scenarios where a client
>> could trigger the server to attempt an error message that would
>> include the client's information if it passed other checks first:
>>
>> - requesting NBD_OPT_INFO/GO on an export name that is not present
>>    (commit 0cfae925 in v2.12 echoes the name)
>>
>> - requesting NBD_OPT_LIST/SET_META_CONTEXT on an export name that is
>>    not present (commit e7b1948d in v2.12 echoes the name)
>>
>> At the time, those were still safe because we flagged names larger
>> than 256 bytes with a different message; but that changed in commit
>> 93676c88 (v4.2) when we raised the name limit to 4096 to match the NBD
>> string limit.  (That commit also failed to change the magic number
>> 4096 in nbd_negotiate_send_rep_err to the just-introduced named
>> constant.)  So with that commit, long client names appended to server
>> text can now trigger the assertion, and thus be used as a denial of
>> service attack against a server.  As a mitigating factor, if the
>> server requires TLS, the client cannot trigger the problematic paths
>> unless it first supplies TLS credentials, and such trusted clients are
>> less likely to try to intentionally crash the server.
>>
>> Reported-by: Xueqiang Wei <xuwei@redhat.com>
>> CC: qemu-stable@nongnu.org
>> Fixes: https://bugzilla.redhat.com/1843684 CVE-2020-10761
>> Fixes: 93676c88d7
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   nbd/server.c               | 28 +++++++++++++++++++++++++---
>>   tests/qemu-iotests/143     |  4 ++++
>>   tests/qemu-iotests/143.out |  2 ++
>>   3 files changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/nbd/server.c b/nbd/server.c
>> index 02b1ed080145..ec130303586d 100644
>> --- a/nbd/server.c
>> +++ b/nbd/server.c
>> @@ -217,7 +217,7 @@ nbd_negotiate_send_rep_verr(NBDClient *client, 
>> uint32_t type,
>>
>>       msg = g_strdup_vprintf(fmt, va);
>>       len = strlen(msg);
>> -    assert(len < 4096);
>> +    assert(len < NBD_MAX_STRING_SIZE);
>>       trace_nbd_negotiate_send_rep_err(msg);
>>       ret = nbd_negotiate_send_rep_len(client, type, len, errp);
>>       if (ret < 0) {
>> @@ -231,6 +231,27 @@ nbd_negotiate_send_rep_verr(NBDClient *client, 
>> uint32_t type,
>>       return 0;
>>   }
>>
>> +/*
>> + * Truncate a potentially-long user-supplied string into something
>> + * more suitable for an error reply.
>> + */
>> +static const char *
>> +nbd_truncate_name(const char *name)
>> +{
>> +#define SANE_LENGTH 80
>> +    static char buf[SANE_LENGTH + 3 + 1]; /* Trailing '...', NUL */
> 
> s/NUL/NULL/

NULL is the pointer (typically 4 or 8 bytes); NUL is the character 
(exactly one byte in all multi-byte-encodings like UTF-8, or 
sizeof(wchar_t) when using wide characters).

> 
> Hmm. It may break if we use it in parallel in two coroutines or 
> threads.. Not sure, is it possible now, neither of course will it be 
> possible in future.

After some testing (including adding some temporary sleep() into the 
code), it looks like 'qemu-nbd -e 2' is currently serialized (we don't 
start responding to a second client until we are done negotiating with 
the first); on that grounds, we are not risking that information leaks 
from one client to another.  But you are correct that it is not obvious, 
and that if we do have a situation where two threads can try to allow an 
NBD connection, then this static buffer could leak information from one 
client to another.  So I'll need to post a v2.

> 
> I'd avoid creating functions returning  instead use g_strdup_printf(), like
> 
> char *tmp = g_strdup_printf("%.80s...", name);
> 
>    ( OR, if you want explicit constant: g_strdup_printf("%.*s...", 
> SANE_LENGTH, name) )
> 
> ... report error ...
> 
> g_free(tmp)
> 
> Using g_strdup_printf also is safer as we don't need to care about buf 
> size.

malloc'ing the buffer is not too bad; error messages are not the hot 
path. I'll change it along those lines for v2.

>> @@ -996,7 +1017,8 @@ static int nbd_negotiate_meta_queries(NBDClient 
>> *client,
>>       meta->exp = nbd_export_find(export_name);
>>       if (meta->exp == NULL) {
>>           return nbd_opt_drop(client, NBD_REP_ERR_UNKNOWN, errp,
>> -                            "export '%s' not present", export_name);
>> +                            "export '%s' not present",
>> +                            nbd_truncate_name(export_name));
>>       }
>>
> 
> Hmm, maybe instead of assertion, shrink message in 
> nbd_negotiate_send_rep_verr() too?
> This will save us from forgotten (or future) uses of the function.

Truncating in nbd_negotiate_send_rep_verr is arbitrary; it does not have 
the context of what makes sense to truncate.  With an artificially short 
length, and a client request for "longname_from_the_client", the 
difference would be between:

export "longnam..." not present
export "longname_from_the_cl...

As a user, I prefer the first form, but truncating in 
nbd_negotiate_send_rep_verr is the second form.

> 
> Shrinking name is better, as it provides better message on result. But 
> generally shrink
> all two long messages in nbd_negotiate_send_rep_verr() (maybe, together 
> with error_report())
> seems a good thing for me.

What would error_report() accomplish?  Logging on the server that we are 
truncating a message sent back to the client doesn't help the client. 
This is not a case of protocol violation, and a server sending an error 
message to the client is not out of the ordinary.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


