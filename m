Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009CAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAAA6217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAA6217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuGvH-0001Al-68
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 09:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuGpb-0002DB-Kh
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:18:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuGpY-0005Hl-EU
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:18:07 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:54505)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuGpY-0005Gf-5C
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:18:04 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MWAWq-1j5lJK0ZWk-00Xb59; Wed, 22 Jan 2020 15:17:44 +0100
Subject: Re: [PATCH v8 13/13] linux-user: Add support for TYPE_LONG and
 TYPE_ULONG in do_ioctl()
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>, qemu-devel@nongnu.org
References: <1579117007-7565-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1579117007-7565-14-git-send-email-Filip.Bozuta@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4bf31999-2fa0-15cf-8a3b-38da5f34bb19@vivier.eu>
Date: Wed, 22 Jan 2020 15:17:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1579117007-7565-14-git-send-email-Filip.Bozuta@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NpULaVKQQczZqxTL7LMy7iGbYdiHu8tZ5gaBvVzMf1ccL2Wr/LP
 Xnf1D/DoTxaWOD9fwDs1mDDxYuOQo0qztpAXz3Ck9vdtkoNMdpzQN8u3o2pqprx71g5pDvc
 T6SdD5WQZaWkuEvDBQQxKVHXyREDSCvnl45bP/jgpWJFA6W1cjN6RnY89mOKgpQSeLc2vVy
 3C55kVooTKF8ex4JYIaMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wtqqGrBUbwQ=:Ixfpl+EMQUGt6KIni+jO52
 jmXKQwOgY/Drz9k2zHO+Kvz5oliVuAto9aGf6iuUExVbrJBAGwnNS1zuPqEUQ8DGGWfi1pcWD
 tOvLZtWH9QkoG7xQwdQwIxS1gRGe0p4+1ny51IHzVDX+raQP1j9wYkX9BdntXjm/6YfzxiMdB
 +H92sUnXm4c6yOaOpeUcH1uBouteaEVVmb06h9U7dPqLd3GEXf+TXomUmnIf+qGnbtN66f7tD
 dknFiscFOMTTnGDTOF4xMZq/dMWAk0vMaumrxGNtA+ZVoeSxFkLaUlZ9xnJIfyYbVXA/49bvD
 AiUiANAHd9AV3zTfmJVhwyIk0sTOja06A0jsbYCl/3TPZrv5RgHqm23COQORmCz2BL9jrErK+
 o9r5g7u9qqAbNBjTQbZIHgpRtqpoK55+vKH4NQTVF0cWEwMwazvGGtAUgz2xv8UBsxz42nYXO
 z20HEG9K8wZvhYjtR5tsNdcEBcYbtx4KF4oqnbcIsa19zTg2H2rPOiN1GcYYjc99YyT56OghH
 su0wCd6IH6yfRLgtjcCntrX9B4S87WMo556D/2uWLfafx3cWMWiuf3xmUjkR0usjMe9hNxGaR
 wiLVUTS3oYLfOU58/XPyhFskS6dd9/a0X42yzcoCtBS6uLkMkhMzWJZtaJasqjeNkwssu1gDs
 cWl9Z+YZE//G4wV2JkGZ7Bo43tKhSBpTkMCvawBQnCvxjFK/Ys6E/rq7l0YWblEcEYczxMKP7
 fvR88etvbLM5eLEIPh48i05sY7QD26ScM7Fl5bIBKifBJf8XYcMqV4altUlu5q6Tu8l7gGHqQ
 UYQwsU/t+sLCQpfb9bYE3X7azX0qDTbOvB1PbAURb2T5wliOxc=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, arnd@arndb.de,
 richard.henderson@linaro.org, jcmvbkbc@gmail.com, amarkovic@wavecomp.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 15/01/2020 à 20:36, Filip Bozuta a écrit :
> Function "do_ioctl()" located in file "syscall.c" was missing
> an option for TYPE_LONG and TYPE_ULONG. This caused some ioctls
> to not be recognised because they had the third argument that was
> of type 'long' or 'unsigned long'.
> 
> For example:
> 
> Since implemented ioctls RTC_IRQP_SET and RTC_EPOCH_SET
> are of type IOW(writing type) that have unsigned long as
> their third argument, they were not recognised in QEMU
> before the changes of this patch.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> ---
>  linux-user/syscall.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index a3993a2..2ba2c5c 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -5176,6 +5176,8 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
>          break;
>      case TYPE_PTRVOID:
>      case TYPE_INT:
> +    case TYPE_LONG:
> +    case TYPE_ULONG:
>          ret = get_errno(safe_ioctl(fd, ie->host_cmd, arg));
>          break;
>      case TYPE_PTR:
> 

Applied to my linux-user branch.

Thanks,
Laurent

