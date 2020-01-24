Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BBDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7327C2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c26cwiay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7327C2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv2fp-0003ER-Ja
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 12:23:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iv2f2-0002iw-VL
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:22:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iv2f0-0003Yo-AH
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:22:24 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45657)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iv2f0-0003Xs-4R; Fri, 24 Jan 2020 12:22:22 -0500
Received: by mail-ot1-x344.google.com with SMTP id 59so2302199otp.12;
 Fri, 24 Jan 2020 09:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rAKShrNxMu3ZVat7CaRPVYDzrzP2/5uHm5ULUp8EUpc=;
 b=c26cwiayGVDPDXdmJFWnl6MmTqthKhfn7DI0vXyZLxAY6dmcloeir5lUzRuFCvplMr
 wWOEs/VH2fQCVghYrXRZwWF25sCmCneo7irwMaMUfQ6NKRjFqrRuOG2C4p+iBFFCVhy4
 6HPef2jBxh7EWvH34ltMTYGi7WjVoT2NSxWn3qy9kHJcez1Mv22aOgV9APGYjY/ekUWn
 InTY+eyglVjd3Cw2+JOc/pV0s1lwHSRvMS+kF2uxyUJRgiozuYMV6artPZdOXfvU8SwZ
 CT45vaJOijti2jlgGrmNFYT/KWEqFYe2vAL1SSfUt+s8iVhV2JYAllys5bljzoZ9QQbd
 0/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rAKShrNxMu3ZVat7CaRPVYDzrzP2/5uHm5ULUp8EUpc=;
 b=XmIumVFojWxixHhNk3BWac2jYnbJgequv4p6ex385h9nb6yFj7Q8y0EQZHvGlVN/GD
 EECo4SLJ/Sit28Jgl4wU37bjF/DxvkZgPgM6K+5bB42cVY+oFFRLk1hgsOUL2uqH4WKG
 OKMbmBd9yca/lLmyD84bDeZ9LINLKDgmnLsyajq0TLiDKJLUhKXJlwpCbnuY8kBWHPO+
 a7GI2AvDc1nx+Jp4hB77hI1KR1H1C5ylcdutGKeyFITlIsBZORZMn+DNH+nRihWXHFQL
 ffamDS1qYz9CGPLeDDb/21xCJN5v7nrspnWfL4YlqOFgqc5VxwqA909z7EpkaLmcEc+P
 2Odg==
X-Gm-Message-State: APjAAAXiJBngYvimn++cpCNZNHZYnV8Jz7McW1Eo1FDRJ/XUZNz9n3iS
 K49hk8Er2oj1H0xjOkd36C25tWxw9kR2WGOk0uU=
X-Google-Smtp-Source: APXvYqw9aRbgM81GuxpOj1mlfaj+0Jt4PG+cf1703N0aLzFxN2zps2b6qqJBca9/Wr1sC6qH5iGYAOBN+MPnYIDPzek=
X-Received: by 2002:a9d:198b:: with SMTP id k11mr3563830otk.295.1579886540773; 
 Fri, 24 Jan 2020 09:22:20 -0800 (PST)
MIME-Version: 1.0
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106182425.20312-7-danielhb413@gmail.com>
In-Reply-To: <20200106182425.20312-7-danielhb413@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 24 Jan 2020 18:22:09 +0100
Message-ID: <CAL1e-=iaSis_dBzA+=GBQq5q24V2r8Tnt6jvQjtKs97RJ4-yJQ@mail.gmail.com>
Subject: Re: [PATCH v1 06/59] mips-semi.c: remove 'uhi_done' label in
 helper_do_semihosting()
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000000c7124059ce6000e"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000c7124059ce6000e
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 6, 2020 at 7:29 PM Daniel Henrique Barboza <
danielhb413@gmail.com> wrote:

> The label 'uhi_done' is a simple 'return' call and can
> be removed for a bit more clarity in the code.
>
> CC: Aurelien Jarno <aurelien@aurel32.net>
> CC: Aleksandar Markovic <amarkovic@wavecomp.com>
> CC: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  target/mips/mips-semi.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
>
Applied to MIPS queue.


