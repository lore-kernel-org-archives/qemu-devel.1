Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A56FC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 14:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2B021726
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 14:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQyFc0Gb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2B021726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49749 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSNDj-0002bO-Sz
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 10:55:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hSNCo-0002Gw-0F
	for qemu-devel@nongnu.org; Sun, 19 May 2019 10:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hSNCm-0006qE-Pb
	for qemu-devel@nongnu.org; Sun, 19 May 2019 10:54:29 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hSNCm-0006oV-CF
	for qemu-devel@nongnu.org; Sun, 19 May 2019 10:54:28 -0400
Received: by mail-wm1-x342.google.com with SMTP id j187so10587431wmj.1
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=n0+z0a8CngaR48skqyfqp+w31k6UjMTHpUzG7doFXn0=;
	b=mQyFc0GbBGtL2ZEQJk0ayrrc3LSrqhNFKtG8eegeOiZG6FzGX5zHEf/1Pmyp8f52cE
	gnzEYMznwHNuo98q+XibxpuEUP2pkwU+/PZIPa6R+vQDSkZjMNqI+qlqdx1bkY1pBuGV
	u0gK9IIxMV64aE4XX3xDxafeOJ/WEg9fMgZUJRa1V2a+61WmMJyS1TaYxgXVHZ/jwQeP
	FYFrsl7V3SKlS/CX8tFiLIu1sxFmYv0JpKxV06LIomvFZ/d2kyGz8KCdaMbGlBVWsdiD
	qIQnogE+emK7QUG4pUwoPVGfrrvmiA1CWC+BoFo8+j4M/pASxqwD8dVDSRTzMTnPY0F1
	Kvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=n0+z0a8CngaR48skqyfqp+w31k6UjMTHpUzG7doFXn0=;
	b=T47ttehounBmzyNOAINXddCqN5HRBJiLnhOGfhdUZIvFyVD87LHD7qPzIF+VADZIUU
	9sdMO8bls7tEmhbQt+3yU8sF6WUvTbxnpz9UMs4bbshF6zglha5C2YcDCXu6HTKJxBcw
	dF5YvsHEfRKcJw1ZbwymbuGTjkb/xi4QxipWKPAsH69PEqa6bgvxT77z+sUKStz+uAW7
	1W3hBvqvbdkEu7VTA0zQvT0RwBeHeM5IGW48gEULKVHnU5bwyN1VHRF2CcsLHP2lQ3rH
	vsYHgOMWMdWymtno3QDJt4xhr5zTl1EbYKFdl5mREvo63n+QPA76l6H5odn6nmvG5VrF
	dogA==
X-Gm-Message-State: APjAAAVEZkiPkhNLTEXbtW7ID1+o0r9EMp3Ox409pOOJ6KKIrjjV0QKd
	/UCt7UCevfyS3CsI2fmSxnevDw==
X-Google-Smtp-Source: APXvYqxk/FnXrWoKK8fRCEUyMc9/MMwZ0aiQTJ8uTVBcKaqT0fG7bQRxle4mY3UXfcChX13eMY49TA==
X-Received: by 2002:a1c:5f02:: with SMTP id t2mr9218143wmb.19.1558277665583;
	Sun, 19 May 2019 07:54:25 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	n4sm11453030wmk.24.2019.05.19.07.54.24
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sun, 19 May 2019 07:54:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 85DB41FF87;
	Sun, 19 May 2019 15:54:24 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-16-arilou@gmail.com>
	<87k1ermzec.fsf@zen.linaroharston>
	<CAP7QCoiqc+CAUiS0gNQbxKXOoAk7MvDvWpUkoMZxVK04NjBevg@mail.gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <CAP7QCoiqc+CAUiS0gNQbxKXOoAk7MvDvWpUkoMZxVK04NjBevg@mail.gmail.com>
Date: Sun, 19 May 2019 15:54:24 +0100
Message-ID: <87r28u5wbj.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v9 15/27] gdbstub: Implement file io (F
 pkt) with new infra
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

> Hi Alex, I did have some issues with the 'F' packet as it's not really
> well documented, I suggest changing the schema to:
> "L,L,o0"
> so basically no support for anything after the first C in the Ctrl-C,
> if you have a sample or a documentation that really implements
> the F packet fully ill take a look at it and see how the schema should
> really look like.

I'm only going by whats in the gdbdocs:

  https://sourceware.org/gdb/onlinedocs/gdb/The-F-Request-Packet.html#The-F=
