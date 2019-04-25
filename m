Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EA2C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D585206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tRuOzZAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D585206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58907 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJfmV-0006yr-5Y
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 10:55:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJflJ-0006Om-Lu
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJflI-0002go-1f
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:54:09 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hJflH-0002eX-PY
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:54:07 -0400
Received: by mail-wm1-x343.google.com with SMTP id j13so9751600wmh.2
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 07:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=qawtHmyCUIHCAWR++c574txNmWTh1YcNgFiybx3OlO4=;
	b=tRuOzZAFHue3aJqfwj7KRl6OjJA0UtVK2LVYzk9Meil3CXl8+FvN35/GjTLi73i+n9
	1H8ggFhu31afcKksOKIrq/oPcsAlMKVtKdiAI0Jc1eL6MoZiDh6DqcYHjfFwQA2RP63B
	2t7GpdUxdSKbJHgUSStqhqUXqf3rC8P+JdnVZRWJcjPbF3ZaHHH9d4ZaPGo3rmyErs+b
	PZ0veyvFaiG9ZSV+U3vUWxOBn5MSQhi0NkPdCdP5FSDQowzg1jjCicIoq2YmMUO714Kq
	YRcw+NBx2aazgbXz95leef93qFQoxLy/6akF8pKJTHrRs1naL2wcyGoNWLlcHPNo+49e
	/Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=qawtHmyCUIHCAWR++c574txNmWTh1YcNgFiybx3OlO4=;
	b=oZE6HlleF1hfdF3JRV393yv0glz/A4zrcCytqwd31Q1ZJw0hutZs2K9UwMzMJ2zZaO
	tj7ziIh3uUaRxzvzem1/YuECdD/u+Jwjb8gb58vcYcfwM7RDkpbpmuEDqhO31ZX1vhl9
	tsLNe35t8E15ObfvupwUUZPRZgPKJ6KPf2twtYz86eLtc4EjXb86EXW4z87D7nI5c0mC
	CKuOTICdxWE+c28M13Bklr0JIlrCrmo03FpConLUxpJW4LgHftjluRLE92Lbje8P3LBz
	vGYOckTHsclkEriWtPP4ct+R20QoCQNemhFkMQLc6ajQUiCd+yGet+IQvcWNsqgAHHOJ
	daSA==
X-Gm-Message-State: APjAAAWvky/xp0+ANw8kRE66dn+kV1xSp2UTrMqozrCQSuhYOI6wtPSI
	FAz96B8R2ocgoNDy6po/zjGMoQ==
X-Google-Smtp-Source: APXvYqzpE6BM2mHxGLse6SfS+PTSwQ4u58n2X3x/uZBslzwKGRPyT5+9WQ8eAPQbyprS6QcfFaHu6Q==
X-Received: by 2002:a1c:9ad1:: with SMTP id c200mr4167501wme.140.1556204046450;
	Thu, 25 Apr 2019 07:54:06 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	g17sm11805618wrw.43.2019.04.25.07.54.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 07:54:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id A4DA01FF87;
	Thu, 25 Apr 2019 15:54:04 +0100 (BST)
References: <20190424142714.28460-1-arilou@gmail.com>
	<20190424142714.28460-20-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190424142714.28460-20-arilou@gmail.com>
Date: Thu, 25 Apr 2019 15:54:04 +0100
Message-ID: <87sgu6uodv.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v3 20/20] gdbstub: Refactor parse handle
 packet to work with a static array
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
Message-ID: <20190425145404.9La2lQU_Jli0rHR4KhskzdRfZ7saF4D4gddq1zmPyQs@z>


arilou@gmail.com writes:

> From: Jon Doron <arilou@gmail.com>
>
> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  gdbstub.c | 386 ++++++++++++++++++++++--------------------------------
>  1 file changed, 158 insertions(+), 228 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index c206a9a7c6..0ed9a91768 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -2263,240 +2263,170 @@ static void handle_gen_set(GdbCmdContext *gdb_c=
tx, void *user_ctx)
>      put_packet(gdb_ctx->s, "");
>  }
>
> -static int gdb_handle_packet(GDBState *s, const char *line_buf)
> +static void handle_extend_mode(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    put_packet(gdb_ctx->s, "OK");
> +}
> +
> +static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
>  {
> -    const char *p;
> -    int ch;
> -    uint8_t mem_buf[MAX_PACKET_LENGTH];
> -    char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
>      char thread_id[16];
>
> +    /* TODO: Make this return the correct value for user-mode.  */
> +    gdb_fmt_thread_id(gdb_ctx->s, gdb_ctx->s->c_cpu, thread_id,
> +                      sizeof(thread_id));
> +    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "T%02xthread:%s=
;",
> +             GDB_SIGNAL_TRAP, thread_id);
> +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
> +    /*
> +     * Remove all the breakpoints when this query is issued,
> +     * because gdb is doing and initial connect and the state
> +     * should be cleaned up.
> +     */
> +    gdb_breakpoint_remove_all();
> +}