> diff --git a/target/mips/mips-semi.c b/target/mips/mips-semi.c
> index 35bdfd7c77..10a710c1e8 100644
> --- a/target/mips/mips-semi.c
> +++ b/target/mips/mips-semi.c
> @@ -218,7 +218,7 @@ static int copy_argn_to_target(CPUMIPSState *env, int
> arg_num,
>          if (!p) {                               \
>              gpr[2] = -1;                        \
>              gpr[3] = EFAULT;                    \
> -            goto uhi_done;                      \
> +            return;                             \
>          }                                       \
>      } while (0)
>
> @@ -228,14 +228,14 @@ static int copy_argn_to_target(CPUMIPSState *env,
> int arg_num,
>          if (!p) {                                       \
>              gpr[2] = -1;                                \
>              gpr[3] = EFAULT;                            \
> -            goto uhi_done;                              \
> +            return;                                     \
>          }                                               \
>          p2 = lock_user_string(addr2);                   \
>          if (!p2) {                                      \
>              unlock_user(p, addr, 0);                    \
>              gpr[2] = -1;                                \
>              gpr[3] = EFAULT;                            \
> -            goto uhi_done;                              \
> +            return;                                     \
>          }                                               \
>      } while (0)
>
> @@ -272,7 +272,7 @@ void helper_do_semihosting(CPUMIPSState *env)
>          if (gpr[4] < 3) {
>              /* ignore closing stdin/stdout/stderr */
>              gpr[2] = 0;
> -            goto uhi_done;
> +            return;
>          }
>          gpr[2] = close(gpr[4]);
>          gpr[3] = errno_mips(errno);
> @@ -302,7 +302,7 @@ void helper_do_semihosting(CPUMIPSState *env)
>              gpr[2] = fstat(gpr[4], &sbuf);
>              gpr[3] = errno_mips(errno);
>              if (gpr[2]) {
> -                goto uhi_done;
> +                return;
>              }
>              gpr[2] = copy_stat_to_target(env, &sbuf, gpr[5]);
>              gpr[3] = errno_mips(errno);
> @@ -314,14 +314,14 @@ void helper_do_semihosting(CPUMIPSState *env)
>      case UHI_argnlen:
>          if (gpr[4] >= semihosting_get_argc()) {
>              gpr[2] = -1;
> -            goto uhi_done;
> +            return;
>          }
>          gpr[2] = strlen(semihosting_get_arg(gpr[4]));
>          break;
>      case UHI_argn:
>          if (gpr[4] >= semihosting_get_argc()) {
>              gpr[2] = -1;
> -            goto uhi_done;
> +            return;
>          }
>          gpr[2] = copy_argn_to_target(env, gpr[4], gpr[5]);
>          break;
> @@ -369,6 +369,5 @@ void helper_do_semihosting(CPUMIPSState *env)
>          fprintf(stderr, "Unknown UHI operation %d\n", op);
>          abort();
>      }
> -uhi_done:
>      return;
>  }
> --
> 2.24.1
>
>
>

