Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07064C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 00:16:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C53DF206F6
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 00:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDig57Ts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53DF206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKWUK-0008W0-VA
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 20:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jKWTV-0007o0-KK
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 20:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jKWTU-00024P-Aj
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 20:15:49 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:42374)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jKWTT-0001tl-TT
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 20:15:48 -0400
Received: by mail-pl1-x62a.google.com with SMTP id e1so3444836plt.9
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 17:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tTdXwy6l5P9uAZyySoFBOYXulSQwaHPgr7dfVcbiEaE=;
 b=lDig57TszW7KZp2e7f+fvEoyNxcqSwGOlFDkd6dxyOf5gFDLWjSd7j7WpmZ0VQlzjA
 PFnoLEiX0WaaAz6FtK2jmkXA5ZrBAxO4rZP+NdhneQmk790Ha7iek3srxPaQMasUg3wF
 U9UrUu2QIL2bkWDTkgyowwPhBWN3n0EkQoNwFLwIiZUCBEpRFVIhRqyxKRmd+PLu5yJU
 Oh7Bqp11ELd+lH4VK+0AnEgbJS9q0twsYs83c87rKGqKczs0flS9W3A76qSl1/CZ2EHO
 X6GrOOMSHHlXlbu/M4b9hXa7C+U7vLyIQPiWiFDaymHFTbrBj0XxAnVFj9j2Hl66kRiA
 JjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tTdXwy6l5P9uAZyySoFBOYXulSQwaHPgr7dfVcbiEaE=;
 b=nm4DrEypUpPfQ6ix5QPecyIWbrK+hu2phUpFBrsz0g1RcxdyGY+0y2bHaVntRUdEf8
 pZaqzDpLQcjXzP7S6LUsO1aFPzj5fwiKABxFZhMYrYwokN2ki5jhgVzR/pjrc5ehyh5P
 Zw6v1opH7CFpMNgVZOT4gGFGVEjWRj2KhOoyJ9FjGFBH59BJhwIGewBXkUpFxrBYhbKt
 LTbWmZ9tzsxURvagYuIw0zmMN6eqlx6TSAZUqbmAr38EPMaGvIZCzlFP2XtV0a6pLD6b
 5FsHXuW0TCPzeUEPXcpDRX9bP/xiuSX04aKyg/gm2fL1J/olU5zAlY49qIDkM3LbaYuq
 YDFQ==
X-Gm-Message-State: AGi0PubX7Fr8d9FT82F90+jasoENQpttR1TJ0Fyh4D/aK1Gxej64xSoz
 9qj0XnTLIcvQmlpldJtAQCxUubRvTXo=
X-Google-Smtp-Source: APiQypKwVOPZb6TlARn5OpkoUvgPwXQZS8itdEGAp0N0Zob+En95pLRssOTyQBb6qJHHGWaLdbaVdA==
X-Received: by 2002:a17:90a:1a10:: with SMTP id
 16mr13423007pjk.31.1585959345975; 
 Fri, 03 Apr 2020 17:15:45 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id 74sm6451738pfy.120.2020.04.03.17.15.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2020 17:15:45 -0700 (PDT)
Subject: Re: plugin interface function qemu_plugin_mem_size_shift
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Robert Henry <robhenry@microsoft.com>
References: <BL0PR2101MB1026AF0CA590021284C39D1BD60C0@BL0PR2101MB1026.namprd21.prod.outlook.com>
 <875zege6vh.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a1220ceb-8588-7e38-32e2-5d292ddbd659@linaro.org>
Date: Fri, 3 Apr 2020 17:15:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <875zege6vh.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62a
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/20 11:55 AM, Alex Bennée wrote:
> + * The size_shift is the scale of access, e.g. << 3 is a 64 bit wide
> + * access.

Maybe better as "e.g. 1 << 3 is an 8-byte access."?


r~

