Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42188C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 07:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22DF21924
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 07:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqhiF9Wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22DF21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKzei-0000GF-VE
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 03:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKzd3-0007Rw-Pb
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 03:55:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23943
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKzd0-0000vN-Od
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 03:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600847748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CAR75+dWJ0oy+C4Blkmu4uQRB3uY7oE1J17EMXF8h80=;
 b=IqhiF9WxScsAPq84VcrddoNPkhKeyrpE7+18in3SxbnhDFKzrhRs1GRV8vSJrmkeiuLKQm
 MyRnl+XD6MtNR1LiRZW6sf0FblPmAEOcyzjAI/rSTqhhgLI3fFIOKDNJUugs9gpTeBWWHW
 RWIO/hz8IoaBkS08hO1x6rQ7GVphFao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-vwDw4-JyNyGp2egvdJxy_Q-1; Wed, 23 Sep 2020 03:55:45 -0400
X-MC-Unique: vwDw4-JyNyGp2egvdJxy_Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD16581F00F;
 Wed, 23 Sep 2020 07:55:44 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-49.ams2.redhat.com [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71A0F78826;
 Wed, 23 Sep 2020 07:55:43 +0000 (UTC)
Subject: Re: [PATCH] Deprecate lm32 port
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200827113259.25064-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a1dda44f-e521-ef82-f5bc-7435c81fe888@redhat.com>
Date: Wed, 23 Sep 2020 09:55:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200827113259.25064-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 03:55:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Michael Walle <michael@walle.cc>, "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/08/2020 13.32, Peter Maydell wrote:
> Deprecate our lm32 target support. Michael Walle (former lm32 maintainer)
> suggested that we do this in 2019:
>  https://www.mail-archive.com/qemu-devel@nongnu.org/msg605024.html
> because the only public user of the architecture is the many-years-dead
> milkymist project. (The Linux port to lm32 was never merged upstream.)
> 
> In commit 4b4d96c776f552e (March 2020) we marked it as 'orphan' in
> the MAINTAINERS file, but didn't officially deprecate it. Mark it
> deprecated now, with the intention of removing it from QEMU in
> mid-2021 before the 6.1 release.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Based-on: 20200825172719.19422-1-peter.maydell@linaro.org
> ("Deprecate Unicore32 port") to avoid the obvious textual-conflict.
> 
>  docs/system/deprecated.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 4c52098c707..5c7fc8a3c99 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -416,6 +416,14 @@ The above, converted to the current supported format::
>  linux-user mode CPUs
>  --------------------
>  
> +``lm32`` CPUs (since 5.2.0)
> +'''''''''''''''''''''''''''
> +
> +The ``lm32`` guest CPU support is deprecated and will be removed in
> +a future version of QEMU. The only public user of this architecture
> +was the milkymist project, which has been dead for years; there was
> +never an upstream Linux port.

I was just looking at the current version of deprecated.rst (which has
this patch included), and could it be that it ended up in the wrong
section here? "lm32" is rather a softmmu target, not a linux-user mode CPU?

 Thomas


