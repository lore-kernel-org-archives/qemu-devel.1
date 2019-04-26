Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB96C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08CC2077B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="thHrJVsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08CC2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38904 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJsN1-0001U6-Ut
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 00:21:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsME-00017v-Kx
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsMD-0001An-3O
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:21:06 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:44976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsMC-0001AE-RS
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:21:05 -0400
Received: by mail-vs1-xe42.google.com with SMTP id j184so1159335vsd.11
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=xB4p+Gk4SpUtsTpZ9uN70z+EfyDfX5GZORKupEH00JI=;
	b=thHrJVsl4tRS7KaqJglhcGUMo234DElqbam12+ieyMIYWTgTLh6T3aDtKzlrbJubhF
	V8ggAPZzh/jr2xOYXN9tvf/R2KKrKvXct/zeYYindSMtZqVosgxF2kohHQ9umNGFqjAQ
	YTv21Z+t3ZXKf60NaUGPQnvpWGpHq2IkaXGF1NVMxceRAxwyiwaNxG2XLnik8QOsr4/9
	Qv4U9IYWfo2df9tIHSkmqnPRXcEouiYHgB5euld8yL5CFVdO1DU8VRWt29war4YZJIFk
	6jJwiL5ohkIltifj88IlEWspMYO9/N/jsW/vmqPYpwBhuCns3n8q+pxTuZTfrwZXqkcS
	s2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=xB4p+Gk4SpUtsTpZ9uN70z+EfyDfX5GZORKupEH00JI=;
	b=ELTbZgglDw2vnjHUtTalOEbe7smT7JISLGPPwsO2X2fqGfV74qxAjOv7YhYa7pGX1a
	/2Y35KpEaJvDDVh6Y/3aL5uKSZ1hrIp8SFZiJypWpnJJ+4Q0Rw8na/kiM97Tyk895d70
	n6hfInz6Fv3tAYNanBXhj7Yeb2YWtfERpc2Jbujk+un2v1LXn0dKZDwCT3kkd1OJ2MAG
	r7J3HxENVzkEOKcuH8VBZOIQk91F7Mr/ZcA0rFtSGq439KNZgkUjLsTNYv++wmlnxxh8
	Btg3kE5Cs9Njg1zv6TmrUMbIegQKV1wDXFj86b/wjmPM/nvheQ7VcoNMD67FmrOgEYDs
	G8lw==
X-Gm-Message-State: APjAAAX8TF4BuqX8GkV001p8ySaXugblRvrOmXoU7zU+mjCPMQlpH1Yg
	uTnLENHhy8TMC4KD8r8Qjd2tOw53W3XkhC9umc4=
X-Google-Smtp-Source: APXvYqxnvB5x15uDTD7ioSqRceI6ZqCsPBYnKJV6ezmFdgX4JUk1fYiVlMx4QjmD07iZx1+nko9WfnAvTk4ZRRfPcgE=
X-Received: by 2002:a67:b106:: with SMTP id w6mr23714182vsl.16.1556252463787; 
	Thu, 25 Apr 2019 21:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190424142714.28460-1-arilou@gmail.com>
	<87wojiuowi.fsf@zen.linaroharston>
In-Reply-To: <87wojiuowi.fsf@zen.linaroharston>
From: Jon Doron <arilou@gmail.com>
Date: Fri, 26 Apr 2019 07:20:52 +0300
Message-ID:
 <CAP7QCoh7a+YQ_99J=bFXK+PWRcTCDVGZfmhKZmgtSxmJHbaEvA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e42
Subject: Re: [Qemu-devel] [PATCH v3 01/20] gdbstub: Add infrastructure to
 parse cmd packets
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
Message-ID: <20190426042052.3X5i8DOUenSeF2uJ3lm9IklD_bPeO1jaEi5T0CiHuCc@z>

Thank you Alex I will publish v8 with fixes from your review :) please
see my comments below

