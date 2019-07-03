Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9687EC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 10:38:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73705218A0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 10:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73705218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiceh-0001hB-00
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 06:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55061)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hice5-0001Eu-4d
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 06:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hice3-0001xh-ME
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 06:37:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44744)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hice3-0001mo-Gp
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 06:37:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9CB712EF188;
 Wed,  3 Jul 2019 10:37:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-102.ams2.redhat.com
 [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F46D7C611;
 Wed,  3 Jul 2019 10:37:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 71A7B1132ABF; Wed,  3 Jul 2019 12:37:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <878stfzozv.fsf@dusky.pond.sub.org>
 <1c014d01-edef-d418-75a4-96f0811717e8@redhat.com>
Date: Wed, 03 Jul 2019 12:37:41 +0200
In-Reply-To: <1c014d01-edef-d418-75a4-96f0811717e8@redhat.com> (Paolo
 Bonzini's message of "Wed, 3 Jul 2019 07:37:46 +0200")
Message-ID: <87v9wjwgi2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 03 Jul 2019 10:37:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] What's IOMMUMemoryRegion's super?
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 03/07/19 07:05, Markus Armbruster wrote:
>>     static const TypeInfo iommu_memory_region_info = {
>>         .parent             = TYPE_MEMORY_REGION,
>>         .name               = TYPE_IOMMU_MEMORY_REGION,
>>         .class_size         = sizeof(IOMMUMemoryRegionClass),
>>         .instance_size      = sizeof(IOMMUMemoryRegion),
>>         .instance_init      = iommu_memory_region_initfn,
>>         .abstract           = true,
>>     };
>> 
>>     typedef struct IOMMUMemoryRegionClass {
>>         /* private */
>> --->    struct DeviceClass parent_class;
>>         [...]
>>     };
>> 
>>     struct IOMMUMemoryRegion {
>>         MemoryRegion parent_obj;
>>         [...]
>>     };
>> 
>> The parent is TYPE_MEMORY_REGION, and the instance struct's first member is
>> TYPE_MEMORY_REGION's instance struct as I expect, but the class struct's
>> first member is something else entirely.
>
> Cut-and-paste error.  MemoryRegion adds no methods so that could be

I wonder whether there's anything we could do to catch such errors
automatically.

> either ObjectClass or better
>
>     typedef struct MemoryRegionClass {
>         /* private */
>         ObjectClass parent_class;
>     } ObjectClass;

I'll prepare the patch.  Thanks!

