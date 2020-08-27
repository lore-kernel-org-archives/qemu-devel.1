Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E17EC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAFED206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6nbapsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFED206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBIKp-0007jo-96
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 09:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBIKI-0007Jp-6J
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:52:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBIKG-0007zs-3O
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598536342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oThdlIrllQDLF+Ns4fsBpYk786vgQXR0rR11wIQjC/4=;
 b=N6nbapsqnitnM7ChNwuBtkUfH+O+ZZbCzdsTKrrKAvLgvx9gre5CNnc/yJqhS/0M8+0pm1
 QHRSsk6yWqD73q/Og8vC7i0z1b0yiy152G54Xwg16E64JPuVSEzq81q7MrtWKkY0qFou0R
 FBXZSyUmRrf5fwbX6RbLFzwMUX9wLnY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-1IekiwF_OZWdq04IMhbz1w-1; Thu, 27 Aug 2020 09:52:18 -0400
X-MC-Unique: 1IekiwF_OZWdq04IMhbz1w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 890B4802B62;
 Thu, 27 Aug 2020 13:52:17 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 321AD5D9F1;
 Thu, 27 Aug 2020 13:52:15 +0000 (UTC)
Subject: Re: [PATCH] Deprecate lm32 port
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200827113259.25064-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8385e0cf-b955-e62d-dfdc-51380b7c5433@redhat.com>
Date: Thu, 27 Aug 2020 15:52:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200827113259.25064-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:54:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.782, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Thomas Huth <thuth@redhat.com>

What's next? moxie? ... apart from the tree-wide clean-ups and trivial
fixes, moxie did not have any major updates since 2013 when it has been
added, as far as I can see ... is anybody still using it?


