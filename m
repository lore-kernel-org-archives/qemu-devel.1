Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB663C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 21:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B466B20787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 21:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdMpr21j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B466B20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRMu1-00060r-Rs
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 17:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jRMtQ-0005ZS-35
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 17:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jRMtP-00037T-Ow
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 17:26:51 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:44532)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jRMtN-00034s-PQ; Wed, 22 Apr 2020 17:26:49 -0400
Received: by mail-io1-xd42.google.com with SMTP id z2so4096907iol.11;
 Wed, 22 Apr 2020 14:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A4dS2queDcDvYC7IXsJvQeC9fkc+O9hHFZS63p9xynU=;
 b=UdMpr21j5UpXNyLl89Wsn+F87L7PfI+bkPDO0qMy94+0q39MpvfJd6jh7d/9YkUbbw
 80bn8LkC3dJVcpHC+gH7pEcVbk389J6RLuNWHi/wzQKoDV2+U0aRXLZinqrfJ4RyGXdF
 hP496UN+/pg9mP3F0UIh7yocwKDST4DiBGG2mV3A0a3qfyK4ASPB+N0hJBjmuKC2qoBh
 EycgaoGEj9mnL/+ygGmFYiwljFuV3hfojCU+I6IUlTLDK5263U4KzafQFuyhK/U9UOiE
 cmWxLbqzpKgACBy6MBAyUlYc2xhqRTLzqw7O286CxWvTlAl0uqrUd5c5h8mIuOgoS3dM
 C7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A4dS2queDcDvYC7IXsJvQeC9fkc+O9hHFZS63p9xynU=;
 b=JwpIWS9Bfxx0erPqxSuwM3GLzAIskplO0hGgfCojN5OYJpHBKdraK2AgdYcy4QyV0R
 ugI+9NMRySEChGYUfTM6ihHoxIW0F1f0tab1aX5w74qxHrrcTga1NEX6teRjEJngIKrB
 lRFr08zCv1osW5v0MuAs8iKAZAu6RmGpYUS8dFqA1unPuYhp6eh0Zgtmqkka9/DcKVXz
 7yTFQx4PS45CjrQEbQAmHo3cbs78x9lJadSszgcs6e1P9HIy2y8jZ3HRcAlHCdNZxfn+
 g8wqW35D69GwfWV0WMa4R55jKIVrPv9yFZLetE7O+wGG3hbwV09KiwxA9JUq3yUO0TnU
 Nugw==
X-Gm-Message-State: AGi0Pub6AkFLO2obGVj6xhgr73TQYXn4PvVB96kxAF0UEsHDksDTGYJU
 0RaQPsNV6UCE58fN29uJBNXc82eeVkndWZLY6U8=
X-Google-Smtp-Source: APiQypIOOZxalW8sWv4dlBePb3wr2WrH1kOCA0ftQ2vBku7TOwvRY0kv0D+5jG7k8xl9CxRlDvzXYkHhyFfXj0N6Bps=
X-Received: by 2002:a5d:984b:: with SMTP id p11mr719486ios.175.1587590807676; 
 Wed, 22 Apr 2020 14:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200412020830.607-1-zhiwei_liu@c-sky.com>
 <f6dc4fa7-fed5-28a1-5922-68e9a0510de5@c-sky.com>
 <bf6b46c3-cc39-1b4a-4ae4-9de894721f04@linaro.org>
 <CAKmqyKMZ9x+PXOxnFqE5e-h+cCZjJThEBjJip_OCppjX71DSrg@mail.gmail.com>
 <e65178b8-32b0-b389-c58a-6883b9bc0989@linaro.org>
In-Reply-To: <e65178b8-32b0-b389-c58a-6883b9bc0989@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Apr 2020 14:18:17 -0700
Message-ID: <CAKmqyKMyynW3qwyGfHx3ifvu1045vg+tFu3r7ncekTfUDVP=wA@mail.gmail.com>
Subject: Re: [PATCH] linux-user/riscv: fix up struct target_ucontext definition
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Laurent Vivier <laurent@vivier.eu>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 22, 2020 at 12:20 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/22/20 11:05 AM, Alistair Francis wrote:
> > Just to clarify, this patch is still correct right?
>
> Yes.

That's what I thought. Thanks :)

Applied to the RISC-V tree for 5.1.

Alistair

>
>
> r~

