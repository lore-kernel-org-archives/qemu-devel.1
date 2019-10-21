Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ABBCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 045692064B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QvAc5S7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045692064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMbhL-0003RL-5b
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 13:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iMbgC-0002Zb-8i
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iMbgB-0003Cy-4b
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:41:16 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36561)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iMbgA-0003CA-UR
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:41:15 -0400
Received: by mail-pf1-x442.google.com with SMTP id y22so8870797pfr.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 10:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7o2dss3VOzyE7jxjHvktXmTvl4FbMO3NZUv6ex5lRyk=;
 b=QvAc5S7mwtKOdwKwEm9Dvwgd5KhOnqKTFU6+ZysDTHAZFvmbEz8pqP0BcOPZDvpGz8
 CVUYexQ5CiCh5sqomoD368JKgOrc8eTn0c8rTpchucqwe61Ilu0B73JGxWFGMRY1YIQ+
 1xeGF8ph8JOPjGG1vtuXwi0krTJ1vpiw14HElyRyQ2BGnrw7i6iQbd3jWA/Q/Rc7JYOx
 aybzaxz28k4iRjUtzDuc3rEkkjR9NKdp5sobQ63njLUUx4JN8kkaqKEx04hWwCGwNS9d
 1rwVLlWfsjGzdSMAzTLyT+tm188GpN6xaTXEEMzk8DNP7ohkQFMi+S5CQ600pYIsBOOQ
 +yXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7o2dss3VOzyE7jxjHvktXmTvl4FbMO3NZUv6ex5lRyk=;
 b=mw2/DMkneIHI8+jqMeAUaCbLoHQYqpVSuns6IIxPKcSvfybEAp33YDrNZfAcbJUwGd
 sNV46p1VAsID2Kj8d34noQpfKjZob5DTxnDihED60WhUrynVgUdwc+gMCXwaLpFMsQvb
 3kXI1AqLsRxErEI6fHfLMOABJZiX6GI4qkQ64XYcVnXjny0LFbwuciatMrt3AN95oz3x
 TLUBKzDavHNyT4rlRaoI7TjhKTaaij37bfGt/EsREcYSX885ij+mk9EC1u0AxiCEgdkl
 oSFrzKKqDDPug3UDe+icnSMwdgPylj24Upw0xCFndYsPqbo6CaAJ/9SD560Z0Zk1JW41
 QyuA==
X-Gm-Message-State: APjAAAXM23PZRvMXDTQA6b4NyL37MzFV4Ma26kqBfQpbNJVMZ+XqYpIj
 WMlQsmyFbblrLaQbrTJXluBEGA==
X-Google-Smtp-Source: APXvYqxN3WxcpKOza7iDcs5A4OACiuZIfwncgzWkMbciz7HjumpGOvZu0THzGCQfoqmxQur+KlrVsA==
X-Received: by 2002:a62:ac02:: with SMTP id v2mr23443419pfe.200.1571679673053; 
 Mon, 21 Oct 2019 10:41:13 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id x125sm18599307pfb.93.2019.10.21.10.41.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 10:41:12 -0700 (PDT)
Subject: Re: [PATCH 21/21] hw/core: Assert
 memory_region_allocate_system_memory has machine owner
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-22-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a9b24bbe-8186-c50c-fe84-c9dc9c0448ce@linaro.org>
Date: Mon, 21 Oct 2019 10:41:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191020225650.3671-22-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Paul Burton <pburton@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leif Lindholm <leif.lindholm@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jan Kiszka <jan.kiszka@web.de>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/19 3:56 PM, Philippe Mathieu-Daudé wrote:
> All the memory_region_allocate_system_memory() pass a MachineState
> argument. Add an assertion to ensure the new boards/machines added
> set this argument, so all system memory object have the machine as
> its QOM owner.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/core/numa.c      | 4 +---
>  include/hw/boards.h | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

It would be a good idea to add __attribute__((nonnull(x,y,z))) as well, but
since we don't currently have any markup for that in qemu, that can go in a
separate patch set.


r~

