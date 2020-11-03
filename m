Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B2EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67710206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDDFkSpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67710206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZqI5-0006dV-08
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 01:59:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kZqHF-0006BB-6X
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:58:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kZqHD-0000jy-75
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604386721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HlkIYGaxOBu2otrI5g4e4P49HIcT7CAAVkQUNCaPoOA=;
 b=HDDFkSpuW5YbVtJQBCIaQdMv5OBlrgBSuGiDoiGav9DS8s/dtpIKR+PjGyhh2p5/QyiV8X
 CviL5b0tcutg+/wtrtQfCWvDh4XMBhIUD1Z6r0FIgKumZ+6+bc8Uy22UUcFKhOhlz/vbcs
 bIpg0u9CC0Nnn/qrMlXfRtqgAI5/Pww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-9063gRUGM3-Kh3Ftifq6fw-1; Tue, 03 Nov 2020 01:58:37 -0500
X-MC-Unique: 9063gRUGM3-Kh3Ftifq6fw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EFB0801FD6;
 Tue,  3 Nov 2020 06:58:36 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-233.ams2.redhat.com [10.36.112.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF5FA5C230;
 Tue,  3 Nov 2020 06:58:31 +0000 (UTC)
Subject: Re: [PATCH-for-5.2 v3] hw/mips: Remove the 'r4k' machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201102201311.2220005-1-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b79011dc-db5f-ec86-96f6-852a9d32bed7@redhat.com>
Date: Tue, 3 Nov 2020 07:58:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201102201311.2220005-1-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/11/2020 21.13, Philippe Mathieu-Daudé wrote:
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
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v3: Move to "Recently removed features" section
> ---
>  docs/system/deprecated.rst                    |  12 +-
>  .../devices/mips-softmmu-common.mak           |   1 -
>  hw/mips/r4k.c                                 | 318 ------------------
>  MAINTAINERS                                   |   6 -
>  hw/mips/Kconfig                               |  13 -
>  hw/mips/meson.build                           |   1 -
>  6 files changed, 6 insertions(+), 345 deletions(-)
>  delete mode 100644 hw/mips/r4k.c
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 0ebce37a191..e5b7cf274d3 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -327,12 +327,6 @@ The 'scsi-disk' device is deprecated. Users should use 'scsi-hd' or
>  System emulator machines
>  ------------------------
>  
> -mips ``r4k`` platform (since 5.0)
> -'''''''''''''''''''''''''''''''''
> -
> -This machine type is very old and unmaintained. Users should use the ``malta``
> -machine type instead.
> -
>  mips ``fulong2e`` machine (since 5.1)
>  '''''''''''''''''''''''''''''''''''''
>  
> @@ -575,6 +569,12 @@ The version specific Spike machines have been removed in favour of the
>  generic ``spike`` machine. If you need to specify an older version of the RISC-V
>  spec you can use the ``-cpu rv64gcsu,priv_spec=v1.10.0`` command line argument.
>  
> +mips ``r4k`` platform (removed in 5.2)
> +''''''''''''''''''''''''''''''''''''''
> +
> +This machine type is very old and unmaintained. Users should use the ``malta``
> +machine type instead.

Ah, just spotted this v3 - that's better now indeed :-)
Maybe change "is very old" into "was very old"?

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>


