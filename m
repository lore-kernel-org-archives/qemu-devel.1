Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014C4C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE0052166E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0052166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52128 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQbut-0001Ul-5k
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 14:12:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQbqA-0006S9-8o
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:07:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQbq9-0005k0-Fd
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:07:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQbq9-0005jh-AY
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:07:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id d12so20218420wrm.8
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 11:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=/OeGV5F1Pb9WJe+PKVwCyqHlGoAv1sBbATZIgjOTaCc=;
	b=PlP8Gicl9F0Gcpjvx19VIXoVgn1TDHOD7jobtIWXhpUmRWkLDyOS5PA+90t0pRRlrT
	ya3+yITyJef58AG8F+YQ9WhMRVcrPBrsYa1p1WMsGj5SNuYmuafw64soKMkyiorDSxLj
	RL1zjy7B/ucNsYBi9G4ASmx0WCaLrU+tWBCYkZTof8li6UrWnG/72GU8lpUyCaJd8m1w
	ZrQkkpH+rl1Ubl8tgs7WtVufCXkRit885oR5Tia9fDu/Te+gzx6mDDPu22CfQJEcil2t
	VPj7DUx5u5hCAWDhKXLDLTI82mH/BJThAqQIWIjE/nmfRXE2Oee60ywkKmHOXa1QLmWn
	ywxg==
X-Gm-Message-State: APjAAAW9FvypvDolpj8awVR2AyBekA4WxzWFYP1XDk+7cSketKZvQE7u
	s2qeMINd6IsarvvzouuiwpbFfQ==
X-Google-Smtp-Source: APXvYqys4DPFqy4gxL33GqObIZDjccGG7FwAizy6l0gqflAmJL/DV7dy0Md6AEBbnQTp71toV8C8Eg==
X-Received: by 2002:a5d:4e46:: with SMTP id r6mr21960437wrt.290.1557857268306; 
	Tue, 14 May 2019 11:07:48 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	88sm24687157wrc.33.2019.05.14.11.07.47
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 11:07:47 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190514180311.16028-1-armbru@redhat.com>
	<20190514180311.16028-3-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3f7c21b7-a0af-b550-121b-9ba378506fb7@redhat.com>
Date: Tue, 14 May 2019 20:07:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514180311.16028-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 2/6] tests/vhost-user-bridge: Fix misuse
 of isdigit()
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
Cc: thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 8:03 PM, Markus Armbruster wrote:
> vubr_set_host() passes char values to isdigit().  Undefined behavior

"happens"?

> when the value is negative.
> 
> Fix by using qemu_isdigit() instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/vhost-user-bridge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
> index 0033b61f2e..d70b107ebc 100644
> --- a/tests/vhost-user-bridge.c
> +++ b/tests/vhost-user-bridge.c
> @@ -645,7 +645,7 @@ vubr_host_notifier_setup(VubrDev *dev)
>  static void
>  vubr_set_host(struct sockaddr_in *saddr, const char *host)
>  {
> -    if (isdigit(host[0])) {
> +    if (qemu_isdigit(host[0])) {
>          if (!inet_aton(host, &saddr->sin_addr)) {
>              fprintf(stderr, "inet_aton() failed.\n");
>              exit(1);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

