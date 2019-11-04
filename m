Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0D1CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 871CC2080F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871CC2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRhQO-000893-Ne
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 13:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iRhMv-0005ft-6D
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:46:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iRhMu-00070N-3H
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:46:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57440)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iRhMs-0006zf-2Y
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:46:23 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 35D6E368FF
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2019 18:46:21 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id v6so1513203wrm.18
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 10:46:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xu0q6zbquNcFJ9asapZRvI4yKHNnjMZqwZHXo/bCFAQ=;
 b=Ih0rWGN9aHYGXaCdDkEOZgnFwsimeVlyVn6a138CsYKY0pxb5YGeJ3j4eX8A1wTVbm
 Y7Rd/USUcyF2eKxExUP2ELZKUbE+vUUl+Wq8F5G4tL1fO8TLkzClh3G2wnXosFtVAMEb
 VrTUDvZ0VK3CqAnLhFA7HP+AbhSNg4ZCwVLKsUa05Th1GzNMXYquFX999xdXxQkTPLtE
 +JXImUdTpknoupYJ4S0ZnJ8c4g6Fc7gLGqjbzyLVIcm1FYac5CMhPhUvFt1zRzfCdZes
 wOFDTkCnERxKPK9TU1djiN3m+BbweQrQD9dJQpoJQ97OFH2b9cVi0AKjoQUtShwAnIrn
 2xbA==
X-Gm-Message-State: APjAAAWv/8wid8r1zFZInC0FJIO2EgCcr8aR917qrDGghherqcfdReF3
 BonXv4G3h0nWEK6sHeBJr171DWuRTfR9z+1igFOHxd1g0nc74IQvVV3eRPDo0pgN13EVi07c/hQ
 mflf0rw9lixvt4QA=
X-Received: by 2002:a1c:7d95:: with SMTP id y143mr474804wmc.143.1572893179996; 
 Mon, 04 Nov 2019 10:46:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqxl+7st/Ps2r36javvGVcuCbfeBGxyytcehwmItJJ0ArXpN4ZrKOkw0SvSRfzbpxYVjuXgGYg==
X-Received: by 2002:a1c:7d95:: with SMTP id y143mr474777wmc.143.1572893179801; 
 Mon, 04 Nov 2019 10:46:19 -0800 (PST)
Received: from [192.168.1.24] (lfbn-1-7864-228.w92-167.abo.wanadoo.fr.
 [92.167.33.228])
 by smtp.gmail.com with ESMTPSA id a6sm11179178wmj.1.2019.11.04.10.46.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2019 10:46:18 -0800 (PST)
Subject: Re: [PATCH v1 3/6] tests/vm: use console_consume for netbsd
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191104173654.30125-1-alex.bennee@linaro.org>
 <20191104173654.30125-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <36d0d305-01f8-3604-79df-24ec7cd1843c@redhat.com>
Date: Mon, 4 Nov 2019 19:46:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191104173654.30125-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Kamil Rytarowski <kamil@netbsd.org>, cota@braap.org,
 Gerd Hoffmann <kraxel@redhat.com>, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On 11/4/19 6:36 PM, Alex Benn=C3=A9e wrote:
> From: Gerd Hoffmann <kraxel@redhat.com>
>=20
> Use new helper to read all pending console output,
> not just a single char.  Unblocks installer boot.

Again, why not use this by default for everything?

Anyway,
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Message-Id: <20191031085306.28888-4-kraxel@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   tests/vm/netbsd | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index 5e04dcd9b16..d1bccccfd01 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -93,7 +93,7 @@ class NetBSDVM(basevm.BaseVM):
>           for char in list("5consdev com0\n"):
>               time.sleep(0.2)
>               self.console_send(char)
> -            self.console_wait("")
> +            self.console_consume()
>           self.console_wait_send("> ", "boot\n")
>  =20
>           self.console_wait_send("Terminal type",            "xterm\n")
>=20

