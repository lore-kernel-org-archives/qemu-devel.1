Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DA2C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A790206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A790206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIakF-0006eV-Gi
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 11:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIahF-0004fT-Cx
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIahD-0006T9-MN
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:49:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIahC-0006S2-GS
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:49:43 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 20BCA2D6A04
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 15:49:40 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id z17so2943659wru.13
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 08:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vSAoGtiVspXsMwlhtdZDVYQVavkRD1NHLfXQzzg+rds=;
 b=oKrFIiKF0VfDzsfpDXxxtxf2QUnstDeHeVPu3yIMwkvfLekyoTLPKAlkErkIawruo1
 XwmtCAisb6fY4PJRBcp0/sIOU2Io9+1WQ+wwQOVrwTLbvPF9qHU526rKTnhwK7Jy56LO
 RoPgiamgYZsy8yHrLuk2rN+IPyuW3d1PJaP94hezZFCB196SBL0+rbZU1JeH8vPihraY
 kBuube0YO8/WwUeevvxP+fhlTiaPSybcZvbe8lfPoJDvEwpDv57N+yz41ghLLyZuo5Tu
 Ilyvi/+TgUUCpC4YqjaRLLbrwH0AD2l8j+Ehd3IJb7dehv0WuomTgS4ke3sPsRXCpV4n
 JymA==
X-Gm-Message-State: APjAAAU5qzGfwmcrQrKhBMRfrUmB3gI6x0YOlLT2Eyb0r9OrhMJ6AliM
 ouSyH3bWDS/gDqjYElJ1Q2RbyvrPH61YT/HJU7s9sLSZeuweqtpjzmLR2vWF3GCM5+4onRHkBRT
 1KheIclxtSbFtqoQ=
X-Received: by 2002:a1c:a551:: with SMTP id o78mr7800740wme.4.1570722578902;
 Thu, 10 Oct 2019 08:49:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxQeIoMk08FzY5gfSCgjq3m/Jv3ecVKkPHPx5JwDNxQjk/b27l1p2Ymkfh8Mt/OsF9/mRTIqQ==
X-Received: by 2002:a1c:a551:: with SMTP id o78mr7800721wme.4.1570722578697;
 Thu, 10 Oct 2019 08:49:38 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id n17sm6345944wrp.37.2019.10.10.08.49.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2019 08:49:38 -0700 (PDT)
Subject: Re: [PATCH v8 06/15] hw/i386/pc: remove commented out code from
 x86_load_linux()
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191010143125.67246-1-slp@redhat.com>
 <20191010143125.67246-7-slp@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f6e237dc-e2bb-c99d-69ca-dcd47fb2ff2d@redhat.com>
Date: Thu, 10 Oct 2019 17:49:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191010143125.67246-7-slp@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, mst@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/19 4:31 PM, Sergio Lopez wrote:
> Follow checkpatch.pl recommendation and remove commented out code from
> x86_load_linux().

Traces commented out in bc4edd79ee5, almost 12 years ago, and nobody=20
complained, so no need to convert this to trace events :)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>   hw/i386/pc.c | 13 -------------
>   1 file changed, 13 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 90e2d68096..f19d4ac0bd 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1061,9 +1061,6 @@ static void x86_load_linux(PCMachineState *pcms,
>       }
>  =20
>       /* kernel protocol version */
> -#if 0
> -    fprintf(stderr, "header magic: %#x\n", ldl_p(header+0x202));
> -#endif
>       if (ldl_p(header + 0x202) =3D=3D 0x53726448) {
>           protocol =3D lduw_p(header + 0x206);
>       } else {
> @@ -1155,16 +1152,6 @@ static void x86_load_linux(PCMachineState *pcms,
>           prot_addr    =3D 0x100000;
>       }
>  =20
> -#if 0
> -    fprintf(stderr,
> -            "qemu: real_addr     =3D 0x" TARGET_FMT_plx "\n"
> -            "qemu: cmdline_addr  =3D 0x" TARGET_FMT_plx "\n"
> -            "qemu: prot_addr     =3D 0x" TARGET_FMT_plx "\n",
> -            real_addr,
> -            cmdline_addr,
> -            prot_addr);
> -#endif
> -
>       /* highest address for loading the initrd */
>       if (protocol >=3D 0x20c &&
>           lduw_p(header + 0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
>=20

