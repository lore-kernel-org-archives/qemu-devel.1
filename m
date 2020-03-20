Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC667C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B9ED2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lif6Zr6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9ED2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJFm-00065l-OU
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jFJF7-0005fO-3g
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jFJF6-0008Os-4z
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:07:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:45647)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jFJF6-0008Og-1e
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584716843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7GRx3HTajBmpqVBfkAL1DptW6qh1lWEdE+MMIVuAP+M=;
 b=Lif6Zr6xKImOEU2Hi581Z7yOlr24xa9wx88Isc1J3oJ/ca+dcEmyFWoHQXvSb36KQ2XZQh
 6NzOHUVBflp2alDukoMzYpI5MdiJ6a4sholXG+d6L2Wpr6Z4qau0NRjWpGPY6OYwmc9NdW
 eOltS2VCX42Zyg/5c+unJchePKaF74c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-bREpxXHGOyi7Vlz2jX03bQ-1; Fri, 20 Mar 2020 11:07:19 -0400
X-MC-Unique: bREpxXHGOyi7Vlz2jX03bQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FCFD108442D;
 Fri, 20 Mar 2020 15:07:18 +0000 (UTC)
Received: from [10.3.112.193] (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC18E5C1A7;
 Fri, 20 Mar 2020 15:07:17 +0000 (UTC)
Subject: Re: [PATCH 1/2] qapi: Reject section markup in definition
 documentation
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200320091805.5585-1-armbru@redhat.com>
 <20200320091805.5585-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f0b7a6b1-9743-d43b-bf1f-71c4b7270f3a@redhat.com>
Date: Fri, 20 Mar 2020 10:07:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320091805.5585-2-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: peter.maydell@linaro.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/20/20 4:18 AM, Markus Armbruster wrote:
> Section markup in definition documentation makes no sense and can
> produce invalid Texinfo.  Reject.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   docs/devel/qapi-code-gen.txt           |  2 ++
>   scripts/qapi/parser.py                 |  5 +++++
>   tests/qapi-schema/doc-bad-section.err  |  1 +
>   tests/qapi-schema/doc-bad-section.json |  3 +--
>   tests/qapi-schema/doc-bad-section.out  | 24 ------------------------
>   5 files changed, 9 insertions(+), 26 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


