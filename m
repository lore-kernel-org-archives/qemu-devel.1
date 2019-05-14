Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCDDC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2443920675
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2443920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43521 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQTP2-0004Zy-90
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 05:07:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQTNJ-0003Fx-VT
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQTNI-000512-J2
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:05:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQTNI-0004zB-8u
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:05:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id l2so18253361wrb.9
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 02:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=npa3QAVRn4TLgu6ikRWrfw8hEYktXFq50xCvlagqQf0=;
	b=ZfuXaHhBad7iVnpMVGY2lXK48N9IHD/zzqv0hzP0bO67pu0YMjZWOExKkzwitqk8WS
	KF1mZo9xmQov2Iah9BzYmP05VgVv7NDLm3WGZZoCiTMYE8yrMYhoix2k/4Y2lJf+Is72
	zoD0zNwjxFu45ptzLwvKiGXwe1IzrKcy94oHQBQEAVh+bAwJDoKp6nPywSaP+KpehiJN
	maHi16Ub8WJ9K3RSDGMWPsyMPoHTEjFe9h/SwZ5zzymwZoDzT1NeVftkn2Em0k5j7aOQ
	oIT60RBEdM5JAkW23cbaQNJ/2i88av5u5Qrjbtq7LW5Vv+IH5oiA1AGGAHolcRVRNJ7D
	2iEg==
X-Gm-Message-State: APjAAAWUVK2Hu83vJd/CWTb0Ajo3AeQjY7q7HcM1un4Cx6o/Fm0EpLv9
	jLcRcCsy97zar5ZmFQdwjIGJiQ==
X-Google-Smtp-Source: APXvYqwZGHC7CsnSTViP/QVcxo09y5dX57aiNbsJ7gUuJEEWRqpxgVeyTyDmb5TwB16VaqQH+X9jSQ==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr20862802wrw.105.1557824727226;
	Tue, 14 May 2019 02:05:27 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	a22sm2292454wma.41.2019.05.14.02.05.26
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 02:05:26 -0700 (PDT)
To: Jonathan Behrens <jonathan@fintelia.io>, qemu-devel@nongnu.org
References: <20190513194328.11045-1-jonathan@fintelia.io>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bc2e8bd3-e2d1-5a20-301e-023dcdc677a4@redhat.com>
Date: Tue, 14 May 2019 11:05:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513194328.11045-1-jonathan@fintelia.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] cadence_gem: Don't define GEM_INT_Q1_MASK
 twice
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Jonathan Behrens <fintelia@gmail.com>,
	"open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/19 9:43 PM, Jonathan Behrens wrote:
> Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
> ---
>  hw/net/cadence_gem.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 7f63411430..37cb8a4e5c 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -146,7 +146,6 @@
>  #define GEM_DESCONF7      (0x00000298/4)
>  
>  #define GEM_INT_Q1_STATUS               (0x00000400 / 4)
> -#define GEM_INT_Q1_MASK                 (0x00000640 / 4)
>  
>  #define GEM_TRANSMIT_Q1_PTR             (0x00000440 / 4)
>  #define GEM_TRANSMIT_Q7_PTR             (GEM_TRANSMIT_Q1_PTR + 6)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

