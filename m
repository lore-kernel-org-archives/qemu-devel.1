Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1212DC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E6D2075B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/pji2TO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E6D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3QI-0007MA-H0
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kX3Os-0005qs-0K
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:23:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kX3Oo-0006ja-US
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603722179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wBkBa8HwSazyvw+4g8eD8lD+ot5eQ1J9Q3973qNkRR0=;
 b=E/pji2TOz48+o9unH5QX7ASEyF0DYf9IzMUZWN0bJfZcoK47AV0dC1ZqWbqDyiUpcEnh4y
 AjbVoQXgG4zt36ggcXxB6Jr2plr8XcWIShYCH7OntdlDgZfEHIX2vYvkHxNfA59QTjuOcv
 5k4AQea6KD8kCfamE627f4o8DHoH9mM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-XihpB-ijPt6gL6N63H5pKg-1; Mon, 26 Oct 2020 10:22:56 -0400
X-MC-Unique: XihpB-ijPt6gL6N63H5pKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CAB7805F15;
 Mon, 26 Oct 2020 14:22:55 +0000 (UTC)
Received: from [10.3.112.145] (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44AF25576E;
 Mon, 26 Oct 2020 14:22:51 +0000 (UTC)
Subject: Re: [PATCH v5 01/12] qapi: Move GenericList to qapi/util.h
To: Markus Armbruster <armbru@redhat.com>
References: <20201023183652.478921-1-eblake@redhat.com>
 <20201023183652.478921-2-eblake@redhat.com>
 <8736215auz.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <84817ac8-f0ca-88c6-bf22-5c6e56588ae6@redhat.com>
Date: Mon, 26 Oct 2020 09:22:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <8736215auz.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 rjones@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 9:18 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> Placing GenericList in util.h will make it easier for the next patch
>> to promote QAPI_LIST_ADD() into a public macro without requiring more
>> files to include the unrelated visitor.h.
> 
> Is this true?
> 
> You don't actually need GenericList to make use of QAPI_LIST_ADD(), do
> you?  Any QAPI list type should do.

Correct, compilation still works if I drop this patch.

> 
>> However, we can't also move GenericAlternate; this is because it would
>> introduce a circular dependency: qapi-builtin-types.h needs a complete
>> definition of QEnumLookup (so it includes qapi/util.h), and
>> GenericAlternate needs a complete definition of QType (declared in
>> qapi-builtin-types.h).  Leaving GenericAlternate in visitor.h breaks
>> the cycle, and doesn't matter since we don't have any further planned
>> uses for that type outside of visitors.
>>
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
> 
> I did suggest to consider moving GenericList and GenericAlternate next
> to QAPI_LIST_ADD(), because they're (loosely) related.  We can't move
> GenericAlternate.  Moving only GenericList brings GenericList and
> QAPI_LIST_ADD() together, but separates the more closely related
> GenericList and GenericAlternate.  Meh.
> 
> I'd leave it put.

Agreed. Dropping this patch in v6.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


