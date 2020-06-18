Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34718C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 07:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B3121BE5
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 07:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCnhGFOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B3121BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlotI-000713-AB
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 03:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jlosQ-00061K-St
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 03:22:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28474
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jlosP-0006Cg-E7
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 03:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592464940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WuKyOet/AaV5QvIueDD/F5fYHhvYjh5IjfC51YZ2wMA=;
 b=XCnhGFOnU6Tnyxs5IwxxrlzLbWJcTKYHlFvpB1XGzY8x34IcutvwdeohE43OY05im2IfyX
 hDMs3XMOpF4dQCsGXCVGNJP6w7aqmQunBP+c3T9j/597olEFyTUSRjVL3p2iGkm+RBdGdw
 60NGoyXI7a/UZBd+jLZI/OJTyq3OawI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-NPOAOyynM06J5WPp0SzeuA-1; Thu, 18 Jun 2020 03:22:18 -0400
X-MC-Unique: NPOAOyynM06J5WPp0SzeuA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1062E107ACCA;
 Thu, 18 Jun 2020 07:22:17 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A930A19931;
 Thu, 18 Jun 2020 07:22:12 +0000 (UTC)
Subject: Re: [PATCH v4 8/8] tpm: Disable interrupt support for TIS on sysbus
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200617142305.1198672-1-stefanb@linux.vnet.ibm.com>
 <20200617142305.1198672-9-stefanb@linux.vnet.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <82d6e996-f4e7-bf5d-0a08-368adff2f31b@redhat.com>
Date: Thu, 18 Jun 2020 09:22:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200617142305.1198672-9-stefanb@linux.vnet.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:47:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
 philmd@redhat.com, mkedzier@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 6/17/20 4:23 PM, Stefan Berger wrote:
> Disable interrupt support for the TIS on sysbus.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Message-id: 20200616205721.1191408-9-stefanb@linux.vnet.ibm.com
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/hw/acpi/tpm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index d356f2e06e..21f81690a5 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -25,7 +25,7 @@
>  #define TPM_TIS_ADDR_SIZE           0x5000
>  
>  #define TPM_TIS_ISA_IRQ             13    /* only one possible */
> -#define TPM_TIS_SYSBUS_IRQ          5
> +#define TPM_TIS_SYSBUS_IRQ          TPM_IRQ_DISABLED
>  
>  #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
>  #define TPM_TIS_LOCALITY_SHIFT      12
> 


