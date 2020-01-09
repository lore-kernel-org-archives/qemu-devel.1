Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713F7C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 20:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1998520721
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 20:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9MAv7s3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1998520721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iped8-0006Qo-IV
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 15:42:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ipecI-0005ju-5L
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 15:41:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ipecE-0004h1-O2
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 15:41:18 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44780)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ipecE-0004dL-Gz; Thu, 09 Jan 2020 15:41:14 -0500
Received: by mail-oi1-x244.google.com with SMTP id d62so7083918oia.11;
 Thu, 09 Jan 2020 12:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=RFXwf8GtVQjU8CU2hMGxbhpAt5nh4xZHGbJS4fwqJwE=;
 b=j9MAv7s3cUfd+mvUh75hyIWbV6wOq8Yc1JXVPiaDdQzb6tiA+XO6nSb2VckRkT8mfq
 Lpgn6t5N8cIbqUkrqsNnC3LQINtL51HxCIspGXAYp0k71fMX9BTvqDwvdybyf2UxRG78
 R7pQkr7C413Ius0Y58LdvLJpq6jSjucu6L+MKtTl3PXFr4LQcXIWbiiSI+cJ+1paxcFd
 TcMJQh2DY/xG9uszMwYChDMf5sSTESDAYtbOdFu1HbQFhrPjNn9///Bxjiw1saKhSgjc
 D1K2+6MdWo4RaA+Nerltd4WAQvCA/VGUeBg6Vw/fPhohSZdwa3l4imFJUEn4wkpK+Nty
 1j3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=RFXwf8GtVQjU8CU2hMGxbhpAt5nh4xZHGbJS4fwqJwE=;
 b=FsdYv8mcfFxT/rV+XZGTs7D/uk+DZPXyki83NMwRh8pLY5hNESwVy+iVW9MEyZYmAT
 Idgxe9QmnI/C6t247Di9LmQ2/9EajPm2Z5BEiX3ZBU88F1URwwr6OZ5RGy//N15/HaKj
 yT+W+Ejtj0GpUDMyllFwr5oF8r1q4qtaso9KQuUEs5WYMLg/7foQFonk8IuPi6cb13YC
 LCQlLhhVT5GVfC8YZ7Vvj5VS6jd3XzOm5trWAj9ht3r9EDpSsBw4nkXe5cybRDu4D7dG
 C7OXgpa8N0SyXVZaZtd+Az4+ah0bBiQ9/SvFryuCM5KZH/VMIJpRQXv7jiAeet5wPlqm
 tBhQ==
X-Gm-Message-State: APjAAAVIj3rNypDyS7LoV/X1SGYgmIrHX0nag8zSMDLpXs0DDYkY0+Z1
 hx4dukY0Zxg94JkYcpPK0GBriWMRxehRRNKug/o=
X-Google-Smtp-Source: APXvYqw6fMR5Biiv+tRCCr6bEBRO4ogqIG+Q13i6ty0YssCF3c1/rfbz7Fqhwpem8V5VtlMIOnity0nVZ45IGB5ERrA=
X-Received: by 2002:aca:bbc6:: with SMTP id l189mr4825443oif.53.1578602473745; 
 Thu, 09 Jan 2020 12:41:13 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Thu, 9 Jan 2020 12:41:13 -0800 (PST)
In-Reply-To: <20200106182425.20312-7-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106182425.20312-7-danielhb413@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 9 Jan 2020 21:41:13 +0100
Message-ID: <CAL1e-=hSf-Z5BSep_4nMRKzcNJoNJpzh94w4zVhsc3Nnf0SGDw@mail.gmail.com>
Subject: Re: [PATCH v1 06/59] mips-semi.c: remove 'uhi_done' label in
 helper_do_semihosting()
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000b0730b059bbb076b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b0730b059bbb076b
Content-Type: text/plain; charset="UTF-8"

On Monday, January 6, 2020, Daniel Henrique Barboza <danielhb413@gmail.com>
wrote:

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
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


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

