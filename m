Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9406EC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 04:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8BD24697
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 04:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAF9HTy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8BD24697
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8cVO-0001qC-E7
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 23:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j8cUk-0001OX-A6
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 23:15:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j8cUj-0000XH-1l
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 23:15:53 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46360)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j8cUi-0000Wz-QP
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 23:15:52 -0500
Received: by mail-pl1-x643.google.com with SMTP id y8so3650216pll.13
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2020 20:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2r9/94Bl/0g5dzH+z7Ky/TfN2p06TubfXG++3zuyI8c=;
 b=YAF9HTy/7wehMTw2iDjCmqiUZBsJoAkLdehlpHE/34P6q/IWbniRc+2ojVOFuXN8TN
 UdNhtYQXMU4ionpJqfl71/rc3fOhxYg2OpObUQh4RznKbBoym2S8h5KY5xAaEAHKynyt
 uc5/SpRMirF1OO7UxAmZdc14iaiUyeG8giQF8YRSz7ZVTT8McSzAUL/Ucd1ibaCe+SOs
 ZUOH5LhjavPkr4oqMSzbi4zIU/fu3J0E5NbxBbVlNtOkTdFfOwUV99VxA+iQffgmJj/d
 +wSNidTCJ5HXVRqOt1F3ASw6eIsstHiv6ytsS4TlF4/BlmrDW4rH73CIYRp+Y7945bp1
 aO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2r9/94Bl/0g5dzH+z7Ky/TfN2p06TubfXG++3zuyI8c=;
 b=EmQ4676E0UtBPP8DlR3pCO1r6VP8dbRshbOAMLWvEf5x2iJaH4cSWIGfbawGwosrDs
 yoa4kxykJQu0oQ5BWcRVczUD1OBaryQo16bmvyQ+LAbdOHFsLVA6kryX7yl65krixaQE
 i1BlVh9jXn2HYbq7vl5/uB/0XjyVtc7b3Y3yQYRmrigxQBAAdyRPYi8CdK2UCQ6GvfB6
 f9bg7FXrXRgMti0T/zfIqF2U9sggC5QQIHT7qwDnxy2jL4c5AyzBo/cTXD0xG9OMaFrL
 agPiStn4/MOsF7EUOmA9bMD3d9aXSJhHpMAlP6RG+qP7zltod8oMmhXn47Qeq1nFLaad
 c4sw==
X-Gm-Message-State: APjAAAVh2/u0gyWjCkpAN8E+8wgxi/fQTmAj3hjpGkt5UGRAxMIYIM7+
 DRkNRVZx9RND9jogJODzJoUq4w==
X-Google-Smtp-Source: APXvYqzKH53n6FQIFUgwyuOVJY8QwZEvDMMBt9oLPhymsUuXi1+kUlDV9XjOkPxtNxr7mXTAo7xv7g==
X-Received: by 2002:a17:90b:11cd:: with SMTP id
 gv13mr19129892pjb.94.1583122551635; 
 Sun, 01 Mar 2020 20:15:51 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 q8sm18415370pfs.161.2020.03.01.20.15.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Mar 2020 20:15:50 -0800 (PST)
Subject: Re: [PATCH v2] i386: Fix GCC warning with snprintf when HAX is enabled
To: Julio Faracco <jcfaracco@gmail.com>, qemu-devel@nongnu.org
References: <20200301191708.18035-1-jcfaracco@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6807c84f-8f17-6f02-ac79-4da42d8bcba0@linaro.org>
Date: Sun, 1 Mar 2020 20:15:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200301191708.18035-1-jcfaracco@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/1/20 11:17 AM, Julio Faracco wrote:
> -    snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
> +    assert(vm_id < 0);
> +
> +    if (snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d",
> +                 vm_id) < 0)
> +        return NULL;
> +

No, you don't need the IF around the snprinf.


r~

