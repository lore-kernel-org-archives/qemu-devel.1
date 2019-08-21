Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E966C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475CB2089E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475CB2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Qa7-0002ar-4w
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 09:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0QZ6-0001PB-2x
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0QY1-0007ut-O0
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:21:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54846)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0QY1-0007uI-AG
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:21:09 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4B6234E4E6
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 13:21:08 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id z2so1227796wrt.6
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 06:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dq/RSImmOeTAB1lrwErB9l1eSPY7ym39ti8soKCl3og=;
 b=Z2yV1v49DscqIA+3+5BiR2sBi9nQu3sWWAAGbqT490PNTAB6PIVCBz0P6gFZBgwRHl
 //qdVV7l2741c7g6v18QV6H2G7rsOKDcVcbMIIZ1lGTkN42eyvQea5EjHdprxTcdRZ3a
 k7L5lASDeyOEXk8V1ycQpeZ34xCJpwdtXDd73yK5H2dIxxafqa2I3y85LgIakbgv9i0+
 cb0M2D9ryRv+ybbZEtPcZ58vtec7gbeIg9txbAFlhYFu2ZC9J/Z5aR2QHLWWXftc0FaX
 6rCIt5hxN+WXM71GUifj3cdhStYMmsCufT2bwid42KE2j7sgUdJCXIySks3ssiBfN7km
 2Omw==
X-Gm-Message-State: APjAAAU5Zgat2p1fBG562IeEab+lNxBBE848X0rDsW5EklEJ/TnZDEFq
 SjAdNK25dOACMDoV6SGT4w4UJWr8qk3zjmKAlc9mj68SnUMsUnVwdPwN9slWSR9Q7boposlPg/1
 hs/nT7H1guwz9tE4=
X-Received: by 2002:adf:e390:: with SMTP id e16mr31394300wrm.153.1566393667121; 
 Wed, 21 Aug 2019 06:21:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyTnYlUih7gPQBcxbw6oPhTJAxADrkkl2x9w9sn/7v97KBKx75QUuuFJMT8IicCkAw6LPmyzA==
X-Received: by 2002:adf:e390:: with SMTP id e16mr31394280wrm.153.1566393666877; 
 Wed, 21 Aug 2019 06:21:06 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id o16sm28831417wrp.23.2019.08.21.06.21.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 06:21:06 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-33-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b68125fa-8062-3087-1f2e-76ed331f797e@redhat.com>
Date: Wed, 21 Aug 2019 15:21:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190819213755.26175-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 32/68] target/arm: Convert SVC
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/19 11:37 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  target/arm/translate.c | 19 +++++++++++++------
>  target/arm/a32.decode  |  4 ++++
>  2 files changed, 17 insertions(+), 6 deletions(-)
>=20
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 6b7b3df685..b6d8b7be8c 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -9968,6 +9968,18 @@ static bool trans_BLX_i(DisasContext *s, arg_BLX=
_i *a)
>      return true;
>  }
> =20
> +/*
> + * Supervisor call
> + */
> +
> +static bool trans_SVC(DisasContext *s, arg_SVC *a)
> +{
> +    gen_set_pc_im(s, s->base.pc_next);
> +    s->svc_imm =3D a->imm;
> +    s->base.is_jmp =3D DISAS_SWI;
> +    return true;
> +}
> +
>  /*
>   * Legacy decoder.
>   */
> @@ -10235,6 +10247,7 @@ static void disas_arm_insn(DisasContext *s, uns=
igned int insn)
>          case 0x09:
>          case 0xa:
>          case 0xb:
> +        case 0xf:
>              /* All done in decodetree.  Reach here for illegal ops.  *=
/
>              goto illegal_op;
>          case 0xc:
> @@ -10250,12 +10263,6 @@ static void disas_arm_insn(DisasContext *s, un=
signed int insn)
>                  goto illegal_op;
>              }
>              break;
> -        case 0xf:
> -            /* swi */
> -            gen_set_pc_im(s, s->base.pc_next);
> -            s->svc_imm =3D extract32(insn, 0, 24);
> -            s->base.is_jmp =3D DISAS_SWI;
> -            break;
>          default:
>          illegal_op:
>              unallocated_encoding(s);
> diff --git a/target/arm/a32.decode b/target/arm/a32.decode
> index 62c6f8562e..0bd952c069 100644
> --- a/target/arm/a32.decode
> +++ b/target/arm/a32.decode
> @@ -528,3 +528,7 @@ LDM_a32          ---- 100 b:1 i:1 u:1 w:1 1 rn:4 li=
st:16   &ldst_block
> =20
>  B                .... 1010 ........................           @branch
>  BL               .... 1011 ........................           @branch
> +
> +# Supervisor call
> +
> +SVC              ---- 1111 imm:24                             &i
>=20

