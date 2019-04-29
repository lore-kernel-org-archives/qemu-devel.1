Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A8FC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 11:30:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F882084B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 11:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F882084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56019 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL4UJ-0001GT-Vx
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 07:30:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL4TX-0000wM-Ks
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 07:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL4TW-0004ae-Oz
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 07:29:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hL4TW-0004aH-JP
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 07:29:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id c5so15453808wrs.11
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 04:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Rhvj3vAyE0PiiQ8HFoOyQeVFyv4yM72F3g3uYuLU7sc=;
	b=b95lclDE9PI8Q5VxsQbM/TpzLaSkps3M8Zgspzi7NgiRLFUiPRPcFXez1Pf4p0s4ko
	VL97wCLDu4vtxl+0D2PYjVw9WlbZb/0mr/dVsC8EjjM78IbUJtymX9xyHXtUijAISGCe
	Hqf92zz9ZAMYtPst+R+w+YMJyGkfcLpiLBg0VN3c4BuqdBSbK75TNIS1V3/COh0qKovO
	pQVSsj63Evcmi8hWfpauBTY5A4NLoTjuhbCykrQP1QmOxSBBbl+4b08E6pclpJXt+jBh
	PwK/0G8Lan4fGTAmmrAn3moiDr1p/wEPgmZJvtPb/Ob/dB7iHu0N56KwbAMr9cEFT/X7
	00rw==
X-Gm-Message-State: APjAAAX8R/xFBTruf7Denmiw67gjUNCmNJI1BsIkHFPFYXvWjrMB7IlB
	LvK/28oow+cYXqt5g1MOq++vCA==
X-Google-Smtp-Source: APXvYqwIFTHSMJ9pqca8dpzySz+CpahlOQI50qjSngElNuQMxQSFnHZ3ahOIuZCM7mbY34KURpx7Ag==
X-Received: by 2002:a5d:4348:: with SMTP id u8mr15829429wrr.129.1556537373491; 
	Mon, 29 Apr 2019 04:29:33 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	z17sm17567844wrm.33.2019.04.29.04.29.32
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 04:29:32 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190316234456.18140-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <97745dfa-ceaf-6572-59ba-a37e8f3c1e89@redhat.com>
Date: Mon, 29 Apr 2019 13:29:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190316234456.18140-1-philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH for-4.1 0/2] hw/alpha: Add the CY82C693UB
 southbridge in Kconfig
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429112931.S3ceR7KNUBaepJMoPbRuOoZIj0dOYZ9080lN5x4vBkE@z>

CC'ing Thomas who is a Kconfig expert.

On 3/17/19 12:44 AM, Philippe Mathieu-Daudé wrote:
> Explicit the CY82C693UB southbridge used by the 264DP.
> 
> Philippe Mathieu-Daudé (2):
>   hw/isa/southbridge: Add the Cypress 82C693UB chipset
>   hw/alpha/Kconfig: The 264DP machine use a CY82C693UB southbridge
> 
>  hw/alpha/Kconfig |  5 +----
>  hw/isa/Kconfig   | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 

