Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882EAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:12:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CFBE206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TI75IPFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFBE206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixZqE-0002ft-DL
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ixZpB-0001PI-O4
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ixZp9-0002kH-R7
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:11:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30555
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ixZp9-0002he-NL
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580490678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XmYUhX+Coo8LK5j6iZ/AGX0kk82S6qjoh9Wg6ExfkyQ=;
 b=TI75IPFgQMTe0S/ZWCAh7MFntWmbNUm/wjPB7/FXixIf/E86evriHZF8Ku6agqfSjHcyiD
 q/dgX7SyQVcK4RAzRWZTwYlsT/IG1vXJxxUbQjVqSHlGzEIbm4KRGehKJ/SqzXaSmFULpB
 KFje2KxuPK3CRE7y70Lg0N7oPODszq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-IkSHn0a0O6qX5_nIt96ScQ-1; Fri, 31 Jan 2020 12:11:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4F68800D5B;
 Fri, 31 Jan 2020 17:11:15 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 379281001B2B;
 Fri, 31 Jan 2020 17:11:12 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] finish qemu-nbd --partition deprecation
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <20200123164650.1741798-1-eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b3fe3a5b-0692-fb35-55ec-281fc2699e98@redhat.com>
Date: Fri, 31 Jan 2020 11:11:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123164650.1741798-1-eblake@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: IkSHn0a0O6qX5_nIt96ScQ-1
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
Cc: peter.maydell@linaro.org,
 "libvirt-list@redhat.com" <libvirt-list@redhat.com>, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping

On 1/23/20 10:46 AM, Eric Blake wrote:
> Based-on: <20200116141511.16849-1-peter.maydell@linaro.org>
> (0/3 convert qemu-nbd, qemu-block-drivers to rST)
> 
> In v2:
> - rebased on top of rST doc changes
> - patch 1 added
> 
> Eric Blake (2):
>    docs: Fix typo in qemu-nbd -P replacement
>    qemu-nbd: Removed deprecated --partition option
> 
>   docs/interop/qemu-nbd.rst |  15 ++---
>   qemu-deprecated.texi      |  49 ++++++--------
>   qemu-nbd.c                | 133 +-------------------------------------
>   3 files changed, 24 insertions(+), 173 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


