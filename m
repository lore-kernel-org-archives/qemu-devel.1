Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26335C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA4B206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZG+98PpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA4B206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZqFA-0005aX-KQ
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 01:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kZqEL-00056O-H5
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:55:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kZqEI-0008LR-T0
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:55:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604386539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ig7J4QjrPhueH7/znaB6mKYdLZg/u7kuqbIzcbyVVbw=;
 b=ZG+98PpEDog/cpKQbbiiXSLrUttoP4qr4tedp/WoIAlBjoe8HQJJptcOYhE/GqXZYIuQ70
 3b1m7EPAfj2xw3kUUj8fauOhzL0LkkqunRvHGObjhDXsb9Li+FNsU7nyHJrSzFSF66HZef
 2nGi+xkHenlRy6ap+VZCt0tt4Jkkmu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-jL4pO3YbO7udgRQIG7LMEA-1; Tue, 03 Nov 2020 01:55:38 -0500
X-MC-Unique: jL4pO3YbO7udgRQIG7LMEA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF21F8030AE;
 Tue,  3 Nov 2020 06:55:36 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-233.ams2.redhat.com [10.36.112.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF24C6EF59;
 Tue,  3 Nov 2020 06:55:31 +0000 (UTC)
Subject: Re: [PATCH-for-5.2] hw/mips: Remove the 'r4k' machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201102102631.2058219-1-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e96d9497-cb8e-a86e-8e90-826a29f6710b@redhat.com>
Date: Tue, 3 Nov 2020 07:55:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201102102631.2058219-1-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: libvir-list@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/11/2020 11.26, Philippe Mathieu-Daudé wrote:
> We deprecated the support for the 'r4k' machine for the 5.0 release
> (commit d32dc61421), which means that our deprecation policy allows
> us to drop it in release 5.2. Remove the code.
> 
> To repeat the rationale from the deprecation note:
> - this virtual machine has no specification
> - the Linux kernel dropped support for it 10 years ago
> 
> Users are recommended to use the Malta board instead.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  docs/system/deprecated.rst                    |   2 +-
>  .../devices/mips-softmmu-common.mak           |   1 -
>  hw/mips/r4k.c                                 | 318 ------------------
>  MAINTAINERS                                   |   6 -
>  hw/mips/Kconfig                               |  13 -
>  hw/mips/meson.build                           |   1 -
>  6 files changed, 1 insertion(+), 340 deletions(-)
>  delete mode 100644 hw/mips/r4k.c
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 0ebce37a191..0e83ea2ca0a 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -327,7 +327,7 @@ The 'scsi-disk' device is deprecated. Users should use 'scsi-hd' or
>  System emulator machines
>  ------------------------
>  
> -mips ``r4k`` platform (since 5.0)
> +mips ``r4k`` platform (removed in 5.2)
>  '''''''''''''''''''''''''''''''''

You should move the paragraph to the "Recently removed features" section
instead.

 Thomas


