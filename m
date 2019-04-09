Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4244EC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 19:00:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07FFA20883
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 19:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FFA20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47806 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDvzC-0000E4-Uv
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 15:00:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDvyR-0008HK-LZ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDvyQ-0001sU-NJ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:59:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDvyQ-0001sG-E7
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:59:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id r186so3035357wmf.1
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 11:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=v8Z5Atrm3PvY0PAkr9OFzq3JY2sbuJ9EB3V5/Vfi83s=;
	b=kInBZ36+IbQ24GPSQvu4frVNWQn/Sw9fLnpvdWEiO7njYQS38ezqBdGv+KQlqyEVbC
	pnz7YFGZ8gTxddVqemWhPUfl9CmkjxsTF82Cwo//BQv8hgnv9Ov1LZ8otB8FjOwSLd4K
	hjyKdfYpPbJykxBFte5zTwOMMid4bpPARU6aDq5x+SCSm67K52EMpvwZltBiDniNwnA+
	ggH91i2exFbHTnxetwg/FpoCAnmCOq2AmgS7w4SLjjJeDaT7vaikmE40CJ7aPJ+UeKbD
	g9Elia4CEgkGjpfVT8ropRhYLQyMDLKcIgAw8PVgWlFduMc34Hl20gw4SiW7SwimHZOV
	LCQQ==
X-Gm-Message-State: APjAAAXDBZR/jgsPzmyuLIfT6MN1wgY4iBDxidyhnA5OTEkCpmLotdCv
	O2/57bT0Vn2LjU3K/H5XTr5LJQ==
X-Google-Smtp-Source: APXvYqyea+EalMErLpzPQceJ3hm6sbNNQXaKMQ75koV4IxTgx3nkhBhflNpTIut5brNovMaFygjRNA==
X-Received: by 2002:a1c:495:: with SMTP id 143mr21258405wme.78.1554836397491; 
	Tue, 09 Apr 2019 11:59:57 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	h10sm58913060wrs.27.2019.04.09.11.59.56
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 11:59:56 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190409174018.25798-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f018f4d8-7fb2-9037-3b5a-b34f1c5d876d@redhat.com>
Date: Tue, 9 Apr 2019 20:59:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409174018.25798-1-armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
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
Cc: peter.maydell@linaro.org, alistair.francis@wdc.com, slp@redhat.com,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409185955.cwglbkISkZa_exo3Z1cVvvwZaEIKibLm6l0X8Mr7oPM@z>

On 4/9/19 7:40 PM, Markus Armbruster wrote:
> If the value of get_image_size() exceeds INT_MAX / 2 - 10000, the
> computation of @dt_size overflows to a negative number, which then
> gets converted to a very large size_t for g_malloc0() and
> load_image_size().  In the (fortunately improbable) case g_malloc0()
> succeeds and load_image_size() survives, we'd assign the negative
> number to *sizep.  What that would do to the callers I can't say, but
> it's unlikely to be good.
> 
> Fix by rejecting images whose size would overflow.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  device_tree.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/device_tree.c b/device_tree.c
> index 296278e12a..f8b46b3c73 100644
> --- a/device_tree.c
> +++ b/device_tree.c
> @@ -84,6 +84,10 @@ void *load_device_tree(const char *filename_path, int *sizep)
>                       filename_path);
>          goto fail;
>      }
> +    if (dt_size > INT_MAX / 2 - 10000) {

We should avoid magic number duplication.
That said, this patch looks safe.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

BTW how did you figure that out?

> +        error_report("Device tree file '%s' is too large", filename_path);
> +        goto fail;
> +    }
>  
>      /* Expand to 2x size to give enough room for manipulation.  */
>      dt_size += 10000;
> 

