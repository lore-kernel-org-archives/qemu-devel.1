Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EADC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3BB2081C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Az8Schi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3BB2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58752 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJfbP-0002VI-J7
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 10:43:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJfaT-00022Q-83
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:42:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJfaR-0002aV-Sd
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:42:57 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hJfaR-0002Zo-IZ
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:42:55 -0400
Received: by mail-wm1-x343.google.com with SMTP id y197so10987571wmd.0
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 07:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=eejksrFVtOPBTlFqyluj4TgFc0cE0CEAdvG1YBePgsk=;
	b=Az8Schi0xCRaQleBILvg5nj5DV29UNTrLDd3eNQIZeGFG3STA4ON5l4nhB0+CjQqQd
	1w7RrXRVr6R41Gd2lsgfIPT5J49S/KSAgbBok1zWeYjQwmFtXmMRnpq35QR2sNNM8FpT
	Q13VjUkZhtJLHYyuxsTH42NTBe7Au6R+oFipYB6HmL/zRLF5nhG9mMBCSaSEyp2lw2Px
	SoPPQK9KPYNqAoGZIkA1+rDIuEusdgVFe+caHF67OJmUCqD49Bs+KYYYn735HzYqAJZh
	JDU+GyxUZqPCQ3MvLVxL1jA8zyd5mE8ug0gctaPGQ5IE0CBseZvguFO/p5u9V0mDtTkp
	9jIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=eejksrFVtOPBTlFqyluj4TgFc0cE0CEAdvG1YBePgsk=;
	b=i3PIjDahrUKehblCfmaxVtmiameYikcDfqzKExUgl2YPisV6AEAPcKnWbfctOKBYRs
	qyVLCGw2z+UgPti/SwE9iFf2wvhCBlvvaLSALio8xjmJu0ADpwLn+OB56PUadpGiLIes
	H06M7mqMeiErJDnGgLeM1Vxt0ua5Wy+4s01ygI6NKxayGMypbc8hP6+n9VvDPrnCC3IN
	xGIlTROKxi1AATCM0HkVEgKNEjDgwQmE9Sv42AjlobGLDHol8AP9rHr1c217osgoNXpQ
	P//dJ85AyLRG2EP0axnmF05wD+pPwZmKlvaUlp6PrEYjFEISdcsHJRWP7jC/vA5/zIPu
	ARZQ==
X-Gm-Message-State: APjAAAVv2KhTmj/YHFX/0fIraQpEpzaJGV0vT/2WLHtUZ0w3LaHGxxs2
	k+KWvGzBdv0uV0ExZJaFCY4n/g==
X-Google-Smtp-Source: APXvYqzGqXgk2IHpqv6Ky526vAGO8ex6R1rRjqihyz44J9IBg0aLJ21Q9q9dE+MrwabnI+n22AaGeA==
X-Received: by 2002:a7b:c054:: with SMTP id u20mr4101336wmc.100.1556203374306; 
	Thu, 25 Apr 2019 07:42:54 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	v192sm21951782wme.24.2019.04.25.07.42.53
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 07:42:53 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 363CC1FF87;
	Thu, 25 Apr 2019 15:42:53 +0100 (BST)
References: <20190424142714.28460-1-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190424142714.28460-1-arilou@gmail.com>
Date: Thu, 25 Apr 2019 15:42:53 +0100
Message-ID: <87wojiuowi.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425144253.wGtEebx_Y4rHi4ikpoRNO4LwhOdhcKT99u8YQLouY74@z>


arilou@gmail.com writes:

