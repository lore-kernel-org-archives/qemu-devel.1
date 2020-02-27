Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D194C4BA37
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:57:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93CC24670
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQdE7Wyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93CC24670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j79MT-0000JG-03
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 21:57:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j79LF-0007a0-Qu
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j79LE-0002Qy-C1
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:56:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48034
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j79LE-0002Ni-7c
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582772150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jOD1mvtKL71jY8cnJeuHBQHBFrZ7+qrm+WKIb39u4Ds=;
 b=QQdE7WycIeO7uXGAp6oHaQNx8teHnjORoHngwGC5hWMMKLZe/3DadQdszJs31sticlSs4e
 Y5Tv+fhcV6t7YVnY3UWNpDxEpWIHtDlNJqAC/yW/XqQtIfTK+cb8E8RRHDAbjIgpO24MIe
 1tCnypHXQdM2QeDyQ3G+H5p2JEq4No0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-8MQGQyG2PyC1XZYflqZkAA-1; Wed, 26 Feb 2020 21:55:44 -0500
X-MC-Unique: 8MQGQyG2PyC1XZYflqZkAA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5345C1902EA1;
 Thu, 27 Feb 2020 02:55:43 +0000 (UTC)
Received: from [10.3.116.57] (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B8C692990;
 Thu, 27 Feb 2020 02:55:33 +0000 (UTC)
Subject: Re: [PATCH 1/2] fuzz: fix typos in linker-script comments
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200227024856.23777-1-alxndr@bu.edu>
 <20200227024856.23777-2-alxndr@bu.edu>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3476395c-3aba-6246-d11c-f108e33edfcd@redhat.com>
Date: Wed, 26 Feb 2020 20:55:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227024856.23777-2-alxndr@bu.edu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bandan Das <bsd@redhat.com>, Thomas Huth <thuth@redhat.com>,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/26/20 8:48 PM, Alexander Bulekov wrote:
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>   tests/qtest/fuzz/fork_fuzz.ld | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/fuzz/fork_fuzz.ld b/tests/qtest/fuzz/fork_fuzz.ld
> index b23a59f194..b5aad06f20 100644
> --- a/tests/qtest/fuzz/fork_fuzz.ld
> +++ b/tests/qtest/fuzz/fork_fuzz.ld
> @@ -1,5 +1,5 @@
>   /* We adjust linker script modification to place all of the stuff that needs to
> - * persist across fuzzing runs into a contiguous seciton of memory. Then, it is
> + * persist across fuzzing runs into a contiguous section of memory. Then, it is
>    * easy to re-map the counter-related memory as shared.
>   */
>   
> @@ -32,6 +32,6 @@ SECTIONS
>         __FUZZ_COUNTERS_END = .;
>     }
>   }
> -/* Dont overwrite the SECTIONS in the default linker script. Instead insert the
> +/* Don't overwrite the SECTIONS in the default linker script. Instead insert the
>    * above into the default script */

As long as you're touching these two comments, checkpatch is going to 
complain that they don't follow the usual style of:

/*
  * Text starts here...
  * through here.
  */

If you fix that as well for these two comments,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


