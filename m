Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EA2C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F394320737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcLOu6Pg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F394320737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOhME-0003vC-3U
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 08:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jOhLF-0003Jj-Qx
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jOhLD-0003MK-OL
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:40:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21234
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jOhLC-0003KY-0v
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586954428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CxCrMvW5FVEwMZe2G2bX5lBV9F1bXfb7I5lGEoDsoPg=;
 b=TcLOu6PgkxZnRp2HTnmkixdaYV06uGkHTPtmhC56B7gwa0xIbFFpUu65d0HjptYdaOpEGk
 smbSsT7nK1nfWGYkseUzjR8yyFOwzqBNes04jjKBRs7F3U0EIFnV0HPpo4920sKWL8aZxR
 uTNaiguI2tuKS+A/jaQBM9OOhi5MALk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-UUeMKMwtMjSq2NdWlxl2NQ-1; Wed, 15 Apr 2020 08:40:27 -0400
X-MC-Unique: UUeMKMwtMjSq2NdWlxl2NQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27243107B281;
 Wed, 15 Apr 2020 12:40:26 +0000 (UTC)
Received: from [10.3.115.59] (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B28B1116D95;
 Wed, 15 Apr 2020 12:40:25 +0000 (UTC)
Subject: Re: [PATCH v2 for-5.1 1/9] tests-qemu-opts: Cover has_help_option(), 
 qemu_opt_has_help_opt()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200415074927.19897-1-armbru@redhat.com>
 <20200415074927.19897-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <bc3dac90-889d-eb4b-0f4f-4c4e11a44be1@redhat.com>
Date: Wed, 15 Apr 2020 07:40:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415074927.19897-2-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 2:49 AM, Markus Armbruster wrote:
> The two turn out to be inconsistent for "a,b,,help".  Test case
> marked /* BUG */.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/test-qemu-opts.c | 44 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


