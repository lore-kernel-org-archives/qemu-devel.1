Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35741C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 077D2206A3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077D2206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44053 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRXp7-00026M-Cr
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 04:02:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRXnu-0001WR-PE
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRXns-0002Hp-VT
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:01:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hRXno-00027o-CF
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:01:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id c77so4485943wmd.1
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 01:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=iLn0wTkT81tkBhcHXh0MSBWMhwsAZmmHDpRG2khi6eQ=;
	b=b+ZRyPY5OhXZ91FOiGM82vdznsw1VdT3SbE3/+5Mv6QIznU44/7ebPgE0wZtHUo2Ga
	0slKXlaky+MIHkUkIAK3LZdxjE6xyJsZWdbBgRX3mpabo3hlcO7ifWcPCV8MAI6Do2oQ
	Y19+gnf7TTa0InbsZcrJEdLCL/x4v695N7Zw9xnHocEkzvyHWa3t/HqMG5wLAJi0yKJF
	ThZ6vIUajBGWsYmuJiHrFbmmKzDIwPH5XSlHiv5nOsi+W7290YmDJVooTGlJuBNsD8cz
	WfD+3uCe0eHRAM+F27zRpeVmKblETvQRPmCmAWPFC799Jdli30c2OSKNBt/9N2IyzyJd
	CwWg==
X-Gm-Message-State: APjAAAX3VoE7SrzBZ3x7M91EaW3OTILs16ZeoG587GrQqp8Xz4YoZlif
	zzyGWbbWFHTDRzlDnq6xHOBhtw==
X-Google-Smtp-Source: APXvYqwAfdb5pIyuAXWFY86xZrEzMeLkp2aK5KL/b1B+AlIHn7Fy9FSRqwtzCMro1kWAKvSWqqBXzQ==
X-Received: by 2002:a1c:e3c3:: with SMTP id a186mr1174816wmh.5.1558080042043; 
	Fri, 17 May 2019 01:00:42 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	g13sm2106103wrw.63.2019.05.17.01.00.41
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 01:00:41 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190517045136.3509-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1d36d568-8fec-f81e-635f-a34560e04b2a@redhat.com>
Date: Fri, 17 May 2019 10:00:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517045136.3509-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v14 00/13] RX architecture support
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
Cc: ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/19 6:51 AM, Richard Henderson wrote:
> This is Sato-san's v13, plus the typos that Phil noticed therein,
> plus the change to tlb_fill required by
> 
>     commit d8276573da58e8ce78dab8c46dd660efd664bcb7
>     Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190510'
>     Add CPUClass::tlb_fill.
>     Improve tlb_vaddr_to_host for use by ARM SVE no-fault loads.
> 
> 
> r~
> 
> 
> Richard Henderson (1):
>   target/rx: Convert to CPUClass::tlb_fill
> 
> Yoshinori Sato (12):
>   target/rx: TCG translation
>   target/rx: TCG helper
>   target/rx: CPU definition
>   target/rx: RX disassembler
>   hw/intc: RX62N interrupt controller (ICUa)
>   hw/timer: RX62N internal timer modules
>   hw/char: RX62N serial communication interface (SCI)
>   hw/rx: RX Target hardware definition
>   qemu/bitops.h: Add extract8 and extract16
>   hw/registerfields.h: Add 8bit and 16bit register macros
>   Add rx-softmmu
>   MAINTAINERS: Add RX

Series:
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

But please reorder patches before sending the pull request, see:
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03671.html

- patch 9 first "Add extract8 and extract16"
- patch 10 then "Add 8bit and 16bit register macros"
- then other patches 1-8, 11-13

This will help if we unlikely have to bisect ;)

Regards,

Phil.

