Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31256C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2372068D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFWWa1AX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2372068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWfaT-0004uP-WD
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 06:52:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iWfZr-0004Qz-DE
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:52:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iWfZq-0005Wz-AO
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:52:19 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iWfZq-0005WV-24
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:52:18 -0500
Received: by mail-wm1-x344.google.com with SMTP id z19so18489192wmk.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 03:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=H+oMJaJi21xNPQFR07PpI/CDaTwbV0CojKF4JNAPeUQ=;
 b=fFWWa1AXr9N6cgBTTLzZZswf/b+moELCCzCjhTrXGoRYaHZtSdJV9fPT5CoQIcw4fs
 8IFbk1o9C6Vwixwpt8ur3YdW+lv/xA70rBlSVGxYsB2qaom4OCIVlQLkZK2q939PK5tu
 fKYKqv9nZWWoZJWXFm3zMYfGF6P++npcAADtCPi/ck2dQScuQlBQdf8Hsn1yrIib0QN1
 MagyxqY8B139Vp9amcenvjT0CUQ6D1wWCaFpXUxlK4hA7ral9PZ0TCUxHk2PfTR4wa6E
 X8vLy4+se61uh6/lzscje6vlcUsW1Wyri8g+Z6G/ZkLB1CHBL+H2jJdfcx2fqcgasfVJ
 zjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=H+oMJaJi21xNPQFR07PpI/CDaTwbV0CojKF4JNAPeUQ=;
 b=DFiQFLF1KqEhmCB5dPzQKQMR1DKpxo+8eEXnyF2pMt30ndX0fB4QNovKxUl5ETc/pz
 yBzZeS04FKd4W0eYpNmqoliBGJQHDVEkMbvXpcp614aGD8EQkIpW1wLWk5WWvoDSxkto
 tkmCrxXd1b7hBK8QjhQ4gjbRardDAqo4ACQSSUTWo30h4gs9j7MbGHb7xXG2B4qE2+KY
 nBMq/XkhTPKb7ncLdAye4BmLUiYXtafwEeMwNYA1VWxmpbkmejq9QX5YU9jDMUVE6GVq
 0ga78Od1sxHY3uqgqSqd3t5092IGl49PMF8cX2DfFkFUCY/8yLF3/NhUOS6wEs/z2/lM
 g+5g==
X-Gm-Message-State: APjAAAVSJ+z9m7L+2lxKb+lL1TfpARN1JfNQUYhZIQmASmzN9QGJvw3R
 XmJ6e/OoQIKkIiwJEaP3yFzMvw==
X-Google-Smtp-Source: APXvYqz7/r3RU9U7ld8qc6imXZ1Y/k2Jdm+NcIGPsRTVsP4jQjOAd3XgqmGn5zDNibWv0EBB2SaeEQ==
X-Received: by 2002:a05:600c:21d5:: with SMTP id
 x21mr23381015wmj.162.1574077936925; 
 Mon, 18 Nov 2019 03:52:16 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z8sm22252766wrp.49.2019.11.18.03.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 03:52:15 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8D1C51FF87;
 Mon, 18 Nov 2019 11:52:14 +0000 (GMT)
References: <20191115173000.21891-1-alex.bennee@linaro.org>
 <20191115173000.21891-3-alex.bennee@linaro.org>
 <9c06e53f-3efe-d2e4-1a76-5fc84d8cb6ea@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH 02/11] gdbstub: stop passing GDBState * around
In-reply-to: <9c06e53f-3efe-d2e4-1a76-5fc84d8cb6ea@linaro.org>
Date: Mon, 18 Nov 2019 11:52:14 +0000
Message-ID: <87lfsdh05t.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: damien.hedde@greensocs.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 luis.machado@linaro.org, qemu-devel@nongnu.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 11/15/19 6:29 PM, Alex Benn=C3=A9e wrote:
>> We only have one GDBState which should be allocated at the time we
>> process any commands. This will make further clean-up a bit easier.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  gdbstub.c | 307 +++++++++++++++++++++++++++++++-----------------------
>>  1 file changed, 177 insertions(+), 130 deletions(-)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index c5b6701825f..2e6ff5f583c 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -1399,7 +1399,6 @@ static int cmd_parse_params(const char *data, cons=
t char *schema,
>>  }
>>
>>  typedef struct GdbCmdContext {
>> -    GDBState *s;
>>      GdbCmdVariant *params;
>>      int num_params;
>>      uint8_t mem_buf[MAX_PACKET_LENGTH];
>> @@ -1480,7 +1479,7 @@ static int process_string_cmd(GDBState *s, void *u=
ser_ctx, const char *data,
>>              return -1;
>>          }
>>
>> -        gdb_ctx.s =3D s;
>> +        g_assert(s =3D=3D gdbserver_state);
>>          cmd->handler(&gdb_ctx, user_ctx);
>>          return 0;
>>      }
>> @@ -1505,7 +1504,7 @@ static void run_cmd_parser(GDBState *s, const char=
 *data,
>>  static void handle_detach(GdbCmdContext *gdb_ctx, void *user_ctx)
>>  {
>>      GDBProcess *process;
>> -    GDBState *s =3D gdb_ctx->s;
>> +    GDBState *s =3D gdbserver_state;
>>      uint32_t pid =3D 1;
>>
>>      if (s->multiprocess) {
> [...]
>
> Modulo my question about why not use a non-pointer variable,
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Sure - we might as well go for static assignment. My main worry was
overly long lines but we could shorten the global to compensate or wrap
a helper around.

>
>
> r~


--
Alex Benn=C3=A9e

