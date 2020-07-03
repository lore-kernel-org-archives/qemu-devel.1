Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD16FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A5C208E4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ri6frTUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A5C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrLTu-00049L-VK
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLTL-0003eE-0U
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:11:19 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLTJ-0007I3-Be
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:11:18 -0400
Received: by mail-oi1-x242.google.com with SMTP id j11so23796883oiw.12
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 06:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=smykBEdXki25h29ZQIloSGJPE7mUsGsKt+NrmNXIO5M=;
 b=Ri6frTUc44IoyMey7MJwe0c52a9tihrvwMVzSbuPJH6A1r6JaJ0GcyB5ipupDRCgV7
 7slcXsuvqgr0Tij4kc91DJNHTr/db2C5IO7GRjCJ6afQDdZfHPLJH0J8NjYxr1QK99on
 6K9f3u+KNmX9VmJXJSO+jVwXnfSjvC9l0bPAH1tptIB/s0OgWQ6s9DA8Ylh7SIsxVvV7
 vCx22TusjItYAy5k/jqcPg4blmDCTLAjCEyheL2/Z043Yfl5eZucI8WHpdAplqv3p9Ta
 vLVHfIOx5gcXtOhacY9zFJFkU6GueKtDVpWJOc+rXolCV5iL+dDIaMd0oSNawQKNqO94
 BnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=smykBEdXki25h29ZQIloSGJPE7mUsGsKt+NrmNXIO5M=;
 b=fIF8QCqJAqZOOGZbq4dXsMbs/s/GPaCp6c+CwZcX1TJDyF8/kxF29M2YQ6Ym0hU+a9
 w9bq/mATMg30nfWXVF4XXH6D2PHbP7M3kLEWmmzdNgmxbC18Pz85Oi816Zvdv4rhu4LK
 jCajROII8yGZXHy2sx5zlQZt9M7otd+ujjW7wRt447ThOkF7q0AqwOju/d3ghmVcc413
 GZnfXJRsIJ7zFhedZH47APsYNfINogn/6CmqHV3jcoFceuJt0lTiYrGmWN7iWGd7A0Er
 bGI6PfjMKepqaTfzydaDvRhVPphLrkycKHaolzxzrQeyP0y1DLXVC9BLkStFJo5E4OMB
 XDDw==
X-Gm-Message-State: AOAM532wRTxVw/qne/Tfs2qpN/1LhD/x5IjQNCr1Dfg8h4Vsi567I+c9
 AeyACtrfhCxFfrQRJoDw9KRpW3f4gHq8eB66dUBdow==
X-Google-Smtp-Source: ABdhPJxpPyeyOypN8L0HrSQ1PDXCu5RrfJCgme17EMOhUZxl/01wPPNlzH3JoT72yuCqyEVgmoxSmlHIyS1E1Yth0Xw=
X-Received: by 2002:aca:1706:: with SMTP id j6mr447669oii.146.1593781876038;
 Fri, 03 Jul 2020 06:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-5-f4bug@amsat.org>
In-Reply-To: <20200630133912.9428-5-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 14:11:05 +0100
Message-ID: <CAFEAcA_Nv-N0qrgPRYhXVPHEAD1My4oCaieK3i+YPLA827jr=w@mail.gmail.com>
Subject: Re: [PATCH v7 04/17] hw/sd/sdcard: Use the HWBLOCK_SIZE definition
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 at 14:39, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Replace the following different uses of the same value by
> the same HWBLOCK_SIZE definition:
>   - 512 (magic value)
>   - 0x200 (magic value)
>   - 1 << HWBLOCK_SHIFT
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

