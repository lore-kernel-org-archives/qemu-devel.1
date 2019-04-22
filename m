Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EF1C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 16:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7292214AE
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 16:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7292214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39875 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIbwB-0004cC-24
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 12:36:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIbuV-00037f-O2
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 12:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIbpS-0007uE-AL
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 12:30:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIbpS-0007tZ-3F
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 12:30:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so15086532wmc.3
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 09:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=rekENEXr49yQmesagg6Od3D4OkDhe+yrEOJOyHEeTQM=;
	b=NoOE3D7v2TzumMaUq9DEyOrVu29VKZ0elT9zegyIWdvOIvtLwAajZlwA9y6zFpoOkp
	sNhQbSQt1rOAdpjK9dSMACJb7SljBOFDP4GT2RyKsT/ZERO2vm4e4r1zdxzooukTpHuS
	vX+i0i43OjQXpH0b24NaNx2pbmXiCF859DNr4ikQdmb4zlaG7FmsInq25Bkb+Acxf7Ti
	pGff4laWWy39LMPRUIAGpaoJro3hB0Qg83QQT1B5IEJBZa+0fUxMXAXIarcWdeTSlaD1
	5C1f61G+Z4R4In81HjLaqGJXkx7lfd74cRNKQH1cwaMYJ0ICX4ef6EeB/w5mXQak9Su8
	KYgA==
X-Gm-Message-State: APjAAAU5JzhiXiwBshMezDRmLyX8LYJcJKhqMhInZv+N6NNEPSk1vyz+
	cqDk6/NQMp07rQWX5uV6R/VrXA==
X-Google-Smtp-Source: APXvYqwpi7v/9kaBWbmMgAcODEroBJcI41GIQHBvJ1rdHkkg5OEzQkbL1WAlOwGnIKRitkRbS9sfwg==
X-Received: by 2002:a1c:a9d4:: with SMTP id
	s203mr13288480wme.117.1555950601120; 
	Mon, 22 Apr 2019 09:30:01 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163])
	by smtp.gmail.com with ESMTPSA id c1sm3606465wrp.69.2019.04.22.09.30.00
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 Apr 2019 09:30:00 -0700 (PDT)
To: Li Qiang <liq3ea@163.com>, jslaby@suse.cz, pbonzini@redhat.com
References: <20190422141156.15746-1-liq3ea@163.com>
	<20190422141156.15746-3-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0033c7fe-f9d5-223d-b5c2-6835041b7281@redhat.com>
Date: Mon, 22 Apr 2019 18:29:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422141156.15746-3-liq3ea@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v3 2/3] edu: mmio: allow 64-bit access in
 read dispatch
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422162959.SFnepRM_cNYeqX40tNjXYtCWcmSGYBXe8YgJNgt2OzQ@z>

On 4/22/19 4:11 PM, Li Qiang wrote:
> The edu spec says when address >= 0x80, the MMIO area can
> be accessed by 64-bit.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>

Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>

> ---
> Change since v2:
> Fix an error per Phillippe's advice
> 
>  hw/misc/edu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index 65fc32b928..33de05141f 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -185,7 +185,11 @@ static uint64_t edu_mmio_read(void *opaque, hwaddr addr, unsigned size)
>      EduState *edu = opaque;
>      uint64_t val = ~0ULL;
>  
> -    if (size != 4) {
> +    if (addr < 0x80 && size != 4) {
> +        return val;
> +    }
> +
> +    if (addr >= 0x80 && size != 4 && size != 8) {
>          return val;
>      }
>  
> 

