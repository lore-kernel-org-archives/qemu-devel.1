Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D10C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 12:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07FA020835
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 12:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FA020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41010 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH6PZ-0006lJ-80
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 08:45:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH6Oi-0006Hw-66
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH6Oh-0007CF-8C
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:44:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hH6Oh-0007Bl-2Q
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:44:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so2778091wrw.13
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 05:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=M3UlS4rawRt2jE3EMSwiYOIGr68uUe7U0NU4ND8gLeo=;
	b=ES/JXEpZ8gb+tQK03P74NLufkOsJyJ+C7IEfj7HPcG8W+4VMSvkwfutxFXyelpwT3n
	CiPduiRA5gWDhxTggAezckg9OhP9z7pHjtmJ0Uxq/PH0UPDOGeG1sqIKrqgLQBgJRVqc
	IC2ynqO23D0ZIawHJA1OGv5kiF7AYaabN8xTUIQUj4taXFpcblfJxMN8+0DQcGiyMyYj
	Vk/yhwwl9dG1e5GWdSRDnfKs3Opu/T06kvWeqOgew/6S6LNMYFOokAdWhAWiyBHN5h3j
	wBzQT2Tv2u57jk4j0Kh4vTNpGZRzBk5i4FcgS6EQEJgwqKTarG3L/tR71oL8vbBe0KHN
	Lo5g==
X-Gm-Message-State: APjAAAVOyoqXb+6TVpVwdLISyJsyP307v7ALXBilYlmCvQAE5zp1KO8D
	eoZTcu6lMKLedCnPJOXyf5578Q==
X-Google-Smtp-Source: APXvYqzdGQ+oyTV1YPVDsqxJUOX3Ng8+2liIs+av8/J0gVtaK4qCq4NcSZ7MVRtp7aajkhf0YpflJw==
X-Received: by 2002:a5d:6b02:: with SMTP id v2mr849110wrw.84.1555591449936;
	Thu, 18 Apr 2019 05:44:09 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	b134sm2894071wmd.26.2019.04.18.05.44.09
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Apr 2019 05:44:09 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20190418040103.15314-1-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7ffb2830-56e0-2d9f-ea4e-71543fa06ece@redhat.com>
Date: Thu, 18 Apr 2019 14:44:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418040103.15314-1-ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH] hppa: Delete unused hppa_cpu_list()
 function
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
Cc: Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418124408.iVZD4THb6hvyV0So5IwIBySdSz__hzEZ5qp9Kovy_14@z>

Hi Eduardo,

On 4/18/19 6:01 AM, Eduardo Habkost wrote:
> hppa_cpu_list() is dead code and is never called.  Delete it.
> 
> Cc: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/hppa/cpu.c | 22 ----------------------
>  1 file changed, 22 deletions(-)
> 
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 00bf444620..b3b1826209 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -110,28 +110,6 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
>  #endif
>  }
>  
> -static void hppa_cpu_list_entry(gpointer data, gpointer user_data)
> -{
> -    ObjectClass *oc = data;
> -    CPUListState *s = user_data;
> -
> -    (*s->cpu_fprintf)(s->file, "  %s\n", object_class_get_name(oc));
> -}
> -
> -void hppa_cpu_list(FILE *f, fprintf_function cpu_fprintf)

You forgot to remove the declaration in "target/hppa/cpu.h".

With this header updated:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> -{
> -    CPUListState s = {
> -        .file = f,
> -        .cpu_fprintf = cpu_fprintf,
> -    };
> -    GSList *list;
> -
> -    list = object_class_get_list_sorted(TYPE_HPPA_CPU, false);
> -    (*cpu_fprintf)(f, "Available CPUs:\n");
> -    g_slist_foreach(list, hppa_cpu_list_entry, &s);
> -    g_slist_free(list);
> -}
> -
>  static void hppa_cpu_initfn(Object *obj)
>  {
>      CPUState *cs = CPU(obj);
> 

