Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E5DC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 10:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47E4D21726
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 10:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gn+kKRLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E4D21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46754 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSJHS-0001j2-JO
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 06:43:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hSJGg-0001Q6-Us
	for qemu-devel@nongnu.org; Sun, 19 May 2019 06:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hSJGf-0004oI-UZ
	for qemu-devel@nongnu.org; Sun, 19 May 2019 06:42:14 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:46372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hSJGf-0004mY-OD
	for qemu-devel@nongnu.org; Sun, 19 May 2019 06:42:13 -0400
Received: by mail-ed1-x541.google.com with SMTP id f37so18654710edb.13
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 03:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Sy64OA/XY3mCarBpfadd1tYVlBo1at/mMAIA6izytCM=;
	b=Gn+kKRLm0QBn6f2N1BbcMpMH2HrO/095kqhMw2/2VxI9qlMacMg7TFn4Mjewu4lxq1
	WRoqsqkTk569zdButo4Ih6cqn5o1WiaGovapl3BRdo9CTuqAdOaMhN3mLns+BZEZoA4/
	leM4qt0ReEzW7K3xVhNFgCFInFOPZa/AI00rqgAD3trbs7m6QSw4IwvI8AaUMlyrMJx+
	pyMQGu9lDSQ/EdN+jmYE4vsYtMvVEJLMrCknDuXy4HryOef7JT9ZGRk9+x7jP7ZBm6HN
	64vckuR7e3dfok5wX+0dX23M2sCDxjdkzjiO+XXLd3ofV31+BXVYje1ZI4FUArslhRre
	Cmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=Sy64OA/XY3mCarBpfadd1tYVlBo1at/mMAIA6izytCM=;
	b=H9alX2xZ/iJGdH+txeC4hQWF2HiwxNPAA+kzAoS3yvWoZ5qwK9/bvI/KmuQ7flM+mE
	Fc960RJpdxGh9RF4rAWVXxdttNM2/jLXegM702jYLF1aZhnVOFzV1c3sw3lYt/6eKwpV
	azyVSdmAFHDpZ0RikLfWtKvbOLAQ8MazBvcVbIju5ulXUXdYkWVUjVFphHqiz3t4fLk9
	QKkWbz/D1SrScG0lqxTZnXGyqi1ueKvuAmtWArmYh/IzLXKayBRZq54kluNis5dFc8nP
	zXl/W16egyTALj8j+Nxa+gUBiMqSiYSC2QJG9+OeONYTCScpvmBmauJYWSBj22dJg0gY
	Q1jg==
X-Gm-Message-State: APjAAAXHWPKtJhxC3pmjVQJJ1OTF3oMjw7jRSMzsA6H8uDktwWuPga/+
	tzsWVUAJLE7XlojFJWIm+hO4hRXHVQ7+6uVQCCc=
X-Google-Smtp-Source: APXvYqzA0ivCreg5GTemh555VNuxw9sAo3r+LJ7C4W7PH9UO43/OSw0ZSsYZsxMoGFgYz3Ok766KfN9P4LMgHGxUUOc=
X-Received: by 2002:a50:9177:: with SMTP id f52mr69879606eda.18.1558262531930; 
	Sun, 19 May 2019 03:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-15-arilou@gmail.com>
	<87lfz7n1f5.fsf@zen.linaroharston>
In-Reply-To: <87lfz7n1f5.fsf@zen.linaroharston>
From: Jon Doron <arilou@gmail.com>
Date: Sun, 19 May 2019 13:42:01 +0300
Message-ID: <CAP7QCogdQDx1t=u6U_NkYspzQCTLJAR-jmA=6mXKUv2v+PJNXw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::541
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

I agree but I guess to really fix it we need to change
gdb_read_register implementation to support returning the size of the
register for mem_buffer =3D NULL
Let's leave it for another patchset?

On Wed, May 15, 2019 at 7:10 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Jon Doron <arilou@gmail.com> writes:
>
> > Signed-off-by: Jon Doron <arilou@gmail.com>
> > ---
> >  gdbstub.c | 31 +++++++++++++++++++++++--------
> >  1 file changed, 23 insertions(+), 8 deletions(-)
> >
> > diff --git a/gdbstub.c b/gdbstub.c
> > index adfe39b3a3..3478ac778d 100644
> > --- a/gdbstub.c
> > +++ b/gdbstub.c
> > @@ -1757,6 +1757,21 @@ static void handle_write_all_regs(GdbCmdContext =
*gdb_ctx, void *user_ctx)
> >      put_packet(gdb_ctx->s, "OK");
> >  }
> >
> > +static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ct=
x)
> > +{
> > +    target_ulong addr, len;
> > +
> > +    cpu_synchronize_state(gdb_ctx->s->g_cpu);
> > +    len =3D 0;
> > +    for (addr =3D 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs; addr++)=
 {
> > +        len +=3D gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf=
 + len,
> > +                                 addr);
> > +    }
>
> Again no bounds checking - we get away with it because for hppa:
>
>   (* 8 128 2) =3D 2048
>
> Anyway:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> > +
> > +    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, len);
> > +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
> > +}
> > +
> >  static int gdb_handle_packet(GDBState *s, const char *line_buf)
> >  {
> >      CPUState *cpu;
> > @@ -1764,7 +1779,7 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
> >      CPUClass *cc;
> >      const char *p;
> >      uint32_t pid, tid;
> > -    int ch, reg_size, type, res;
> > +    int ch, type, res;
> >      uint8_t mem_buf[MAX_PACKET_LENGTH];
> >      char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
> >      char thread_id[16];
> > @@ -1923,14 +1938,14 @@ static int gdb_handle_packet(GDBState *s, const=
 char *line_buf)
> >          }
> >          break;
> >      case 'g':
> > -        cpu_synchronize_state(s->g_cpu);
> > -        len =3D 0;
> > -        for (addr =3D 0; addr < s->g_cpu->gdb_num_g_regs; addr++) {
> > -            reg_size =3D gdb_read_register(s->g_cpu, mem_buf + len, ad=
dr);
> > -            len +=3D reg_size;
> > +        {
> > +            static const GdbCmdParseEntry read_all_regs_cmd_desc =3D {
> > +                .handler =3D handle_read_all_regs,
> > +                .cmd =3D "g",
> > +                .cmd_startswith =3D 1
> > +            };
> > +            cmd_parser =3D &read_all_regs_cmd_desc;
> >          }
> > -        memtohex(buf, mem_buf, len);
> > -        put_packet(s, buf);
> >          break;
> >      case 'G':
> >          {
>
>
> --
> Alex Benn=C3=A9e

