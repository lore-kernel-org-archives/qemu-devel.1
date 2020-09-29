Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02336C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 468592072E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVhK3z2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468592072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNBXM-0006pH-Uo
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 05:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNBTU-0004S2-Ep
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:59:04 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNBTS-0000Ze-Hr
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:59:04 -0400
Received: by mail-wr1-x442.google.com with SMTP id c18so4418707wrm.9
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 01:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HP2URMinbtT0S4bPhAXRvbSSG7+JGfKwytqz9MnePTI=;
 b=bVhK3z2ATAR8qWirb+UXN/4a4HEbZm3OippN2bd+jBVO2oKaWkAznTtOfAdRBt6d0W
 TDD6B847CcwW9UJcEsGVh6vYfZ1hCDL2PWYDzRBAuhmyAL68cCIcUjUmPazPu96Pfi7n
 icICED1uSbGaYMMoFZkUatQiBd8iqcniUCY6qkqMow5JSiPq8RiZi2ykewxvd9/6cOPy
 +mBiP8gUcgoAUDBo2g85QrFUvrK14/AnkWjOLBskK1fXG2+BqzyUOYYLF70naK9nU6n3
 xZdvgMCmSGpMeqnD26ocBv9kpdVOafvP7CHIj5hNOwcR5HGGpcEcmr2oFuNlkYJd5VgK
 Jgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HP2URMinbtT0S4bPhAXRvbSSG7+JGfKwytqz9MnePTI=;
 b=gj1L6crlgV3ImUQkF6OJ7izu3bOdXSGSFEgq/zkDfzbcSGlNUOV4HB0eu7qrSl6s6+
 vL+yaoEEfsPxzW4PLijialrxBhbxcOqQL/R9IZu4djDSCVNXbWG+7QGghv5oshoberG6
 +SvoHxgYEwHmezeMW9xgov2mdOffmgNV8B1APZUEcBOWFBqGCHD1V6Pc5pX5KpMp95lB
 qjdxogWuXY5hfhR+yCEsln9veRa3GQBgmGS/rt9K/Ir315JsGPTnNp6gJHhGk+qPiNr7
 JyVxZopE3DIAZ73gFMOuRqDIV5ufQzyQpu4cot2maqgzjrTzxUo0gJ6J2P+12PWE8Cy/
 u+Rw==
X-Gm-Message-State: AOAM533j3b10ePk5VAjcs2Gd5K32/AkizgT/+qlleiP3W6eJJ3X4dAtq
 JDpmeOeeIIpAXczFj60pzGE=
X-Google-Smtp-Source: ABdhPJzCzGiaUh1pQ7F5dWz0JxFV1ii+gOROzCidYR1H+9WGqlBB5qzEt/X7CnX8mIEQ9g9IJlPiqQ==
X-Received: by 2002:adf:ec90:: with SMTP id z16mr2894381wrn.145.1601369940892; 
 Tue, 29 Sep 2020 01:59:00 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id i33sm5546069wri.79.2020.09.29.01.58.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 01:59:00 -0700 (PDT)
Subject: Re: [PATCH 00/16] hw/mips: Set CPU frequency
To: qemu-devel@nongnu.org
References: <160134758680.17704.16181427169478621258@66eaa9a8a123>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <304f8e56-5032-e8d8-1931-5c5fc48cd0d7@amsat.org>
Date: Tue, 29 Sep 2020 10:58:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <160134758680.17704.16181427169478621258@66eaa9a8a123>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: damien.hedde@greensocs.com, zltjiangshi@gmail.com,
 aleksandar.rikalo@syrmia.com, ehabkost@redhat.com, paulburton@kernel.org,
 edgar.iglesias@gmail.com, wainersm@redhat.com, aleksandar.qemu.devel@gmail.com,
 hpoussin@reactos.org, crosa@redhat.com, chenhc@lemote.com, philmd@redhat.com,
 aurelien@aurel32.net, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 4:46 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200928171539.788309-1-f4bug@amsat.org/
> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
> ---
> qemu-system-aarch64: falling back to tcg
> socket_accept failed: Resource temporarily unavailable
> **
> ERROR:../src/tests/qtest/libqtest.c:301:qtest_init_without_qmp_handshake: assertion failed: (s->fd >= 0 && s->qmp_fd >= 0)

Unrelated to this series, as it is only MIPS.

> ../src/tests/qtest/libqtest.c:166: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
>   TEST    iotest-qcow2: 013
> ERROR qtest-x86_64: pxe-test - Bail out! ERROR:../src/tests/qtest/libqtest.c:301:qtest_init_without_qmp_handshake: assertion failed: (s->fd >= 0 && s->qmp_fd >= 0)
> make: *** [run-test-110] Error 1
> make: *** Waiting for unfinished jobs....
> 
> Looking for expected file 'tests/data/acpi/virt/FACP.numamem'
> ---
> real    18m49.678s
> user    0m13.756s
> 
> 
> The full log is available at
> http://patchew.org/logs/20200928171539.788309-1-f4bug@amsat.org/testing.docker-quick@centos7/?type=message.
> ---

