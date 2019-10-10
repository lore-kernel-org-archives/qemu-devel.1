Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA58FC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 07:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3F1218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 07:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3F1218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iITKb-0002Ha-PS
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 03:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iITJv-0001sT-7W
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 03:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iITJs-0004Pv-MI
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 03:57:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53302)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iITJs-0004P4-8v
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 03:57:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 50D0A88382D;
 Thu, 10 Oct 2019 07:57:07 +0000 (UTC)
Received: from [10.36.116.245] (ovpn-116-245.ams2.redhat.com [10.36.116.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76972600C4;
 Thu, 10 Oct 2019 07:57:03 +0000 (UTC)
From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3] migration: Support gtree migration
To: Peter Xu <peterx@redhat.com>
References: <20191004112025.28868-1-eric.auger@redhat.com>
 <20191009062852.GB1039@xz-x1>
Message-ID: <27d37e80-31d8-006a-b2a8-c61c5129c7c4@redhat.com>
Date: Thu, 10 Oct 2019 09:57:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191009062852.GB1039@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Thu, 10 Oct 2019 07:57:07 +0000 (UTC)
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 10/9/19 8:28 AM, Peter Xu wrote:
> On Fri, Oct 04, 2019 at 01:20:25PM +0200, Eric Auger wrote:
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
> Mostly looks sane to me (with Juan's comment fixed).  Some more
> trivial comments below.
> 
>> +/*
>> + * For migrating a GTree whose key is a pointer to _key_type and the
>> + * value, a pointer to _val_type
>> + * The target tree must have been properly initialized
>> + * _vmsd: Start address of the 2 element array containing the key vmsd
>> + *        and the data vmsd
>> + * _key_type: type of the key
>> + * _val_type: type of the value
>> + */
>> +#define VMSTATE_GTREE_V(_field, _state, _version, _vmsd,                       \
>> +                        _key_type, _val_type)                                  \
>> +{                                                                              \
>> +    .name         = (stringify(_field)),                                       \
>> +    .version_id   = (_version),                                                \
>> +    .vmsd         = (_vmsd),                                                   \
>> +    .info         = &vmstate_info_gtree,                                       \
>> +    .start        = sizeof(_key_type),                                         \
> 
> Nitpick: Are we reusing the "start" field to store the size just to
> avoid defining new field in VMStateField?  If so, not sure whether we
> can start to use unions to both keep VMStateField small while keep the
> code clean.  Like:
> 
>   union {
>     struct {
>       size_t key_size;
>       size_t value_size;
>     };
>     struct {
>       size_t start;
>       size_t size;
>     };
>   }
Indeed that's the usage. I don't have a strong preference. Juan, Dave,
what do you prefer? keep it as it is or introduce unions?

> 
> ?
> 
> This can of course also be done on top of this patch no matter what.
> 
> [...]
> 
>> +static gboolean put_gtree_elem(gpointer key, gpointer value, gpointer data)
>> +{
>> +    struct put_gtree_data *capsule = (struct put_gtree_data *)data;
>> +    QEMUFile *f = capsule->f;
>> +    int ret;
>> +
>> +    qemu_put_byte(f, true);
>> +
>> +    /* put the key */
>> +    if (!capsule->key_vmsd) {
>> +        qemu_put_be32(f, GPOINTER_TO_UINT(key)); /* direct key */
> 
> This is special code path for direct key case.  Can we simply define
> VMSTATE_GTREE_DIRECT_KEY_V() somehow better so that it just uses the
> VMSTATE_UINT32_V() as the key vmsd?  Then iiuc vmstate_save_state()
> could work well with that too.
if the key_vmsd is a VMSTATE_UINT32_V then I understand
vmstate_save_state(f, capsule->key_vmsd, key, capsule->vmdesc)
expects key to be a pointer to a uint32. But in that case of direct key,
it is a uint32. I don't figure out how to use vmstate_save_state in your
proposal.

> 
> Also, should we avoid using UINT in all cases?  But of course if we
> start to use VMSTATE_UINT32_V then we don't have this issue.
Depending on the clarification of above point, maybe I can rename
VMSTATE_GTREE_DIRECT_KEY_V into VMSTATE_GTREE_DIRECT_UINT_KEY_V

direct keys seem to be more common for hash tables actually.
https://developer.gnome.org/glib/stable/glib-Hash-Tables.html#g-hash-table-new-full

There are stand conversion macros to/from int, uint, size
https://developer.gnome.org/glib/stable/glib-Type-Conversion-Macros.html

Thanks

Eric

> 
> Thanks,
> 
>> +    } else {
>> +        ret = vmstate_save_state(f, capsule->key_vmsd, key, capsule->vmdesc);
>> +        if (ret) {
>> +            capsule->ret = ret;
>> +            return true;
>> +        }
>> +    }
>> +
>> +    /* put the data */
>> +    ret = vmstate_save_state(f, capsule->val_vmsd, value, capsule->vmdesc);
>> +    if (ret) {
>> +        capsule->ret = ret;
>> +        return true;
>> +    }
>> +    return false;
>> +}
> 

