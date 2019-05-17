Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C513C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E00C206A3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E00C206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44107 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRXsM-00033j-Cb
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 04:05:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRXrK-0002bW-Ps
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRXrJ-0004p2-Sb
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:04:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hRXrJ-0004no-ML
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:04:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id e15so6066268wrs.4
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 01:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=EkdtYN9rGBWgLBY2RKk1D/GSfZXsL1vUlwa/JFNQQq8=;
	b=Sz13FZMUGNlg2aAoiyXnCp2OVmjIfO2yi1WeEZ0OQm381aYAe1VgE8FRNX+a8YJooo
	bkE4M5c06/bTY+FeN7wJ18I3Bej+AGfG6uouSvLL8Ez5DJW+BRbdGdfnbrs4mM1S0z7b
	JgNqF6RnTWlvypC06AhATAsJnCf2YviZ14FVJRVvxuHpu9MjgQKOGe5LlUe2N/s9jq74
	0Ka8vx5/T+YE3Mt6EaDW8PXwnxXf3cw++iP+u4lPgQbfE1+FY/S2Zd1EoR5VLuvmvcxq
	S8jrE801XCKx2RGkljH1dp2W0vu+ovbZuCJ8VKJvydtRDZuanpAHwa+XqnH6d1Xt9C9J
	SzYA==
X-Gm-Message-State: APjAAAXGpV3WSPL5CcVMGnDuEF7WsE3U0VvBnHUofhqXt6NWeap9Z01r
	oCqsIU3wTtxvtfNsYpVqr/eY/AKrv8E=
X-Google-Smtp-Source: APXvYqze7juDadLmi4V9C7uVUHREAcLFNJY28Rg2kRDXvu/pICtwWsJAo6aOfDWztG/tcrF/6ohh+w==
X-Received: by 2002:a5d:6b12:: with SMTP id v18mr17018833wrw.306.1558080292503;
	Fri, 17 May 2019 01:04:52 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id z4sm9400504wru.69.2019.05.17.01.04.51
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 01:04:51 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20190515121146.7248-1-mst@redhat.com>
	<1556808723-226478-2-git-send-email-imammedo@redhat.com>
	<20190517095528.45405c7e@Igors-MacBook-Pro>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <72e9b84d-629e-8091-263c-c32f7138fa52@redhat.com>
Date: Fri, 17 May 2019 10:04:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517095528.45405c7e@Igors-MacBook-Pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PULL 23/37] tests: acpi: rename
 acpi_parse_rsdp_table() into acpi_fetch_rsdp_table()
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
Cc: Laurent Vivier <lvivier@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Ben Warren <ben@skyportsystems.com>, qemu-devel@nongnu.org,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/19 9:55 AM, Igor Mammedov wrote:
> On Thu, 16 May 2019 08:20:15 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> From: Igor Mammedov <imammedo@redhat.com>
>>
>> so name would reflect what the function does
>>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
>> Message-Id: <1556808723-226478-2-git-send-email-imammedo@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Michael,
> My mail client doesn't do proper threading since something wrong with Message-Ids in this pull req,
> 
> for example this patch in V4 I've posted has message id
>   Message-Id: <1556808723-226478-2-git-send-email-imammedo@redhat.com>
> and the same patch (modified with your SoB) here also has the same Message-Id
>   Message-ID: <1556808723-226478-2-git-send-email-imammedo@redhat.com>
> which to me look broken 

Same happens to me (Thunderbird).

