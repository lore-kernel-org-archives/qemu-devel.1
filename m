Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58E3C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC3F120828
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3F120828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjP60-0005J2-Md
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 10:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48945)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hjP4h-0003m6-R1
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hjP4e-0000IH-Ju
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:20:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56154)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hjP4e-0008WC-9G
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:20:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so9058209wmj.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 07:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kxWgxblh8sq4nVjKmliUU8hXIg5TI3gyeCWkzDz7y/A=;
 b=TGj312/ofirQMrJofBM90CRvyjEJtEB49Qo0XAziAcHzBbEr6F/RF0JPtT5gmoxI5V
 rYurP5riUQPOpkaLt31eQd8FoaB6i9zW9wAx0qx67/erVoR7wJyE2W2M3NIBQ1FxPwGI
 hnozSL6bKjVSp+Prkttb7bLN8f4QEkRgs6DDCIOxf7pM0VsLOrxxACLAgecfy9l8kV+p
 OEqsKzczIdSIuoSioF5OncRTlBtneYqgGvWxAY9/tsuFZQxGL3eekGG4bXd30E+6dZor
 OEFPZDt5QRAjkQe4I5EM/CeDuyA7DS1j9lxBiRC2dm7cFIH2VQYUq4hx+B4/R0QmlyiK
 wt7w==
X-Gm-Message-State: APjAAAUV1Vqgw2xAdyWZo2rRO3stkLprp6/im0OKEtP8YT/KC4QJa6hb
 d9h0B2U+pgD/j9wtAmGZLqnkfQ==
X-Google-Smtp-Source: APXvYqxswceVMUwjetkS1ZBWqByoy07gDbaUsDzHRQogdyl99zD3NSZcGQKjHjuRxUrwBCRjQZLB8A==
X-Received: by 2002:a7b:cae9:: with SMTP id t9mr3766568wml.126.1562336425261; 
 Fri, 05 Jul 2019 07:20:25 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id z9sm11912887wrs.14.2019.07.05.07.20.24
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 07:20:24 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190705132954.19500-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fee81cc5-dff4-3edc-c871-769f52912acc@redhat.com>
Date: Fri, 5 Jul 2019 16:20:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190705132954.19500-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH for 4.1] gdbstub: revert to previous
 set_reg behaviour
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/5/19 3:29 PM, Alex Bennée wrote:
> The refactoring of handle_set_reg missed the fact we previously had
> responded with an empty packet when we were not using XML based
> protocols. This broke the fallback behaviour for architectures that
> don't have registers defined in QEMU's gdb-xml directory.
> 
> Revert to the previous behaviour and clean up the commentary for what
> is going on.
> 
> Fixes: 62b3320bddd
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Jon Doron <arilou@gmail.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  gdbstub.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index ea3349d1aa..b6df7ee25a 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1669,12 +1669,23 @@ static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
>      put_packet(gdb_ctx->s, "E22");
>  }
>  
> +/*
> + * handle_set/get_reg
> + *
> + * Older gdb are really dumb, and don't use 'G/g' if 'P/p' is available.
> + * This works, but can be very slow. Anything new enough to understand
> + * XML also knows how to use this properly. However to use this we
> + * need to define a local XML file as well as be talking to a
> + * reasonably modern gdb. Responding with an empty packet will cause
> + * the remote gdb to fallback to older methods.
> + */
> +
>  static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
>  {
>      int reg_size;
>  
>      if (!gdb_has_xml) {
> -        put_packet(gdb_ctx->s, "E00");
> +        put_packet(gdb_ctx->s, "");
>          return;
>      }
>  
> @@ -1694,11 +1705,6 @@ static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
>  {
>      int reg_size;
>  
> -    /*
> -     * Older gdb are really dumb, and don't use 'g' if 'p' is avaialable.
> -     * This works, but can be very slow.  Anything new enough to
> -     * understand XML also knows how to use this properly.
> -     */
>      if (!gdb_has_xml) {
>          put_packet(gdb_ctx->s, "");
>          return;
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