On Thu, Apr 25, 2019 at 5:42 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> arilou@gmail.com writes:
>
> > From: Jon Doron <arilou@gmail.com>
> >
> > Signed-off-by: Jon Doron <arilou@gmail.com>
> > ---
> >  gdbstub.c | 215 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 215 insertions(+)
> >
> > diff --git a/gdbstub.c b/gdbstub.c
> > index d54abd17cc..b5bd01b913 100644
> > --- a/gdbstub.c
> > +++ b/gdbstub.c
> > @@ -1268,6 +1268,221 @@ out:
> >      return res;
> >  }
> >
> > +typedef union GdbCmdVariant {
> > +    const char *data;
> > +    uint8_t opcode;
> > +    unsigned long val_ul;
> > +    unsigned long long val_ull;
> > +    struct {
> > +        GDBThreadIdKind kind;
> > +        uint32_t pid;
> > +        uint32_t tid;
> > +    } thread_id;
> > +} GdbCmdVariant;
> > +
> > +static const char *cmd_next_param(const char *param, const char delimi=
ter)
> > +{
> > +    const char *delim;
> > +    static char all_delimiters[] =3D ",;:=3D";
> > +    static char no_delimiter[] =3D "\0";
> > +    char curr_delimiters[2] =3D {0};
> > +    const char *delimiters;
> > +
> > +    if (delimiter =3D=3D '?') {
> > +        delimiters =3D all_delimiters;
> > +    } else if (delimiter =3D=3D '0') {
> > +        delimiters =3D no_delimiter;
> > +    } else if (delimiter =3D=3D '.' && *param) {
> > +        return param + 1;
> > +    } else {
> > +        curr_delimiters[0] =3D delimiter;
> > +        delimiters =3D curr_delimiters;
> > +    }
> > +
> > +    while (*param) {
> > +        delim =3D delimiters;
> > +        while (*delim) {
> > +            if (*param =3D=3D *delim) {
> > +                return param + 1;
> > +            }
> > +            delim++;
> > +        }
> > +        param++;
> > +    }
> > +
> > +    return param;
> > +}
> > +
> > +static int cmd_parse_params(const char *data, const char *schema,
> > +                            GdbCmdVariant *params, int *num_params)
> > +{
> > +    int curr_param;
> > +    const char *curr_schema, *curr_data;
> > +
> > +    *num_params =3D 0;
> > +
> > +    if (!schema) {
> > +        return 0;
> > +    }
> > +
> > +    curr_schema =3D schema;
> > +    curr_param =3D 0;
> > +    curr_data =3D data;
> > +    while (curr_schema[0] && curr_schema[1] && *curr_data) {
> > +        switch (curr_schema[0]) {
> > +        case 'l':
> > +            if (qemu_strtoul(curr_data, &curr_data, 16,
> > +                             &params[curr_param].val_ul)) {
> > +                return -EINVAL;
> > +            }
> > +            curr_param++;
> > +            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
> > +            break;
> > +        case 'L':
> > +            if (qemu_strtou64(curr_data, &curr_data, 16,
> > +                              (uint64_t *)&params[curr_param].val_ull)=
) {
> > +                return -EINVAL;
> > +            }
> > +            curr_param++;
> > +            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
> > +            break;
> > +        case 's':
> > +            params[curr_param].data =3D curr_data;
> > +            curr_param++;
> > +            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
> > +            break;
> > +        case 'o':
> > +            params[curr_param].opcode =3D *(uint8_t *)curr_data;
> > +            curr_param++;
> > +            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
> > +            break;
> > +        case 't':
> > +            params[curr_param].thread_id.kind =3D
> > +                read_thread_id(curr_data, &curr_data,
> > +                               &params[curr_param].thread_id.pid,
> > +                               &params[curr_param].thread_id.tid);
> > +            curr_param++;
> > +            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
> > +            break;
> > +        case 'x':
> > +            params[curr_param].data =3D curr_data;
> > +            curr_param++;
> > +            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
> > +            break;
> > +        case '?':
> > +            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
> > +            break;
> > +        default:
> > +            return -EINVAL;
> > +        }
> > +        curr_schema +=3D 2;
> > +    }
> > +
> > +    *num_params =3D curr_param;
> > +    return 0;
> > +}
> > +
> > +typedef struct GdbCmdContext {
> > +    GDBState *s;
> > +    GdbCmdVariant *params;
> > +    int num_params;
> > +    uint8_t mem_buf[MAX_PACKET_LENGTH];
> > +    char str_buf[MAX_PACKET_LENGTH + 1];
> > +} GdbCmdContext;
> > +
> > +typedef void (*GdbCmdHandler)(GdbCmdContext *gdb_ctx, void *user_ctx);
> > +
> > +/*
> > + * cmd_startswith -> cmd is compared using startswith
> > + * cmd_full_match -> cmd is compared using strcmp
>
> Doesn't !cmd_full_match imply cmd_startswith?

Done

>
> > + *
> > + *
> > + * schema definitions:
> > + * Each schema parameter entry consists of 2 chars,
> > + * the first char represents the parameter type handling
> > + * the second char represents the delimiter for the next parameter
> > + *
> > + * Currently supported schema types:
> > + * 'l' -> unsigned long (stored in .val_ul)
> > + * 'L' -> unsigned long long (stored in .val_ull)
> > + * 's' -> string (stored in .data)
> > + * 'o' -> single char (stored in .opcode)
> > + * 't' -> thread id (stored in .thread_id)
> > + * 'x' -> xml (stored in .data), must have a ':' delimiter
> > + * '?' -> skip according to delimiter
> > + *
> > + * Currently supported delimiters:
> > + * '?' -> Stop at any delimiter (",;:=3D\0")
> > + * '0' -> Stop at "\0"
> > + * '.' -> Skip 1 char unless reached "\0"
> > + * Any other value is treated as the delimiter value itself
> > + */
> > +typedef struct GdbCmdParseEntry {
> > +    GdbCmdHandler handler;
> > +    const char *cmd;
> > +    union {
> > +        int flags;
> > +        struct {
> > +            int cmd_startswith:1;
> > +            int cmd_full_match:1;
> > +        };
> > +    };
> > +    const char *schema;
> > +} GdbCmdParseEntry;
> > +
> > +static inline int startswith(const char *string, const char *pattern)
> > +{
> > +  return !strncmp(string, pattern, strlen(pattern));
> > +}
> > +
> > +__attribute__((unused)) static int process_string_cmd(
> > +        GDBState *s, void *user_ctx, const char *data,
> > +        GdbCmdParseEntry *cmds, int num_cmds);
> > +
> > +static int process_string_cmd(GDBState *s, void *user_ctx, const char =
*data,
> > +                              GdbCmdParseEntry *cmds, int num_cmds)
> > +{
> > +    int i, schema_len, max_num_params;
> > +    GdbCmdContext gdb_ctx;
> > +
> > +    if (!cmds) {
> > +        return -1;
> > +    }
> > +
> > +    for (i =3D 0; i < num_cmds; i++) {
>
> Allocating:
>
>         GdbCmdParseEntry *cmd =3D &cmds[i];
>
> might make the remaining code a little simpler to deal with.
>
>

Done

> > +        if (!cmds[i].handler || !cmds[i].cmd ||
>
> Some of these seem like asserts:
>
>         g_assert(cmd->handler && cmd->cmd);
>
> > +            (cmds[i].cmd_startswith && !startswith(data, cmds[i].cmd))=
 ||
> > +            (cmds[i].cmd_full_match && strcmp(data, cmds[i].cmd))) {
>
> then we can have the skip test:
>
>         if (cmd->cmd_startswith && !startswith(data, cmd->cmd)) {
>             continue;
>         } else if (strcmp(cmd->cmd, data)!=3D0) {
>             continue;
>         }
>
>

Done

> > +            continue;
> > +        }
> > +
> > +        max_num_params =3D 0;
>
> You can set the default when you declare this above
>

Done but I figured it would be nicer to only initialize when required...

> > +        if (cmds[i].schema) {
> > +            schema_len =3D strlen(cmds[i].schema);
> > +            if (schema_len % 2) {
> > +                return -2;
> > +            }
> > +
> > +            max_num_params =3D schema_len / 2;
> > +        }
> > +
> > +        gdb_ctx.params =3D
> > +            (GdbCmdVariant *)alloca(sizeof(*gdb_ctx.params) * max_num_=
params);
> > +        memset(gdb_ctx.params, 0, sizeof(*gdb_ctx.params) *
> > max_num_params);
>
> You could use the glib function instead:
>
>   gdb_ctx.params =3D g_newa(GdbCmdVariant, max_num_params);
>
> Although you still have to zero it which you could avoid with a g_new0()
> but you'd then have to free the pointer later. Parsing code is fiddly I
> guess...
>

Stayed with _alloca for now unless you really want me to change...

> > +
> > +        if (cmd_parse_params(&data[strlen(cmds[i].cmd)],
> > cmds[i].schema,
>
> Is the strlen appropriate if we have cmd_startswith?
>

Well yes, because you want to skip the "cmd" part and get straight to
the parameters, the strlen is on the cmd string
only, i.e: Maddr,length:XX=E2=80=A6
the command is "M" and you want to only skip the M and get to the parameter=
s

> > +                             gdb_ctx.params, &gdb_ctx.num_params)) {
> > +            return -1;
> > +        }
> > +
> > +        gdb_ctx.s =3D s;
> > +        cmds[i].handler(&gdb_ctx, user_ctx);
> > +        return 0;
> > +    }
> > +
> > +    return -1;
> > +}
> > +
> >  static int gdb_handle_packet(GDBState *s, const char *line_buf)
> >  {
> >      CPUState *cpu;
>
>
> --
> Alex Benn=C3=A9e

