Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AC1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 07:33:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84AA72080D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 07:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULk4OBKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84AA72080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRsKr-00052c-IK
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 03:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kRsJq-0004V5-Iq
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 03:32:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kRsJo-00012u-Vv
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 03:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602487945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cP6Ij0JDPXAEt5O6ghPsImAMlBHw5j7+FOjjThyyDyQ=;
 b=ULk4OBKSrtasNEPebOzLBjLdU3VgwYT3BrWse1wpWez1ds00ZYC/AjfElVPNTuBQhTQIvi
 Mb2Cwa+qKI32T54Dup//xubNB7DccsHXm4LCMK8U1/TBtW9t/KEWm5JCXe5lxtFuPlDy+a
 +wavxYynTHNdWUra6iwPHnJf0Aca+48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-sliaujHLPpu5-6h-NnXoOQ-1; Mon, 12 Oct 2020 03:32:18 -0400
X-MC-Unique: sliaujHLPpu5-6h-NnXoOQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6607100A24C;
 Mon, 12 Oct 2020 07:32:16 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-22.ams2.redhat.com [10.36.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A74819C78;
 Mon, 12 Oct 2020 07:32:14 +0000 (UTC)
Subject: Re: [PATCH 4/4] docs/system/target-ppc.rst: Update PReP historical
 information
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201012071906.3301481-1-f4bug@amsat.org>
 <20201012071906.3301481-5-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <39636370-3fa7-aee4-07ca-2371757bb8b4@redhat.com>
Date: Mon, 12 Oct 2020 09:32:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201012071906.3301481-5-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Jocelyn Mayer <l_indien@magic.fr>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/10/2020 09.19, Philippe Mathieu-Daudé wrote:
> Link Jocelyn Mayer's web page from the Wayback Machine,
> and correct the PReP acronym.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Cc: Jocelyn Mayer <l_indien@magic.fr>
> ---
>  docs/system/target-ppc.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/system/target-ppc.rst b/docs/system/target-ppc.rst
> index a2f04c533c2..1f57966771d 100644
> --- a/docs/system/target-ppc.rst
> +++ b/docs/system/target-ppc.rst
> @@ -3,7 +3,7 @@
>  PowerPC System emulator
>  -----------------------
>  
> -Use the executable ``qemu-system-ppc`` to simulate a complete 40P (PREP)
> +Use the executable ``qemu-system-ppc`` to simulate a complete 40P (PReP)
>  or PowerMac PowerPC system.
>  
>  QEMU emulates the following PowerMac peripherals:
> @@ -20,7 +20,7 @@ QEMU emulates the following PowerMac peripherals:
>  
>  -  VIA-CUDA with ADB keyboard and mouse.
>  
> -QEMU emulates the following 40P (PREP) peripherals:
> +QEMU emulates the following 40P (PReP) peripherals:
>  
>  -  PCI Bridge
>  
> @@ -43,5 +43,5 @@ the g3beige and mac99 PowerMac and the 40p machines. OpenBIOS is a free
>  (GPL v2) portable firmware implementation. The goal is to implement a
>  100% IEEE 1275-1994 (referred to as Open Firmware) compliant firmware.
>  
> -More information is available at
> -http://perso.magic.fr/l_indien/qemu-ppc/.
> +Archived historical information is available at
> +https://web.archive.org/web/20051212135300/http://perso.magic.fr/l_indien/qemu-ppc/.

There seems to be a later version available in the archive, too:

https://web.archive.org/web/20080212093125/http://perso.magic.fr/l_indien/qemu-ppc/

... but I think the contents did not change anymore. So:

Reviewed-by: Thomas Huth <thuth@redhat.com>


