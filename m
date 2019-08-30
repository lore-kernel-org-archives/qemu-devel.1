Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620B3C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 16:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9B32173E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 16:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZys7H+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9B32173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3k8h-0002Iw-DE
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 12:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i3jje-0003Lw-UU
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 12:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i3jjb-0007NW-Ku
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 12:26:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i3jjb-0007DL-3i
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 12:26:47 -0400
Received: by mail-wr1-x444.google.com with SMTP id b6so4780037wrv.11
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 09:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=WA5AgdFWRejX5yW8H8epnm5GABJADmoHtBjX5jU3LDk=;
 b=QZys7H+FN3p+1uq7QAw3eu5iFMvU1Vl546goYuhMHgcbi6Y5SpZS0GCWBuEJwwD75Q
 HqcuYR02XBUUXB6yOEcyZigwFP+U+n/CRGvu2R2lyZ4PCQXwguMTJRmKdnGqJTLRF8Te
 FBbBAECuWE5VR2TwAZBopGCzzeOu3jcXpYhg/Z21C2cS9VwiD+12sjQBElbY0Rf5224m
 g5x0VDyQ2McOql1A58sDT+vaTpHyDONVtGsU/XjV46wKJgKQ4GAeA2Kl3s8AaI92sIgD
 uhOhO40piZw9tXPB/opIhzfHTARJdnyAj3gELoNQ52zJtMgdu5toYH/OhbKupmWjQ8kt
 ErtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=WA5AgdFWRejX5yW8H8epnm5GABJADmoHtBjX5jU3LDk=;
 b=HaDduUa95Z5CoxdAvVpUliiAWL2ghNRVyMSUIOSX/Aq2V1eodoI6X6rBTzFbaSZfGI
 U2el9j3/xJ888eFM8lot6OJjDhtYejuGEff/AAFS8IyrUc12Awq4ao8CLPqkJZTGLZ04
 NbBEQd0bLd4rDJcKtJxT4HDn/sHGou/6Qey04ehdzteIuq7EcC1mMc2D7YzaNE1SqJVu
 TUurq/egU6ZlukNz28dHD/eGlOTb/f0CV93Qnl0lU4grr5QGykpnMuTD6a3ToYWH6cai
 EKVZNL+xUrqWdIG0Rmxa8McYipltA09vNTtyxswy2P+3PKLmV6PFjGIrY6lwUEY5P6QN
 8Uww==
X-Gm-Message-State: APjAAAU/JDEnG2A8YE5tDn3XhYZ1HE96CZjyB9iIIe8ud7HcvKaYepml
 b5hXXRqonRTNUAJEW4LtzDxSWw==
X-Google-Smtp-Source: APXvYqw1GdeAIoO7ZeR2vTDviJn8Hjty3AxJWj5Lh8F+zQWwdwk5NvywQYEZoO+OAPdlGWD0oXUmZQ==
X-Received: by 2002:a5d:658d:: with SMTP id q13mr12173784wru.78.1567182404683; 
 Fri, 30 Aug 2019 09:26:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w5sm11626979wrc.82.2019.08.30.09.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2019 09:26:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 578E61FF87;
 Fri, 30 Aug 2019 17:26:43 +0100 (BST)
References: <20190829173437.5926-1-vandersonmr2@gmail.com>
 <20190829173437.5926-11-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190829173437.5926-11-vandersonmr2@gmail.com>
Date: Fri, 30 Aug 2019 17:26:43 +0100
Message-ID: <87r2527h6k.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v8 10/11] monitor: adding new info cfg
 command
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 vandersonmr <vandersonmr2@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

