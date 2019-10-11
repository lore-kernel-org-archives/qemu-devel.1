Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A103C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 11:45:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E532084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 11:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E532084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iItLw-00060q-4d
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 07:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iItLI-0005cO-34
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 07:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iItLF-0004s2-ID
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 07:44:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iItLF-0004q3-9s
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 07:44:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 46C7383F3D;
 Fri, 11 Oct 2019 11:44:15 +0000 (UTC)
Received: from [10.36.116.245] (ovpn-116-245.ams2.redhat.com [10.36.116.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 450915D9C3;
 Fri, 11 Oct 2019 11:44:09 +0000 (UTC)
Subject: Re: [PATCH v4] migration: Support gtree migration
To: quintela@redhat.com
References: <20191010205242.711-1-eric.auger@redhat.com>
 <87k19bwpp6.fsf@trasno.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <60332b12-b914-4783-878a-a57411261b34@redhat.com>
Date: Fri, 11 Oct 2019 13:44:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87k19bwpp6.fsf@trasno.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 11 Oct 2019 11:44:15 +0000 (UTC)
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
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, peterx@redhat.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Juan,

On 10/11/19 12:18 PM, Juan Quintela wrote:
> Eric Auger <eric.auger@redhat.com> wrote:
>> Introduce support for GTree migration. A custom save/restore
>> is implemented. Each item is made of a key and a data.
>>
>> If the key is a pointer to an object, 2 VMSDs are passed into
>> the GTree VMStateField.
>>
>> When putting the items, the tree is traversed in sorted order by
>> g_tree_foreach.
>>
>> On the get() path, gtrees must be allocated using the proper
>> key compare, key destroy and value destroy. This must be handled
>> beforehand, for example in a pre_load method.
>>
>> Tests are added to test save/dump of structs containing gtrees
>> including the virtio-iommu domain/mappings scenario.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> I found a bug, you have to respin, go to BUG
> (here was a reviewed-by)
> 
> But, ....
> 
> I didn't noticed on the 1st look
> 
>> +    const VMStateDescription *key_vmsd = direct_key ? NULL : &field->vmsd[0];
>> +    const VMStateDescription *val_vmsd = direct_key ? &field->vmsd[0] :
>> +                                                      &field->vmsd[1];
>> +    const char *key_vmsd_name = direct_key ? "direct" : key_vmsd->name;
> 
> This is ugly as hell.
> We are using a pointer to pass to mean an array, and abuse it.

I agree. My first attempt was using subsections to pass the second vmsd
but it was similarly ugly.
> 
> But once told that, it is not trivial to do this in a proper way.
> 
> On the other hand, if you have to respin for any other reason, please
> consider changing the meaning of vmsd[0] and [1].
> 
> vmsd[0] -> val_t
> vmsd[1] -> key_t

OK. I chose that order since usually the pair is expressed as key/value
and I found it more logical from the qemu user perspective. But I have
no strong preference.

> 
> if (vmsd[1] == NULL)
>    direct_key = true;
> 
>     const VMStateDescription *val_vmsd = &field->vmsd[0];
>     const VMStateDescription *key_vmsd = &field->vmsd[1]
>     const char *key_vmsd_name = key_vmsd ? "direct" : key_vmsd->name;
> 
> Same for get_gtree().
OK
> 
> 
>> +        if (direct_key) {
>> +            key = (void *)(uintptr_t)qemu_get_be64(f);
> 
> no g_malloc().
> 
>> +        } else {
>> +            key = g_malloc0(key_size);
>> +            ret = vmstate_load_state(f, key_vmsd, key, version_id);
>> +            if (ret) {
>> +                error_report("%s : failed to load %s (%d)",
>> +                             field->name, key_vmsd->name, ret);
>> +                g_free(key);
>> +                return ret;
>> +            }
>> +        }
>> +        val = g_malloc0(val_size);
>> +        ret = vmstate_load_state(f, val_vmsd, val, version_id);
>> +        if (ret) {
>> +            error_report("%s : failed to load %s (%d)",
>> +                         field->name, val_vmsd->name, ret);
>> +            g_free(key);
> 
> BUG: Allways free.  This need to be protected by a direct_key(), no?
ouch yes
> 
>> +            g_free(val);
>> +            return ret;
>> +        }
>> +        g_tree_insert(tree, key, val);
>> +    }
>> +    if (count != nnodes) {
>> +        error_report("%s inconsistent stream when loading the gtree",
>> +                     field->name);
> 
> BUG2:  we need to return an error here, right?
yep
> 
>> +    }
>> +    trace_get_gtree_end(field->name, key_vmsd_name, val_vmsd->name, ret);
>> +    return ret;
>> +}
>> +
> 
> Later, Juan.
> 

Thanks for the review

Eric

