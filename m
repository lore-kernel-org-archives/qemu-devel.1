Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FE3C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A667C206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFzfNtaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A667C206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD345-0003Vt-Q4
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD2qi-0003YV-9h; Tue, 01 Sep 2020 05:45:08 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD2qg-0002KC-IQ; Tue, 01 Sep 2020 05:45:08 -0400
Received: by mail-wr1-x441.google.com with SMTP id c15so740663wrs.11;
 Tue, 01 Sep 2020 02:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ak1MELy64MVFTjZtGG5oZHevqS7oZZr0pksQQpBgw3Y=;
 b=eFzfNtaTeZDUe7avJJpEJRi8X2aKN70Pw1Cztdqdq5xa+4DkmgJTb1XZbA33irPMsd
 n6kTcjpnlU7Dj9SrjwSUiyhwMkiZO9BoPXSH0L1VBqwWnxD3PSCWMQrV+9IxrTdx3/i4
 UqX87eWW8cu2SUqJDNTSIi7mMrZBi63BRZOrXoSbRC89mYbrDnU+sFYlGNDonNGIqaOD
 bZSllu/jbJrSFu55+EKEU0s3UO/sW7SPCxpCQZNKeDTOelXGMSOtd0HJtByY8uDnpF1Y
 4k3NwSKY68DmsHePT/9xB7Qi1awbd4jvF6iuSgNsYNM1g+eDMtkaoCuQAzHbSuLhaXyG
 9lPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ak1MELy64MVFTjZtGG5oZHevqS7oZZr0pksQQpBgw3Y=;
 b=AmJ4nkXkUaoerYPesQePn8BQV2X/kaIUtEALweORljolbyL0vwE2PDia5fDHbpMFih
 1a68LY8ZZ5wPQIrU+04ymo8s2mMpgyfxDqyk6ndnnBpNF/ayaTQuBR05HNjF8UnpsTTo
 vWZxJBcYwggpX5LYEQdc6DFSxZSrvVKGU2RuVcxBGpo7X3G0KHOyNiSbmUQR13oQkPVB
 t4ytAIcIAzJVnj47MZ8pHP7KLQEWm/Erb+Q9cmvuB3EhIpDTyYqzVS/NgumEsi/gDMYc
 jOu+aF7pcMZnEhfTwldXC1kcUFwGDBzBObaVQfcOCY7O4YwSo7zgBbp2yQd7efsBPQ0o
 ty5w==
X-Gm-Message-State: AOAM532l6bKWfo9tlXdc0XwSx67cmZK6h5+F7voCLcC+9NAu2k/PVagX
 T7TRnTDUMjmdRJDVSvtaa2Y=
X-Google-Smtp-Source: ABdhPJzZu5dLEd5ReCUReHJCEUSG2jvoTvmvHJa8GyaH5SzFgIXNTHPR6QzDBMlnSUtWTDXGOjEdrQ==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr939876wrv.318.1598953504454;
 Tue, 01 Sep 2020 02:45:04 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id l8sm1443299wrx.22.2020.09.01.02.45.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 02:45:03 -0700 (PDT)
Subject: Re: [PATCH v3 12/16] hw/arm: xlnx: Set all boards' GEM 'phy-addr'
 property value to 23
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis
 <Alistair.Francis@wdc.com>, Palmer Dabbelt <palmerdabbelt@google.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
 <1598924352-89526-13-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7df18804-3a54-321b-8aa5-4e07a93a1318@amsat.org>
Date: Tue, 1 Sep 2020 11:45:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598924352-89526-13-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Jason Wang <jasowang@redhat.com>,
 Bin Meng <bin.meng@windriver.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 3:39 AM, Bin Meng wrote:
> From: Bin Meng <bin.meng@windriver.com>
> 
> When cadence_gem model was created for Xilinx boards, the PHY address
> was hard-coded to 23 in the GEM model. Now that we have introduced a
> property we can use that to tell GEM model what our PHY address is.
> Change all boards' GEM 'phy-addr' property value to 23, and set the
> PHY address default value to 0 in the GEM model.
> 
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> 
> ---
> 
> Changes in v3:
> - use the correct (Object *) to set the 'phy-addr' in xlnx-zynqmp.c
> 
>  hw/arm/xilinx_zynq.c | 1 +
>  hw/arm/xlnx-versal.c | 1 +
>  hw/arm/xlnx-zynqmp.c | 2 ++
>  hw/net/cadence_gem.c | 6 +++---
>  4 files changed, 7 insertions(+), 3 deletions(-)
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