> Adding "info cfg id depth" commands to HMP.
> This command allow the exploration a TB
> neighbors by dumping [and opening] a .dot
> file with the TB CFG neighbors colorized
> by their hotness.
>
> The goal of this command is to allow the dynamic exploration
> of TCG behavior and code quality. Therefore, for now, a
> corresponding QMP command is not worthwhile.
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  accel/tcg/tb-stats.c    | 164 ++++++++++++++++++++++++++++++++++++++++
>  hmp-commands-info.hx    |   7 ++
>  include/exec/tb-stats.h |   1 +
>  monitor/misc.c          |  22 ++++++
>  4 files changed, 194 insertions(+)
>
> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
> index d588c551c9..fd2344c5d1 100644
> --- a/accel/tcg/tb-stats.c
> +++ b/accel/tcg/tb-stats.c
> @@ -679,6 +679,170 @@ void dump_tb_info(int id, int log_mask, bool use_mo=
nitor)
>      /* tbdi free'd by do_dump_tb_info_safe */
>  }
>
> +/* TB CFG xdot/dot dump implementation */
> +#define MAX_CFG_NUM_NODES 1000
> +static int cfg_tb_id;
> +static GHashTable *cfg_nodes;
> +static uint64_t root_count;
> +
> +static void fputs_jump(TBStatistics *from, TBStatistics *to, FILE *dot)
> +{
> +    if (!from || !to) {
> +        return;
> +    }
> +
> +    int *from_id =3D (int *) g_hash_table_lookup(cfg_nodes, from);
> +    int *to_id   =3D (int *) g_hash_table_lookup(cfg_nodes, to);
> +
> +    if (!from_id || !to_id) {
> +        return;
> +    }
> +
> +    fprintf(dot, "   node_%d -> node_%d;\n", *from_id, *to_id);
> +}
> +
> +/* Hotness colors used in the CFG */
> +#define HOT_RED1  0xFF000 /* RGB(255,0,0)     */
> +#define HOT_RED2  0xFF333 /* RGB(255,51,48)   */
> +#define MILD_RED  0xFF666 /* RGB(255,102,96)  */
> +#define WEAK_RED1 0xFF999 /* RGB(255,153,144) */
> +#define WEAK_RED2 0xFFCCC /* RGB(255,204,192) */
> +
> +static void fputs_tbstats(TBStatistics *tbs, FILE *dot, int log_flags)
> +{
> +    if (!tbs) {
> +        return;
> +    }
> +
> +    uint32_t color =3D MILD_RED;
> +    uint64_t count =3D tbs->executions.normal;
> +    if (count > 1.6 * root_count) {
> +        color =3D HOT_RED1;
> +    } else if (count > 1.2 * root_count) {
> +        color =3D HOT_RED2;
> +    } else if (count < 0.4 * root_count) {
> +        color =3D WEAK_RED2;
> +    } else if (count < 0.8 * root_count) {
> +        color =3D WEAK_RED1;
> +    }
> +
> +    GString *code_s =3D get_code_string(tbs, log_flags);
> +
> +    for (int i =3D 0; i < code_s->len; i++) {
> +        if (code_s->str[i] =3D=3D '\n') {
> +            code_s->str[i] =3D ' ';
> +            code_s =3D g_string_insert(code_s, i, "\\l");
> +            i +=3D 2;
> +        }
> +    }
> +
> +    fprintf(dot,
> +            "   node_%d [fillcolor=3D\"#%xFF0000\" shape=3D\"record\" "
> +            "label=3D\"TB %d\\l"
> +            "-------------\\l"
> +            "PC:\t0x"TARGET_FMT_lx"\\l"
> +            "exec count:\t%lu\\l"
> +            "\\l %s\"];\n",
> +            cfg_tb_id, color, cfg_tb_id, tbs->pc,
> +            tbs->executions.normal, code_s->str);
> +
> +    int *id =3D g_new(int, 1);
> +    *id =3D cfg_tb_id;
> +    g_hash_table_insert(cfg_nodes, tbs, id);
> +
> +    cfg_tb_id++;
> +
> +    g_string_free(code_s, true);
> +}
> +
> +static void fputs_preorder_walk(TBStatistics *tbs, int depth, FILE *dot,=
 int log_flags)
