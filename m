Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51900C4CEC9
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 18:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A1020692
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 18:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ycsBjFif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A1020692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9Ccp-0002I3-5I
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 14:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i9Caa-0000vp-Tg
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 14:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i9CaY-0005sO-H2
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 14:16:04 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:35573)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i9CaY-0005rf-3s
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 14:16:02 -0400
Received: by mail-ed1-x541.google.com with SMTP id f24so12087245edv.2
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 11:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kka5U1eKjulTqQnAwTA54p3H1OYw4mv0KDOijnCkr+A=;
 b=ycsBjFifs03M9M0wNRVpok+bEVkIkLXh33BuWeJKvYPIoIp4eOr6App3Z5Yx1m7+Xv
 3K/l3rcxLxA0mjk8+c5CoFQTJ48BOb/3+McmvfdRhhC2PdWURR92CvPF3IvZBtLe7RCm
 CLDYbiJQUEleJO/z1Umz08DMSW5FWI7/5lX4Ihs3P5vLIoifqrhmCo8QdW4AsHaEu3Kv
 F5M8bXdcV6DbNP7RuvEhCwOJJGmR7A6EYm5R9k6y25HEBl/925fkA4Oe9OoT0PI0szFk
 34j2TpWNswhe+HiTkXQtDwdBPjZoevR98y6l1A4DRzE3jOThstl8XAfFlrkXbreivNzI
 /7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kka5U1eKjulTqQnAwTA54p3H1OYw4mv0KDOijnCkr+A=;
 b=cvh0QIkEc0YYm8Rw6L5YQa9RArQ2phA+u9rflR2+LcIT80zYNMsG+U/TnNtJdd4IAG
 8R+0qvIg0Z3s5FwVe+r+soOWNxa+kjiZND+84zFGWyktADugTAqm5gvIGpRUiaGYUMHr
 +pIJvF6lwuW8PW7z8axULsHSz8DLLOGlwijuPGXBg3MASGkhKLLYq8kEzqhf6luanuC9
 sluSTIGtWZve/1e+m6w3JsMGUKUJC4pUF1Wqxuq4MdjsjMhC91uONubG56zUY8s8k9Ni
 iKfirZk9XYPGgmKt/youo9c0rl/Qg4xwWbV7GofX5Bs0ZBG8eYJiCzKCbcPZrR3n+h3D
 kuUQ==
X-Gm-Message-State: APjAAAUXnVNQa2Dfy4n6ueDgev5Uq1xzkIE8qOSW1Co0HB1zM2qgtHsc
 tdIT0j3PgoK3LzxIvbnBtBHpWg==
X-Google-Smtp-Source: APXvYqzHsZzLQzI+PC3l8XrZGAZaH4l3P/bLE8YX/2EquUG1hntyEv/Om2j/qGuoMyaLJEXjAvgvVg==
X-Received: by 2002:a05:6402:1426:: with SMTP id
 c6mr38016603edx.53.1568484960424; 
 Sat, 14 Sep 2019 11:16:00 -0700 (PDT)
Received: from [192.168.44.107] ([185.81.138.21])
 by smtp.gmail.com with ESMTPSA id c22sm2271091edc.9.2019.09.14.11.15.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 14 Sep 2019 11:15:59 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org
References: <20190910193408.28917-1-alex.bennee@linaro.org>
 <20190910193408.28917-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <01c627ec-9382-d4cf-4a61-b4267c3267fb@linaro.org>
Date: Sat, 14 Sep 2019 14:15:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910193408.28917-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v1 2/4] elf: move elf.h to elf/elf.h and
 split out types
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
Cc: Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anthony Green <green@moxielogic.com>,
 Palmer Dabbelt <palmer@sifive.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Jia Liu <proljc@gmail.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Helge Deller <deller@gmx.de>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Fabien Chouteau <chouteau@adacore.com>,
 "open list:S390-ccw boot" <qemu-s390x@nongnu.org>, qemu-arm@nongnu.org,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, "open list:PReP" <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/19 3:34 PM, Alex Bennée wrote:
> Most of the users of elf.h just want the standard Elf definitions. The
> couple that want more than that want an expansion based on ELF_CLASS
> which can be used for size agnostic code. The later is moved into
> elf/elf-types.inc.h to make it clearer what it is for. While doing
> that I also removed the whitespace damage.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---

This patch is hard to follow because it moves and splits at the same time.

With this patch split into two,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

