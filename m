Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63968C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B45F20786
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Pjol1y0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B45F20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBCz9-0004Wt-DW
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 04:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1kBCy9-0003Fl-T6
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:09:14 -0400
Received: from mout01.posteo.de ([185.67.36.65]:41668)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1kBCy7-0002co-FQ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:09:13 -0400
Received: from submission (posteo.de [89.146.220.130]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 03866160063
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 10:09:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
 t=1598515748; bh=jN24SPAZ/2evUSql6i+TkrJg4i0SKVW8QMpUGDhoT0k=;
 h=Subject:To:Cc:From:Date:From;
 b=Pjol1y0Uc/nkRIn97V/5JZW/iu7ImoIajmi2UFh7BZdSd2YIPZh7lEn2EXMiUWVnz
 fi1TKBMZUcQFC1Sr03MHoeFzkZaGX1N4N1KZ7qAV8WovGf40Jcjgh4WphKrTOfNTIT
 hDd8PbDw3zdxXpKFQ1T9qoC9DYFkUYxjrdDyS08BOtARh8snq3amv9W3lyu2rQcZEo
 pxoCzXKYcbuNdoHCQW0369mU85UTsOHWDJX3lygqOmblFS3N/+/424mpiGNfs3aJDC
 Fc3AvU38UOe3HV+TtrjJi78ha+fjhYgOFDHfZVoaEk0g2m/F33j6qMbL00uj+DNGCz
 QlN6qoJ8QeQgQ==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4Bcb3Q3yZfz6tmR;
 Thu, 27 Aug 2020 10:09:06 +0200 (CEST)
Subject: Re: [PATCH v2 20/58] mcf_fec: Move mcf_fec_state typedef to header
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200820001236.1284548-1-ehabkost@redhat.com>
 <20200820001236.1284548-21-ehabkost@redhat.com>
From: Thomas Huth <th.huth@posteo.de>
Message-ID: <2ccb85c1-ee1b-bb0a-8a19-a9516325b878@posteo.de>
Date: Thu, 27 Aug 2020 10:09:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200820001236.1284548-21-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth@posteo.de;
 helo=mout01.posteo.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:36:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.239,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Thomas Huth <huth@tuxfamily.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/08/2020 02.11, Eduardo Habkost wrote:
> Move typedef closer to the type check macros, to make it easier
> to convert the code to OBJECT_DEFINE_TYPE() in the future.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2: none
> 
> ---
> Cc: Thomas Huth <huth@tuxfamily.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  include/hw/m68k/mcf_fec.h | 1 +
>  hw/net/mcf_fec.c          | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/m68k/mcf_fec.h b/include/hw/m68k/mcf_fec.h
> index eeb471f9c9..c09e33a57c 100644
> --- a/include/hw/m68k/mcf_fec.h
> +++ b/include/hw/m68k/mcf_fec.h
> @@ -11,6 +11,7 @@
>  #define HW_M68K_MCF_FEC_H
>  
>  #define TYPE_MCF_FEC_NET "mcf-fec"
> +typedef struct mcf_fec_state mcf_fec_state;
>  #define MCF_FEC_NET(obj) OBJECT_CHECK(mcf_fec_state, (obj), TYPE_MCF_FEC_NET)
>  
>  #define FEC_NUM_IRQ 13
> diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
> index 281345862c..25e3e453ab 100644
> --- a/hw/net/mcf_fec.c
> +++ b/hw/net/mcf_fec.c
> @@ -32,7 +32,7 @@ do { printf("mcf_fec: " fmt , ## __VA_ARGS__); } while (0)
>  #define FEC_MAX_FRAME_SIZE 2032
>  #define FEC_MIB_SIZE 64
>  
> -typedef struct {
> +struct mcf_fec_state {
>      SysBusDevice parent_obj;
>  
>      MemoryRegion iomem;
> @@ -56,7 +56,7 @@ typedef struct {
>      uint32_t etdsr;
>      uint32_t emrbr;
>      uint32_t mib[FEC_MIB_SIZE];
> -} mcf_fec_state;
> +};
>  
>  #define FEC_INT_HB   0x80000000
>  #define FEC_INT_BABR 0x40000000
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

