Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1267C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B719D206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B719D206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIWYE-0005Xh-VG
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 07:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIWWo-0004hA-Cl
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIWWn-0001Ue-7j
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:22:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37888)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIWWn-0001Tr-1E
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:22:41 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 16FE43C93D
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 11:22:40 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id p6so1478340wmc.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 04:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n3ouSwwc2Y0r2hD+bOqLEn0oCaK1IxEhQXsxSp5wFJw=;
 b=B9XaOGkZSOesA2Rzp+69NZdXfXNRe732QjyYahNWKab3/3o1Jd0cDXZf7mcBtC7wuO
 1j3iFj7eoxgVQo87/pF4Xw2nWrdVcluAI713kBwPbrJ81xHesRyNSbpoGeUk49mOvanG
 48ZTMtDmdIhLW5h+gA0rZ0N7cqaISE9bI+ygCeRUdoTrBJfVjh+sTyAcSd9Nd3xEjCt0
 GYOVkJL62sLedVqy8LRpUl3ZEzQPuzOVptT4evKxkCzd6U4PG6XJk5YplsuBBPUSoRIp
 /D01wH4hoqdd52X/cWAS0ViV8F3oIa862VNQe/gkyTrYm4Fy5QOxgsWrQloPfruf6C4Z
 Js2w==
X-Gm-Message-State: APjAAAX67KV4iqSECxoFFhkNKUwEgyA6rBIAAxWeqtgYAlr8e2vaVGX/
 k/rgWzxyFqZj6tWrqfV5/H6zghpe8YguTwvVcfk6RHmJ9jzhQuF78IIK8wkSjvB8y558bBPWj0w
 RagzHJKN0nDVNzzY=
X-Received: by 2002:a1c:a647:: with SMTP id p68mr7269428wme.139.1570706558867; 
 Thu, 10 Oct 2019 04:22:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwtGuGbzuWEA9FKFYSbQtYYX8yVK0yk3lCUk3TVbvkAVpylwhjuBeb94ngLUxCfKa1MgwXKyA==
X-Received: by 2002:a1c:a647:: with SMTP id p68mr7269408wme.139.1570706558694; 
 Thu, 10 Oct 2019 04:22:38 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id b62sm7698651wmc.13.2019.10.10.04.22.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2019 04:22:38 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] IDE: deprecate ide-drive
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20191009224303.10232-1-jsnow@redhat.com>
 <20191009224303.10232-2-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <518ae20b-049d-19ee-1e86-c48466ba0655@redhat.com>
Date: Thu, 10 Oct 2019 13:22:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009224303.10232-2-jsnow@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, libvir-list@redhat.com,
 Peter Krempa <pkrempa@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/19 12:43 AM, John Snow wrote:
> It's an old compatibility shim that just delegates to ide-cd or ide-hd.
> I'd like to refactor these some day, and getting rid of the super-object
> will make that easier.
> 
> Either way, we don't need this.
> 
> Libvirt-checked-by: Peter Krempa <pkrempa@redhat.com>

Peter made a comment regarding Laszlo's Regression-tested-by tag:

   [...] nobody else is using
   this convention (there are exactly 0 instances of
   "Regression-tested-by" in the project git log as far as
   I can see), and so in practice people reading the commits
   won't really know what you meant by it. Everybody else
   on the project uses "Tested-by" to mean either of the
   two cases you describe above, without distinction...

It probably applies to 'Libvirt-checked-by' too.

https://www.mail-archive.com/qemu-devel@nongnu.org/msg632705.html

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

