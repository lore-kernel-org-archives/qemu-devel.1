Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034E4C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EBA20678
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLRF6d9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EBA20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZyjr-000511-U0
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 09:56:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iZyip-00043X-Sv
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:55:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iZyio-0002ht-TA
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:55:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58065
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iZyio-0002hf-Pb
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:55:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574866514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=teQhX9ZP8G7bPnrnovOVEkUhnQX+02wb9y7BE0TGd6E=;
 b=PLRF6d9o4CfgaBqtDoeauBO+xg2iI/xeE3rENTynUCnUyY+hvhvzdluC2qceOjtHatkUSE
 rEJ3KDeQcmgvRx4dJSW4GfieCVNvx6wbX8dWQPVAZAUoKPgIr9BDghCQeuQCSbImPGYu7E
 XPCVB7I3geTEZHyxh77sDUx0+nFnUK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-tBEnypCcML-mjhemso8xmA-1; Wed, 27 Nov 2019 09:55:11 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24D41801E5A;
 Wed, 27 Nov 2019 14:55:10 +0000 (UTC)
Received: from [10.3.116.163] (ovpn-116-163.phx2.redhat.com [10.3.116.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 042CA131FE70;
 Wed, 27 Nov 2019 14:55:08 +0000 (UTC)
Subject: Re: [PATCH] iotests/273: Filter format-specific information
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191127120614.513834-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4cd65ef2-8948-e8bc-5d60-01e03d383220@redhat.com>
Date: Wed, 27 Nov 2019 08:55:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191127120614.513834-1-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: tBEnypCcML-mjhemso8xmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/27/19 6:06 AM, Max Reitz wrote:
> Doing this allows running this test with e.g. -o compat=0.10 or
> -o compat=refcount_bits=1.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/273     |  3 ++-
>   tests/qemu-iotests/273.out | 27 ---------------------------
>   2 files changed, 2 insertions(+), 28 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

Harmless if we have reason to include it in -rc3, but late enough that 
it is not by itself a reason to hold up the 4.2 release, so it's also 
fine if it slips to 5.0.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


