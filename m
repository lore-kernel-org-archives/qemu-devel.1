Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD060C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA8E20868
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA8E20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50126 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZJQj-0001hS-0L
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 14:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56219)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZH38-00068z-Cg
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:45:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZH35-0003Tt-Ey
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:45:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44485)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZH33-0001l7-Sw
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:44:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id b17so2617626wrq.11
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 08:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FYRkl8iCUme4qVWAdiVljKg5yHotz5W0hkostJEMbVc=;
 b=YNxgTEWt2p8RkFZzkxC1OLwMJXFYlhyuidkI73J+q+mXpY3yAtyyLLshlMq6HViWkk
 +MDaK+89PeMenSG9WOwNgFsPKT+AHZ/B3IxpPXl/MM8sPRGUyDFRWn/7TRHFLI/xqpWB
 z0F/IOrlkoVQDbiT6yEGhPk6da3NID+wqPUEShIqIa3zaNVaMXZGlCMJOJZdHf1/i7qU
 5fNM3E9tu2XRUjtk8PMzxOQ0mPIupSuG738jZIjp1krJFmUI5oC+qWSgFg4sX9huRRyC
 ohnQF98nRvaUiszbN6TlFBdHZYy+G8GNzYQE1aPcmXLL4Bb2NB5mWdlSHFaNBklhc6ap
 01Tw==
X-Gm-Message-State: APjAAAXeWgiUhYwGHc3L+tBX2j1c0kUh3j7kDtjXZCWpqtlmsgIOJWqa
 F5IkcnK/7Bedn5j6Gg+DmBVLnQ==
X-Google-Smtp-Source: APXvYqzxvseeuHIU4xEpZFP4LbxpxFvlAmcqkpnyJQBfWIfyioqiKwgtTutVO3p5oz1TR987j0wfVQ==
X-Received: by 2002:a5d:474a:: with SMTP id o10mr8061764wrs.157.1559922218185; 
 Fri, 07 Jun 2019 08:43:38 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id c17sm1830740wrv.82.2019.06.07.08.43.37
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 08:43:37 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20190607153725.18055-1-philmd@redhat.com>
 <20190607153725.18055-6-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c18e62f2-0c69-29ab-d447-9ca24315c549@redhat.com>
Date: Fri, 7 Jun 2019 17:43:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607153725.18055-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v18 05/29] !fixup target/rx: CPU definition
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/19 5:37 PM, Philippe Mathieu-Daudé wrote:
> New qom-cpu style requested by Igor.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  target/rx/cpu.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index 3c43467534..c370f65faa 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -80,7 +80,7 @@ static void rx_cpu_list_entry(gpointer data, gpointer user_data)
>  void rx_cpu_list(void)
>  {
>      GSList *list;
> -    list = object_class_get_list_sorted(TYPE_RXCPU, false);
> +    list = object_class_get_list_sorted(TYPE_RX_CPU, false);

This line belongs to the previous !fixup patch, but it is a fixup anyway...

>      g_slist_foreach(list, rx_cpu_list_entry, NULL);
>      g_slist_free(list);
>  }