This isn't a static conversion - this should be it's own patch.

> +
> +static void handle_kill(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    /* Kill the target */
> +    error_report("QEMU: Terminated via GDBstub");
> +    exit(0);
> +}
> +
> +static GdbCmdParseEntry gdb_packet_table[0x100] =3D {
> +    ['!'] =3D {
> +        .handler =3D handle_extend_mode,
> +        .cmd =3D "!",
> +        .cmd_startswith =3D 1
> +    },
> +    ['?'] =3D {
> +        .handler =3D handle_target_halt,
> +        .cmd =3D "?",
> +        .cmd_startswith =3D 1
> +    },
> +    ['c'] =3D {
> +        .handler =3D handle_continue,
> +        .cmd =3D "c",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "L0"
> +    },
> +    ['C'] =3D {
> +        .handler =3D handle_cont_with_sig,
> +        .cmd =3D "C",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "l0"
> +    },
> +    ['v'] =3D {
> +        .handler =3D handle_v_commands,
> +        .cmd =3D "v",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "s0"
> +    },
> +    ['k'] =3D {
> +        .handler =3D handle_kill,
> +        .cmd =3D "k",
> +        .cmd_startswith =3D 1
> +    },
> +    ['D'] =3D {
> +        .handler =3D handle_detach,
> +        .cmd =3D "D",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "?.l0"
> +    },
> +    ['s'] =3D {
> +        .handler =3D handle_step,
> +        .cmd =3D "s",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "L0"
> +    },
> +    ['F'] =3D {
> +        .handler =3D handle_file_io,
> +        .cmd =3D "F",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "s0"
> +    },
> +    ['g'] =3D {
> +        .handler =3D handle_read_all_regs,
> +        .cmd =3D "g",
> +        .cmd_startswith =3D 1
> +    },
> +    ['G'] =3D {
> +        .handler =3D handle_write_all_regs,
> +        .cmd =3D "G",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "s0"
> +    },
> +    ['m'] =3D {
> +        .handler =3D handle_read_mem,
> +        .cmd =3D "m",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "L,L0"
> +    },
> +    ['M'] =3D {
> +        .handler =3D handle_write_mem,
> +        .cmd =3D "M",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "L,L:s0"
> +    },
> +    ['p'] =3D {
> +        .handler =3D handle_get_reg,
> +        .cmd =3D "p",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "L0"
> +    },
> +    ['P'] =3D {
> +        .handler =3D handle_set_reg,
> +        .cmd =3D "P",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "L?s0"
> +    },
> +    ['Z'] =3D {
> +        .handler =3D handle_insert_bp,
> +        .cmd =3D "Z",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "l?L?L0"
> +    },
> +    ['z'] =3D {
> +        .handler =3D handle_remove_bp,
> +        .cmd =3D "z",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "l?L?L0"
> +    },
> +    ['H'] =3D {
> +        .handler =3D handle_set_thread,
> +        .cmd =3D "H",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "o.t0"
> +    },
> +    ['T'] =3D {
> +        .handler =3D handle_thread_alive,
> +        .cmd =3D "T",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "t0"
> +    },
> +    ['q'] =3D {
> +        .handler =3D handle_gen_query,
> +        .cmd =3D "q",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "s0"
> +    },
> +    ['Q'] =3D {
> +        .handler =3D handle_gen_set,
> +        .cmd =3D "Q",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "s0"
> +    },
> +};

But I agree with Richard that swapping a switch for a very sparse table
seems to be adding bloat for no useful gain.

