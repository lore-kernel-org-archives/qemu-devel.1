Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE84C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 07:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D6E20659
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 07:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7gODjYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D6E20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1m1f-0007aA-Ej
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 02:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1m0R-0006wo-VQ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:00:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1m0R-00076Y-0u
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:00:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21346
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1m0Q-00076K-Tz
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581490818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6MRxxhJz5ACe4KFlcaa+fP4wgS0TkQlKalaXQCvWfjU=;
 b=a7gODjYMZ601OTsvEGkriyqBMVPg3x5xpNG1hSYKT2reTTZO14lKf3sPjUJKKxAdTtyu9R
 Vy7IuS7fsN8nADz2rY8QVo2wtHqoOuTm1CbChJSZFPpmDUZ5/EVYtCeWrdW7k85CBjDlRe
 Xkcma2NjBWiZ+s3ZG/kYO/lBmNBLyaM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-aS_3CNPWMNmMPaaSF7NqhQ-1; Wed, 12 Feb 2020 02:00:15 -0500
Received: by mail-wr1-f69.google.com with SMTP id c6so416954wrm.18
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 23:00:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JBqVS9TdpckNkCj29pRaqkiTCWcb7HanfRdJZjSEvaA=;
 b=LjWJRS1fPLjwfk17EUKy6lm1vZQVg02MuRAdlA963rnstZTjtBux7+Q9Y3bHFpheLl
 Rls00odzCU/QnUsuBcrQ+o4Fd9W9RSDkjNNdDnbYF3ge3BX1qdo5ytLheZZrs56kWeok
 p+G3WAWkX3GjWl17FAePi4ksrzWoQma3/pGKTg3Hbqn3/DQHOUKW5IM+f8lHs8q3fGc8
 B0HkK9q/eDr6UulekIYSivxv4GV1b1HRh69s8mJbNAfB5BQAo8H0pX1cJSg8L/4asgfN
 JH0EXPDyy6ohp4MXxuhtcOKM78lvjqsTlpMQgyWDLloFg7a10YkS3BZbjsnljVk6EnJo
 rOmg==
X-Gm-Message-State: APjAAAUaRFbZRsBmN6R5GRbH1p7d/rEsbf86PsXyfygW88A0zUJbYzMz
 /bqKrL370lCyP7gUYglV8iWg5BPgcbFtxIjPqynSS8cZoEj67mc4398yjJDNUYkhKG49K6i3v6Q
 J2n/1p9ZKLzvzZRg=
X-Received: by 2002:adf:ec83:: with SMTP id z3mr12972527wrn.133.1581490814303; 
 Tue, 11 Feb 2020 23:00:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqzHIXGQYkxu0zWlgcQ9o1SAYADdfAKEKNe4sgdImf1skp2RdvfgiyNolpdE5IYNRxL0c56tiw==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr12972470wrn.133.1581490813873; 
 Tue, 11 Feb 2020 23:00:13 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id c74sm7410596wmd.26.2020.02.11.23.00.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 23:00:13 -0800 (PST)
Subject: Re: [PATCH 12/13] target/arm: Correct definition of PMCRDP
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Aaron Lindsay <aaron@os.amperecomputing.com>
References: <20200211173726.22541-1-peter.maydell@linaro.org>
 <20200211173726.22541-13-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c412f5b4-ce4f-8f7f-2ad2-24cc69a6dbc4@redhat.com>
Date: Wed, 12 Feb 2020 08:00:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211173726.22541-13-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: aS_3CNPWMNmMPaaSF7NqhQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 6:37 PM, Peter Maydell wrote:
> The PMCR_EL0.DP bit is bit 5, which is 0x20, not 0x10.  0x10 is 'X'.
> Correct our #define of PMCRDP and add the missing PMCRX.
>=20
> We do have the correct behaviour for handling the DP bit being
> set, so this fixes a guest-visible bug.
>=20

Fixes: 033614c47de
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index cb3c30f1725..c6758bfbeb5 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1017,7 +1017,8 @@ static const ARMCPRegInfo v6_cp_reginfo[] =3D {
>   #define PMCRN_MASK  0xf800
>   #define PMCRN_SHIFT 11
>   #define PMCRLC  0x40
> -#define PMCRDP  0x10
> +#define PMCRDP  0x20
> +#define PMCRX   0x10
>   #define PMCRD   0x8
>   #define PMCRC   0x4
>   #define PMCRP   0x2
>=20


