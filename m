Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C0DC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 18:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F310420715
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 18:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTwuFsXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F310420715
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1DM8-0008Tq-4h
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 13:00:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j1DLP-0007xw-NN
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:59:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j1DLO-0005KJ-MY
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:59:39 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j1DLN-0005JN-P3
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:59:37 -0500
Received: by mail-pg1-x541.google.com with SMTP id z7so4296620pgk.7
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 09:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=aHgzZrsrwcWeQ87VMrWjH4rMXOkj/mrqsMJ6vGEraG4=;
 b=vTwuFsXRyylgRKGarS+ot9yCdYqTChm7nPjrlyI3dcpgTLF6UgViuj0/epNyF8QYFy
 ha+damVOOgwrHRPkVOmTwrdH7NIDl92QvTV9NUCrWL0oBG4C4a9oxdMXJUkQXekhgsFe
 vrt3J/Hl5RNu79mwXJtxn+IsCeTaJb2d4wQqlx0zNNFRn5XM/6pSF4mHp01Fs2FbtPqu
 8cClocKFDbKi1m5Pf3nwBNduLXUkEdT1+Oc3zHpvhcb3L4W5ukl7wcfRyE/peFOIoM/Z
 Q2WbLT4nDaYTYlMD5J7x8bbjE5TDiC4gwv+le0/bYx8+jia2fU+zh0eYEzbx4OFv5zLQ
 DnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=aHgzZrsrwcWeQ87VMrWjH4rMXOkj/mrqsMJ6vGEraG4=;
 b=b+c1CHpf949z7DxPV567CH7090YL+8CnWy2kgwsPBYbq8dkBuiLbwG4XCxW3OWtC68
 ecE7h5LI260kZYys0zqEhJlXPfeNbpV/WZsUuUaA6EdipaKmRDS409d+DX885CC3RutU
 wNF1wzPbKE8JH1yz9EZ93tLoozCGeD10Z4DVpV+Iv4cHQ0eZ2MlgKisyybjFfVdZlu/9
 Ky+MZO/lepv9ONuKlXacOV0W6U8ZLGygD8Rgu2Lxmk2z5G3o0jcJ5+srPrXBTDeH6LcO
 xjP8VsRjtydFJLYspDVS1TCPy+bebX0hndipRXnkP/wvLYko5gm1ThBuHtPniD1XpdL6
 8Z8w==
X-Gm-Message-State: APjAAAXvRl107FQAneOAWLWARH71RshyV94M/Iamn4Dzp1VVUL5NYJoi
 6Tqz6zgxa25HxmNM7jpWRZ96CFYBTCQ=
X-Google-Smtp-Source: APXvYqzz7JxOl4/fuWUB8t5abHmZ1dcaoJ7fcrxkXF6ka3tgscWf0jYlxHx85/e3Vwc/VkfJ+0lhMg==
X-Received: by 2002:a63:2701:: with SMTP id n1mr2834110pgn.332.1581357576255; 
 Mon, 10 Feb 2020 09:59:36 -0800 (PST)
Received: from localhost (pat_11.qualcomm.com. [192.35.156.11])
 by smtp.gmail.com with ESMTPSA id h26sm1155458pfr.9.2020.02.10.09.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2020 09:59:35 -0800 (PST)
Date: Mon, 10 Feb 2020 09:59:35 -0800 (PST)
X-Google-Original-Date: Mon, 10 Feb 2020 07:10:57 PST (-0800)
Subject: Re: [PATCH] riscv: Separate FPU register size from core register size
 in gdbstub [v2]
In-Reply-To: <87sgjwr3sz.fsf@keithp.org>
CC: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 sagark@eecs.berkeley.edu, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 qemu-riscv@nongnu.org
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: keithp@keithp.com
Message-ID: <mhng-640eeb10-fc1a-41fd-b870-5f76e8fcdab4@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jan 2020 14:13:16 PST (-0800), keithp@keithp.com wrote:
> Palmer Dabbelt <palmerdabbelt@google.com> writes:
>
>> This isn't working for me.  When I apply it on top of my for-master (which is
>> very close to master), I get 
>
>>     warning: while parsing target description (at line 1): Could not load XML document "riscv-64bit-fpu.xml"
>
> If you're building from an existing directory, I think you'll have to
> force re-creation of riscv32-softmmu/gdbstub-xml.c

That worked, thanks.  It's in the queue, with a note in case I forget again :)

>
> -- 
> -keith