--0000000000000c7124059ce6000e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIE1vbiwgSmFu
IDYsIDIwMjAgYXQgNzoyOSBQTSBEYW5pZWwgSGVucmlxdWUgQmFyYm96YSAmbHQ7PGEgaHJlZj0i
bWFpbHRvOmRhbmllbGhiNDEzQGdtYWlsLmNvbSI+ZGFuaWVsaGI0MTNAZ21haWwuY29tPC9hPiZn
dDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwy
MDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5UaGUgbGFiZWwgJiMzOTt1aGlfZG9uZSYjMzk7IGlz
IGEgc2ltcGxlICYjMzk7cmV0dXJuJiMzOTsgY2FsbCBhbmQgY2FuPGJyPg0KYmUgcmVtb3ZlZCBm
b3IgYSBiaXQgbW9yZSBjbGFyaXR5IGluIHRoZSBjb2RlLjxicj4NCjxicj4NCkNDOiBBdXJlbGll
biBKYXJubyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmF1cmVsaWVuQGF1cmVsMzIubmV0IiB0YXJnZXQ9
Il9ibGFuayI+YXVyZWxpZW5AYXVyZWwzMi5uZXQ8L2E+Jmd0Ozxicj4NCkNDOiBBbGVrc2FuZGFy
IE1hcmtvdmljICZsdDs8YSBocmVmPSJtYWlsdG86YW1hcmtvdmljQHdhdmVjb21wLmNvbSIgdGFy
Z2V0PSJfYmxhbmsiPmFtYXJrb3ZpY0B3YXZlY29tcC5jb208L2E+Jmd0Ozxicj4NCkNDOiBBbGVr
c2FuZGFyIFJpa2FsbyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFsZWtzYW5kYXIucmlrYWxvQHJ0LXJr
LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmFsZWtzYW5kYXIucmlrYWxvQHJ0LXJrLmNvbTwvYT4mZ3Q7
PGJyPg0KU2lnbmVkLW9mZi1ieTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemEgJmx0OzxhIGhyZWY9
Im1haWx0bzpkYW5pZWxoYjQxM0BnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5kYW5pZWxoYjQx
M0BnbWFpbC5jb208L2E+Jmd0Ozxicj4NCi0tLTxicj4NCsKgdGFyZ2V0L21pcHMvbWlwcy1zZW1p
LmMgfCAxNSArKysrKysrLS0tLS0tLS08YnI+DQrCoDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlv
bnMoKyksIDggZGVsZXRpb25zKC0pPGJyPg0KPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rp
dj48ZGl2PkFwcGxpZWQgdG8gTUlQUyBxdWV1ZS48YnI+PC9kaXY+PGRpdj7CoDwvZGl2PjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhl
eDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4
Ij4NCmRpZmYgLS1naXQgYS90YXJnZXQvbWlwcy9taXBzLXNlbWkuYyBiL3RhcmdldC9taXBzL21p
cHMtc2VtaS5jPGJyPg0KaW5kZXggMzViZGZkN2M3Ny4uMTBhNzEwYzFlOCAxMDA2NDQ8YnI+DQot
LS0gYS90YXJnZXQvbWlwcy9taXBzLXNlbWkuYzxicj4NCisrKyBiL3RhcmdldC9taXBzL21pcHMt
c2VtaS5jPGJyPg0KQEAgLTIxOCw3ICsyMTgsNyBAQCBzdGF0aWMgaW50IGNvcHlfYXJnbl90b190
YXJnZXQoQ1BVTUlQU1N0YXRlICplbnYsIGludCBhcmdfbnVtLDxicj4NCsKgIMKgIMKgIMKgIMKg
aWYgKCFwKSB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBc
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqBncHJbMl0gPSAtMTvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqBncHJbM10gPSBFRkFV
TFQ7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCBnb3RvIHVoaV9kb25lO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgXDxicj4NCsKgIMKgIMKgIMKgIMKgfcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCsKgIMKgIMKgfSB3aGls
ZSAoMCk8YnI+DQo8YnI+DQpAQCAtMjI4LDE0ICsyMjgsMTQgQEAgc3RhdGljIGludCBjb3B5X2Fy
Z25fdG9fdGFyZ2V0KENQVU1JUFNTdGF0ZSAqZW52LCBpbnQgYXJnX251bSw8YnI+DQrCoCDCoCDC
oCDCoCDCoGlmICghcCkge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgZ3ByWzJdID0gLTE7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgZ3ByWzNdID0gRUZBVUxUO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgZ290byB1aGlfZG9u
ZTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIHJldHVybjvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQrCoCDCoCDCoCDCoCDCoH3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oFw8YnI+DQrCoCDCoCDCoCDCoCDCoHAyID0gbG9ja191c2VyX3N0cmluZyhhZGRyMik7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KwqAgwqAgwqAgwqAgwqBpZiAoIXAyKSB7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgdW5sb2NrX3VzZXIocCwgYWRkciwgMCk7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgZ3ByWzJdID0g
LTE7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgZ3ByWzNdID0gRUZBVUxUO8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgZ290byB1aGlf
ZG9uZTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIHJldHVybjvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQrCoCDCoCDCoCDCoCDCoH3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoFw8YnI+DQrCoCDCoCDCoH0gd2hpbGUgKDApPGJyPg0KPGJyPg0KQEAgLTI3Miw3ICsyNzIs
NyBAQCB2b2lkIGhlbHBlcl9kb19zZW1paG9zdGluZyhDUFVNSVBTU3RhdGUgKmVudik8YnI+DQrC
oCDCoCDCoCDCoCDCoGlmIChncHJbNF0gJmx0OyAzKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAvKiBpZ25vcmUgY2xvc2luZyBzdGRpbi9zdGRvdXQvc3RkZXJyICovPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqBncHJbMl0gPSAwOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBnb3RvIHVoaV9k
b25lOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm47PGJyPg0KwqAgwqAgwqAgwqAgwqB9
PGJyPg0KwqAgwqAgwqAgwqAgwqBncHJbMl0gPSBjbG9zZShncHJbNF0pOzxicj4NCsKgIMKgIMKg
IMKgIMKgZ3ByWzNdID0gZXJybm9fbWlwcyhlcnJubyk7PGJyPg0KQEAgLTMwMiw3ICszMDIsNyBA
QCB2b2lkIGhlbHBlcl9kb19zZW1paG9zdGluZyhDUFVNSVBTU3RhdGUgKmVudik8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoGdwclsyXSA9IGZzdGF0KGdwcls0XSwgJmFtcDtzYnVmKTs8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoGdwclszXSA9IGVycm5vX21pcHMoZXJybm8pOzxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgKGdwclsyXSkgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBnb3RvIHVoaV9kb25lOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm47PGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqBncHJbMl0g
PSBjb3B5X3N0YXRfdG9fdGFyZ2V0KGVudiwgJmFtcDtzYnVmLCBncHJbNV0pOzxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgZ3ByWzNdID0gZXJybm9fbWlwcyhlcnJubyk7PGJyPg0KQEAgLTMxNCwx
NCArMzE0LDE0IEBAIHZvaWQgaGVscGVyX2RvX3NlbWlob3N0aW5nKENQVU1JUFNTdGF0ZSAqZW52
KTxicj4NCsKgIMKgIMKgY2FzZSBVSElfYXJnbmxlbjo8YnI+DQrCoCDCoCDCoCDCoCDCoGlmIChn
cHJbNF0gJmd0Oz0gc2VtaWhvc3RpbmdfZ2V0X2FyZ2MoKSkgezxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgZ3ByWzJdID0gLTE7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gdWhpX2RvbmU7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJldHVybjs8YnI+DQrCoCDCoCDCoCDCoCDCoH08YnI+
DQrCoCDCoCDCoCDCoCDCoGdwclsyXSA9IHN0cmxlbihzZW1paG9zdGluZ19nZXRfYXJnKGdwcls0
XSkpOzxicj4NCsKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KwqAgwqAgwqBjYXNlIFVISV9hcmdu
Ojxicj4NCsKgIMKgIMKgIMKgIMKgaWYgKGdwcls0XSAmZ3Q7PSBzZW1paG9zdGluZ19nZXRfYXJn
YygpKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqBncHJbMl0gPSAtMTs8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgZ290byB1aGlfZG9uZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJu
Ozxicj4NCsKgIMKgIMKgIMKgIMKgfTxicj4NCsKgIMKgIMKgIMKgIMKgZ3ByWzJdID0gY29weV9h
cmduX3RvX3RhcmdldChlbnYsIGdwcls0XSwgZ3ByWzVdKTs8YnI+DQrCoCDCoCDCoCDCoCDCoGJy
ZWFrOzxicj4NCkBAIC0zNjksNiArMzY5LDUgQEAgdm9pZCBoZWxwZXJfZG9fc2VtaWhvc3Rpbmco
Q1BVTUlQU1N0YXRlICplbnYpPGJyPg0KwqAgwqAgwqAgwqAgwqBmcHJpbnRmKHN0ZGVyciwgJnF1
b3Q7VW5rbm93biBVSEkgb3BlcmF0aW9uICVkXG4mcXVvdDssIG9wKTs8YnI+DQrCoCDCoCDCoCDC
oCDCoGFib3J0KCk7PGJyPg0KwqAgwqAgwqB9PGJyPg0KLXVoaV9kb25lOjxicj4NCsKgIMKgIMKg
cmV0dXJuOzxicj4NCsKgfTxicj4NCi0tIDxicj4NCjIuMjQuMTxicj4NCjxicj4NCjxicj4NCjwv
YmxvY2txdW90ZT48L2Rpdj48L2Rpdj4NCg==
--0000000000000c7124059ce6000e--

