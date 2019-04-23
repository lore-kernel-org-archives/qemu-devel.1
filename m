Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE00C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B402218D3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B402218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60550 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ47T-0006FB-FI
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 18:42:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ45a-0004iA-LN
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ3zo-0004ER-D4
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:34:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJ3zo-0004DD-66
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:34:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so22188258wra.12
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=QunzcbZ8nTWCmoiv3jqVBQGDo7+nt4uraJUdNozr4Zs=;
	b=CJ+p3LzYltSFYOBAia8D/fdJLeBt1IuPn8RmnWKGtFjeJMMGeYhBiyo9myU1PGdZft
	ZYGgc/H8F8Wv2gOaRKSeISunhXEAH2RsC8kgtCT2R3Ashuu68dlRvnnoIw04ZKJCNeTV
	udXpCvb4nX9wAce1xSBOega+Xcss+Tp2eQAedfvyd41LNtngn//lJ6dfrMbzH6cBG3dM
	9KTLPKitBU39pHecsNsoz11cAIzZ52CXIU3dXyA+P9/NFWweN5fs2DXUbLi+8L5Pnfti
	Ea2KKVCuNK0JJlsX2hHiQeykjz3MQTgoFMMrcvwnEYwCtNeXGWjt4TkqJVNvYQlJ5cMZ
	knbw==
X-Gm-Message-State: APjAAAXsz5cV9hMlGOonqAgBZs3H8gFAZRD6cArdya40B0d+KICMAr+f
	hTKyGvjsxayqIGBRguLrDcalpQ==
X-Google-Smtp-Source: APXvYqwMiEPsQF9zoXmt7WNqFkrbKOAjYf+Mg07gPUqo7QsEcbdTfVpCR8ebtDj48Dt5+uNiT7FF0w==
X-Received: by 2002:a05:6000:11cf:: with SMTP id
	i15mr18182693wrx.287.1556058875239; 
	Tue, 23 Apr 2019 15:34:35 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	t15sm15469016wrx.22.2019.04.23.15.34.34
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 15:34:34 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
	qemu-devel@nongnu.org
References: <20190423160608.7519-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <319f3544-a107-416f-ff8a-3501943f1821@redhat.com>
Date: Wed, 24 Apr 2019 00:34:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423160608.7519-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] net: Print output of "-net nic,
 model=help" to stdout instead of stderr
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423223433.H1ACw87h2kD1MIwbrogA0HmH-DKa9zy5KLJQrbmH9QI@z>

On 4/23/19 6:06 PM, Thomas Huth wrote:
> We are printing all other help output to stdout already (e.g. "-help",
> "-cpu help" and "-machine help" output). So the "-net nic,model=help"
> output should go to stdout instead of stderr, too. And while we're at
> it, also print the NICs line by line, like we do it e.g. with the
> "-cpu help" or "-M help" output, too.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1574327
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  net/net.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/net.c b/net/net.c
> index f3a3c5444c..2cf5e76469 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -837,9 +837,10 @@ int qemu_show_nic_models(const char *arg, const char *const *models)
>          return 0;
>      }
>  
> -    fprintf(stderr, "qemu: Supported NIC models: ");
> -    for (i = 0 ; models[i]; i++)
> -        fprintf(stderr, "%s%c", models[i], models[i+1] ? ',' : '\n');
> +    printf("Supported NIC models:\n");
> +    for (i = 0 ; models[i]; i++) {
> +        printf("%s\n", models[i]);
> +    }
>      return 1;
>  }
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

