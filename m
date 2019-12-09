Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D58C00454
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:14:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA7F20692
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXbaYIAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA7F20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieLgC-0006Vp-E9
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 11:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ieLfB-0005U2-Ls
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:13:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ieLf9-00047b-TV
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:13:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57310
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ieLf9-00047P-Pe
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575908011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nj2hHjpWw0OsW7IKuFPGD7PgkHmwOe9BsqEFycUai0U=;
 b=UXbaYIAscDN7vRuLXSfXZGBw5EvAye4YiHGjgWWDSwrmBMW2M+3b+/Sqnyv8mdiFnPnmig
 tGmA+DAxR62pfZc/DLlwlgFraKiq9bmPkOgRgEnE9Q75Si3qYKGNiK6xdNizM/LfzAOPHM
 mfkxBsQglqMIyWbLl646ZaWg98kFvL8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-AcjgsyzoOE2kBJRJYhqJYw-1; Mon, 09 Dec 2019 11:13:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF913593A1;
 Mon,  9 Dec 2019 16:13:26 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 607C160476;
 Mon,  9 Dec 2019 16:13:19 +0000 (UTC)
Subject: Re: [PULL 1/1] pseries: Update SLOF firmware image
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <20191209160015.20253-1-eblake@redhat.com>
 <20191209160015.20253-2-eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <036d6386-58dc-cf54-7987-256714285e92@redhat.com>
Date: Mon, 9 Dec 2019 10:13:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191209160015.20253-2-eblake@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: AcjgsyzoOE2kBJRJYhqJYw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, peter.maydell@linaro.org,
 vsementsov@virtuozzo.com, jsnow@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 10:00 AM, Eric Blake wrote:
> From: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> This fixes PCI bridge regression.
> 
> Alexey Kardashevskiy (3):
>        ibm,client-architecture-support: Fix stack handling
>        fdt: Fix updating the tree at H_CAS
>        version: update to 20191209
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>   pc-bios/README   |   2 +-
>   pc-bios/slof.bin | Bin 928552 -> 931040 bytes
>   roms/SLOF        |   2 +-
>   3 files changed, 2 insertions(+), 2 deletions(-)

No clue why my pull request script tried to mail this patch; the cover 
letter was correct. I'll resend the actual patch mentioned by the cover 
letter.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


