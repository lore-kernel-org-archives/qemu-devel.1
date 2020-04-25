Return-Path: <SRS0=p7gi=6J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65E1C55185
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 08:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BD2C2071E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 08:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD2C2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSGMV-0001qr-KP
	for qemu-devel@archiver.kernel.org; Sat, 25 Apr 2020 04:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jSGLq-0001DN-Ln
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 04:39:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jSGLq-0003ay-3K
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 04:39:54 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:50175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jSGLp-0003Gp-Ax
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 04:39:53 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MmUDf-1ijonG2aCv-00iTOH; Sat, 25 Apr 2020 10:39:43 +0200
To: Helge Deller <deller@gmx.de>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org
References: <20200424210422.GB26282@ls3530.fritz.box>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] linux-user: Drop unnecessary check in signalfd4 syscall
Message-ID: <c9f3644e-21c8-600b-4bf6-d55e6c52153f@vivier.eu>
Date: Sat, 25 Apr 2020 10:39:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200424210422.GB26282@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:En75GcvXVsK9MXxkhHFsNyv8sBe1RQea1qaq/ROv0Oye935B3SA
 Ivdra6FWfJ9x18hWvSwqJbli90NxDEREBopvPIPdxdCYOnTAfdUc0C5oa8uczpjIDE+vetW
 OWEJThXo3UTuMrkbI9GGBqylKtA5bKqIAb1zq2a/y2yZ0r9WJ31P5405J/9xhX8VHwTyvMF
 j/AXwLVPl7zKApqiV2VHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k4KPPU8R38E=:3Sd16Awfc8VRxFs7Kcgx5J
 pCZaM8wNwf4zWCIBhdLWmJNw8Gy0gOwyRwEkkzrneo8MHcf8fxrNMJWFLHJtcCyfdCqhojxMV
 aOiWK8Dwq6pLgda2EsyhqWC4dO5nPpkicYg+IgI9couwcEHDV9hMLix9TDFAcZ5P9Iri84/Vj
 T+62iPVMwPUpR0G8/KOhig8aIMidQXee0PzAoPkPDAouO7CRu0TUEScC1NWlzst4Ud2d9A2sA
 20pnNgaj9aVvvA02SuLi+AhQEhmtk59oPaNjzlzHacJnF1RKHVv4+sjTzaED2kZMV3QCPwT7o
 5k3uxaFybA+v0in+2mHe9JU38wKDRNBUm/xsnGAl8S9Sfx7eZ72X9R6X3Yc0ZcROrvwFeArXG
 cHSP9SnKFCZ2J1xiFu/HFuKaVOy7Z2fwEimpYszg0bfJAW8BRLExKimW4DXFCrzPf4EGNrLUd
 6kRgV0CEA1D6tZ9aGEQg15SSY47qc/W5Zkbqhon3BtcTwsQAomUtyIARCFG7lp9Tg1v5Qjnej
 prhe/I21HCtp6chEHcwqWA18ixr7n8ynBRUElCOr4WYiy5L8GHk+NpwhAvUrCxsiy/652qMU4
 hJyiotFjStIA8zPIXLbTaWrbW7IKM6v4wO/9CHTke0thaXAL6p7WtS8DL0XRFTAgvz865l3tF
 ms9IeE1sC8zESq6o+QQhxG/H0kOjxX5DfA84/FpdnS612ZdKQUuNt919KX/d25rmHsWzb57E7
 rmt8Y1+zUS9Kqe3ogFfmX7ROzf7gDyBn7xEJNwwvf7LX0tZdoXyC1r7mEJF8jK7rHHJ0b4K5H
 d6Os/Ce4GIlodSy3RsZ+AnWRRyLVA4QipXraMLDNSDoYzMjcSkD4X77ajzmQZ+qv6Jkd6BE
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/25 04:14:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 217.72.192.74
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

Le 24/04/2020 à 23:04, Helge Deller a écrit :
> The signalfd4() syscall takes optional O_NONBLOCK and O_CLOEXEC fcntl
> flags.  If the user gave any other invalid flags, the host syscall will
> return correct error codes, so simply drop the extra check here.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 05f03919ff..ebf0d38321 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7176,9 +7176,6 @@ static abi_long do_signalfd4(int fd, abi_long mask, int flags)
>      sigset_t host_mask;
>      abi_long ret;
> 
> -    if (flags & ~(TARGET_O_NONBLOCK | TARGET_O_CLOEXEC)) {
> -        return -TARGET_EINVAL;
> -    }
>      if (!lock_user_struct(VERIFY_READ, target_mask, mask, 1)) {
>          return -TARGET_EFAULT;
>      }
> 

Perhaps we want to trigger the TARGET_EINVAL before the TARGET_EFAULT if
we have both cases?

But I've checked the kernel, and the kernel does a copy_from_user()
before checking the flags, but it returns EINVAL rather than EFAULT.

We can remove the flags checking but we should also change TARGET_EFAULT
by TARGET_EINVAL.

Thanks,
Laurent

