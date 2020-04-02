Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A8CC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:46:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C4EF20737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWsc28gG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4EF20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK3un-0004GQ-95
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 13:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jK3tx-0003dn-Rb
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jK3tw-00042j-14
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:45:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38791
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jK3tv-0003yg-MP
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585849510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LQIVs8e35Uo8MR4NW/CKax+ijvT3dGGka2gUfbP0OCg=;
 b=cWsc28gGRcUi310VZxwVTBF2/xU7JUiuzuYzuvc/zDJffg4jCueWHqycM8mjQOKVPOB8I9
 qOLLsiz9kFRP8ofa8NX4zw28fcHEZO/RamgiVrUXhdMeEao5KFhVbHxFzZR/tp3ZsOKWPh
 VV1NCtdrmG4uaWuvtqL0uKEOoCtQQKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-PMMz8NutMueEKaDysaEwmg-1; Thu, 02 Apr 2020 13:45:02 -0400
X-MC-Unique: PMMz8NutMueEKaDysaEwmg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DECF98014D0;
 Thu,  2 Apr 2020 17:45:00 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59D555D9CD;
 Thu,  2 Apr 2020 17:45:00 +0000 (UTC)
Subject: Re: [PATCH v2] qobject: json-streamer: Change bracket_count to
 brace_count
To: Simran Singhal <singhalsimran0@gmail.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20200402171940.GA21781@simran-Inspiron-5558>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <bce51ad2-e79a-f093-e895-114ad325b4cf@redhat.com>
Date: Thu, 2 Apr 2020 12:44:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402171940.GA21781@simran-Inspiron-5558>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 12:19 PM, Simran Singhal wrote:
> Change the "parser->bracket_count >= 0" to "parser->brace_count >= 0"
> to fix the typo.
> 
> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>

Please add:

Fixes: 8d3265b3

at which point you can also add:

Reviewed-by: Eric Blake <eblake@redhat.com>

> ---
> Changes in v2:
>          -No need to remove the duplicate occurence of "parser->bracket_count >= 0"
> 	but actually it is a typo and one occurence should be "parser->brace_count >= 0".

occurrence (but at least this typo won't make it into git)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


