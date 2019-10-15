Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EEAC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF4A20650
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF4A20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKOSf-00082N-VY
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 11:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iKOQd-0006FU-N5
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iKOQc-0005pf-AS
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:08:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iKOQY-0005oY-2J; Tue, 15 Oct 2019 11:07:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3301E7BDAC;
 Tue, 15 Oct 2019 15:07:57 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 88AC960C63;
 Tue, 15 Oct 2019 15:07:56 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] nbd: Don't send oversize strings
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191010210018.22000-1-eblake@redhat.com>
 <20191010210018.22000-2-eblake@redhat.com>
 <e777bd6b-525d-99e1-2584-a31f3609d5cd@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c7ed4149-8cef-7897-ae95-9b24a3d4f378@redhat.com>
Date: Tue, 15 Oct 2019 10:07:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <e777bd6b-525d-99e1-2584-a31f3609d5cd@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 15 Oct 2019 15:07:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/19 2:32 AM, Vladimir Sementsov-Ogievskiy wrote:
> 11.10.2019 0:00, Eric Blake wrote:
>> Qemu as server currently won't accept export names larger than 256
>> bytes, nor create dirty bitmap names longer than 1023 bytes, so most
>> uses of qemu as client or server have no reason to get anywhere near
>> the NBD spec maximum of a 4k limit per string.
>>
>> However, we weren't actually enforcing things, ignoring when the
>> remote side violates the protocol on input, and also having several
>> code paths where we send oversize strings on output (for example,
>> qemu-nbd --description could easily send more than 4k).  Tighten
>> things up as follows:
>>
>> client:
>> - Perform bounds check on export name and dirty bitmap request prior
>>     to handing it to server
>> - Validate that copied server replies are not too long (ignoring
>>     NBD_INFO_* replies that are not copied is not too bad)
>> server:
>> - Perform bounds check on export name and description prior to
>>     advertising it to client
>> - Reject client name or metadata query that is too long
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---

>> +++ b/include/block/nbd.h
>> @@ -232,6 +232,7 @@ enum {
>>     * going larger would require an audit of more code to make sure we
>>     * aren't overflowing some other buffer. */
> 
> This comment says, that we restrict export name to 256...

Yes, because we still stack-allocate the name in places, but 4k is too 
large for stack allocation.  But we're inconsistent on where we use the 
smaller 256-limit; the server won't serve an image that large, but 
doesn't prevent a client from requesting a 4k name export (even though 
that export will not be present).


>> +++ b/blockdev-nbd.c
>> @@ -162,6 +162,11 @@ void qmp_nbd_server_add(const char *device, bool has_name, const char *name,
>>            name = device;
>>        }
>>
>> +    if (strlen(name) > NBD_MAX_STRING_SIZE) {
>> +        error_setg(errp, "export name '%s' too long", name);
>> +        return;
>> +    }
> 
> Hmmm, no, so here we restrict to 4096, but, we will not allow client to request more than
> 256. Seems, to correctly update server-part, we should drop NBD_MAX_NAME_SIZE and do the
> audit mentioned in the comment above its definition.

Yeah, I guess it's time to just get rid of NBD_MAX_NAME_SIZE, and move 
away from stack allocations.  Should I do that as a followup to this 
patch, or spin a v3?

>> +++ b/nbd/client.c
>> @@ -289,8 +289,8 @@ static int nbd_receive_list(QIOChannel *ioc, char **name, char **description,
>>            return -1;
>>        }
>>        len -= sizeof(namelen);
>> -    if (len < namelen) {
>> -        error_setg(errp, "incorrect option name length");
>> +    if (len < namelen || namelen > NBD_MAX_STRING_SIZE) {
>> +        error_setg(errp, "incorrect list name length");
> 
> New wording made me go above and read the comment, what functions does. Comment is good, but without
> it, it sounds like name of the list for me...

Maybe:

incorrect name length in server's list response

> 
>>            nbd_send_opt_abort(ioc);
>>            return -1;
>>        }
>> @@ -303,6 +303,11 @@ static int nbd_receive_list(QIOChannel *ioc, char **name, char **description,
>>        local_name[namelen] = '\0';
>>        len -= namelen;
>>        if (len) {
>> +        if (len > NBD_MAX_STRING_SIZE) {
>> +            error_setg(errp, "incorrect list description length");

and

incorrect description length in server's list response


>> @@ -648,6 +657,7 @@ static int nbd_send_meta_query(QIOChannel *ioc, uint32_t opt,
>>        if (query) {
>>            query_len = strlen(query);
>>            data_len += sizeof(query_len) + query_len;
>> +        assert(query_len <= NBD_MAX_STRING_SIZE);
>>        } else {
>>            assert(opt == NBD_OPT_LIST_META_CONTEXT);
>>        }
> 
> you may assert export_len as well..

It was asserted earlier, but doing it again might not hurt, especially 
if I do the followup patch getting rid of NBD_MAX_NAME_SIZE


>> @@ -1561,6 +1569,8 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
>>            exp->export_bitmap = bm;
>>            exp->export_bitmap_context = g_strdup_printf("qemu:dirty-bitmap:%s",
>>                                                         bitmap);
>> +        /* See BME_MAX_NAME_SIZE in block/qcow2-bitmap.c */
> 
> Hmm. BME_MAX_NAME_SIZE is checked only when creating persistent bitmaps. But for non-persistent
> name length is actually unlimited. So, we should either limit all bitmap names to 1023 (hope,
> this will not break existing scenarios) or error out here (or earlier) instead of assertion.

I'm leaning towards limiting ALL bitmaps to the same length (as we've 
already debated the idea of being able to convert an existing bitmap 
from transient to persistent).

> 
> We also may want QEMU_BUILD_BUG_ON(NBD_MAX_STRING_SIZE < BME_MAX_NAME_SIZE + sizeof("qemu:dirty-bitmap:") - 1)

Except that BME_MAX_NAME_SIZE is not (currently) in a public .h file.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

