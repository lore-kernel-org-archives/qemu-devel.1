Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386EBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA2F206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvkeTczn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA2F206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqf5y-00082l-7e
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqf4l-0006Bm-Mv
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:55:08 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:38239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqf4j-0002pt-QO
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:55:07 -0400
Received: by mail-ej1-x642.google.com with SMTP id w16so25359533ejj.5
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=66IoJJYbx2eqPTYwnGocI9DHSH178FfXyaJnef75iLs=;
 b=XvkeTcznqFK9b8x7rgHaJHJ4WMkgroSCDY16WmAMdwwIvgfcXwecCypW1UAEImh9UN
 t7dMM/hCTPsQCF/L8EPo1b8fMEqTAdc2X/6n0NbC1hi/UamxisFlevziGrIazi0RC1GT
 5pGGUmx3joQfyuSDxPO75O1r78m+QOL3KfFHrHI7et2bHN8W7U0EVcfe4JkxTPdx56Rd
 iPkbBp4KwREmKuGiqOXlcOSHMoTXbdknLQHF5uBfLEojj5v+RCPANAP4vg99C83AW6eW
 +xsGx/Xb7kAz8aeC2QPTEE0Yi+Ma2z7DwG8enYbSapB7LgK3euMdx37bIHvUoMyXKrOs
 w0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=66IoJJYbx2eqPTYwnGocI9DHSH178FfXyaJnef75iLs=;
 b=JIT50XNoxArz9dBQPXE5w+zv0hoONrz3mS7eF4EYqkNI35m75nhgwpGtjZHFUX0n3Z
 3/gtZ0DnVQ0qX9AExDrkH4lXEXlYL+vzcaMSP4KsLl8GMkNguMXd6hk2plUD/n7KMEZJ
 j3HaD9sK7DCnoBmYdNaAJ9ybQC79eNoPSm7zyo08stwbBYvowmuuJeP1PaWfmx46tghy
 lxFryecB6sKkTDh9HSDbJHLz0pmtFo8kT4dFEVW1Nnuj3ev6eCu41oGVwBle7yw58K8A
 +VCZMPU/Qa4M96s9yJj1/n1mFY8M+jmgcQ8C4aNRd1kGgOsQCIFYxu2nfYnZgbWsfXEI
 M4+Q==
X-Gm-Message-State: AOAM533gk/bNc9Acte8Yy50zycyPpWnPTq+zrnyefulXH4KKAyTCzWrK
 lQR1Y+Ch/Re64tRGpLMcBRU=
X-Google-Smtp-Source: ABdhPJxdKAiM84LQ/qJSX3Oq2iWvwJoz58yh3fapcIZYkLP0kDj5ZqmU4y0Q8/IHvkKAyiRxGVedSw==
X-Received: by 2002:a17:906:5912:: with SMTP id
 h18mr23310104ejq.259.1593618903881; 
 Wed, 01 Jul 2020 08:55:03 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id bc23sm6568300edb.90.2020.07.01.08.55.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 08:55:03 -0700 (PDT)
Subject: Re: [PATCH v4 27/40] tests/acceptance: fix dtb path for
 machine_rx_gdbsim
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200701135652.1366-1-alex.bennee@linaro.org>
 <20200701135652.1366-28-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4db591b4-4db6-380e-15ec-8ff142c60854@amsat.org>
Date: Wed, 1 Jul 2020 17:55:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200701135652.1366-28-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, berrange@redhat.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 richard.henderson@linaro.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, cota@braap.org,
 Cleber Rosa <crosa@redhat.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/20 3:56 PM, Alex Bennée wrote:
> The old path doesn't exist but the rx-virt.dtb file has the same
> checksum so lets use that.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/acceptance/machine_rx_gdbsim.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/acceptance/machine_rx_gdbsim.py b/tests/acceptance/machine_rx_gdbsim.py
> index a44f2c87da0..bff63e421d5 100644
> --- a/tests/acceptance/machine_rx_gdbsim.py
> +++ b/tests/acceptance/machine_rx_gdbsim.py
> @@ -50,7 +50,7 @@ class RxGdbSimMachine(Test):
>          :avocado: tags=machine:gdbsim-r5f562n7
>          :avocado: tags=endian:little
>          """
> -        dtb_url = ('https://acc.dl.osdn.jp/users/23/23887/rx-qemu.dtb')
> +        dtb_url = ('https://acc.dl.osdn.jp/users/23/23887/rx-virt.dtb')

Or:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg718316.html

Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>          dtb_hash = '7b4e4e2c71905da44e86ce47adee2210b026ac18'
>          dtb_path = self.fetch_asset(dtb_url, asset_hash=dtb_hash)
>          kernel_url = ('http://acc.dl.osdn.jp/users/23/23845/zImage')
> 

