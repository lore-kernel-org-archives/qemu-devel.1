Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E674BC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF66920873
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="az5XhZ+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF66920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBK0b-0005sL-TD
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jBJzx-0005J0-5H
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jBJzw-0006fT-7l
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:07:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28162
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jBJzw-0006fI-3B
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583766435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rCTQqPb0MqrRy0isFN56NKQxK9h/ZHsOznKh3+eYFh4=;
 b=az5XhZ+bWVIsn6HefTnzrPBBmqID7z0o2KjZ/51xZIjkLD9OUVMsFf5kzEQirxicZ47bkL
 okklzDmSqH4qgdHVQ2irCl6NyGji3oF0LMQfYbnCQ2xJO0Rg1vbaOnrXfIPN607O8dEI94
 kd62TXhkN1NDi4utSobM9UqMwqxnvzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-AM1LnAZDODynjMvpyO0LEg-1; Mon, 09 Mar 2020 11:07:12 -0400
X-MC-Unique: AM1LnAZDODynjMvpyO0LEg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA54785EE90;
 Mon,  9 Mar 2020 15:07:10 +0000 (UTC)
Received: from [10.3.116.177] (ovpn-116-177.phx2.redhat.com [10.3.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CA0A7389B;
 Mon,  9 Mar 2020 15:07:10 +0000 (UTC)
Subject: Re: [PATCH] docs: Add RX target.
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org,
 philmd@redhat.com
References: <20200308130637.37651-1-ysato@users.sourceforge.jp>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e6ccf136-cf93-865d-31bb-4463b65416a9@redhat.com>
Date: Mon, 9 Mar 2020 10:07:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200308130637.37651-1-ysato@users.sourceforge.jp>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/8/20 8:06 AM, Yoshinori Sato wrote:
> Add rx-virt target specificaion document.

specification

> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>   docs/system/target-rx.rst | 35 +++++++++++++++++++++++++++++++++++
>   docs/system/targets.rst   |  1 +
>   2 files changed, 36 insertions(+)
>   create mode 100644 docs/system/target-rx.rst
> 
> diff --git a/docs/system/target-rx.rst b/docs/system/target-rx.rst
> new file mode 100644
> index 0000000000..8540fd5218
> --- /dev/null
> +++ b/docs/system/target-rx.rst
> @@ -0,0 +1,35 @@
> +.. _RX-System-emulator:
> +
> +RX System emulator
> +--------------------
> +
> +Use the executable ``qemu-system-rx`` to simulate a Virtual RX target.
> +This target emulated following devices.

s/emulated/emulates the/


> +++ b/docs/system/targets.rst
> @@ -17,3 +17,4 @@ Contents:
>      target-arm
>      target-m68k
>      target-xtensa
> +   target-rx

Is it worth keeping this list alphabetically sorted?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


