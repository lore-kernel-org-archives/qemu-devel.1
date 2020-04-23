Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A1BC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:35:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445CF20736
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/+2x6vy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445CF20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRfkv-0004Kr-E5
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 13:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRfjv-0002rI-FK
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRfjr-0007ca-2u
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:34:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43854
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRfjq-0007bC-KW
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587663254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wdpcyR9mGmnTm3UtdbYmdJ9tj1Qm+92Xqg0VfT0/Aug=;
 b=H/+2x6vy5ZQfu1I0gL/noVn/jIZ37q6hnv7fu8F1BQ3GpPov/Qrjz5o+e2d7cZht8Zycm3
 RSxHeW2A+dKFPR/24ZuPewfxFyQ3VIm+P5K/7jBLd2ij03V63BJqhf1lWEokguFq5vgwR5
 lR8x99XzbsZLxzdgyDgDCX6f0rBYoGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-I2Hk4g3aOiOojbPHjbi9ew-1; Thu, 23 Apr 2020 13:34:02 -0400
X-MC-Unique: I2Hk4g3aOiOojbPHjbi9ew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 285B8107ACF2;
 Thu, 23 Apr 2020 17:34:01 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 764A660C18;
 Thu, 23 Apr 2020 17:34:00 +0000 (UTC)
Subject: Re: [PATCH 02/13] qapi: Fix the virtual walk example in visitor.h's
 big comment
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200423160036.7048-1-armbru@redhat.com>
 <20200423160036.7048-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <fdb48b5b-7051-254d-a5a0-8de39a21cecb@redhat.com>
Date: Thu, 23 Apr 2020 12:33:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423160036.7048-3-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 02:14:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 11:00 AM, Markus Armbruster wrote:
> Call visit_check_list().  Missed in commit a4a1c70dc7 "qapi: Make
> input visitors detect unvisited list tails".
> 
> Drop an irrelevant error_propagate() while there.

Aha - you found this because of your error cleanup work ;)

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qapi/visitor.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