> +{
> +    if (tbs && depth > 0
> +            && cfg_tb_id < MAX_CFG_NUM_NODES
> +            && !g_hash_table_contains(cfg_nodes, tbs)) {
> +
> +        fputs_tbstats(tbs, dot, log_flags);
> +
> +        if (tbs->tb) {
> +            TranslationBlock *left_tb  =3D NULL;
> +            TranslationBlock *right_tb =3D NULL;
> +            if (tbs->tb->jmp_dest[0]) {
> +                left_tb =3D (TranslationBlock *) atomic_read(tbs->tb->jm=
p_dest);
> +            }
> +            if (tbs->tb->jmp_dest[1]) {
> +                right_tb =3D (TranslationBlock *) atomic_read(tbs->tb->j=
mp_dest + 1);
> +            }

I think my comments about relying on jmp_dest on the previous patch hold
for this as well.

> +
> +            if (left_tb) {
> +                fputs_preorder_walk(left_tb->tb_stats, depth - 1, dot, l=
og_flags);
> +                fputs_jump(tbs, left_tb->tb_stats, dot);
> +            }
> +            if (right_tb) {
> +                fputs_preorder_walk(right_tb->tb_stats, depth - 1, dot, =
log_flags);
> +                fputs_jump(tbs, right_tb->tb_stats, dot);
> +            }
> +        }
> +    }
> +}
> +
> +struct PreorderInfo {
> +    TBStatistics *tbs;
> +    int depth;
> +    int log_flags;
> +};
> +
> +static void fputs_preorder_walk_safe(CPUState *cpu, run_on_cpu_data icmd)
> +{
> +    struct PreorderInfo *info =3D icmd.host_ptr;
> +
> +    GString *file_name =3D g_string_new(NULL);;
> +    g_string_printf(file_name, "/tmp/qemu-cfg-tb-%d-%d.dot", id,
> info->depth);

g_string is great for building things up on the fly but slight overkill
for this sort of case. Besides I think using g_file_open_tmp might be a
better choice than hand rolling our own magic tmp file code.

  int dot_fd =3D g_file_open_tmp("qemu-cfg-XXXX", &name, &error);

> +    FILE *dot =3D fopen(file_name->str, "w+");
> +
> +    fputs(
> +            "digraph G {\n"
> +            "   mclimit=3D1.5;\n"
> +            "   rankdir=3DTD; ordering=3Dout;\n"
> +            "   graph[fontsize=3D10 fontname=3D\"Verdana\"];\n"
> +            "   color=3D\"#efefef\";\n"
> +            "   node[shape=3Dbox style=3Dfilled fontsize=3D8 fontname=3D=
\"Verdana\" fillcolor=3D\"#efefef\"];\n"
> +            "   edge[fontsize=3D8 fontname=3D\"Verdana\"];\n"
> +         , dot);
> +
> +    cfg_nodes =3D g_hash_table_new(NULL, NULL);
> +    fputs_preorder_walk(info->tbs, info->depth, dot, info->log_flags);
> +    g_hash_table_destroy(cfg_nodes);
> +
> +    fputs("}\n\0", dot);
> +    fclose(dot);
> +
> +    qemu_log("CFG dumped: %s\n", file_name->str);

  qemu_log("CFG dumped: %s\n", name);
  g_free(name);

> +
> +    g_string_free(file_name, true);
> +    g_free(info);
> +}
> +
> +void dump_tb_cfg(int id, int depth, int log_flags)
> +{
> +    cfg_tb_id =3D 1;
> +    root_count =3D 0;
> +
> +    /* do a pre-order walk in the CFG with a limited depth */
> +    TBStatistics *root =3D get_tbstats_by_id(id);
> +    if (root) {
> +        root_count =3D root->executions.normal;
> +    }
> +
> +    struct PreorderInfo *info =3D g_new(struct PreorderInfo, 1);
> +    info->tbs =3D root;
> +    info->depth =3D depth + 1;
> +    info->log_flags =3D log_flags;
> +    async_safe_run_on_cpu(first_cpu, fputs_preorder_walk_safe,
> +            RUN_ON_CPU_HOST_PTR(info));
> +}
> +
> +/* TBStatistic collection controls */
> +
>
>  void enable_collect_tb_stats(void)
>  {
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index f415479011..8c96924c0b 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -305,6 +305,13 @@ ETEXI
>                        "dump flags can be used to set dump code level: ou=
t_asm in_asm op",
>          .cmd        =3D hmp_info_tb,
>      },
> +    {
> +        .name       =3D "cfg",
> +        .args_type  =3D "id:i,depth:i?,flags:s?",
> +        .params     =3D "id [depth flags]",
> +        .help       =3D "plot CFG around TB with the given id",
> +        .cmd        =3D hmp_info_cfg,
> +    },
>      {
>          .name       =3D "coverset",
>          .args_type  =3D "coverage:i?",
> diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
> index 51d73e1c5f..4515db106a 100644
> --- a/include/exec/tb-stats.h
> +++ b/include/exec/tb-stats.h
> @@ -155,6 +155,7 @@ void dump_tbs_info(int count, int sort_by, bool use_m=
onitor);
>   */
>  void dump_tb_info(int id, int log_mask, bool use_monitor);
>
> +void dump_tb_cfg(int id, int depth, int log_flags);
>
>  /* TBStatistic collection controls */
>  void enable_collect_tb_stats(void);
> diff --git a/monitor/misc.c b/monitor/misc.c
> index b99c018124..b3b31d7035 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -556,6 +556,28 @@ static void hmp_info_tb(Monitor *mon, const QDict *q=
dict)
>      dump_tb_info(id, mask, true);
>  }
>
> +static void hmp_info_cfg(Monitor *mon, const QDict *qdict)
> +{
> +    const int id =3D qdict_get_int(qdict, "id");
> +    const int depth =3D qdict_get_try_int(qdict, "depth", 3);
> +    const char *flags =3D qdict_get_try_str(qdict, "flags");
> +    int mask;
> +
> +    if (!tcg_enabled()) {
> +        error_report("TB information is only available with accel=3Dtcg"=
);
> +        return;
> +    }
> +
> +    mask =3D flags ? qemu_str_to_log_mask(flags) : CPU_LOG_TB_IN_ASM;
> +
> +    if (!mask) {
> +        error_report("Unable to parse log flags, see 'help log'");
> +        return;
> +    }
> +
> +    dump_tb_cfg(id, depth, mask);
> +}
> +
>  static void hmp_info_coverset(Monitor *mon, const QDict *qdict)
>  {
>      int coverage;


--
Alex Benn=C3=A9e

