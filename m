Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696FCC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F29216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+uCwv11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F29216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjQz9-0003qN-CY
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 12:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41905)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <frasse.iglesias@gmail.com>) id 1hjQnT-0001Yg-BF
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frasse.iglesias@gmail.com>) id 1hjQnQ-0004zO-Tp
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:10:50 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:34239)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
 id 1hjQnQ-0004vB-LO; Fri, 05 Jul 2019 12:10:48 -0400
Received: by mail-lf1-x142.google.com with SMTP id b29so6699497lfq.1;
 Fri, 05 Jul 2019 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=awTb69l5hLwdxql4WcINY2RSzlnobwbnmh6DKscJkCs=;
 b=d+uCwv11FOleIZ1FDQN4UBLkz7KfUeu7ZadYGhd1UBl8s6G+pS6muGOobED/NAViia
 8a9SmQrGK35Yug2tAR4dz7OaW3eOEYVl6OmdL4mAJXDj4Jh0HDktML7cLnK8s4WZmiu5
 onyspJ9Eeji+5vsCAVaCpGbGVoNc90SniwfICpS5LumhcnQ70t53kPC5GTFRd//KCsEN
 wiDzzyMG6AUUbkLB2PqvvhaSTKKJxPFrkHxBiFyrVxMDUluu88JPEyxpgbRFA+bSV1zd
 1XcOY59GWxMBJn+rReemJ7LXju4Zgo6R8XITrTjESWugceM/9YY0ZsMOoEaneiQdbaW5
 C6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=awTb69l5hLwdxql4WcINY2RSzlnobwbnmh6DKscJkCs=;
 b=I/qof5VBKVVzgj20NBNqw3xe3D8vxYuKaflZ56b4wWb0BfhAUHVzhrkBQoiMTNi0pZ
 iePaxYoyLaWvjJUbdVjquX2SXMfTfscrXoyVNpdeRc/zZiXeV3j1hfmU9WgSHvlHn4qn
 xxx6+pd0EYypFJCb0VjhLqP1CWPNlb8HJzjuhvXQ5PY3r37HfwP6UlDtAbQqP+apVBFr
 pIjhse/xKyzmrXhQ8lcdfk/UJdqsgHnPmMH8IlaqKM9l0EdKfz2Tn2kHUHXrzmX0TsVI
 dxBojaZqmKj35Mh9b4iSzCJlAi2CZVc7jJo9IV7oocoeT/mt3u+eJrjsRvXQzh1AMaF/
 PVUQ==
X-Gm-Message-State: APjAAAURkvrZtnv8g7mGcGyOKa7LzoFO4BxQPXCcaVdrH1kksBcLWuqE
 E/a9tgRRjFhUoOTq//c6fw4=
X-Google-Smtp-Source: APXvYqy+/0D2BiTouDsLNur5euF4Pr0AUC9wlmA/oKzp1uxAwIScv+JjRb1Wl4SC7F8tcRFVuMo0+g==
X-Received: by 2002:ac2:44b1:: with SMTP id c17mr2348205lfm.87.1562343046995; 
 Fri, 05 Jul 2019 09:10:46 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 137sm1845140ljj.46.2019.07.05.09.10.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 05 Jul 2019 09:10:46 -0700 (PDT)
Date: Fri, 5 Jul 2019 18:10:44 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190705161044.pyfkofyz6llg4ztn@fralle-msi>
References: <20190705150850.4967-1-philmd@redhat.com>
 <20190705150850.4967-3-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190705150850.4967-3-philmd@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH v3 2/2] hw/ssi/xilinx_spips: Avoid AXI
 writes to the LQSPI linear memory
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Prasad J Pandit <ppandit@redhat.com>, Lei Sun <slei.casper@gmail.com>,
 qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On [2019 Jul 05] Fri 17:08:50, Philippe Mathieu-Daudé wrote:
> Lei Sun found while auditing the code than a CPU write would

s/than/that/

> trigger a NULL pointer deference.

s/deference/dereference/

> 
> From UG1085 datasheet [*] AXI writes in this region are ignored
> and generates an External Slave Error (SLVERR).

s/External/AXI/

> 
> Fix by implementing the write_with_attrs() handler.
> Return MEMTX_ERROR  when the region is accessed  (this error maps

There is an extra whitespace after 'MEMTX_ERROR' and also after
'accessed'.

Sorry for not mentioning above before, after correcting this cosmetica:

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

Best regards,
Francisco Iglesias

> to an AXI slave error).
> 
> [*] https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultrascale-trm.pdf
> 
> Reported-by: Lei Sun <slei.casper@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/ssi/xilinx_spips.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index e80619aece..4c0b0aa3c9 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -1221,8 +1221,24 @@ static MemTxResult lqspi_read(void *opaque, hwaddr addr, uint64_t *value,
>      return MEMTX_OK;
>  }
>  
> +static MemTxResult lqspi_write(void *opaque, hwaddr offset, uint64_t value,
> +                               unsigned size, MemTxAttrs attrs)
> +{
> +    /*
> +     * From UG1085, Chapter 24 (Quad-SPI controllers):
> +     * - Writes are ignored
> +     * - AXI writes generate an external AXI slave error (SLVERR)
> +     */
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s Unexpected %u-bit access to 0x%" PRIx64
> +                                   " (value: 0x%" PRIx64 "\n",
> +                  __func__, size << 3, offset, value);
> +
> +    return MEMTX_ERROR;
> +}
> +
>  static const MemoryRegionOps lqspi_ops = {
>      .read_with_attrs = lqspi_read,
> +    .write_with_attrs = lqspi_write,
>      .endianness = DEVICE_NATIVE_ENDIAN,
>      .valid = {
>          .min_access_size = 1,
> -- 
> 2.20.1
> 

