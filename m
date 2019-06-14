Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508F9C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 12:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24FF52133D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 12:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FF52133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51164 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hblSt-0004Rb-Sh
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 08:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56101)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hblIW-0006MM-Op
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hblIU-0006RF-GA
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:27:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33653)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hblIU-0006PH-9d
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:27:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so2362659wru.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 05:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fOJOXybyVWH0IOEQeI6XxgSeydz4kVUmZfkpKTZH48U=;
 b=S4xsX3l63FLVzC19pAJM4YnIaH0wNJ/VQUVLeSyuRj35KOG70bfUDdwsIwDDgK/mnF
 xR25hv7334RV69T+PehvAkhZn+qOAYAKTQa4fpKgHpFUC0M8mxbLdxaFP7rF2njB2xnX
 Hsl8LOzkK7tYO/iW5Hg9FwYEDdPSKs9wRnvs5rto65hgtIAgr7cLr/XCBwZHR4WNLcXB
 Gp0vdiXR7oBDumjjw9fTR1niIxq7HeyeSsuf49jbYRfNqP4Wtle6YChaIWjfczP77xjQ
 N8lI8+BG5C46Yo+11OS8NJyLM62T7jL3T3z/EyQF1y/qjQZaRw2+1blGSTMBiWHBoky/
 yRCQ==
X-Gm-Message-State: APjAAAWv0H6Smw788F88uufB6jgWDe5Ad7cusNLB+lyYHQvi7YzGqNnz
 4WYhBieAnY1beAy/G0iQKpGnNQ==
X-Google-Smtp-Source: APXvYqy1rm/biY9ou0cdvrBOBL+NYcLX7hlESpVoadHtGYbbOIGWItR7KYMZc+ervA07m7ATnm5CVw==
X-Received: by 2002:a5d:5552:: with SMTP id g18mr3710970wrw.254.1560515227604; 
 Fri, 14 Jun 2019 05:27:07 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id d17sm3885264wrx.9.2019.06.14.05.27.06
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 05:27:07 -0700 (PDT)
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Eddie James <eajames@linux.ibm.com>, qemu-arm@nongnu.org
References: <1560286476-23494-1-git-send-email-eajames@linux.ibm.com>
 <dee5afb8-cc31-8963-6a7c-169c77e23d3c@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ec91b789-c2da-4ebf-ca6f-ae8113e4d57f@redhat.com>
Date: Fri, 14 Jun 2019 14:27:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <dee5afb8-cc31-8963-6a7c-169c77e23d3c@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2] hw: misc: Add Aspeed XDMA device
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
Cc: andrew@aj.id.au, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 2:10 PM, Cédric Le Goater wrote:
> On 11/06/2019 22:54, Eddie James wrote:
>> The XDMA engine embedded in the Aspeed SOCs performs PCI DMA operations
>> between the SOC (acting as a BMC) and a host processor in a server.
>>
>> The XDMA engine exists on the AST2400, AST2500, and AST2600 SOCs, so
>> enable it for all of those. Add trace events on the important register
>> writes in the XDMA engine.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>> Changes since v1:
>>  - add trace events
>>  - minor cleanup

Thank you for these changes.

>>
>> This patch is based on Cedric's big Aspeed update:
>>     http://patchwork.ozlabs.org/cover/1105343/
> 
> Eddie, 
> 
> I have pushed the patch in my tree and I plan to resend 
> as part of the patchset above.
> 
> Thanks,
> 
> C. 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

