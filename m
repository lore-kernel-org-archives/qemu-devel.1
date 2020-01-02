Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDABC2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 11:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 970E921655
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 11:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QzwN4MD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970E921655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imybF-0004xt-Oj
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 06:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imyaa-0004Rg-Dg
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:24:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imyaY-0006nz-Es
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:24:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54312
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imyaY-0006nG-8F
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577964264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnKjfN+dTe7awd3Z1ieOUyD7hBqLGQ9bsXfNjMDsXos=;
 b=QzwN4MD+52GBcTCDuzm5jh2cAkp6qtqKeWqlW0/bYDtCa1nb5z5pSv6HJXWQ4ZDw647PHP
 +ab58A/VZczhcHuxX4MnOZllu9ts3gq4mxkAgd5HGyHcJe+IFDaQtXtgf7m1qDOWYe0x+W
 tcYDuGcAY9QtuLyLdX+0fEc5tZsLciU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-01w6OvI9MIeKnQCbZniIwg-1; Thu, 02 Jan 2020 06:24:23 -0500
Received: by mail-ed1-f71.google.com with SMTP id m21so7056184edp.14
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 03:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dnKjfN+dTe7awd3Z1ieOUyD7hBqLGQ9bsXfNjMDsXos=;
 b=eSmR8MP5VxLeu0d6nSmcLO7yVDvQ3plONUhs4hT5F/HjisgvCWqk77PC6R5s+3mXVX
 BoL+kYDXHDIFn3BPbYBrWejB1m5+bZUAhhBW+dP88dYi0wKsnVOqlG7B6voTDIsZuOcF
 zIhq3cY9xt1Du9snmsDcvs5rR6PizU0tdHeYk2/ZZLflDPunCtT4kwkpiRmFINSnslCD
 lUYU+51fYbKEdV+iJYNeiBczFs7kwwJouONE3/8X6X8TuZN0niqP5WRQG/MrVjph3n5N
 RYufSj2MHI1R6+C/hR+55GFbYPdGE0ETDXYssUQYVJBxoHbjbXXngSckrZqb9l7HXQOS
 fszg==
X-Gm-Message-State: APjAAAVY5LJsWrGYc2DXGKlqQS5DHdgUA0DnwpAk4DgIvUXDZCxkl6WL
 97eOXMrB3aDjD9GvjWgJ8viH5ZyWOm0xXCNfwST0Be8xfXjQF3v47KG8KCY4iilYy75mJgUEIMH
 FR9ZzF5SyP9Cvzew=
X-Received: by 2002:a17:906:2e41:: with SMTP id
 r1mr87355668eji.127.1577964262248; 
 Thu, 02 Jan 2020 03:24:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqxmZYREZjTOPLg/tvPZIp6o2JkrPtdfEl+UR/lROML01Mccmk2F8Ndtffqvccjrg4K3nibtVQ==
X-Received: by 2002:a17:906:2e41:: with SMTP id
 r1mr87355642eji.127.1577964261977; 
 Thu, 02 Jan 2020 03:24:21 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id u26sm7339814ejj.7.2020.01.02.03.24.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2020 03:24:21 -0800 (PST)
Subject: Re: sysbus usb xhci
To: "kraxel@redhat.com" <kraxel@redhat.com>,
 Sai Pavan Boddu <saipava@xilinx.com>
References: <MN2PR02MB5935CFE95528B85E06DA9583CA200@MN2PR02MB5935.namprd02.prod.outlook.com>
 <20200102094515.bbjaqlif7ucvzuou@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b8ad0f98-a02d-bcb2-acd8-a6e9fb606167@redhat.com>
Date: Thu, 2 Jan 2020 12:26:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200102094515.bbjaqlif7ucvzuou@sirius.home.kraxel.org>
Content-Language: en-US
X-MC-Unique: 01w6OvI9MIeKnQCbZniIwg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/2/20 10:45 AM, kraxel@redhat.com wrote:
> On Thu, Jan 02, 2020 at 07:13:25AM +0000, Sai Pavan Boddu wrote:
>> Hi Gred,
>>
>> We are seeing of options to reuse the hcd-xhci model and use it over system bus interface rather than pci. (for Xilinx ZynqMP SOC, usb emulation)
>> Are there any plans of implementing a sysbus device ? if none it would be good if provided few pointers to start.
> 
> There have been some discussions about this for a (IIRC) sbsa machine,
> but I'm not sure whenever that where just ideas or some code exists.
> 
>> Im looking at hcd-ehci/ochi as a reference, let me know if there are any know limitations for this usecase.
> 
> Yep, the path for xhci would be quite simliar:  Create a new
> XHCIPciState struct, move over all pci-specific bits from XHCIState,
> leaving the generic stuff in XHCIState for sharing with sysbus.
> Possibly move all pci-specific code bits into a new source file (for
> cleanup, will also allow to build qemu with CONFIG_PCI=n and still have
> XHCI enabled).
> 
> Once this separation is done you should be able to create a sysbus
> device, reusing the generic xhci code and adding sysbus plumbing
> (mmio, irq, ...)

The SDHCI commits b635d98cf32..8b7455c75e seem similar to what you want 
to achieve (see also commit ce8646034).


