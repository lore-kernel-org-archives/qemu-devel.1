Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DADDC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 13:00:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A1620856
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 13:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qNxZMRjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A1620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35254 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hShuI-00049F-HK
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 09:00:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hShol-000843-Lv
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hShok-0001e3-Fa
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:55:03 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hShok-0001dX-6H
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:55:02 -0400
Received: by mail-wr1-x444.google.com with SMTP id r7so14435255wrr.13
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 05:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=ZKNvXUx7OOpZq5l6QJtELsUqLgs3iyQWbgHSaLImIXs=;
	b=qNxZMRjFZLoPmEgMWi8KaL3wGqIWPC8fsxvfGGQzBbFLb//i45U8xbFYWf+nAyK3is
	2Gzij/lZGBfFTzupIATOUepUU/iXZ4fQkJF5SksXfuTXytVlJo8r4Qf2FmRrz9PfTfQS
	u64KESGGb+kcfwPwOxazQhxkWuZKxjHt5nEZudbTO4NJYHJ4PG2zlbykcsOG1guXktYd
	cHzGuf96V4a6yju/wVhxwy30Vt7DY6GYu+nsIF5p5Mon3Zmn1t2zPRxXfbsT+lOgEuJu
	qjpmMrpjWuCr4DiOtcvlj79qwck340K69LcL4icniFE2UvZGpd/ej1QhEjKPiWoa3pMR
	4Crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=ZKNvXUx7OOpZq5l6QJtELsUqLgs3iyQWbgHSaLImIXs=;
	b=PTrfCgWq+lU6e32Kf1GemBlyyzumA19riJgNWPdtT95Nt85KxKIQmMxZnSiETN8znz
	SdJXI0NFgycShNzPRSfJ+M83VHeB60YyP60RvexJglEs0CAOIYHPHCOXg6NfWOqB3i32
	NzlWWxQFIPKVMrxoaBDJMSABxbBigtHxkuZfvzQ+uJiYj28wbjnsxsXmftPI9JfW14nn
	+qGZxU/F5adAuh5KU0rJGvkLez+NXfVBhQuVUTczlKXD3MpbcaDZeJDUDOM0TbyHaRTP
	wMlkI5BiXPlxTA67UGBdJVmeSt0AdrrtZI1iCFn98ghnthDE48PocFPhsz7VS1xIs8le
	PnEA==
X-Gm-Message-State: APjAAAV2c7pn7/xDgC+vhLu1LlJ2bL/NpH5vPlsQkURfFJpW2ptrDcgc
	OMCoYqCMiT5GVGM+7s20Pmu3jA==
X-Google-Smtp-Source: APXvYqwf+zi8rEV596aGmEohoX9TJnIWC2G1Ei2YqzT94bV5fPcye5maQOSGStJm2aMDJVx+sxljWA==
X-Received: by 2002:adf:ec0b:: with SMTP id x11mr9033199wrn.88.1558356900670; 
	Mon, 20 May 2019 05:55:00 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	s10sm14914711wrt.66.2019.05.20.05.54.59
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 20 May 2019 05:54:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 700B41FF87;
	Mon, 20 May 2019 13:54:59 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-21-arilou@gmail.com>
	<87ef4zmy7b.fsf@zen.linaroharston>
	<CAP7QCohHS+VvbvZENPeuvfVc=TNtvwoiA+6dgZO4XoZs4skXuw@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <CAP7QCohHS+VvbvZENPeuvfVc=TNtvwoiA+6dgZO4XoZs4skXuw@mail.gmail.com>
Date: Mon, 20 May 2019 13:54:59 +0100
Message-ID: <87r28tguak.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v9 20/27] gdbstub: Implement target halted
 (? pkt) with new infra
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jon Doron <arilou@gmail.com> writes:

> On Wed, May 15, 2019 at 8:20 PM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>>
>>
>> Jon Doron <arilou@gmail.com> writes:
>>
>> > Signed-off-by: Jon Doron <arilou@gmail.com>
>> > ---
>> >  gdbstub.c | 36 ++++++++++++++++++++++++++----------
>> >  1 file changed, 26 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/gdbstub.c b/gdbstub.c
>> > index 2fd0d66f4d..d678191705 100644
>> > --- a/gdbstub.c
>> > +++ b/gdbstub.c
>> > @@ -2239,13 +2239,30 @@ static void handle_gen_set(GdbCmdContext *gdb_=
ctx, void *user_ctx)
>> >      put_packet(gdb_ctx->s, "");
>> >  }
>> >
>> > +static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
>> > +{
>> > +    char thread_id[16];
>> > +
>> > +    /* TODO: Make this return the correct value for user-mode.  */
>>
>> Can this be cleaned up as we convert?
>>
>
> To be honest i have no idea what the "correct value" is or how to get
> it, can you tell me what it should be and ill add it to the patch?

Actually I think you can delete the comment and mention the thread-id
has been correctly reported in usermode since bd88c780e6

>
>> > +    gdb_fmt_thread_id(gdb_ctx->s, gdb_ctx->s->c_cpu, thread_id,
>> > +                      sizeof(thread_id));
>> > +    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "T%02xthread=
:%s;",
>> > +             GDB_SIGNAL_TRAP, thread_id);
>> > +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
>> > +    /*
>> > +     * Remove all the breakpoints when this query is issued,
>> > +     * because gdb is doing and initial connect and the state
>>
>> s/and/an/
>>
>> > +     * should be cleaned up.
>> > +     */
>> > +    gdb_breakpoint_remove_all();
>> > +}
>> > +
>> >  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>> >  {
>> >      const char *p;
>> >      int ch;
>> >      uint8_t mem_buf[MAX_PACKET_LENGTH];
>> >      char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
>> > -    char thread_id[16];
>> >      const GdbCmdParseEntry *cmd_parser =3D NULL;
>> >
>> >      trace_gdbstub_io_command(line_buf);
>> > @@ -2257,15 +2274,14 @@ static int gdb_handle_packet(GDBState *s, cons=
t char *line_buf)
>> >          put_packet(s, "OK");
>> >          break;
>> >      case '?':
>> > -        /* TODO: Make this return the correct value for user-mode.  */
>> > -        snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
>> > -                 gdb_fmt_thread_id(s, s->c_cpu, thread_id, sizeof(thr=
ead_id)));
>> > -        put_packet(s, buf);
>> > -        /* Remove all the breakpoints when this query is issued,
>> > -         * because gdb is doing and initial connect and the state
>> > -         * should be cleaned up.
>> > -         */
>> > -        gdb_breakpoint_remove_all();
>> > +        {
>> > +            static const GdbCmdParseEntry target_halted_cmd_desc =3D {
>> > +                .handler =3D handle_target_halt,
>> > +                .cmd =3D "?",
>> > +                .cmd_startswith =3D 1
>> > +            };
>> > +            cmd_parser =3D &target_halted_cmd_desc;
>> > +        }
>> >          break;
>> >      case 'c':
>> >          {
>>
>>
>> --
>> Alex Benn=C3=A9e


--
Alex Benn=C3=A9e

