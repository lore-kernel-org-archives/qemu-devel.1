Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC51C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB9921E73
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rjJA277U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB9921E73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvOI3-0003Bu-V7
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60832)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvOHb-0002Qm-Mk
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvOHa-000480-HZ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:55:23 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43880)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvOHa-000472-5J
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:55:22 -0400
Received: by mail-pl1-x641.google.com with SMTP id 4so34445348pld.10
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 08:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=prLuYlCIjqqGCnuy16UMao/whYuieT5vCsOk/Uu8Jfs=;
 b=rjJA277UKjGXhHdTw07ZfW3C5Mn6ZbEDCyfEzYhzyY5Fa6hqywzzPHsfVqhjmsY1xd
 swUGLSFFlIfDfAfMlqMngfwVZO6uXvboimYFhSbZ2cmSQSMK6PClDl/OID2BpXOt13Pd
 U2cOUPTWvLOpP7nh5Xeo9afmgoeSdlhfEFRUqA71QsbwvshALi+Qzfk0g/enc95E4z7h
 i5tdWDwKeM4+P1UwQwPHD2IUFy4X6tQQB312FSE/2X0v0sHI0VNQdcTK41kBrmdl49eh
 MulrE+5MtbI4z8k+ssVC20xJJ9kiczTOLWOvAXbhyjkgBmI8VDQ9JuzBl/kEiyyUub+i
 HQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=prLuYlCIjqqGCnuy16UMao/whYuieT5vCsOk/Uu8Jfs=;
 b=rWjw8Ds+bf/UShlEHwyBClYGGRr7V+DRVDJqcoeZlJdq5EAqSv1vb3DRk7EWFo3tkF
 tZmEZ6WP5Vk3EQormMccccD08Mo7Nj61PrM0FJWqVde0MpKp6UExwG0SFeSPMR5zf9NM
 QXHPmH6wfBD+98DD25REI/f9A/eEKjUmsTuW4a28gBwCUF9Jo4Q5WAoJjAngNRDQc58v
 utqXERXpYXkivyXGSeeHr4N2/nBSxEnhU5CVKWZ6iNykP0xOcB5YkWwNLv1AqumxXY7s
 3S+KOpa/1cJpelHyNe1ITAO+MAYU6thOK8az5vNW8n5TBCBKWz9ZCrxV7cJ0OVxkmmet
 HwTw==
X-Gm-Message-State: APjAAAX4BGWmLoFbp9X0NYBLue0KoKji9Sl5MyNg1R8jQrBoUfMWcQnA
 yZN6N7vvnkGfxok5AFExGwC9JQ==
X-Google-Smtp-Source: APXvYqwIO3zpV1oWn1WTT9oo13fQBavOvrIiC2GODyL0n0Zg2Nz8i5QgHeaYS7+9K7WlPGsK/Ms0Lw==
X-Received: by 2002:a17:902:8d92:: with SMTP id
 v18mr8949359plo.211.1565193321031; 
 Wed, 07 Aug 2019 08:55:21 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id i3sm98279530pfo.138.2019.08.07.08.55.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 08:55:20 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <45ec4924e0b34a3d9124e2db06af75b4@tpw09926dag18e.domain1.systemhost.net>
 <1565166687895.25037@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <28cf72ed-7a4e-668f-40ca-71a2c7fbeca5@linaro.org>
Date: Wed, 7 Aug 2019 08:55:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565166687895.25037@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH v6 16/26] exec: Map device_endian onto MemOp
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, imammedo@redhat.com, sagark@eecs.berkeley.edu,
 david@redhat.com, jasowang@redhat.com, palmer@sifive.com,
 mark.cave-ayland@ilande.co.uk, laurent@vivier.eu, keith.busch@intel.com,
 jcmvbkbc@gmail.com, frederic.konrad@adacore.com, pbonzini@redhat.com,
 kraxel@redhat.com, edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn,
 pburton@wavecomp.com, marex@denx.de, robh@kernel.org, hare@suse.com,
 sstabellini@kernel.org, berto@igalia.com, proljc@gmail.com,
 qemu-block@nongnu.org, arikalo@wavecomp.com, jslaby@suse.cz, deller@gmx.de,
 mst@redhat.com, magnus.damm@gmail.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, mreitz@redhat.com, hpoussin@reactos.org,
 joel@jms.id.au, anthony.perard@citrix.com, xen-devel@lists.xenproject.org,
 rth@twiddle.net, philmd@redhat.com, green@moxielogic.com, atar4qemu@gmail.com,
 antonynpavlov@gmail.com, jiri@resnulli.us, ehabkost@redhat.com,
 minyard@acm.org, sw@weilnetz.de, alistair@alistair23.me, chouteau@adacore.com,
 b.galvani@gmail.com, eric.auger@redhat.com, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, peter.chubb@nicta.com.au, yuval.shaia@oracle.com,
 stefanha@redhat.com, marcandre.lureau@redhat.com, shorne@gmail.com,
 sundeep.lkml@gmail.com, jsnow@redhat.com, david@gibson.dropbear.id.au,
 kwolf@redhat.com, crwulff@gmail.com, qemu-riscv@nongnu.org,
 xiaoguangrong.eric@gmail.com, i.mitsyanko@gmail.com, lersek@redhat.com,
 cohuck@redhat.com, alex.williamson@redhat.com, Andrew.Baumann@microsoft.com,
 jcd@tribudubois.net, andrew@aj.id.au, michael@walle.cc,
 paul.durrant@citrix.com, qemu-ppc@nongnu.org, huth@tuxfamily.org,
 amarkovic@wavecomp.com, kbastian@mail.uni-paderborn.de, jan.kiszka@web.de,
 stefanb@linux.ibm.com, andrew.smirnov@gmail.com, aurelien@aurel32.net,
 clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/19 1:31 AM, tony.nguyen@bt.com wrote:
> Preparation to replace device_endian with MemOp.
> 
> Mapping device_endian onto MemOp limits behaviour changes to this
> relatively smaller patch.
> 
> The next patch will replace all device_endian usages with the
> equivalent MemOp. That patch will be large but have no behaviour
> changes.
> 
> A subsequent patch will then delete unused device_endian.
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  hw/char/serial.c          | 18 ++++++------------
>  include/exec/cpu-common.h | 10 +++++++---
>  2 files changed, 13 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

