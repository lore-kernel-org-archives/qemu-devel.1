Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FFDC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2961420878
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LahHLSdi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2961420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO3YK-0001U5-7V
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kO3Xg-0000e9-9E
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 14:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kO3Xd-0005kn-Un
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 14:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601577776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V1SCDp4hy1FKNoF+R4/BFbx+dcTDTU9haxk2VctjCS0=;
 b=LahHLSdiFJwv0SCK2Awp5tBs+t6IUDAztYt/N0D+HfJaCYvcjTY0jtvG3uxbLUoC7wuM2r
 mgvngSBMBwa5pfgJU7KKtnSAiA21VIrF5Rmv+nEzAgRuoZGr5hV0SD2kwwPT4/Wh/toTFI
 rvZ2COYTJJ4coNsX9h9Ec/QyWP8Wbd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-G0-5WzctPuukBUUg2uoSDg-1; Thu, 01 Oct 2020 14:42:52 -0400
X-MC-Unique: G0-5WzctPuukBUUg2uoSDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7773108E1CB;
 Thu,  1 Oct 2020 18:42:48 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 306415DA74;
 Thu,  1 Oct 2020 18:42:39 +0000 (UTC)
Date: Thu, 1 Oct 2020 14:42:38 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 1/3] util/cutils: Introduce freq_to_str() to display
 Hertz units
Message-ID: <20201001184238.GI3717385@habkost.net>
References: <20201001164322.1585392-1-f4bug@amsat.org>
 <20201001164322.1585392-2-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20201001164322.1585392-2-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Havard Skinnemoen <hskinnemoen@google.com>,
 Tyrone Ting <kfting@nuvoton.com>, Damien Hedde <damien.hedde@greensocs.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc@lmichel.fr>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 01, 2020 at 06:43:20PM +0200, Philippe Mathieu-Daudé wrote:
> Introduce freq_to_str() to convert frequency values in human
> friendly units using the SI units for Hertz.
> 
> Suggested-by: Luc Michel <luc@lmichel.fr>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/qemu/cutils.h | 12 ++++++++++++
>  util/cutils.c         | 14 ++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index 3a86ec0321..4bbf4834ea 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -158,6 +158,18 @@ int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *result);
>  
>  char *size_to_str(uint64_t val);
>  
> +/**
> + * freq_to_str:
> + * @freq_hz: frequency to stringify
> + *
> + * Return human readable string for frequency @freq_hz.
> + * Use SI units like KHz, MHz, and so forth.
> + *
> + * The caller is responsible for releasing the value returned
> + * with g_free() after use.
> + */
> +char *freq_to_str(uint64_t freq_hz);
> +
>  /* used to print char* safely */
>  #define STR_OR_NULL(str) ((str) ? (str) : "null")
>  
> diff --git a/util/cutils.c b/util/cutils.c
> index 8da34e04b0..be4e43a9ef 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -885,6 +885,20 @@ char *size_to_str(uint64_t val)
>      return g_strdup_printf("%0.3g %sB", (double)val / div, suffixes[i]);
>  }
>  
> +char *freq_to_str(uint64_t freq_hz)
> +{
> +    static const char *const suffixes[] = { "", "K", "M", "G", "T", "P", "E" };
> +    double freq = freq_hz;
> +    size_t idx = 0;
> +
> +    while (freq >= 1000.0 && idx < ARRAY_SIZE(suffixes)) {
> +        freq /= 1000.0;
> +        idx++;
> +    }
> +
> +    return g_strdup_printf("%0.3g %sHz", freq, suffixes[idx]);

The only thing protecting this from out of bounds array access is
the fact that UINT64_MAX is smaller than 1000E.  I wonder if this
causes a Coverity warning.

> +}
> +
>  int qemu_pstrcmp0(const char **str1, const char **str2)
>  {
>      return g_strcmp0(*str1, *str2);
> -- 
> 2.26.2
> 

-- 
Eduardo


