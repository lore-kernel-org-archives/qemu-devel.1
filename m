Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07389C06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 10:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D07962189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 10:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07962189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiyjJ-0000R6-1O
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 06:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42670)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiyhz-0007oU-TG
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiyhw-00046X-38
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:11:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiyhu-00045f-RO
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:11:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so5153433wmj.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 03:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T12ELBIQOvpU4zK2KzgxIGBuajSkwKNPgvhXDMhJJGw=;
 b=bBiSdBVvVsoGD4Q237QIp23K8PxMWspCNcFQg8hJmmKHYM2vZA6y+lFDC16gqOdDKz
 QZo7SJo2U337Ct66MJfkSmNQSsHAzU6Y3po0wIZVnoMx/f/jKapXv5TNEoqjpxlOZgRz
 Mzo08LsoNf8PMQETFeUBmtvH9oH0KTv4/dnV7XBu9zl8L5B1FakCya6y6Qn/Aa2jXcL6
 96q/H7ERtfYE0N1q6UaaCpDkCN5OjzXI3hr1oj90cjXTIDfd56mSVKLh2cpPib4LWC5Y
 0INZJB2OZxoar9hvGjxKSyr21nP9mAg1zZyN4wLO3SYPD7GptrCazU3dpWifriJoD8lL
 I7Nw==
X-Gm-Message-State: APjAAAUfwEm3pRdMhcilvCd++HX2IJxFx5CGnMDva+Ln/n9kf/S7sx85
 BNi/M+dQzO/aHY6UYs+5VG5P4A==
X-Google-Smtp-Source: APXvYqyaVuDHgQ1j4VnWiq9HEvHrEHueiejBJ2MEemePagq+EawgOvdRGca122JBp0rBRapjRFlXwg==
X-Received: by 2002:a1c:7d8e:: with SMTP id y136mr11695069wmc.16.1562235073742; 
 Thu, 04 Jul 2019 03:11:13 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id o20sm10284070wrh.8.2019.07.04.03.11.12
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jul 2019 03:11:13 -0700 (PDT)
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Sai Pavan Boddu <saipava@xilinx.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20190703190615.31436-1-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <59f87427-3d1d-928b-ac87-0a0a4049c4f5@redhat.com>
Date: Thu, 4 Jul 2019 12:11:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703190615.31436-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH] hw/ssi/xilinx_spips: add lqspi_write
 routine
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
Cc: Lei Sun <slei.casper@gmail.com>, qemu-arm@nongnu.org,
 Prasad J Pandit <pjp@fedoraproject.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing the Xilinx folks.

On 7/3/19 9:06 PM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> Define skeleton lqspi_write routine. Avoid NULL dereference.
> 
> Reported-by: Lei Sun <slei.casper@gmail.com>

I wish reporters give more information about their findings, that would
help understanding the fix is correct, or how we could find/fix other
places with similar issues...

Does this come from static analysis?
Guest fuzzing code? If Linux guest, this range should not be ioremapped.

Sometimes this I/O range are not visible from the CPU address space but
only the DMA.

Anyway, if this comes from new access from the kernel driver, then we
should probably implement more registers in QEMU.

> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/ssi/xilinx_spips.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index 8115bb6d46..0836b8977a 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -1221,8 +1221,15 @@ lqspi_read(void *opaque, hwaddr addr, unsigned int size)
>      }
>  }
>  
> +static void
> +lqspi_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
> +{
> +    return;

My first reflex was to ask you to replace this line by this (or equivalent):

  qemu_log_mask(LOG_UNIMP,
                "%s Unexpected %u-bit access to 0x%"PRIx64
                " (value: 0x%"PRIx64"\n",
                __func__, size << 3, offset, data);

So we can track guest accesses to this range.

However, looking at the datasheet 'UG1085 (v1.0) November 24, 2015',
Chapter 22: Quad-SPI Controller, I understand this region is only
accessible by the CPU in READ mode, as an AXI slave.

So, if we model this, even logging LOG_GUEST_ERROR is incorrect, we
should trap some AXI bus access error.

So the proper fix might be:

> +}
> +
>  static const MemoryRegionOps lqspi_ops = {
>      .read = lqspi_read,
> +    .write = lqspi_write,

       .write_with_attrs = lqspi_write,

>      .endianness = DEVICE_NATIVE_ENDIAN,
>      .valid = {
>          .min_access_size = 1,
> 

With:

static MemTxResult lqspi_write(void *opaque, hwaddr offset,
                               uint64_t value, unsigned size,
                               MemTxAttrs attrs)
{
    return MEMTX_DECODE_ERROR;
}

So arm_extabort_type() could return a "AXI bus Decode error".

Peter/Edgar, what do you think?

Regards,

Phil.

