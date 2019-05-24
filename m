Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B3DC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD0A217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD0A217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50540 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU4tP-0007VM-1C
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 03:45:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU4sf-00078q-3E
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU4se-0006MK-4O
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:44:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hU4sd-0006Lp-V7
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:44:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id t5so8144754wmh.3
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 00:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=gsXAeuU3PKAkCy9NShUgEiywrqZrqa6UMCDduTS62ro=;
	b=ST2yf1EFRcSs3zBsy53JmeOdcy+HDMuGvLxlOfP94sPNUm4+QSNDrzabjijpTnoVSS
	Exp1e2EJ6mTXEWlkrB9Wwq4aZt5en07Ie1CEwfTqS2kpsKDVAHrcP3ctqdUOQH0SW4s9
	onBSJ3gM6cpE5oANd6wALPwYyOd4neYcRE0PlmDYwsCvXqSxtt11cYOR8G42jcX+H46c
	zhKGmjJUUEB7U410L+I8N0ZjFkUgaNt1ipgomY5gba/Qoddb8j60YHh7+V7y6LHt2N0a
	HZMjFSJcDr3/7lWJ7zY3zSQKohks6+1elkbt+zMDKcy89cAiabBCJ7h7wVr1Bj4uFoRg
	LQsg==
X-Gm-Message-State: APjAAAX3pKq+5Hvjt2Gdz86EofJk5GHq5F6ZfhEviLbgfAw4jmYJ6qMx
	rKxpyBYyWse4p608z9XmwqxxzQ==
X-Google-Smtp-Source: APXvYqzAxlLNG6O/JBu7M6xyloHii5AntUIWUIU8swwvY5WnTT58QPAr7oV5bVslYccAsRlC06AKWA==
X-Received: by 2002:a1c:9d56:: with SMTP id g83mr15508590wme.8.1558683882907; 
	Fri, 24 May 2019 00:44:42 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	k184sm4149090wmk.0.2019.05.24.00.44.41
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 00:44:42 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190504060336.21060-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <79f09ce1-076c-6f20-562b-1b0a1eec4fb9@redhat.com>
Date: Fri, 24 May 2019 09:44:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504060336.21060-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH] tests/docker: Update the Fedora image to
 Fedora 30
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
Cc: Fam Zheng <fam@euphon.net>,
	=?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/19 8:03 AM, Philippe Mathieu-Daudé wrote:
> Fedora 30 got released:
> 
>   https://fedoramagazine.org/announcing-fedora-30/
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Based-on: <20190408201203.28924-1-marcandre.lureau@redhat.com>
>           qxl: fix -Waddress-of-packed-member
> 
> Based-on: <20190503112654.4393-1-laurent@vivier.eu>
>           Pull request trivial branch 2019-05-03

'based-on' series got merged, ping?

> ---
>  tests/docker/dockerfiles/fedora.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
> index 69d4a7f5d75..1496b68ba15 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -1,4 +1,4 @@
> -FROM fedora:29
> +FROM fedora:30
>  ENV PACKAGES \
>      bc \
>      bison \
> 

