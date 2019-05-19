Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E29C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 14:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9A321726
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 14:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7tQukwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9A321726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49765 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSNEd-0003ZN-Pu
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 10:56:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hSNDa-0002eS-4h
	for qemu-devel@nongnu.org; Sun, 19 May 2019 10:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hSNDZ-0007Wz-0L
	for qemu-devel@nongnu.org; Sun, 19 May 2019 10:55:18 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hSNDY-0007WI-PV
	for qemu-devel@nongnu.org; Sun, 19 May 2019 10:55:16 -0400
Received: by mail-wr1-x443.google.com with SMTP id w13so981555wru.11
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 07:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=c0Q/+1JowvY6L7Dprc/fAlwbRaIt18jq9HkKqjP0p5Y=;
	b=D7tQukwLu8eAWbWqTR9xUSqir+6I2zdqUEv8k/fMDKvOHe2cClqPwfixOp6wG2C6JX
	bpWMqDH8dqKCABN4hqeTnAn1izbzo2hNtK8uN1DvaNz4XwhZEGHLhm0ZQq9BPPQFRf3X
	UVgiYLYAPbAtMNNf+cNp1jKmcUKt9NjJsUdc7pA+y6SM1meSW51FHYT9Eoq46eb5GgHz
	CgM2nAytmQuA7yvTx62a5P6fuUT+zdvysWbouZVc/8FJ/tzNqub7y/7k7mSM7giUXKyS
	nlb9jFgx9ntiCsUVxc827oIMNAEtaI7WSgR+/0l5moa2rGZu4CvqRD11drkQam1SmXAA
	nRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=c0Q/+1JowvY6L7Dprc/fAlwbRaIt18jq9HkKqjP0p5Y=;
	b=t7gBBBbfqvPlE2XDIuMehsKcRMf8r2G5aTp4V8AHxN8LAu6NWL5INDzuh4tAsPZktd
	AY8ouyyIhL37oYDJl6N+o3u3R2L1Lmyvuwl7YBcsoHnxGTzYZzYl5ZiZFNXkn95r0yNu
	iW4hy4TlXyN7gcDszBGMipVgh523eLRqubiBO1vdUYJBUz4deZ4xDfJMW2ZdJ3GacXit
	OLBPqGWyDAn9PW101P0s3VDMQMXzLc6VWWtJDVrQLXXHxoT4Ywn4ChQDpu0pVRBXVPZc
	nDwuavhnWEE7MW4sFMse3C2eugTVNmrFrWQpaG5rvozCATUhgcrspZPMa9J7c1DBnQ3T
	s9Tg==
X-Gm-Message-State: APjAAAVGPxDd3Zwdy7IbjYJnhifaUcqFrDuRd3wnnIaAE0+3XtMhSZJU
	kUIFkAHjggRfYIf1XA38lkoODw==
X-Google-Smtp-Source: APXvYqxg33QgFdIg7Bbg23AsTSXmzm0TpD+7xfh7CQfboo05l6W74fWqJ7MJWDZ49NRWcEwNdWCnlw==
X-Received: by 2002:adf:db11:: with SMTP id s17mr2827673wri.43.1558277715576; 
	Sun, 19 May 2019 07:55:15 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	c63sm14824093wma.29.2019.05.19.07.55.14
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sun, 19 May 2019 07:55:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id A085A1FF87;
	Sun, 19 May 2019 15:55:14 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-15-arilou@gmail.com>
	<87lfz7n1f5.fsf@zen.linaroharston>
	<CAP7QCogdQDx1t=u6U_NkYspzQCTLJAR-jmA=6mXKUv2v+PJNXw@mail.gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <CAP7QCogdQDx1t=u6U_NkYspzQCTLJAR-jmA=6mXKUv2v+PJNXw@mail.gmail.com>
Date: Sun, 19 May 2019 15:55:14 +0100
Message-ID: <87pnoe5wa5.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v9 14/27] gdbstub: Implement read all
 registers (g pkt) with new infra
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

> I agree but I guess to really fix it we need to change
> gdb_read_register implementation to support returning the size of the
> register for mem_buffer =3D NULL
> Let's leave it for another patchset?

Sure

>
> On Wed, May 15, 2019 at 7:10 PM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>>
>>
>> Jon Doron <arilou@gmail.com> writes:
>>
>> > Signed-off-by: Jon Doron <arilou@gmail.com>
>> > ---
>> >  gdbstub.c | 31 +++++++++++++++++++++++--------
>> >  1 file changed, 23 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/gdbstub.c b/gdbstub.c
>> > index adfe39b3a3..3478ac778d 100644
>> > --- a/gdbstub.c
>> > +++ b/gdbstub.c
>> > @@ -1757,6 +1757,21 @@ static void handle_write_all_regs(GdbCmdContext=
 *gdb_ctx, void *user_ctx)
>> >      put_packet(gdb_ctx->s, "OK");
>> >  }
>> >
>> > +static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_c=
tx)
>> > +{
>> > +    target_ulong addr, len;
>> > +
>> > +    cpu_synchronize_state(gdb_ctx->s->g_cpu);
>> > +    len =3D 0;
>> > +    for (addr =3D 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs; addr++=
) {
>> > +        len +=3D gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_bu=
f + len,
>> > +                                 addr);
>> > +    }
>>
>> Again no bounds checking - we get away with it because for hppa:
>>
>>   (* 8 128 2) =3D 2048
>>
>> Anyway:
>>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> > +
>> > +    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, len);
>> > +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
>> > +}
>> > +
>> >  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>> >  {
>> >      CPUState *cpu;
>> > @@ -1764,7 +1779,7 @@ static int gdb_handle_packet(GDBState *s, const =
char *line_buf)
>> >      CPUClass *cc;
>> >      const char *p;
>> >      uint32_t pid, tid;
>> > -    int ch, reg_size, type, res;
>> > +    int ch, type, res;
>> >      uint8_t mem_buf[MAX_PACKET_LENGTH];
>> >      char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
>> >      char thread_id[16];
>> > @@ -1923,14 +1938,14 @@ static int gdb_handle_packet(GDBState *s, cons=
t char *line_buf)
>> >          }
>> >          break;
>> >      case 'g':
>> > -        cpu_synchronize_state(s->g_cpu);
>> > -        len =3D 0;
>> > -        for (addr =3D 0; addr < s->g_cpu->gdb_num_g_regs; addr++) {
>> > -            reg_size =3D gdb_read_register(s->g_cpu, mem_buf + len, a=
ddr);
>> > -            len +=3D reg_size;
>> > +        {
>> > +            static const GdbCmdParseEntry read_all_regs_cmd_desc =3D {
>> > +                .handler =3D handle_read_all_regs,
>> > +                .cmd =3D "g",
>> > +                .cmd_startswith =3D 1
>> > +            };
>> > +            cmd_parser =3D &read_all_regs_cmd_desc;
>> >          }
>> > -        memtohex(buf, mem_buf, len);
>> > -        put_packet(s, buf);
>> >          break;
>> >      case 'G':
>> >          {
>>
>>
>> --
>> Alex Benn=C3=A9e


--
Alex Benn=C3=A9e

