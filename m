Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939DAC4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 17:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6994220640
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 17:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6994220640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8SbN-0006FU-Fl
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 13:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i8Sab-0005pm-HW
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i8Saa-00069f-Hg
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:09:01 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:33685)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i8Saa-00069R-92; Thu, 12 Sep 2019 13:09:00 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MYNS0-1hczQu00h8-00VMyY; Thu, 12 Sep 2019 19:08:58 +0200
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <1568296920-29939-1-git-send-email-frederic.konrad@adacore.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7b255a1c-b821-9faf-bd10-c4df95241cf4@vivier.eu>
Date: Thu, 12 Sep 2019 19:08:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568296920-29939-1-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/aiZY5VzuZS7R5Pc04thiZDtGl1LYuUi156eC7UeES0nJCwRxKG
 vQsoqTGF8FfmTM7dC5Gmfw+cjontrFQGIrB6I1hvquW+pFsgP2VAFEFTTbnTUCv+i5bCgNp
 XNpqAGGqqKQzIej8dANYItJPgA61D1fuNuiE5hWwuVx5hUs5Xar4fW2gRCI1lFxM0rTYCh+
 fTxrCrQ+m5WXio+4WiUxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9cF5xpNWOMo=:O9JzmL5Orjae/Rnsj/DSEl
 Kh/Rn0BQe3J2TdhtAalhjdZTrPzxfs5oyzKkCNdjzoJTewlObwpdZ73kyA8vnCu8r+w5TIAcw
 atNUq727BhZGd2KMMTpAxI/L/nOpBJZldVbO5qFCH8dpCkiaDfez0uAQrkpTPAGIxUfBT0ATz
 gW/tzBwY7IW4pGDATfg0iuPop6b1lVSKYDPkiIEglb2npd/0yhZ5qEqTU0gG1RJvUT6CQauvK
 uYtBPTs0eIB2tsxDCXiyepmdCGdF0Oct8iVc/I/nMckCnoCOKzimOykgHuaRjLcY+y7y0DJz4
 SQoyhmOWNcyg8SXNd8Ei3rmuQUyup8WirYE7tIIAUEs+vXqM/5zm3Wqco4R1vtJomW2K/Yljb
 mGrcHaLkOanLH4GCPAlczXNklTq+wfxYQpYXtXFNOkL6uD8N2cl4kMwLmWyg2eVFJ91+Skuh1
 CVVhceXlKgDL/QclZaNQ5Ivfd0GGt9UvZlLkfjtuOaMeDvMMaZlHUHqrD1v+hYA97gaaLblqE
 NCRJeNGX+FQzfHSM9mSsxk53cYDEInWSnEsgAvZ/jfIiCv5+WumfVKqA1+ZnKh5xFOi/pOavL
 57kK0+NhMwkzHpUCFsW3Fb5BDPXcf2egwVHpJG/aeFfJHlXHC0sAWp1P3tsWZGfsE/1Dd1ftk
 gMfV2n6tqyKC84G+LrbYqj9Zb92okKjI11+lhGrVJYphNdEe0OU4dBRgqNOelPqKSMxLFla+z
 zZufOZvsuFmAAkCmjYkZbMpMWJG9n+OHE8+CbAZ1BYJF2fPbA+UInDI0CpZuCkOFJ1cEdBRRv
 aFjCmC9IVot+PX8eOHmOv++HHZRbcdqMwL8rRjyI7r6P4KCwd8Bg5QdEFmGy2slm6iIYFR4fE
 rY0YGGswUUJBq0E/URDMzx0cLFh/XtAiR3EvPVOOM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: Re: [Qemu-devel] [PATCH] target/m68k/fpu_helper.c: rename the
 access arguments
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

Le 12/09/2019 à 16:02, KONRAD Frederic a écrit :
> The "access" arguments clash with a macro under Windows with MinGW:
>   CC      m68k-softmmu/target/m68k/fpu_helper.o
>   target/m68k/fpu_helper.c: In function 'fmovem_predec':
>   target/m68k/fpu_helper.c:405:56: error: macro "access" passed 4 arguments,
>    but takes just 2
>                size = access(env, addr, &env->fregs[i], ra);
> 
> So this renames them access_fn.
> 
> Tested with:
>  ./configure --target-list=m68k-softmmu
>  make -j8
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>  target/m68k/fpu_helper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
> index 9b039c8..4137542 100644
> --- a/target/m68k/fpu_helper.c
> +++ b/target/m68k/fpu_helper.c
> @@ -396,14 +396,14 @@ typedef int (*float_access)(CPUM68KState *env, uint32_t addr, FPReg *fp,
>                              uintptr_t ra);
>  
>  static uint32_t fmovem_predec(CPUM68KState *env, uint32_t addr, uint32_t mask,
> -                               float_access access)
> +                              float_access access_fn)
>  {
>      uintptr_t ra = GETPC();
>      int i, size;
>  
>      for (i = 7; i >= 0; i--, mask <<= 1) {
>          if (mask & 0x80) {
> -            size = access(env, addr, &env->fregs[i], ra);
> +            size = access_fn(env, addr, &env->fregs[i], ra);
>              if ((mask & 0xff) != 0x80) {
>                  addr -= size;
>              }
> @@ -414,14 +414,14 @@ static uint32_t fmovem_predec(CPUM68KState *env, uint32_t addr, uint32_t mask,
>  }
>  
>  static uint32_t fmovem_postinc(CPUM68KState *env, uint32_t addr, uint32_t mask,
> -                               float_access access)
> +                               float_access access_fn)
>  {
>      uintptr_t ra = GETPC();
>      int i, size;
>  
>      for (i = 0; i < 8; i++, mask <<= 1) {
>          if (mask & 0x80) {
> -            size = access(env, addr, &env->fregs[i], ra);
> +            size = access_fn(env, addr, &env->fregs[i], ra);
>              addr += size;
>          }
>      }
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