-Request-Packet

>
> -- Jon.
>
> On Wed, May 15, 2019 at 7:54 PM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>>
>>
>> Jon Doron <arilou@gmail.com> writes:
>>
>> There is a bit more going on here than a simple conversion. I think we
>> need some additional commentary about the format of the data coming
>> back.
>>
>>
>> > Signed-off-by: Jon Doron <arilou@gmail.com>
>> > ---
>> >  gdbstub.c | 62 +++++++++++++++++++++++++++++++++++--------------------
>> >  1 file changed, 40 insertions(+), 22 deletions(-)
>> >
>> > diff --git a/gdbstub.c b/gdbstub.c
>> > index 3478ac778d..9fe130f30d 100644
>> > --- a/gdbstub.c
>> > +++ b/gdbstub.c
>> > @@ -1772,6 +1772,39 @@ static void handle_read_all_regs(GdbCmdContext =
*gdb_ctx, void *user_ctx)
>> >      put_packet(gdb_ctx->s, gdb_ctx->str_buf);
>> >  }
>> >
>> > +static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
>> > +{
>> > +    int num_syscall_params;
>> > +    GdbCmdVariant syscall_params[3] =3D {};
>> > +
>> > +    if (!gdb_ctx->num_params) {
>> > +        return;
>> > +    }
>> > +
>> > +    if (cmd_parse_params(gdb_ctx->params[0].data, "L,L,o0", syscall_p=
arams,
>> > +                         &num_syscall_params)) {
>> > +        return;
>> > +    }
>>
>> What's going on here? I thought the schema was meant to handle the
>> parsing of data. I see bellow we originally parse the command as a null
>> terminated string but we actually should handle:
>>
>>   =E2=80=98Fretcode,errno,Ctrl-C flag;call-specific attachment=E2=80=99
>>
>> I see the argument for dealing with the call-specific attachment here
>> but shouldn't the generic parsing code be able to split everything
>> apart?
>>
>> > +
>> > +    if (!num_syscall_params) {
>> > +        return;
>> > +    }
>> > +
>> > +    if (gdb_ctx->s->current_syscall_cb) {
>> > +        gdb_ctx->s->current_syscall_cb(gdb_ctx->s->c_cpu,
>> > +                                       (target_ulong)syscall_params[0=
].val_ull,
>> > +                                       (target_ulong)syscall_params[1=
].val_ull);
>> > +        gdb_ctx->s->current_syscall_cb =3D NULL;
>> > +    }
>>
>>
>>
>> > +
>> > +    if (syscall_params[2].opcode =3D=3D (uint8_t)'C') {
>> > +        put_packet(gdb_ctx->s, "T02");
>> > +        return;
>> > +    }
>> > +
>> > +    gdb_continue(gdb_ctx->s);
>> > +}
>> > +
>> >  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>> >  {
>> >      CPUState *cpu;
>> > @@ -1913,28 +1946,13 @@ static int gdb_handle_packet(GDBState *s, cons=
t char *line_buf)
>> >          return RS_IDLE;
>> >      case 'F':
>> >          {
>> > -            target_ulong ret;
>> > -            target_ulong err;
>> > -
>> > -            ret =3D strtoull(p, (char **)&p, 16);
>> > -            if (*p =3D=3D ',') {
>> > -                p++;
>> > -                err =3D strtoull(p, (char **)&p, 16);
>> > -            } else {
>> > -                err =3D 0;
>> > -            }
>> > -            if (*p =3D=3D ',')
>> > -                p++;
>> > -            type =3D *p;
>> > -            if (s->current_syscall_cb) {
>> > -                s->current_syscall_cb(s->c_cpu, ret, err);
>> > -                s->current_syscall_cb =3D NULL;
>> > -            }
>> > -            if (type =3D=3D 'C') {
>> > -                put_packet(s, "T02");
>> > -            } else {
>> > -                gdb_continue(s);
>> > -            }
>> > +            static const GdbCmdParseEntry file_io_cmd_desc =3D {
>> > +                .handler =3D handle_file_io,
>> > +                .cmd =3D "F",
>> > +                .cmd_startswith =3D 1,
>> > +                .schema =3D "s0"
>> > +            };
>> > +            cmd_parser =3D &file_io_cmd_desc;
>> >          }
>> >          break;
>> >      case 'g':
>>
>>
>> --
>> Alex Benn=C3=A9e


--
Alex Benn=C3=A9e

