Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B014BC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B2920815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B2920815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54597 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFqk-0001ee-Ki
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:51:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRFnP-0007gZ-Nk
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRFnL-0006lb-VM
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:47:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hRFnL-0006it-Np
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:47:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so3351704wmo.2
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ScyyIgG1/5Wxh3TB+cI8IhMzDMg2E/NLyl1UvLAXpGI=;
	b=kSchPZqtKPFu66846QXb8kA+INMQGjkxdJ8Tv9FlT/fnjjaPCxUVW2Yg2zNcCqLN9u
	KqfOQOI5h5FNu5XCyA2vY2O9qu7S05wtcFLvErMO4yIbfJpxpawVGBFhX+W7qQuAGvZt
	73ZkaMf0FV61WTi420VFbYj+A4Ail8Eh37JZ+srbFUdh8gBd3+lMQxP+4CeBoPOJh/rR
	tlisuDj2AMDCzXQ4jLrdKpwgtEai4p3Qa3B49GH/cQBlnO2ME4UAWjjZp7clIT4B1ndB
	3eXX6m3Gsd16n5/+yUOvvS1rsE2mBrqD2JIKVoVz4/hQUsP/eAIUhehngc94QA45tHvC
	IPvA==
X-Gm-Message-State: APjAAAVIEBb4oykKkcBWb8Kz5k2SECctik+7UJXsrqw/M2E05yVcTV5s
	fP2fRlrLeBvdIH5T8RWjlR7SKA==
X-Google-Smtp-Source: APXvYqwmXnaBp7kcW8tbMkLfHmnxn+B9Gc+L8e2Pi0uXQePGZQyjEW7VnkBIhURKTrIQEeN3iFPjxQ==
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr28721109wmh.32.1558010853738; 
	Thu, 16 May 2019 05:47:33 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id w2sm3660814wrm.74.2019.05.16.05.47.32
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 05:47:33 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org,
	richard.henderson@linaro.org
References: <20190516055244.95559-1-ysato@users.sourceforge.jp>
	<20190516055244.95559-11-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fc048420-4abf-ca39-426f-ec9cf70f2014@redhat.com>
Date: Thu, 16 May 2019 14:47:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516055244.95559-11-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v13 10/12] hw/registerfields.h: Add 8bit
 and 16bit register macros.
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yoshinori,

On 5/16/19 7:52 AM, Yoshinori Sato wrote:
> Some RX peripheral using 8bit and 16bit registers.
> Added 8bit and 16bit APIs.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/hw/registerfields.h | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
> index 2659a58737..a0bb0654d6 100644
> --- a/include/hw/registerfields.h
> +++ b/include/hw/registerfields.h
> @@ -22,6 +22,14 @@
>      enum { A_ ## reg = (addr) };                                          \
>      enum { R_ ## reg = (addr) / 4 };
>  
> +#define REG8(reg, addr)                                                  \
> +    enum { A_ ## reg = (addr) };                                          \
> +    enum { R_ ## reg = (addr) };

This macro is used in your devices (previous patches) and we can not
build the previous patches without this one:

  CC      rx-softmmu/hw/char/renesas_sci.o
./hw/char/renesas_sci.c:34:10: error: expected ‘)’ before numeric constant
 REG8(SMR, 0)
          ^~
          )
./hw/char/renesas_sci.c:42:10: error: expected ‘)’ before numeric constant
 REG8(BRR, 1)
          ^~
          )
./hw/char/renesas_sci.c:51:10: error: expected ‘)’ before numeric constant
 REG8(TDR, 3)
          ^~
          )
./hw/char/renesas_sci.c:62:10: error: expected ‘)’ before numeric constant
 REG8(RDR, 5)
          ^~
          )
./hw/char/renesas_sci.c:68:11: error: expected ‘)’ before numeric constant
 REG8(SEMR, 7)
           ^~
           )
./hw/char/renesas_sci.c: In function ‘can_receive’:
./hw/char/renesas_sci.c:78:16: error: implicit declaration of function
‘FIELD_EX8’; did you mean ‘FIELD_EX64’?
[-Werror=implicit-function-declaration]
         return FIELD_EX8(sci->scr, SCR, RE);
                ^~~~~~~~~
                FIELD_EX64
./hw/char/renesas_sci.c:78:16: error: nested extern declaration of
‘FIELD_EX8’ [-Werror=nested-externs]
./hw/char/renesas_sci.c:78:36: error: ‘SCR’ undeclared (first use in
this function)
         return FIELD_EX8(sci->scr, SCR, RE);
                                    ^~~
