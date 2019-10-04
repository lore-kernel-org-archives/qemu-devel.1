Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A9CC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFAF520867
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAF520867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGJjl-0005yo-Ue
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 05:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iGJiU-0005N4-3B
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iGJiQ-0000ln-TT
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:17:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44658)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iGJiQ-0000lE-KL
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:17:34 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 856C469080
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 09:17:33 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id f3so2412212wrr.23
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 02:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6EgLQeCQ13jJihqWAUFH53DIYVoq7bz4CdluEnDWm4E=;
 b=Mdr35pmW1yq5DjMneHuP0r0x++7DeZkfRlYNXfh0aNfz5qGxsDi0z5m245uI96lScX
 uCfidZUN0TUJFmHWI9I/7DKElUfzK8d+LQDo8prd1UW20skhMW38CLknGIL6OmtYu8l3
 3e7mGgMNfSqy0KLGurtXCpf/syv5Grn1fPp7M2MvqmkNGJl2o0cgVUiLb7bR17QMVUO2
 VjzuHUjHJIHdbZWjAj5bn6CsMQB9AJju6b/36zoJQ00QP4cZyj8lq/5xSF6whW70XiF4
 3RTUtT0clOMczlGxqvEngUdF4UTDt7LO2L6okDn1SL/maInCv21fh7IAnu/g8Lck78E2
 1e5w==
X-Gm-Message-State: APjAAAX6dqa10DJ6B7avW6JTQLv6A4bsSU7wMe5tVoqMei/rBYEYzDYa
 mS42NK/Gg0YcULeWnezvzHbYyL+p+NaFN7EW38NtOrwwtF8ERkVkb3no9UTLZ46eWmqJVevZpWj
 VagtCgqPwXUgoLf8=
X-Received: by 2002:a5d:45c6:: with SMTP id b6mr9707346wrs.4.1570180652328;
 Fri, 04 Oct 2019 02:17:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwg5bF6DDXweTFyqxY617lLm7ce7WQMHxyMyY4m55lWTUBKT+YjBUrQz8k0htSqG9zm62CuiQ==
X-Received: by 2002:a5d:45c6:: with SMTP id b6mr9707331wrs.4.1570180652121;
 Fri, 04 Oct 2019 02:17:32 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b62sm7702956wmc.13.2019.10.04.02.17.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2019 02:17:31 -0700 (PDT)
Subject: Re: [PATCH] xive: Make some device types not user creatable
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
References: <157017473006.331610.2983143972519884544.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e4c1619d-b982-e4ab-eeb9-31baddd885ba@redhat.com>
Date: Fri, 4 Oct 2019 11:17:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <157017473006.331610.2983143972519884544.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Greg,

On 10/4/19 9:38 AM, Greg Kurz wrote:
> Some device types of the XIVE model are exposed to the QEMU command
> line:
> 
> $ ppc64-softmmu/qemu-system-ppc64 -device help | grep xive
> name "xive-end-source", desc "XIVE END Source"
> name "xive-source", desc "XIVE Interrupt Source"
> name "xive-tctx", desc "XIVE Interrupt Thread Context"
> 
> These are internal devices that shouldn't be instantiable by the
> user. By the way, they can't be because their respective realize
> functions expect link properties that can't be set from the command
> line:
> 
> qemu-system-ppc64: -device xive-source: required link 'xive' not found:
>   Property '.xive' not found
> qemu-system-ppc64: -device xive-end-source: required link 'xive' not found:
>   Property '.xive' not found
> qemu-system-ppc64: -device xive-tctx: required link 'cpu' not found:
>   Property '.cpu' not found

Why do you have to test that manually, isn't it what 
tests/device-introspect-test.c::test_one_device does?

> Hide them by setting dc->user_creatable to false in their respective
> class init functions.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/intc/xive.c |    3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 29df06df1136..6c54a35fd4bb 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -670,6 +670,7 @@ static void xive_tctx_class_init(ObjectClass *klass, void *data)
>       dc->realize = xive_tctx_realize;
>       dc->unrealize = xive_tctx_unrealize;
>       dc->vmsd = &vmstate_xive_tctx;
> +    dc->user_creatable = false;
>   }
>   
>   static const TypeInfo xive_tctx_info = {
> @@ -1118,6 +1119,7 @@ static void xive_source_class_init(ObjectClass *klass, void *data)
>       dc->props   = xive_source_properties;
>       dc->realize = xive_source_realize;
>       dc->vmsd    = &vmstate_xive_source;
> +    dc->user_creatable = false;
>   }
>   
>   static const TypeInfo xive_source_info = {
> @@ -1853,6 +1855,7 @@ static void xive_end_source_class_init(ObjectClass *klass, void *data)
>       dc->desc    = "XIVE END Source";
>       dc->props   = xive_end_source_properties;
>       dc->realize = xive_end_source_realize;
> +    dc->user_creatable = false;
>   }
>   
>   static const TypeInfo xive_end_source_info = {
> 
> 