> +
> +static int gdb_handle_packet(GDBState *s, const char *line_buf)
> +{
>      trace_gdbstub_io_command(line_buf);
>
> -    p =3D line_buf;
> -    ch =3D *p++;
> -    switch(ch) {
> -    case '!':
> -        put_packet(s, "OK");
> -        break;
> -    case '?':
> -        /* TODO: Make this return the correct value for user-mode.  */
> -        snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
> -                 gdb_fmt_thread_id(s, s->c_cpu, thread_id, sizeof(thread=
_id)));
> -        put_packet(s, buf);
> -        /* Remove all the breakpoints when this query is issued,
> -         * because gdb is doing and initial connect and the state
> -         * should be cleaned up.
> -         */
> -        gdb_breakpoint_remove_all();
> -        break;
> -    case 'c':
> -        {
> -            static GdbCmdParseEntry continue_cmd_desc =3D {
> -                .handler =3D handle_continue,
> -                .cmd =3D "c",
> -                .cmd_startswith =3D 1,
> -                .schema =3D "L0"
> -            };
> -            process_string_cmd(s, NULL, line_buf, &continue_cmd_desc, 1);
> -        }
> -        break;
> -    case 'C':
> -        {
> -            static GdbCmdParseEntry cont_with_sig_cmd_desc =3D {
> -                .handler =3D handle_cont_with_sig,
> -                .cmd =3D "C",
> -                .cmd_startswith =3D 1,
> -                .schema =3D "l0"
> -            };
> -            process_string_cmd(s, NULL, line_buf, &cont_with_sig_cmd_des=
c, 1);
> -        }
> -        break;
> -    case 'v':
> -        {
> -            static GdbCmdParseEntry v_cmd_desc =3D {
> -                .handler =3D handle_v_commands,
> -                .cmd =3D "v",
> -                .cmd_startswith =3D 1,
> -                .schema =3D "s0"
> -            };
> -            process_string_cmd(s, NULL, line_buf, &v_cmd_desc, 1);
> -        }
> -        break;
> -    case 'k':
> -        /* Kill the target */
> -        error_report("QEMU: Terminated via GDBstub");
> -        exit(0);
> -    case 'D':
> -        {
> -            static GdbCmdParseEntry deatch_cmd_desc =3D {
> -                .handler =3D handle_detach,
> -                .cmd =3D "D",
> -                .cmd_startswith =3D 1,
> -                .schema =3D "?.l0"
> -            };
> -            process_string_cmd(s, NULL, line_buf, &deatch_cmd_desc, 1);
> -        }
> -        break;
> -    case 's':
> -        {
> -            static GdbCmdParseEntry step_cmd_desc =3D {
> -                .handler =3D handle_step,
> -                .cmd =3D "s",
> -                .cmd_startswith =3D 1,
> -                .schema =3D "L0"
> -            };
> -            process_string_cmd(s, NULL, line_buf, &step_cmd_desc, 1);
> -        }
> -        break;
> -    case 'F':
> -        {
> -            static GdbCmdParseEntry file_io_cmd_desc =3D {
> -                .handler =3D handle_file_io,
> -                .cmd =3D "F",
> -                .cmd_startswith =3D 1,
> -                .schema =3D "s0"
> -            };
> -            process_string_cmd(s, NULL, line_buf, &file_io_cmd_desc, 1);
> -        }
> -        break;
> -    case 'g':
> -        {
> -            static GdbCmdParseEntry read_all_regs_cmd_desc =3D {
> -                .handler =3D handle_read_all_regs,
> -                .cmd =3D "g",
> -                .cmd_startswith =3D 1
> -            };
> -            process_string_cmd(s, NULL, line_buf, &read_all_regs_cmd_des=
c, 1);
> -        }
> -        break;
> -    case 'G':
> -        {
> -            static GdbCmdParseEntry write_all_regs_cmd_desc =3D {
> -                .handler =3D handle_write_all_regs,
> -                .cmd =3D "G",
> -                .cmd_startswith =3D 1,
> -                .schema =3D "s0"
> -            };
> -            process_string_cmd(s, NULL, line_buf, &write_all_regs_cmd_de=
sc, 1);
> -        }
> -        break;
> -    case 'm':
> -        {
> -            static GdbCmdParseEntry read_mem_cmd_desc =3D {
> -                .handler =3D handle_read_mem,
> -                .cmd =3D "m",
> -                .cmd_startswith =3D 1,
> -                .schema =3D "L,L0"
> -            };
> -            process_string_cmd(s, NULL, line_buf, &read_mem_cmd_desc, 1);
> -        }
> -        break;
> -    case 'M':
> -        {
> -            static GdbCmdParseEntry write_mem_cmd_desc =3D {
> -                .handler =3D handle_write_mem,
> -                .cmd =3D "M",
> -                .cmd_startswith =3D 1,
> -                .schema =3D "L,L:s0"
> -            };
> -            process_string_cmd(s, NULL, line_buf, &write_mem_cmd_desc, 1=
);
> -        }
> -        break;
> -    case 'p':
> -        {
> -            static GdbCmdParseEntry get_reg_cmd_desc =3D {
> -                .handler =3D handle_get_reg,
> -                .cmd =3D "p",
> -                .cmd_startswith =3D 1,
> -                .schema =3D "L0"
> -            };
> -            process_string_cmd(s, NULL, line_buf, &get_reg_cmd_desc, 1);
> -        }
> -        break;
> -    case 'P':
> -        {
> -            static GdbCmdParseEntry set_reg_cmd_desc =3D {
> -                .handler =3D handle_set_reg,
> -                .cmd =3D "P",
> -                .cmd_startswith =3D 1,
> -                .schema =3D "L?s0"
> -            };
> -            process_string_cmd(s, NULL, line_buf, &set_reg_cmd_desc, 1);
> -        }
> -        break;
> -    case 'Z':
> -        {
> -            static GdbCmdParseEntry insert_bp_cmd_desc =3D {
> -                .handler =3D handle_insert_bp,
> -                .cmd =3D "Z",
> -                .cmd_startswith =3D 1,
> -                .schema =3D "l?L?L0"
> -            };
> -            process_string_cmd(s, NULL, line_buf, &insert_bp_cmd_desc, 1=
);
> -        }
> -        break;
> -    case 'z':
> -        {
> -            static GdbCmdParseEntry remove_bp_cmd_desc =3D {
> -                .handler =3D handle_remove_bp,
> -                .cmd =3D "z",
> -                .cmd_startswith =3D 1,
> -                .schema =3D "l?L?L0"
> -            };
> -            process_string_cmd(s, NULL, line_buf, &remove_bp_cmd_desc, 1=
);
> -        }
> -        break;
> -    case 'H':
> -        {
> -            static GdbCmdParseEntry set_thread_cmd_desc =3D {
> -                .handler =3D handle_set_thread,
> -                .cmd =3D "H",
> -                .cmd_startswith =3D 1,
> -                .schema =3D "o.t0"
> -            };
> -            process_string_cmd(s, NULL, line_buf, &set_thread_cmd_desc, =
1);
> -        }
> -        break;
> -    case 'T':
> -        {
> -            static GdbCmdParseEntry thread_alive_cmd_desc =3D {
> -                .handler =3D handle_thread_alive,
> -                .cmd =3D "T",
> -                .cmd_startswith =3D 1,
> -                .schema =3D "t0"
> -            };
> -            process_string_cmd(s, NULL, line_buf, &thread_alive_cmd_desc=
, 1);
> -        }
> -        break;
> -    case 'q':
> -        {
> -            static GdbCmdParseEntry gen_query_cmd_desc =3D {
> -                .handler =3D handle_gen_query,
> -                .cmd =3D "q",
> -                .cmd_startswith =3D 1,
> -                .schema =3D "s0"
> -            };
> -            process_string_cmd(s, NULL, line_buf, &gen_query_cmd_desc, 1=
);
> -        }
> -        break;
> -    case 'Q':
> -        {
> -            static GdbCmdParseEntry gen_set_cmd_desc =3D {
> -                .handler =3D handle_gen_set,
> -                .cmd =3D "Q",
> -                .cmd_startswith =3D 1,
> -                .schema =3D "s0"
> -            };
> -            process_string_cmd(s, NULL, line_buf, &gen_set_cmd_desc, 1);
> -        }
> -        break;
> -    default:
> -        /* put empty packet */
> -        buf[0] =3D '\0';
> -        put_packet(s, buf);
> -        break;
> +    if (process_string_cmd(s, NULL, line_buf,
> +                           &gdb_packet_table[*(uint8_t *)line_buf], 1)) {
> +        put_packet(s, "");
>      }
> +
>      return RS_IDLE;
>  }


--
Alex Benn=C3=A9e

