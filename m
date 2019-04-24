Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A0CC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 17:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929E02054F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 17:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2DLs8f7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929E02054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44991 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJLl3-0004L2-QW
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 13:32:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJLhT-0001gv-SE
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 13:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJLhS-0000lp-Sr
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 13:28:51 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:35319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJLhS-0000lD-Ib
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 13:28:50 -0400
Received: by mail-pg1-x529.google.com with SMTP id j24so39968pgk.2
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 10:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=3AYojD/qkOCEpMNQ/eBWpHXHKraZj/a+Wx4gOByla0I=;
	b=o2DLs8f7NOnjji/2HYh06PbH+ychsGUYr3iWQdvRzKBM/EXj0lNu2gGVEPfaQVjhq6
	4ZwWfFF1EQdmvF7THYHQKf2j6B8vWVJcwpEjl9YSy1YoxpH7NbOml6Zu8d1H/X4uBkqa
	bkuWGFOfFNg4FxpR+FaWaco4nR2sNb7GpQJAZZ6ryGKHyt+R4NLeWP9Gv16gS0ivhwqa
	rjQSHA6jT4DxAojXeEVwzOC0ed384kZleY0hbuYbfKlf9qJiA/eupT+WZvJ1IrLjZFIz
	FQPUo9336Hh7WD8uxobI4CHXwU4Php/sUTmlhyPUP8Cv7MiHg9tmyMpWrspk6a8g6WGf
	Tp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=3AYojD/qkOCEpMNQ/eBWpHXHKraZj/a+Wx4gOByla0I=;
	b=JudELNv5xW4ee1FoQJTY/iuhnnVUmqfx1BUopYCA15KRCrsk7DNbdrK/xKjWrXds61
	DOP3NL9Xp0Zw0OyBcMRPymz2B6PsfikLD0AfDi7uk5nY0r90w2J0VLlYmWVGphQWKIAc
	PgsIjLzXjNMR/VmrxoEWk4PC6W3fQjJbwgURoSf4xEf1WmcZhJxOBTON4mlTXh+prt5x
	ICh9JaFKyhHiYANYLdO/OJOm43UiRc1QSiMP2Ud9RO+ZW8ni84qf7DbsoIGJFDLlRIN6
	xdrUisOfkm6GITNUWmfOCWbaRhrMT/zZr+CVLB5bmrT+Noh/aAGm+3Co95e8rtFLlD4N
	YpWA==
X-Gm-Message-State: APjAAAWt4oLKB4Jzf7F1OXjszOtywTuZZwl7hzkz7US8qCsJDcjpNJPY
	gzqGH8XSTMEROA+VfVJp2XMqgTLTWdM=
X-Google-Smtp-Source: APXvYqw2ENO3mvM1o37BLTEPDcGpQ/QXegK8EUX7oxCIYvRbPX5ZmvgGUIlXk/oyXHV2EUVzf3lSbQ==
X-Received: by 2002:a63:dd58:: with SMTP id g24mr2837489pgj.161.1556126928640; 
	Wed, 24 Apr 2019 10:28:48 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	s85sm34654468pfa.23.2019.04.24.10.28.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Apr 2019 10:28:47 -0700 (PDT)
To: arilou@gmail.com, qemu-devel@nongnu.org
References: <20190424142714.28460-1-arilou@gmail.com>
	<20190424142714.28460-20-arilou@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <cd34aad9-fe14-5262-0244-1ff2332d20f9@linaro.org>
Date: Wed, 24 Apr 2019 10:28:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424142714.28460-20-arilou@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::529
Subject: Re: [Qemu-devel] [PATCH v3 20/20] gdbstub: Refactor parse handle
 packet to work with a static array
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424172845.7lcTpauyxTCCagHnMy-V-92iLELmxv8pb5gmUmprfj0@z>

On 4/24/19 7:27 AM, arilou@gmail.com wrote:
> +static GdbCmdParseEntry gdb_packet_table[0x100] = {

21 out of 256 entries used?  That's a pretty poor occupancy rate.
What was wrong with the switch statement?

Or a modified version in which you sink the call to process_string_cmd
and only load the pointer to the structure within the switch.


r~

