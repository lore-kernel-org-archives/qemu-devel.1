Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F82C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 19:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82F052063F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 19:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F052063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52256 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLYSr-00080x-PY
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 15:30:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLYNE-0003MD-81
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLYAl-0004dG-I2
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:12:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLYAl-0004cR-Cn
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:12:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so5003693wmd.0
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 12:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=2RDFs8S85oa4FrDYgpGFvUVS8sKHDV8ZSoNqkO72bts=;
	b=KaNpgWS2onIDH8A/A54TS/7ax70tY8WpyOkXPAtDVux30gNx9iDf8NADhLQu2Rtq7V
	zs4TVANOUXGd7uL8w8FPLU4T8pxySJol2u5rfhpSW5jAixgCpBJzfU2J1aRSlTJFNoc6
	mWMnvlZ0HdHOoIWmy4Q/Pqy+fU142k7svhuklvvaNKOb5BJvEfl+2Bq7c9nHsfbu0yWK
	5rpssPx4AyyogwYbU68CocQPRK7fu78kS1PSR60hKHK19Ni0VzWxp4FTypYv9NSw7EJN
	jGx5PoNNcc7OjWf59Bgbs5pjPGRhSZFmKghnEtRjy9vtu3ei2vOIISXZ7rj1gz0nAys4
	IItg==
X-Gm-Message-State: APjAAAW3tsNrREZuuY87bi7ntShxI8Az5O8v+xhBSIDnumrncQOllNY/
	He0cyBmF5G41hTSfefuomx426A==
X-Google-Smtp-Source: APXvYqw3iMMwWaW4Nx9uueZLulrqgxagqxHHOd4+aABdr8mP5BRUtP+THtHGyPkJXq09F4IW7G0AXg==
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr3996708wma.129.1556651529913;
	Tue, 30 Apr 2019 12:12:09 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	u17sm4256862wmu.36.2019.04.30.12.12.09
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 12:12:09 -0700 (PDT)
To: Cao Jiaxi <driver1998@foxmail.com>, qemu-devel@nongnu.org,
	qemu-arm <qemu-arm@nongnu.org>
References: <20190430181326.1314-1-driver1998@foxmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c794f5a4-470a-3f49-c5df-bd37d97d711a@redhat.com>
Date: Tue, 30 Apr 2019 21:12:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430181326.1314-1-driver1998@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v2 3/4] util/cacheinfo.c: Use uintptr_t
 instead of unsigned long in AArch64 arch_cache_info()
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430191208.guKVb_JykIQfYynFWQjYmyx4IgLAPfG7kbgwSFI0t2Q@z>

On 4/30/19 8:13 PM, Cao Jiaxi wrote:
> Windows ARM64 uses LLP64 model, which breaks current assumptions.
> 
> Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
> ---
>  util/cacheinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/cacheinfo.c b/util/cacheinfo.c
> index 3cd080b83d..ce6f0dbf6a 100644
> --- a/util/cacheinfo.c
> +++ b/util/cacheinfo.c
> @@ -107,7 +107,7 @@ static void sys_cache_info(int *isize, int *dsize)
>  static void arch_cache_info(int *isize, int *dsize)
>  {
>      if (*isize == 0 || *dsize == 0) {
> -        unsigned long ctr;
> +        uintptr_t ctr;
>  
>          /* The real cache geometry is in CCSIDR_EL1/CLIDR_EL1/CSSELR_EL1,
>             but (at least under Linux) these are marked protected by the
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