> From: Jon Doron <arilou@gmail.com>
>
> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  gdbstub.c | 215 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 215 insertions(+)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index d54abd17cc..b5bd01b913 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1268,6 +1268,221 @@ out:
>      return res;
>  }
>
> +typedef union GdbCmdVariant {
> +    const char *data;
> +    uint8_t opcode;
> +    unsigned long val_ul;
> +    unsigned long long val_ull;
> +    struct {
> +        GDBThreadIdKind kind;
> +        uint32_t pid;
> +        uint32_t tid;
> +    } thread_id;
> +} GdbCmdVariant;
> +
> +static const char *cmd_next_param(const char *param, const char delimite=
r)
> +{
> +    const char *delim;
> +    static char all_delimiters[] =3D ",;:=3D";
> +    static char no_delimiter[] =3D "\0";
> +    char curr_delimiters[2] =3D {0};
> +    const char *delimiters;
> +
> +    if (delimiter =3D=3D '?') {
> +        delimiters =3D all_delimiters;
> +    } else if (delimiter =3D=3D '0') {
> +        delimiters =3D no_delimiter;
> +    } else if (delimiter =3D=3D '.' && *param) {
> +        return param + 1;
> +    } else {
> +        curr_delimiters[0] =3D delimiter;
> +        delimiters =3D curr_delimiters;
> +    }
> +
> +    while (*param) {
> +        delim =3D delimiters;
> +        while (*delim) {
> +            if (*param =3D=3D *delim) {
> +                return param + 1;
> +            }
> +            delim++;
> +        }
> +        param++;
> +    }
> +
> +    return param;
> +}
> +
> +static int cmd_parse_params(const char *data, const char *schema,
> +                            GdbCmdVariant *params, int *num_params)
> +{
> +    int curr_param;
> +    const char *curr_schema, *curr_data;
> +
> +    *num_params =3D 0;
> +
> +    if (!schema) {
> +        return 0;
> +    }
> +
> +    curr_schema =3D schema;
> +    curr_param =3D 0;
> +    curr_data =3D data;
> +    while (curr_schema[0] && curr_schema[1] && *curr_data) {
> +        switch (curr_schema[0]) {
> +        case 'l':
> +            if (qemu_strtoul(curr_data, &curr_data, 16,
> +                             &params[curr_param].val_ul)) {
> +                return -EINVAL;
> +            }
> +            curr_param++;
> +            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
> +            break;
> +        case 'L':
> +            if (qemu_strtou64(curr_data, &curr_data, 16,
> +                              (uint64_t *)&params[curr_param].val_ull)) {
> +                return -EINVAL;
> +            }
> +            curr_param++;
> +            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
> +            break;
> +        case 's':
> +            params[curr_param].data =3D curr_data;
> +            curr_param++;
> +            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
> +            break;
> +        case 'o':
> +            params[curr_param].opcode =3D *(uint8_t *)curr_data;
> +            curr_param++;
> +            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
> +            break;
> +        case 't':
> +            params[curr_param].thread_id.kind =3D
> +                read_thread_id(curr_data, &curr_data,
> +                               &params[curr_param].thread_id.pid,
> +                               &params[curr_param].thread_id.tid);
> +            curr_param++;
> +            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
> +            break;
> +        case 'x':
> +            params[curr_param].data =3D curr_data;
> +            curr_param++;
> +            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
> +            break;
> +        case '?':
> +            curr_data =3D cmd_next_param(curr_data, curr_schema[1]);
> +            break;
> +        default:
> +            return -EINVAL;
> +        }
> +        curr_schema +=3D 2;
> +    }
> +
> +    *num_params =3D curr_param;
> +    return 0;
> +}
> +
> +typedef struct GdbCmdContext {
> +    GDBState *s;
> +    GdbCmdVariant *params;
> +    int num_params;
> +    uint8_t mem_buf[MAX_PACKET_LENGTH];
> +    char str_buf[MAX_PACKET_LENGTH + 1];
> +} GdbCmdContext;
> +
> +typedef void (*GdbCmdHandler)(GdbCmdContext *gdb_ctx, void *user_ctx);
> +
> +/*
> + * cmd_startswith -> cmd is compared using startswith
> + * cmd_full_match -> cmd is compared using strcmp

Doesn't !cmd_full_match imply cmd_startswith?

> + *
> + *
> + * schema definitions:
> + * Each schema parameter entry consists of 2 chars,
> + * the first char represents the parameter type handling
> + * the second char represents the delimiter for the next parameter
> + *
> + * Currently supported schema types:
> + * 'l' -> unsigned long (stored in .val_ul)
> + * 'L' -> unsigned long long (stored in .val_ull)
> + * 's' -> string (stored in .data)
> + * 'o' -> single char (stored in .opcode)
> + * 't' -> thread id (stored in .thread_id)
> + * 'x' -> xml (stored in .data), must have a ':' delimiter
> + * '?' -> skip according to delimiter
> + *
> + * Currently supported delimiters:
> + * '?' -> Stop at any delimiter (",;:=3D\0")
> + * '0' -> Stop at "\0"
> + * '.' -> Skip 1 char unless reached "\0"
> + * Any other value is treated as the delimiter value itself
> + */
> +typedef struct GdbCmdParseEntry {
> +    GdbCmdHandler handler;
> +    const char *cmd;
> +    union {
> +        int flags;
> +        struct {
> +            int cmd_startswith:1;
> +            int cmd_full_match:1;
> +        };
> +    };
> +    const char *schema;
> +} GdbCmdParseEntry;
> +
> +static inline int startswith(const char *string, const char *pattern)
> +{
> +  return !strncmp(string, pattern, strlen(pattern));
> +}
> +
> +__attribute__((unused)) static int process_string_cmd(
> +        GDBState *s, void *user_ctx, const char *data,
> +        GdbCmdParseEntry *cmds, int num_cmds);
> +
> +static int process_string_cmd(GDBState *s, void *user_ctx, const char *d=
ata,
> +                              GdbCmdParseEntry *cmds, int num_cmds)
> +{
> +    int i, schema_len, max_num_params;
> +    GdbCmdContext gdb_ctx;
> +
> +    if (!cmds) {
> +        return -1;
> +    }
> +
> +    for (i =3D 0; i < num_cmds; i++) {

Allocating:

        GdbCmdParseEntry *cmd =3D &cmds[i];

might make the remaining code a little simpler to deal with.


> +        if (!cmds[i].handler || !cmds[i].cmd ||

Some of these seem like asserts:

        g_assert(cmd->handler && cmd->cmd);

> +            (cmds[i].cmd_startswith && !startswith(data, cmds[i].cmd)) ||
> +            (cmds[i].cmd_full_match && strcmp(data, cmds[i].cmd))) {

then we can have the skip test:

        if (cmd->cmd_startswith && !startswith(data, cmd->cmd)) {
            continue;
        } else if (strcmp(cmd->cmd, data)!=3D0) {
            continue;
        }


> +            continue;
> +        }
> +
> +        max_num_params =3D 0;

You can set the default when you declare this above

> +        if (cmds[i].schema) {
> +            schema_len =3D strlen(cmds[i].schema);
> +            if (schema_len % 2) {
> +                return -2;
> +            }
> +
> +            max_num_params =3D schema_len / 2;
> +        }
> +
> +        gdb_ctx.params =3D
> +            (GdbCmdVariant *)alloca(sizeof(*gdb_ctx.params) * max_num_pa=
rams);
> +        memset(gdb_ctx.params, 0, sizeof(*gdb_ctx.params) *
> max_num_params);

You could use the glib function instead:

  gdb_ctx.params =3D g_newa(GdbCmdVariant, max_num_params);

Although you still have to zero it which you could avoid with a g_new0()
but you'd then have to free the pointer later. Parsing code is fiddly I
guess...

> +
> +        if (cmd_parse_params(&data[strlen(cmds[i].cmd)],
> cmds[i].schema,

Is the strlen appropriate if we have cmd_startswith?

> +                             gdb_ctx.params, &gdb_ctx.num_params)) {
> +            return -1;
> +        }
> +
> +        gdb_ctx.s =3D s;
> +        cmds[i].handler(&gdb_ctx, user_ctx);
> +        return 0;
> +    }
> +
> +    return -1;
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;


--
Alex Benn=C3=A9e