./hw/char/renesas_sci.c:78:36: note: each undeclared identifier is
reported only once for each function it appears in
./hw/char/renesas_sci.c:78:41: error: ‘RE’ undeclared (first use in this
function)
         return FIELD_EX8(sci->scr, SCR, RE);
                                         ^~
./hw/char/renesas_sci.c: In function ‘receive’:
./hw/char/renesas_sci.c:86:29: error: ‘SSR’ undeclared (first use in
this function)
     if (FIELD_EX8(sci->ssr, SSR, RDRF) || size > 1) {
                             ^~~
./hw/char/renesas_sci.c:86:34: error: ‘RDRF’ undeclared (first use in
this function)
     if (FIELD_EX8(sci->ssr, SSR, RDRF) || size > 1) {
                                  ^~~~
./hw/char/renesas_sci.c:87:20: error: implicit declaration of function
‘FIELD_DP8’; did you mean ‘FIELD_DP32’?
[-Werror=implicit-function-declaration]
         sci->ssr = FIELD_DP8(sci->ssr, SSR, ORER, 1);
                    ^~~~~~~~~
                    FIELD_DP32
./hw/char/renesas_sci.c:87:20: error: nested extern declaration of
‘FIELD_DP8’ [-Werror=nested-externs]
./hw/char/renesas_sci.c:87:45: error: ‘ORER’ undeclared (first use in
this function)
         sci->ssr = FIELD_DP8(sci->ssr, SSR, ORER, 1);
                                             ^~~~
./hw/char/renesas_sci.c:88:33: error: ‘SCR’ undeclared (first use in
this function)
         if (FIELD_EX8(sci->scr, SCR, RIE)) {
                                 ^~~
./hw/char/renesas_sci.c:88:38: error: ‘RIE’ undeclared (first use in
this function); did you mean ‘PIE’?
         if (FIELD_EX8(sci->scr, SCR, RIE)) {
                                      ^~~
                                      PIE
./hw/char/renesas_sci.c: In function ‘send_byte’:
./hw/char/renesas_sci.c:107:36: error: ‘SSR’ undeclared (first use in
this function)
     sci->ssr = FIELD_DP8(sci->ssr, SSR, TEND, 0);
                                    ^~~
./hw/char/renesas_sci.c:107:41: error: ‘TEND’ undeclared (first use in
this function); did you mean ‘TEI’?
     sci->ssr = FIELD_DP8(sci->ssr, SSR, TEND, 0);
                                         ^~~~
                                         TEI
./hw/char/renesas_sci.c:108:41: error: ‘TDRE’ undeclared (first use in
this function); did you mean ‘TRUE’?
     sci->ssr = FIELD_DP8(sci->ssr, SSR, TDRE, 1);
                                         ^~~~
                                         TRUE
./hw/char/renesas_sci.c:110:29: error: ‘SCR’ undeclared (first use in
this function)
     if (FIELD_EX8(sci->scr, SCR, TIE)) {
                             ^~~
./hw/char/renesas_sci.c:110:34: error: ‘TIE’ undeclared (first use in
this function); did you mean ‘PIE’?
     if (FIELD_EX8(sci->scr, SCR, TIE)) {
                                  ^~~
                                  PIE
./hw/char/renesas_sci.c: In function ‘txend’:
./hw/char/renesas_sci.c:118:30: error: ‘SSR’ undeclared (first use in
this function)
     if (!FIELD_EX8(sci->ssr, SSR, TDRE)) {
                              ^~~
./hw/char/renesas_sci.c:118:35: error: ‘TDRE’ undeclared (first use in
this function); did you mean ‘TRUE’?
     if (!FIELD_EX8(sci->ssr, SSR, TDRE)) {
                                   ^~~~
                                   TRUE
./hw/char/renesas_sci.c:121:45: error: ‘TEND’ undeclared (first use in
this function); did you mean ‘TEI’?
         sci->ssr = FIELD_DP8(sci->ssr, SSR, TEND, 1);
                                             ^~~~
                                             TEI
./hw/char/renesas_sci.c:122:33: error: ‘SCR’ undeclared (first use in
this function)
         if (FIELD_EX8(sci->scr, SCR, TEIE)) {
                                 ^~~
./hw/char/renesas_sci.c:122:38: error: ‘TEIE’ undeclared (first use in
this function); did you mean ‘TEI’?
         if (FIELD_EX8(sci->scr, SCR, TEIE)) {
                                      ^~~~
                                      TEI
./hw/char/renesas_sci.c: In function ‘update_trtime’:
./hw/char/renesas_sci.c:131:43: error: ‘SMR’ undeclared (first use in
this function)
     sci->trtime = 8 - FIELD_EX8(sci->smr, SMR, CHR);
                                           ^~~
./hw/char/renesas_sci.c:131:48: error: ‘CHR’ undeclared (first use in
this function)
     sci->trtime = 8 - FIELD_EX8(sci->smr, SMR, CHR);
                                                ^~~
./hw/char/renesas_sci.c:132:45: error: ‘PE’ undeclared (first use in
this function); did you mean ‘PIE’?
     sci->trtime += FIELD_EX8(sci->smr, SMR, PE);
                                             ^~
                                             PIE
./hw/char/renesas_sci.c:133:45: error: ‘STOP’ undeclared (first use in
this function)
     sci->trtime += FIELD_EX8(sci->smr, SMR, STOP) + 1;
                                             ^~~~
./hw/char/renesas_sci.c:136:55: error: ‘CKS’ undeclared (first use in
this function)
     sci->trtime *= 1 << (2 * FIELD_EX8(sci->smr, SMR, CKS));
                                                       ^~~
./hw/char/renesas_sci.c: In function ‘sci_write’:
./hw/char/renesas_sci.c:150:10: error: ‘A_SMR’ undeclared (first use in
this function); did you mean ‘AF_SMC’?
     case A_SMR:
          ^~~~~
          AF_SMC
./hw/char/renesas_sci.c:142:21: error: ‘SCR’ undeclared (first use in
this function)
     (FIELD_EX8(scr, SCR, TE) || FIELD_EX8(scr, SCR, RE))
                     ^~~
./hw/char/renesas_sci.c:151:14: note: in expansion of macro ‘IS_TR_ENABLED’
         if (!IS_TR_ENABLED(sci->scr)) {
              ^~~~~~~~~~~~~
./hw/char/renesas_sci.c:142:26: error: ‘TE’ undeclared (first use in
this function); did you mean ‘TEI’?
     (FIELD_EX8(scr, SCR, TE) || FIELD_EX8(scr, SCR, RE))
                          ^~
./hw/char/renesas_sci.c:151:14: note: in expansion of macro ‘IS_TR_ENABLED’
         if (!IS_TR_ENABLED(sci->scr)) {
              ^~~~~~~~~~~~~
./hw/char/renesas_sci.c:142:53: error: ‘RE’ undeclared (first use in
this function)
     (FIELD_EX8(scr, SCR, TE) || FIELD_EX8(scr, SCR, RE))
                                                     ^~
./hw/char/renesas_sci.c:151:14: note: in expansion of macro ‘IS_TR_ENABLED’
         if (!IS_TR_ENABLED(sci->scr)) {
              ^~~~~~~~~~~~~
./hw/char/renesas_sci.c:156:10: error: ‘A_BRR’ undeclared (first use in
this function)
     case A_BRR:
          ^~~~~
./hw/char/renesas_sci.c:162:10: error: ‘A_SCR’ undeclared (first use in
this function)
     case A_SCR:
          ^~~~~
./hw/char/renesas_sci.c:165:44: error: ‘SSR’ undeclared (first use in
this function)
             sci->ssr = FIELD_DP8(sci->ssr, SSR, TDRE, 1);
                                            ^~~
./hw/char/renesas_sci.c:165:49: error: ‘TDRE’ undeclared (first use in
this function); did you mean ‘TRUE’?
             sci->ssr = FIELD_DP8(sci->ssr, SSR, TDRE, 1);
                                                 ^~~~
                                                 TRUE
./hw/char/renesas_sci.c:166:49: error: ‘TEND’ undeclared (first use in
this function); did you mean ‘TEI’?
             sci->ssr = FIELD_DP8(sci->ssr, SSR, TEND, 1);
                                                 ^~~~
                                                 TEI
./hw/char/renesas_sci.c:167:42: error: ‘TIE’ undeclared (first use in
this function); did you mean ‘PIE’?
             if (FIELD_EX8(sci->scr, SCR, TIE)) {
                                          ^~~
                                          PIE
./hw/char/renesas_sci.c:171:39: error: ‘TEIE’ undeclared (first use in
this function); did you mean ‘TEI’?
         if (!FIELD_EX8(sci->scr, SCR, TEIE)) {
                                       ^~~~
                                       TEI
./hw/char/renesas_sci.c:174:39: error: ‘RIE’ undeclared (first use in
this function); did you mean ‘PIE’?
         if (!FIELD_EX8(sci->scr, SCR, RIE)) {
                                       ^~~
                                       PIE
./hw/char/renesas_sci.c:178:10: error: ‘A_TDR’ undeclared (first use in
this function)
     case A_TDR:
          ^~~~~
./hw/char/renesas_sci.c:186:10: error: ‘A_SSR’ undeclared (first use in
this function); did you mean ‘A_PSW’?
     case A_SSR:
          ^~~~~
          A_PSW
./hw/char/renesas_sci.c:187:45: error: ‘MPBT’ undeclared (first use in
this function)
         sci->ssr = FIELD_DP8(sci->ssr, SSR, MPBT,
                                             ^~~~
./hw/char/renesas_sci.c:189:45: error: ‘ERR’ undeclared (first use in
this function); did you mean ‘ERI’?
         sci->ssr = FIELD_DP8(sci->ssr, SSR, ERR,
                                             ^~~
                                             ERI
./hw/char/renesas_sci.c:196:10: error: ‘A_RDR’ undeclared (first use in
this function); did you mean ‘O_RDWR’?
     case A_RDR:
          ^~~~~
          O_RDWR
./hw/char/renesas_sci.c:199:10: error: ‘A_SCMR’ undeclared (first use in
this function); did you mean ‘S_ISCHR’?
     case A_SCMR:
          ^~~~~~
          S_ISCHR
./hw/char/renesas_sci.c:201:10: error: ‘A_SEMR’ undeclared (first use in
this function); did you mean ‘AF_SMC’?
     case A_SEMR: /* SEMR */
          ^~~~~~
          AF_SMC
./hw/char/renesas_sci.c: In function ‘sci_read’:
./hw/char/renesas_sci.c:215:10: error: ‘A_SMR’ undeclared (first use in
this function); did you mean ‘AF_SMC’?
     case A_SMR:
          ^~~~~
          AF_SMC
./hw/char/renesas_sci.c:217:10: error: ‘A_BRR’ undeclared (first use in
this function)
     case A_BRR:
          ^~~~~
./hw/char/renesas_sci.c:219:10: error: ‘A_SCR’ undeclared (first use in
this function)
     case A_SCR:
          ^~~~~
./hw/char/renesas_sci.c:221:10: error: ‘A_TDR’ undeclared (first use in
this function)
     case A_TDR:
          ^~~~~
./hw/char/renesas_sci.c:223:10: error: ‘A_SSR’ undeclared (first use in
this function); did you mean ‘A_PSW’?
     case A_SSR:
          ^~~~~
          A_PSW
./hw/char/renesas_sci.c:226:10: error: ‘A_RDR’ undeclared (first use in
this function); did you mean ‘O_RDWR’?
     case A_RDR:
          ^~~~~
          O_RDWR
./hw/char/renesas_sci.c:227:40: error: ‘SSR’ undeclared (first use in
this function)
         sci->ssr = FIELD_DP8(sci->ssr, SSR, RDRF, 0);
                                        ^~~
./hw/char/renesas_sci.c:227:45: error: ‘RDRF’ undeclared (first use in
this function)
         sci->ssr = FIELD_DP8(sci->ssr, SSR, RDRF, 0);
                                             ^~~~
./hw/char/renesas_sci.c:229:10: error: ‘A_SCMR’ undeclared (first use in
this function); did you mean ‘S_ISCHR’?
     case A_SCMR:
          ^~~~~~
          S_ISCHR
./hw/char/renesas_sci.c:231:10: error: ‘A_SEMR’ undeclared (first use in
this function); did you mean ‘AF_SMC’?
     case A_SEMR:
          ^~~~~~
          AF_SMC
./hw/char/renesas_sci.c: In function ‘sci_event’:
./hw/char/renesas_sci.c:266:40: error: ‘SSR’ undeclared (first use in
this function)
         sci->ssr = FIELD_DP8(sci->ssr, SSR, FER, 1);
                                        ^~~
./hw/char/renesas_sci.c:266:45: error: ‘FER’ undeclared (first use in
this function)
         sci->ssr = FIELD_DP8(sci->ssr, SSR, FER, 1);
                                             ^~~
./hw/char/renesas_sci.c:267:33: error: ‘SCR’ undeclared (first use in
this function)
         if (FIELD_EX8(sci->scr, SCR, RIE)) {
                                 ^~~
./hw/char/renesas_sci.c:267:38: error: ‘RIE’ undeclared (first use in
this function); did you mean ‘PIE’?
         if (FIELD_EX8(sci->scr, SCR, RIE)) {
                                      ^~~
                                      PIE
./hw/char/renesas_sci.c: In function ‘can_receive’:
./hw/char/renesas_sci.c:80:1: error: control reaches end of non-void
function [-Werror=return-type]
 }
 ^
cc1: all warnings being treated as errors

I already commented that in a previous review.

> +
> +#define REG16(reg, addr)                                                  \
> +    enum { A_ ## reg = (addr) };                                          \
> +    enum { R_ ## reg = (addr) / 2 };

I wonder why you didn't include those macros before REG32 to keep them
ordered, not a big deal.

> +
>  /* Define SHIFT, LENGTH and MASK constants for a field within a register */
>  
>  /* This macro will define R_FOO_BAR_MASK, R_FOO_BAR_SHIFT and R_FOO_BAR_LENGTH
> @@ -34,6 +42,12 @@
>                                          MAKE_64BIT_MASK(shift, length)};
>  
>  /* Extract a field from a register */
> +#define FIELD_EX8(storage, reg, field)                                    \
> +    extract8((storage), R_ ## reg ## _ ## field ## _SHIFT,                \

Then this function ...

> +              R_ ## reg ## _ ## field ## _LENGTH)
> +#define FIELD_EX16(storage, reg, field)                                   \
> +    extract16((storage), R_ ## reg ## _ ## field ## _SHIFT,               \

... and this one are added in the next patch, so you series is not
bisectable:

  CC      rx-softmmu/hw/char/renesas_sci.o
In file included from ./target/rx/cpu.h:24,
                 from ./hw/char/renesas_sci.c:26:
./hw/char/renesas_sci.c: In function ‘can_receive’:
./include/hw/registerfields.h:46:5: error: implicit declaration of
function ‘extract8’; did you mean ‘extract64’?
[-Werror=implicit-function-declaration]
     extract8((storage), R_ ## reg ## _ ## field ## _SHIFT,                \
     ^~~~~~~~
./hw/char/renesas_sci.c:78:16: note: in expansion of macro ‘FIELD_EX8’
         return FIELD_EX8(sci->scr, SCR, RE);
                ^~~~~~~~~
./include/hw/registerfields.h:46:5: error: nested extern declaration of
‘extract8’ [-Werror=nested-externs]
     extract8((storage), R_ ## reg ## _ ## field ## _SHIFT,                \
     ^~~~~~~~
./hw/char/renesas_sci.c:78:16: note: in expansion of macro ‘FIELD_EX8’
         return FIELD_EX8(sci->scr, SCR, RE);
                ^~~~~~~~~
cc1: all warnings being treated as errors

Richard: Can you reorder the series with:

- patch 11 first "Add extract8 and extract16"
- patch 10 then "Add 8bit and 16bit register macros"
  (while here, can you strip the trailing dot in patch subject?)
- rest of this series, patches 1...9
- finally patch 12 (personally I'd have squashed this one
  in patch 9 "Add rx-softmmu")

> +              R_ ## reg ## _ ## field ## _LENGTH)
>  #define FIELD_EX32(storage, reg, field)                                   \
>      extract32((storage), R_ ## reg ## _ ## field ## _SHIFT,               \
>                R_ ## reg ## _ ## field ## _LENGTH)
> @@ -49,6 +63,22 @@
>   * Assigning values larger then the target field will result in
>   * compilation warnings.
>   */
> +#define FIELD_DP8(storage, reg, field, val) ({                            \
> +    struct {                                                              \
> +        unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
> +    } v = { .v = val };                                                   \
> +    uint8_t d;                                                            \
> +    d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
> +                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
> +    d; })
> +#define FIELD_DP16(storage, reg, field, val) ({                           \
> +    struct {                                                              \
> +        unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
> +    } v = { .v = val };                                                   \
> +    uint16_t d;                                                           \
> +    d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
> +                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
> +    d; })
>  #define FIELD_DP32(storage, reg, field, val) ({                           \
>      struct {                                                              \
>          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
> @@ -57,7 +87,7 @@
>      d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
>                    R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
>      d; })
> -#define FIELD_DP64(storage, reg, field, val) ({                           \
> +#define FIELD_DP64(storage, reg, field, val) ({                         \

I suppose this is change is a mistake. Richard, do you mind dropping it?

>      struct {                                                              \
>          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
>      } v = { .v = val };                                                   \
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

