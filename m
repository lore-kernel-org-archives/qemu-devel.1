Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20717C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1ECE20645
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1ECE20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54385 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIw7b-0002eF-4O
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 10:10:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIw2m-0007E0-NS
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIvpO-0004gr-6M
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:51:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIvpM-0004bm-6N
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:51:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so176732wml.1
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 06:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=UJKWD47nqM2wGkGsmDBqG8dfOJ5VfNgoqcVJ9KPcEEY=;
	b=Q65meZHtMbTtAGDlLBjqxsBKURntGF0wk8zcRB1ytUHB81saGy5G3rbnNjw36FMOq1
	zIvXOZBLNuZ7O38wu5sonNnuW2ndQdPY+E4qoyZXMHTt9yqZy99enSG7QVQqauSzVaKa
	n0JCBYfprU3coKaoIeviw9QlEZ3gBUzo61Q6Ya9k1h/CqW7WLsBumO/ZgejfbdTfHC1I
	T19mUwvSZf5XGB9htDVPX2IlhPnOPJB+G+dj1q+lkOESQEyv2PwLSnO9gDe5vllaZmyN
	ReKuB434VFP44tLqwyTeqh4iYa+99fXSJSZZzcnzclNYA8Yt+u++PbPQluiQ3R1rljm7
	yA2w==
X-Gm-Message-State: APjAAAUxd9w/ie1RsdLsA9lpELsKn2d5ljxBuKkjsaMqQQ4n72QlChd9
	YpkaYz6LinVVkcwg/rS31p7mKw==
X-Google-Smtp-Source: APXvYqw1SAPmb5sLQDKx598xHowsFhZr0TyOl3S5YUJHSLrdeRiGhzbW74cC4GxjOQ2B8/788vSXlw==
X-Received: by 2002:a1c:a9cb:: with SMTP id s194mr2242031wme.62.1556027473842; 
	Tue, 23 Apr 2019 06:51:13 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163])
	by smtp.gmail.com with ESMTPSA id d6sm15001292wrp.9.2019.04.23.06.51.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 06:51:13 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1556018982-3715-7-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <eee78a60-109c-6604-7f12-046ccc34d25b@redhat.com>
Date: Tue, 23 Apr 2019 15:51:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556018982-3715-7-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 6/8] target/mips: Clean up lmi_helper.c
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
Cc: arikalo@wavecomp.com, aurelien@aurel32.net, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423135112.Ut8SQwk8MUG9W2ZZysdXVrv8YZ8Y2Mr-30QAp6Da9OA@z>

On 4/23/19 1:29 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Remove several minor checkpatch warnings and errors.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/lmi_helper.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/target/mips/lmi_helper.c b/target/mips/lmi_helper.c
> index fb1245b..6c645cf 100644
> --- a/target/mips/lmi_helper.c
> +++ b/target/mips/lmi_helper.c
> @@ -21,9 +21,11 @@
>  #include "cpu.h"
>  #include "exec/helper-proto.h"
>  
> -/* If the byte ordering doesn't matter, i.e. all columns are treated
> -   identically, then this union can be used directly.  If byte ordering
> -   does matter, we generally ignore dumping to memory.  */
> +/*
> + * If the byte ordering doesn't matter, i.e. all columns are treated
> + * identically, then this union can be used directly.  If byte ordering
> + * does matter, we generally ignore dumping to memory.
> + */
>  typedef union {
>      uint8_t  ub[8];
>      int8_t   sb[8];
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

