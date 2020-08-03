Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A37C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 17:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D57122086A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 17:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+cjliQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57122086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2eED-0001r0-Vw
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 13:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k2eDW-0001NS-OU
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 13:25:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58900
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k2eDU-00049A-J8
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 13:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596475539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UiPcMaM086DcWe/1lFtVqhl4s0VMj9rjjXaA5Ip7NJU=;
 b=L+cjliQ3NqGUpZVt3LBBYuTn6d8I3lSOYjQ2TMfG0XhVEr4se/cA1dxMSwIq+ptQc9iMsa
 q3tCYpjcbanabKhwlZQzl/ycBOjqT6mb9EZi04kxNEjFx78juIXFiPcrN4Xv8bHjBPm9XA
 PS/GifnGB+0T2mCatdEw2SF6JviLAP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-IvzovwRjPNeJK59UT7ALuw-1; Mon, 03 Aug 2020 13:25:35 -0400
X-MC-Unique: IvzovwRjPNeJK59UT7ALuw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A5FB800138
 for <qemu-devel@nongnu.org>; Mon,  3 Aug 2020 17:25:34 +0000 (UTC)
Received: from [10.3.113.122] (ovpn-113-122.phx2.redhat.com [10.3.113.122])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0506B60BF4;
 Mon,  3 Aug 2020 17:25:33 +0000 (UTC)
Subject: Re: qapi-schema esotera
To: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <5bfa3895-304d-8372-c0db-fda4c1a1ba59@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <dc0a16e2-365f-a9e6-03df-b70f97dd7407@redhat.com>
Date: Mon, 3 Aug 2020 12:25:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5bfa3895-304d-8372-c0db-fda4c1a1ba59@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:37:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/3/20 11:49 AM, John Snow wrote:
> UNION is split into two primary forms:
> 
> 1. Simple (No discriminator nor base)
> 2. Flat (Discriminator and base)
> 
> In expr.py, I notice that we modify the perceived type of the 'type' 
> expression based on the two union forms.
> 
> 1a. Simple unions allow Array[T]
> 1b. Flat unions disallow Array[T]

Rather, branches in a simple unions are syntactic sugar for a wrapper 
struct that contains a single member 'data'; because of that extra 
nesting, the type of that single member is unconstrained.  In flat 
unionw, the type MUST be a QAPI struct, because its members will be used 
inline; as currently coded, this prevents the use of an intrinsic type 
('int', 'str') or an array type.

If you need to use an array type in a flat union, you can't do:

{ 'union' ...
   'data': { 'foo': [ 'MyBranch' ] } }

but you can provide a wrapper type yourself:

{ 'struct': 'MyBranch', 'data': { 'array': [ 'MyType' ] } }
{ 'union' ...
   'data': { 'foo': 'MyBranch' } }

> 
>  From the docs:
> 
> Syntax:
>      UNION = { 'union': STRING,
>                'data': BRANCHES,
>                '*if': COND,
>                '*features': FEATURES }
>            | { 'union': STRING,
>                'data': BRANCHES,
>                'base': ( MEMBERS | STRING ),
>                'discriminator': STRING,
>                '*if': COND,
>                '*features': FEATURES }
>      BRANCHES = { BRANCH, ... }
>      BRANCH = STRING : TYPE-REF
>             | STRING : { 'type': TYPE-REF, '*if': COND }
> 
> Both arms use the same "BRANCHES" grammar production, which both use 
> TYPE-REF.
> 
>      TYPE-REF = STRING | ARRAY-TYPE
>      ARRAY-TYPE = [ STRING ]
> 
> Implying that List[T] should be allowed for both productions.
> Can I ask for a ruling from the judges?

As you found, the docs are a bit misleading; the semantic constraint on 
flat union branches being a struct (because they will be inlined) 
prevents the use of type-refs that are valid in simple unions (where 
those simple types will be wrapped in an implicit struct).  A patch to 
improve the docs would be a reasonable idea.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


