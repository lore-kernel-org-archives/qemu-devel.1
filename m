Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720D2C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 21:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33A372071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 21:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hP13vAde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A372071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZLu6-00047e-Ad
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 16:28:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iZLtM-0003c1-ID
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 16:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iZLtG-0008Gg-Mz
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 16:27:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24005
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iZLtE-0008Eu-Vo
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 16:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574717242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mW069V1XZdaqlye1Zqr8qHgcY6AffgQRAc9aWW0jKQw=;
 b=hP13vAdenuiAua7XTtnrf2vHe9x7clUj6Gvb8AFfC4JBmW8b4KViObpyt5zme+0RI7glmj
 wMO/UgpsGPmSjgOYUg9W2wN1n69ZOb8fnrkJ2XT/mzL2y5nSvZSJuK/WOAVkdMkk4td4Du
 FsjzQSDh2Ddu3+HPYWB3sD8wyOKgAik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-kmTXpOcVNfC2Cz-6NOVvvw-1; Mon, 25 Nov 2019 16:27:19 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EA24593A0;
 Mon, 25 Nov 2019 21:27:18 +0000 (UTC)
Received: from [10.3.116.163] (ovpn-116-163.phx2.redhat.com [10.3.116.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9C915C28D;
 Mon, 25 Nov 2019 21:27:17 +0000 (UTC)
Subject: Re: [QUESTION] What is the best license option for new files
 introduced in QEMU?
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAL1e-=gmaimCBh5NBBYFp6Z1ci4ZheQtXpyjU9Uexqi4zSHh2A@mail.gmail.com>
 <CAL1e-=i-u5eR7Fk_Muobbe0-Viim0iPceHoEGtJWCq7L1o9teA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5edee836-b97b-57fb-70fb-9b6b6bc44a52@redhat.com>
Date: Mon, 25 Nov 2019 15:27:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=i-u5eR7Fk_Muobbe0-Viim0iPceHoEGtJWCq7L1o9teA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: kmTXpOcVNfC2Cz-6NOVvvw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/25/19 1:25 PM, Aleksandar Markovic wrote:

> Thomas pointed to me that I mixed up GPL and LGPL - which is true.
> 
> Still, the question remains with these options:
> 
> * GPL 2.0

Not good. It artificially limits who can reuse this code.

> * GPL 2.0 + wording "or later (at your option)"

Matches what qemu itself uses, so fine; but makes it harder to reuse the 
code in a standalone library.

> * LGPL 2.1

Same problems as GPL2-only

> * LGPL 2.1 + wording "or later (at your option)"

Looser than qemu as a whole, has all the benefits of GPL2+ plus the 
additional benefit of being able to copy the code into other LGPL 
standalone libraries.

It's also acceptable to use even looser licenses, like BSD 2-clause, but 
preferably only if that other license is already used by part of qemu 
(we don't need to make our mix even worse than it already is).

> 
> The context of my question is that I am reviewing a series that came
> with files with different license preambles (or without it at all), and I
> want to advice the submitters on the best option.

You may also want advice from lawyers, based on how you see your code 
being reused outside of qemu.  This list can offer advice, but it is 
non-binding and may not best fit your needs.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


