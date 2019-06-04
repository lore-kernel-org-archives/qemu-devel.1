Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B67C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 06:53:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DABF24DB4
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 06:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DABF24DB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46896 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY3Jw-0006xt-Mo
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 02:53:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY3J2-0006aq-3A
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 02:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY3J0-0001KB-Ms
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 02:52:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hY3Iw-00016G-Sz
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 02:52:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id u16so8192730wmc.5
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 23:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=7HyrfWNzOZWqQd/JNP17mo4lQI1otYlyqUO2aPnONbk=;
	b=HO5UBqO0Fy1rK4bBuLfBGk7dzb/qzAGF/iYILOGuVlLH3stqqDJWAB0MmqbUckNWMu
	HOUh+CNa3wWCPbQtYrGix6Ciy3/H62RaUSzN8CfLgReXEizEZ5d9j/DzwdyTDGjN6kvm
	ONewBbnuLizATRLVs82v4EKn8MlTPmvc8i/emdlkXBMvME6poFK4hnUEeiPVjfEHKIrt
	2EwucKSESon7qrvtZTi+OVSsuBfZttme5GaPltFOeQRRCmrXzPAlMWTFHpdWNedUeiJq
	kg4thO9TZIef6qLWKeXH6R/ragwXP+fB1gA5Ly26g+efu9+P2afihXHhR9Df4R1ylXLR
	S9vA==
X-Gm-Message-State: APjAAAVkFLWGuh0HwYY9CA6bWRKWiyqZalM8KiVmk+D1lMCrXcVc6ZhN
	5/ha1/MKYiXD/9nq6tATfSWhAQ==
X-Google-Smtp-Source: APXvYqxvCDxj5abiAoMvc1ma3ADjGZln8AdJ7FO7nvcBwAe9dFFALK7Gj4ZIUDF3XSmYhyFqYhiwAw==
X-Received: by 2002:a1c:a848:: with SMTP id r69mr15270410wme.12.1559631137145; 
	Mon, 03 Jun 2019 23:52:17 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	197sm16541080wma.36.2019.06.03.23.52.15
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 23:52:16 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190603150120.29255-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <818134d1-ca69-c6fe-acd5-6548c61184dc@redhat.com>
Date: Tue, 4 Jun 2019 08:52:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603150120.29255-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [RFC PATCH] cputlb: use uint64_t for interim
 values for unaligned load
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: 1830872@bugs.launchpad.net, Richard Henderson <rth@twiddle.net>,
	qemu-arm@nongnu.org, randrianasulu@gmail.com,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/19 5:01 PM, Alex Bennée wrote:
> When running on 32 bit TCG backends a wide unaligned load ends up
> truncating data before returning to the guest. We specifically have
> the return type as uint64_t to avoid any premature truncation so we
> should use the same for the interim types.
> 
> Hopefully fixes #1830872

Maybe clearer as:

Fixes: https://bugs.launchpad.net/qemu/+bug/1830872
Fixes: eed5664238e

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  accel/tcg/cputlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index cdcc3771020..b796ab1cbea 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1303,7 +1303,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>          && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
>                      >= TARGET_PAGE_SIZE)) {
>          target_ulong addr1, addr2;
> -        tcg_target_ulong r1, r2;
> +        uint64_t r1, r2;
>          unsigned shift;
>      do_unaligned_access:
>          addr1 = addr & ~(size - 1);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