--000000000000b0730b059bbb076b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGJyPjxicj5PbiBNb25kYXksIEphbnVhcnkgNiwgMjAyMCwgRGFuaWVsIEhlbnJpcXVlIEJhcmJv
emEgJmx0OzxhIGhyZWY9Im1haWx0bzpkYW5pZWxoYjQxM0BnbWFpbC5jb20iPmRhbmllbGhiNDEz
QGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij5UaGUgbGFiZWwgJiMzOTt1aGlfZG9uZSYjMzk7IGlzIGEgc2ltcGxl
ICYjMzk7cmV0dXJuJiMzOTsgY2FsbCBhbmQgY2FuPGJyPg0KYmUgcmVtb3ZlZCBmb3IgYSBiaXQg
bW9yZSBjbGFyaXR5IGluIHRoZSBjb2RlLjxicj4NCjxicj4NCkNDOiBBdXJlbGllbiBKYXJubyAm
bHQ7PGEgaHJlZj0ibWFpbHRvOmF1cmVsaWVuQGF1cmVsMzIubmV0Ij5hdXJlbGllbkBhdXJlbDMy
Lm5ldDwvYT4mZ3Q7PGJyPg0KQ0M6IEFsZWtzYW5kYXIgTWFya292aWMgJmx0OzxhIGhyZWY9Im1h
aWx0bzphbWFya292aWNAd2F2ZWNvbXAuY29tIj5hbWFya292aWNAd2F2ZWNvbXAuY29tPC9hPiZn
dDs8YnI+DQpDQzogQWxla3NhbmRhciBSaWthbG8gJmx0OzxhIGhyZWY9Im1haWx0bzphbGVrc2Fu
ZGFyLnJpa2Fsb0BydC1yay5jb20iPmFsZWtzYW5kYXIucmlrYWxvQHJ0LXJrLmNvbTwvYT4mZ3Q7
PGJyPg0KU2lnbmVkLW9mZi1ieTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemEgJmx0OzxhIGhyZWY9
Im1haWx0bzpkYW5pZWxoYjQxM0BnbWFpbC5jb20iPmRhbmllbGhiNDEzQGdtYWlsLmNvbTwvYT4m
Z3Q7PGJyPg0KLS0tPGJyPg0KwqB0YXJnZXQvbWlwcy9taXBzLXNlbWkuYyB8IDE1ICsrKysrKyst
LS0tLS0tLTxicj4NCsKgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlv
bnMoLSk8YnI+DQo8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+UmV2aWV3ZWQt
Ynk6wqA8c3BhbiBzdHlsZT0iY29sb3I6cmdiKDM0LDM0LDM0KTtmb250LXNpemU6MTRweDtsaW5l
LWhlaWdodDoyMi4xMjAwMDA4MzkyMzM0cHgiPkFsZWtzYW5kYXIgTWFya292aWMgJmx0Ozwvc3Bh
bj48YSBocmVmPSJtYWlsdG86YW1hcmtvdmljQHdhdmVjb21wLmNvbSIgc3R5bGU9ImZvbnQtc2l6
ZToxNHB4O2xpbmUtaGVpZ2h0OjIyLjEyMDAwMDgzOTIzMzRweCI+YW1hcmtvdmljQHdhdmVjb21w
LmNvbTwvYT48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDM0LDM0LDM0KTtmb250LXNpemU6MTRweDts
aW5lLWhlaWdodDoyMi4xMjAwMDA4MzkyMzM0cHgiPiZndDs8L3NwYW4+PC9kaXY+PGRpdj7CoDwv
ZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAu
OGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPg0KZGlmZiAt
LWdpdCBhL3RhcmdldC9taXBzL21pcHMtc2VtaS5jIGIvdGFyZ2V0L21pcHMvbWlwcy1zZW1pLmM8
YnI+DQppbmRleCAzNWJkZmQ3Yzc3Li4xMGE3MTBjMWU4IDEwMDY0NDxicj4NCi0tLSBhL3Rhcmdl
dC9taXBzL21pcHMtc2VtaS5jPGJyPg0KKysrIGIvdGFyZ2V0L21pcHMvbWlwcy1zZW1pLmM8YnI+
DQpAQCAtMjE4LDcgKzIxOCw3IEBAIHN0YXRpYyBpbnQgY29weV9hcmduX3RvX3RhcmdldCg8d2Jy
PkNQVU1JUFNTdGF0ZSAqZW52LCBpbnQgYXJnX251bSw8YnI+DQrCoCDCoCDCoCDCoCDCoGlmICgh
cCkge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgZ3ByWzJdID0gLTE7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgZ3ByWzNdID0gRUZBVUxUO8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgZ290
byB1aGlfZG9uZTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIHJldHVybjvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoFw8YnI+DQrCoCDCoCDCoCDCoCDCoH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQrCoCDCoCDCoH0gd2hpbGUgKDAp
PGJyPg0KPGJyPg0KQEAgLTIyOCwxNCArMjI4LDE0IEBAIHN0YXRpYyBpbnQgY29weV9hcmduX3Rv
X3RhcmdldCg8d2JyPkNQVU1JUFNTdGF0ZSAqZW52LCBpbnQgYXJnX251bSw8YnI+DQrCoCDCoCDC
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
NyBAQCB2b2lkIGhlbHBlcl9kb19zZW1paG9zdGluZyg8d2JyPkNQVU1JUFNTdGF0ZSAqZW52KTxi
cj4NCsKgIMKgIMKgIMKgIMKgaWYgKGdwcls0XSAmbHQ7IDMpIHs8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoC8qIGlnbm9yZSBjbG9zaW5nIHN0ZGluL3N0ZG91dC9zdGRlcnIgKi88YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoGdwclsyXSA9IDA7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGdvdG8g
dWhpX2RvbmU7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJldHVybjs8YnI+DQrCoCDCoCDCoCDC
oCDCoH08YnI+DQrCoCDCoCDCoCDCoCDCoGdwclsyXSA9IGNsb3NlKGdwcls0XSk7PGJyPg0KwqAg
wqAgwqAgwqAgwqBncHJbM10gPSBlcnJub19taXBzKGVycm5vKTs8YnI+DQpAQCAtMzAyLDcgKzMw
Miw3IEBAIHZvaWQgaGVscGVyX2RvX3NlbWlob3N0aW5nKDx3YnI+Q1BVTUlQU1N0YXRlICplbnYp
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqBncHJbMl0gPSBmc3RhdChncHJbNF0sICZhbXA7c2J1
Zik7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqBncHJbM10gPSBlcnJub19taXBzKGVycm5vKTs8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChncHJbMl0pIHs8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgZ290byB1aGlfZG9uZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
cmV0dXJuOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgZ3ByWzJdID0gY29weV9zdGF0X3RvX3RhcmdldChlbnYsICZhbXA7c2J1ZiwgZ3ByWzVdKTs8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoGdwclszXSA9IGVycm5vX21pcHMoZXJybm8pOzxicj4N
CkBAIC0zMTQsMTQgKzMxNCwxNCBAQCB2b2lkIGhlbHBlcl9kb19zZW1paG9zdGluZyg8d2JyPkNQ
VU1JUFNTdGF0ZSAqZW52KTxicj4NCsKgIMKgIMKgY2FzZSBVSElfYXJnbmxlbjo8YnI+DQrCoCDC
oCDCoCDCoCDCoGlmIChncHJbNF0gJmd0Oz0gc2VtaWhvc3RpbmdfZ2V0X2FyZ2MoKSkgezxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgZ3ByWzJdID0gLTE7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IGdvdG8gdWhpX2RvbmU7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJldHVybjs8YnI+DQrCoCDC
oCDCoCDCoCDCoH08YnI+DQrCoCDCoCDCoCDCoCDCoGdwclsyXSA9IHN0cmxlbihzZW1paG9zdGlu
Z19nZXRfYXJnKDx3YnI+Z3ByWzRdKSk7PGJyPg0KwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQrC
oCDCoCDCoGNhc2UgVUhJX2FyZ246PGJyPg0KwqAgwqAgwqAgwqAgwqBpZiAoZ3ByWzRdICZndDs9
IHNlbWlob3N0aW5nX2dldF9hcmdjKCkpIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoGdwclsy
XSA9IC0xOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBnb3RvIHVoaV9kb25lOzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCByZXR1cm47PGJyPg0KwqAgwqAgwqAgwqAgwqB9PGJyPg0KwqAgwqAgwqAg
wqAgwqBncHJbMl0gPSBjb3B5X2FyZ25fdG9fdGFyZ2V0KGVudiwgZ3ByWzRdLCBncHJbNV0pOzxi
cj4NCsKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KQEAgLTM2OSw2ICszNjksNSBAQCB2b2lkIGhl
bHBlcl9kb19zZW1paG9zdGluZyg8d2JyPkNQVU1JUFNTdGF0ZSAqZW52KTxicj4NCsKgIMKgIMKg
IMKgIMKgZnByaW50ZihzdGRlcnIsICZxdW90O1Vua25vd24gVUhJIG9wZXJhdGlvbiAlZFxuJnF1
b3Q7LCBvcCk7PGJyPg0KwqAgwqAgwqAgwqAgwqBhYm9ydCgpOzxicj4NCsKgIMKgIMKgfTxicj4N
Ci11aGlfZG9uZTo8YnI+DQrCoCDCoCDCoHJldHVybjs8YnI+DQrCoH08YnI+DQotLSA8YnI+DQoy
LjI0LjE8YnI+DQo8YnI+DQo8YnI+DQo8L2Jsb2NrcXVvdGU+DQo=
--000000000000b0730b059bbb076b--

