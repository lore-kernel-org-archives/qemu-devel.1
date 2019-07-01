Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E15C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC5AE20881
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5AE20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hht4X-00054l-RQ
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 05:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55122)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hht3U-0003sw-RO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hht3T-0006JF-U3
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:57:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36184)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hht3T-0006IJ-OB
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:56:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so13099592wrs.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 02:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CMw0EV/H5XSWPpqiiBewUydHZY6Goao8skQ8vcfi5wg=;
 b=GM3YVMg0snb6vXctLUF3avIez0PatDRCqfCnZ+ay/a+GmcWSmIfUbme9bFpXVe0/2W
 fnHeu6nLurBjZFHWkqWxCjfPhPobkIyewjyUfYWnTooDiUJ/Pjbd6Ct0dmpDbWNj3IrR
 PGRginygT6c/+0G00wLnfI0KOUvkbB73KaqhdS+wt78kb8Bn5t5zya8wIoRRQSV/OQ3o
 2o0wP2ZwjZYfo1RbL8TqRy2ISYH85Q/Ic3suZL5BwtgY7MoC4tCNlntn0zNurUYrsZse
 sjPG2r330manbAoCa9LDpiZ+pIxxpJH911zG+vmnvg5qbydyroVL4/MjLKlemP1bLbv0
 6NYA==
X-Gm-Message-State: APjAAAWuw6faGvy5JO/lBkojvuRHM4DE02munljPUjVM7gJ/Ggg9y0/i
 7sTWx7qpqQrNWOnNCXhY6xmd2mgNV+0=
X-Google-Smtp-Source: APXvYqwt6aAXmQQkff7grmcScgz8aOx9BLOqw6vC7Z0GhFiTpAyKhp9/QimtpioJ8hPF26pg7YtIkQ==
X-Received: by 2002:a5d:5450:: with SMTP id w16mr9045608wrv.128.1561975018642; 
 Mon, 01 Jul 2019 02:56:58 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id h6sm9659913wre.82.2019.07.01.02.56.57
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 02:56:58 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20190621064615.20099-1-mst@redhat.com>
 <20190621064615.20099-2-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8583cd81-a83e-8289-723e-de2434c0d717@redhat.com>
Date: Mon, 1 Jul 2019 11:56:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190621064615.20099-2-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 1/3] pcie: don't skip multi-mask events
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

On 6/21/19 8:46 AM, Michael S. Tsirkin wrote:
> If we are trying to set multiple bits at once, testing that just one of
> them is already set gives a false positive. As a result we won't
> interrupt guest if e.g. presence detection change and attention button
> press are both set. This happens with multi-function device removal.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/pci/pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 88c30ff74c..b22527000d 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -383,7 +383,7 @@ static void pcie_cap_slot_event(PCIDevice *dev, PCIExpressHotPlugEvent event)
>  {
>      /* Minor optimization: if nothing changed - no event is needed. */
>      if (pci_word_test_and_set_mask(dev->config + dev->exp.exp_cap +
> -                                   PCI_EXP_SLTSTA, event)) {
> +                                   PCI_EXP_SLTSTA, event) == event) {
>          return;
>      }
>      hotplug_event_notify(dev);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

