Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2EBC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 07:33:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5CD218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 07:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5CD218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iISx3-0002bD-Ba
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 03:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iISw2-0001za-BL
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 03:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iISvz-0002P8-O2
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 03:32:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40314)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iISvz-0002Of-I4
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 03:32:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A991D302246D;
 Thu, 10 Oct 2019 07:32:25 +0000 (UTC)
Received: from [10.36.116.245] (ovpn-116-245.ams2.redhat.com [10.36.116.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D27285D6A5;
 Thu, 10 Oct 2019 07:32:21 +0000 (UTC)
Subject: Re: [PATCH v3] migration: Support gtree migration
To: quintela@redhat.com
References: <20191004112025.28868-1-eric.auger@redhat.com>
 <87a7aguole.fsf@trasno.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <61dac94a-7774-714f-ca4f-f02452130854@redhat.com>
Date: Thu, 10 Oct 2019 09:32:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87a7aguole.fsf@trasno.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 10 Oct 2019 07:32:25 +0000 (UTC)
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

On 10/5/19 12:34 AM, Juan Quintela wrote:
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
> Overal I like the patch.  I think that I found a minor error.
> 
> 
>> +static int put_gtree(QEMUFile *f, void *pv, size_t unused_size,
>> +                     const VMStateField *field, QJSON *vmdesc)
>> +{
>> +    bool direct_key = (!field->start);
>> +    const VMStateDescription *key_vmsd = direct_key ? NULL : &field->vmsd[0];
>> +    const VMStateDescription *val_vmsd = direct_key ? &field->vmsd[0] :
>> +                                                      &field->vmsd[1];
>> +    struct put_gtree_data capsule = {f, key_vmsd, val_vmsd, 0};
> 
> Please, consider change the last line to:
> 
>        struct put_gtree_data capsule = {
>            .f = f,
>            .key_vmsd = key_vmsd,
>            .val_vmsd = val_vmsd,
>            .ret = 0};
> 
> It makes much easier make changes on the future.
> 
> Once here, I think that you are missing on the middle a:
> 
>           .vmdesc = vmdesc,
> 
> No?  At least you use it on put_gtree_elem, and I don't see any place
> where you assign it.  When I did the change is when I noticed that it
> was missing.

You are completely right. Thank you for catching this.

Eric
> 
>> +    GTree **pval = pv;
>> +    GTree *tree = *pval;
>> +    int ret;
>> +
>> +    qemu_put_be32(f, g_tree_nnodes(tree));
>> +    g_tree_foreach(tree, put_gtree_elem, (gpointer)&capsule);
>> +    qemu_put_byte(f, false);
>> +    ret = capsule.ret;
>> +    if (ret) {
>> +        error_report("%s : failed to save gtree (%d)", field->name, ret);
>> +    }
>> +    return ret;
>> +}
> 
> As said before, with this changes you have my reviewed-by.
> 
> Later, Juan.
> 

