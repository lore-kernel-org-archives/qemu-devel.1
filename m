Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B6EC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 07:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A95320936
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 07:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFNbgHIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A95320936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVrUS-0006pW-9i
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 03:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVrTs-0006Pv-Sm
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 03:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVrTr-0001CE-Cv
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 03:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603438038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HDCNW4O3z9IXJVZznxtLrBfYABeKDQkFX3n7P36RL9c=;
 b=dFNbgHIkr865+vPcTiuiyLSfXQmJhHkc10APwcTYnLC5oLg65DCZo9vRu+Vr3qIfunv2Gg
 uY7x8GT4d1ng7hd8apVnvGPr+gyy0YJ4E+z36a5HHgDRNrvoGtXzqolr+diucn2RwMIhwR
 BmfLd4DLl/ULjFkvSywsnzJa43YAQcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-eu80FjMQOJyQRNYNTlh51w-1; Fri, 23 Oct 2020 03:27:16 -0400
X-MC-Unique: eu80FjMQOJyQRNYNTlh51w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73B7E1074640;
 Fri, 23 Oct 2020 07:27:15 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-123.ams2.redhat.com [10.36.112.123])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CED111C922;
 Fri, 23 Oct 2020 07:27:14 +0000 (UTC)
Subject: Re: [PATCH 1/2] target/m68k: remove useless qregs array
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20201022203000.1922749-1-laurent@vivier.eu>
 <20201022203000.1922749-2-laurent@vivier.eu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ae05940f-51d3-e7e0-00f1-0377f31a9dc7@redhat.com>
Date: Fri, 23 Oct 2020 09:27:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201022203000.1922749-2-laurent@vivier.eu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/10/2020 22.29, Laurent Vivier wrote:
> They are unused since the target has been converted to TCG.
> 
> Fixes: e1f3808e03f7 ("Convert m68k target to TCG.")
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/cpu.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 521ac67cdd04..9a6f0400fcfe 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -33,8 +33,6 @@
>  #define OS_PACKED   6
>  #define OS_UNSIZED  7
>  
> -#define MAX_QREGS 32
> -
>  #define EXCP_ACCESS         2   /* Access (MMU) error.  */
>  #define EXCP_ADDRESS        3   /* Address error.  */
>  #define EXCP_ILLEGAL        4   /* Illegal instruction.  */
> @@ -139,8 +137,6 @@ typedef struct CPUM68KState {
>      int pending_vector;
>      int pending_level;
>  
> -    uint32_t qregs[MAX_QREGS];
> -
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;

Reviewed-by: Thomas Huth <thuth@redhat.com>

There are still some references to the term qreg in translate.c:

target/m68k/translate.c:#include "qregs.def"
target/m68k/translate.c:#include "qregs.def"
target/m68k/translate.c:/* Generate a jump to the address in qreg DEST.  */

Should these get renamed?

 Thomas


