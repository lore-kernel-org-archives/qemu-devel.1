Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3BCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 807BD20663
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6HasEhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807BD20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUcR-0003vY-Na
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 04:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jdUbO-0002oA-1X
 for qemu-devel@nongnu.org; Tue, 26 May 2020 04:06:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35436
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jdUbN-0004kJ-9D
 for qemu-devel@nongnu.org; Tue, 26 May 2020 04:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590480380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N62yquLSNCxDQV2QKxruJZ6QlvzKfFr6Z6h4p0GGcuY=;
 b=E6HasEhY18y/sz5m2I0bUwQupuLhVQn6uFPBZgIEeXmGSslq37PDepKrazZrAh61PNOGiF
 8BibiZqaoH7bxhPajzsc3+ga8KPZkdg/sf26xTBL+f9VxB+W12kQaKmC1rxcQQXVyCJ/nH
 Wv6R+JYTD6x6nxkqt3qyaBXNj90UB1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-cq5GOZiQMKq0906eCPzCLg-1; Tue, 26 May 2020 04:06:18 -0400
X-MC-Unique: cq5GOZiQMKq0906eCPzCLg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08AC48018A7;
 Tue, 26 May 2020 08:06:17 +0000 (UTC)
Received: from [10.40.195.106] (unknown [10.40.195.106])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C01F810013D2;
 Tue, 26 May 2020 08:06:15 +0000 (UTC)
Subject: Re: [PATCH 2/2] qmp: Expose MachineClass::default_ram_id
To: Eduardo Habkost <ehabkost@redhat.com>
References: <cover.1590426097.git.mprivozn@redhat.com>
 <2dbffbc4e2c0f3a0184daaadf56f94a85aedef58.1590426097.git.mprivozn@redhat.com>
 <20200525180603.GS577771@habkost.net>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <1e8434ce-60c6-8e69-7ac7-65886993050b@redhat.com>
Date: Tue, 26 May 2020 10:06:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200525180603.GS577771@habkost.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: imammedo@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/20 8:06 PM, Eduardo Habkost wrote:
> On Mon, May 25, 2020 at 07:03:28PM +0200, Michal Privoznik wrote:
>> If a management application (like Libvirt) want's to preserve
>> migration ability and switch to '-machine memory-backend' it
>> needs to set exactly the same RAM id as QEMU would. Since the id
>> is machine type dependant, expose it under 'query-machines'
>> result.
>>
>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> 
> The code looks good, but documentation was a bit confusing:
> 
>> ---
> [...]
>> +# @default-ram-id: the default name of initial RAM memory region (since 5.1)
>> +#
> 
> Everywhere else in the commit message you call it "id", but here
> you say "name".  Also, I don't think we have any references to a
> "memory region" abstraction in the docs for the QAPI schema,
> -machine options, or memory backend objects.
> 
> I had to look it up in the code, to finally understand you were
> talking about the memory backend object ID.
> 
> To make it consistent with terminology used for -machine and
> QAPI, I suggest:
> 
>    @default-ram-id: the default ID of initial RAM memory backend (since 5.1)
> 
> I can change it before committing, if you agree.

Thanks for the offer, but I will post a v2, because as I was developing 
patches for libvirt to consume this I found out that some machine types 
don't have the attribute set (riscv is one of them). Therefore I will 
have to make this optional.

Michal


