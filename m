Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9A7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE2EE2078D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/xlQqy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2EE2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6csF-0002N6-5W
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 12:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6clg-000767-J0
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:41:24 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6cle-0002de-Qt
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:41:24 -0400
Received: by mail-wr1-x441.google.com with SMTP id p20so8916384wrf.0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6j2hSGTw+VUf8E9AqnZ1VilYmcnzl3giVdcSPPp7dSE=;
 b=J/xlQqy+NYAm3cfSeAPZuKKh49Ox4X9NkaeVyYQAnqJlbaUKX9O7ARgEaphEnw0D0a
 69Hkmxc2PNs0xD+CCvWoJYSpJRhfslFkJLTd42fY2hWkDWZUhqhue80PyvoBo+X1kw/l
 oRRH9NmtgMeO4EbnavOVolQVVbmdf6zzzCQGsnbcC4m9w/DDyDFotodEJeK9ChXvpdDC
 31WrPFXocT37CUR6qqukHbdLjhAJpXudUMQiwFpTp8rnjWN62Iy9LfbKvyyEJEgcDF66
 s7p/DP2/9qPEIOd924SDNLPgUZVEZgBX3W8yspOa8WSf827o/TxPQjAMht9ycWTsGHaP
 TUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6j2hSGTw+VUf8E9AqnZ1VilYmcnzl3giVdcSPPp7dSE=;
 b=LL2t0aQ9ivanUL8nkBxCvW4DcDkUbXmLCWIKP2aAV8p0auX170x8RfiYaBxI6HJN5N
 amgvXA9Xiyy15G7S4jJy9F8J+8Nk2glVITpAf8UK4JkyafXvrb6y6SS0ijmqsmU2I6Sr
 2fWR/Sr7wvJfbU+ajmixgTexb9VTBBbOceTBJgO0Tz752JzI4CNGOZOIpYlNRiRFJvjE
 NzQ4Fr6bnta/qvrlHqLxgTwYz3oc432pt4GrMA9MxJvVTwpuW2XyUSLzRpadjX/zIb8t
 9FIeHvm6BEKORLIJbCcC8fXVl3wJ+UID/Pa/cgdw4bLhf4NTQbBBoxfHarwtwFYLDbwX
 yUPA==
X-Gm-Message-State: AOAM530nol0QthGzkTp46NXlULA0Xf/KMhRu4mjkd52sh2f6baPdgIsv
 1cmjs/fkcRuXtr8NFs/WHGI=
X-Google-Smtp-Source: ABdhPJw2UIBNBLfABaXx9bLUI2aEIuAPpxFIKO+NBBNiivHtIWZsw7iouMbFU7p6AqXGYhxbFj1Dow==
X-Received: by 2002:adf:e904:: with SMTP id f4mr3428953wrm.300.1597423280660; 
 Fri, 14 Aug 2020 09:41:20 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 62sm17291084wrq.31.2020.08.14.09.41.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 09:41:20 -0700 (PDT)
Subject: Re: [PATCH] hw/block/nand: Decommission the NAND museum
To: qemu-devel@nongnu.org, no-reply@patchew.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <159741495800.4317.10689667632180842440@66eaa9a8a123>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e51a61de-b4f8-5d44-f811-e99eb2bd0c0a@amsat.org>
Date: Fri, 14 Aug 2020 18:41:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159741495800.4317.10689667632180842440@66eaa9a8a123>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 4:22 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200814132118.12450-1-f4bug@amsat.org/
> Hi,
> 
> This series failed the docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> make docker-image-centos7 V=1 NETWORK=1
> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
>   TEST    check-unit: tests/test-char
> Unexpected error in object_property_try_add() at /tmp/qemu-test/src/qom/object.c:1181:
> attempt to add duplicate property 'serial-id' to object (type 'container')

Unrelated, this is a bug Marc-André is tracking.

> ERROR test-char - too few tests run (expected 38, got 9)
> make: *** [check-unit] Error 1
> make: *** Waiting for unfinished jobs....
>   TEST    iotest-qcow2: 024
>   TEST    iotest-qcow2: 025

