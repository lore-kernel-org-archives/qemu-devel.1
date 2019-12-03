Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59565C432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 12:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2908320684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 12:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="chSW3jeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2908320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic7c0-0002DX-CK
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 07:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ic7PJ-0004No-72
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 07:35:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ic7PC-0001Bl-VK
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 07:35:52 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37745)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ic7O8-0005OS-BU
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 07:35:47 -0500
Received: by mail-ot1-x341.google.com with SMTP id k14so2741848otn.4
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 04:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y4Ers7w9eC9tFu3//E3iYq14QUmK3g6bRYSZTOSxXBQ=;
 b=chSW3jeQ3yDjE9qOy+ox4lKN+4lJ9OBSxncisgX8xoaJ4nitsHCBY4f/llanEK2GOu
 eCHPJqeSvqXBE7oPaimtA+3V1CjIP5nL/1931W6gb34Hkw80zDE8TAyqQDGlvvFtszNj
 rVU3CLlVmK0XZRbccA/UmQElzTZk57ADj3urQ5g98oOE9uL08XymdWNW4Zzz8BK/kfJn
 2ETC9R7Wo+Obb+GQMBOjQnzsux8a/gq33BDL8aY2HJ8XiSdmYKEdts/3djXTOTTTVHUF
 Fqt3Xqw9jLZZDIMjf9+T2GCvYTv809ySPvJDNx1rq91CzuoeeeqBiE0SXojf2j8aHPGL
 Lf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y4Ers7w9eC9tFu3//E3iYq14QUmK3g6bRYSZTOSxXBQ=;
 b=N7aQjfL8dLil9R5vrl7EuiCDN5FMuF7wb65vgY0JHxxo5xyhL7PXYjEAmpDx9Fk06C
 +KxFg9818CC42w3gPjlMutsv0F82RKsYLeHCnIGOXpS1jO1CmHl7Jp/j37D2er0BOiLy
 gG39dKiIJxJvFMS+CrXPhApg947h4V4FbQLMJ53hIdIQ/lTOWY5ixP6Q5XTdrPwr33IB
 QwK9O5YdT/C6bzIAJV2wYQu/woyEJbHL7kh7kdPfAq4kpYBEsZqEz3vOk4WKmNXpMFnc
 JgDFE6rXP3Yvjgb/eQ8Q3jMENp9A2iqpljyTL+8TZzPOSkIAH9z+IRoyb7zj4AIy6qs0
 ygbA==
X-Gm-Message-State: APjAAAX0LWleyhREDCjzm3mt9zxLdyZXqR4185ZdYpcA28JYup20k57V
 qBMxBo9os6WdcjJSy4/OQgRwWKor0yyKM83MVWRgWw==
X-Google-Smtp-Source: APXvYqzd9j7AC2GdibUE89z/Zur7rg78vf97ol/Mb09pve+U6TZHT/0su65mecqSP48q/8PkdxOuUqNOh30zMYAKKBs=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr2932410otk.91.1575376481627; 
 Tue, 03 Dec 2019 04:34:41 -0800 (PST)
MIME-Version: 1.0
References: <20191203122753.19792-1-zhengxiang9@huawei.com>
 <20191203122753.19792-2-zhengxiang9@huawei.com>
In-Reply-To: <20191203122753.19792-2-zhengxiang9@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Dec 2019 12:34:30 +0000
Message-ID: <CAFEAcA_TbC2haopmmbLChuE1bxA2KV74fximNu5kQ1pQB9VmYA@mail.gmail.com>
Subject: Re: [PATCH 1/5] tests: fw_cfg: Rename pc_fw_cfg_* to fw_cfg_*
To: Xiang Zheng <zhengxiang9@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 wanghaibin.wang@huawei.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Dec 2019 at 12:29, Xiang Zheng <zhengxiang9@huawei.com> wrote:
>
> Rename pc_fw_cfg_* to fw_cfg_* to make them common for other
> architectures so that we can run fw_cfg tests on aarch64.
>
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>

> -static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)
> +static inline QFWCFG *fw_cfg_init(QTestState *qts)
>  {
> -    return io_fw_cfg_init(qts, 0x510);
> +    const char *arch = qtest_get_arch();
> +
> +    if (!strcmp(arch, "aarch64")) {
> +        return mm_fw_cfg_init(qts, 0x09020000);
> +    } else {
> +        return io_fw_cfg_init(qts, 0x510);
> +    }

Presence and address of the fw_cfg device depends
on the machine type, not the architecture, so is
it possible to write this so that it varies by
machine type, rather than by guest arch ?
There should also presumably be a fallback path
for "fw_cfg not present here", I suppose.

thanks
-- PMM

