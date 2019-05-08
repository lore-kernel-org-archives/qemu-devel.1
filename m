Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29349C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 20:18:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB23E204FD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 20:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB23E204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43334 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOT0t-0002nU-IS
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 16:18:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOSzo-0002Tm-GO
	for qemu-devel@nongnu.org; Wed, 08 May 2019 16:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOSzn-0007Sp-MK
	for qemu-devel@nongnu.org; Wed, 08 May 2019 16:16:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOSzn-0007SH-Gw
	for qemu-devel@nongnu.org; Wed, 08 May 2019 16:16:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id y2so187236wmi.5
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 13:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=SXxKdbuuFLhMCJMYIhyM0I7bGfZqlBBLOhy52+XdYmI=;
	b=CIFnahVAF0Kr6p/L9nLjTVyymXOBr3TtxLA7ru9XBP7swaiYEFg3MHoiYjaxBzDM+L
	ZEESj156EAE7XFYx2v24ys2GOGANLY5gSxSOy16+4mzYgzlUhGCyMryAlW/VGXv0uHqb
	bViUFlaZ4o7jrdV4ypvR24uN0OJLVEcZK44Ew6s3FXDWTOUzW9IvGh6+BYhOwfJKVPiH
	oyoqhOPu6KQ06PkURBXBWHTT29csQOn1Nz4loQfgxRSkX9GywH9eoikVH6uyofIp4NL0
	68/bVdvn0yWm6Hq/sDKsDGQyoZVj4XS1wjfqUuuw7otmTnO8lruJT9SavtrHA++lhfyx
	JP7w==
X-Gm-Message-State: APjAAAVLBtIf/8CDVHpTfRLZIhTWlveBMeel4C1PNgglYiIPTLr5UEXf
	p0wDMSf7UTOeeaI8APZOVl8hsQ==
X-Google-Smtp-Source: APXvYqw6Q8bgRoYPD6qBRiQWOOAjNjclHYQsI5xmygjIbQALEUWoEbMnN+oYOpmwJwrRPFvddgr00g==
X-Received: by 2002:a7b:c415:: with SMTP id k21mr65855wmi.29.1557346614249;
	Wed, 08 May 2019 13:16:54 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	p17sm22851439wrg.92.2019.05.08.13.16.52
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 13:16:53 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
References: <20190316234456.18140-1-philmd@redhat.com>
	<97745dfa-ceaf-6572-59ba-a37e8f3c1e89@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <097f4f90-b190-93d3-5c72-756fb29f7cc3@redhat.com>
Date: Wed, 8 May 2019 22:16:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <97745dfa-ceaf-6572-59ba-a37e8f3c1e89@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH for-4.1 0/2] hw/alpha: Add the CY82C693UB
 southbridge in Kconfig
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo, Thomas,

On 4/29/19 1:29 PM, Philippe Mathieu-Daudé wrote:
> CC'ing Thomas who is a Kconfig expert.
> 
> On 3/17/19 12:44 AM, Philippe Mathieu-Daudé wrote:
>> Explicit the CY82C693UB southbridge used by the 264DP.
>>
>> Philippe Mathieu-Daudé (2):
>>   hw/isa/southbridge: Add the Cypress 82C693UB chipset
>>   hw/alpha/Kconfig: The 264DP machine use a CY82C693UB southbridge

This series does not fix anything, but makes the kconfig graph cleaner.

Regards,

Phil.

