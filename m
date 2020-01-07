Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CDBC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA58421744
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1K1Qo+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA58421744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioo8e-00074d-Sx
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iomxL-0005pC-BR
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:23:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iomxK-0005xM-6A
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:23:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53887
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iomxK-0005x1-1z
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578396205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=5N9uf4KZ99qzJzNRLgNzDXSkvzhad+2YpQb+cUJ/uCU=;
 b=L1K1Qo+7xd2DazUUUu5F/MOuLKJvBhKNWsqoU5kx2/ZCHHkOgFy1ICRnO2XOiqwAZTZhc0
 UsO4ejEYEeK+K37Bs5I/jsZbLh1PsysSs4vWNzFhzyAo2R9ARqvYXjg7OmyjuXCcd+WQ8x
 VbYMnR5zC8bP4ZylCQhLybd3aIDzIPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-eXfZR9NDOoysYKyCkHfbag-1; Tue, 07 Jan 2020 06:23:22 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39A0418AAFA3;
 Tue,  7 Jan 2020 11:23:19 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-116.ams2.redhat.com [10.36.116.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59DED10016EB;
 Tue,  7 Jan 2020 11:23:14 +0000 (UTC)
Subject: Re: [RFC PATCH qemu] spapr: Kill SLOF
To: Andrea Bolognani <abologna@redhat.com>
References: <20200103074404.30853-1-aik@ozlabs.ru>
 <3cf3e733-199a-61ba-7aaa-05e9546cd4d9@ozlabs.ru>
 <dd98618f-01c6-850f-ac00-454a2f798508@gmail.com>
 <81f1f752-3ada-2c8d-38b7-1344c7633e14@ozlabs.ru>
 <e3299f0688127627de96eb2db1f127bf94df9085.camel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <36763452-a67f-b663-42d2-48cd99995a0c@redhat.com>
Date: Tue, 7 Jan 2020 12:23:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e3299f0688127627de96eb2db1f127bf94df9085.camel@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: eXfZR9NDOoysYKyCkHfbag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Fabiano Rosas <farosas@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>, Sam Bobroff <sbobroff@linux.ibm.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?Q?Leonardo_Augusto_Guimar=c3=a3es_Garcia?= <lagarcia@br.ibm.com>,
 Leonardo Bras <leonardo@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/01/2020 10.39, Andrea Bolognani wrote:
> On Tue, 2020-01-07 at 12:55 +1100, Alexey Kardashevskiy wrote:
>> On 07/01/2020 01:15, Daniel Henrique Barboza wrote:
>>> Question: does Petitboot already replaces SLOF in every possible
>>> scenario for all
>>> the spapr machine features?
>>
>> Petitboot kernel+initramdisk almost replaces SLOF + GRUB.
> 
> Is this necessarily a good thing? Personally I quite like the fact
> that I can use the same bootloader across x86, ppc64 and aarch64.

AFAIK petitboot can use the grub config files ... and it is already used
on bare metal POWER8 and POWER9 systems, so it should not be such a big
change to use it for POWER KVM guests, too?

 Thomas


