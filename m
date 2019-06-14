Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD9EC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B107F208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B107F208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49546 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbiOo-0007i1-FZ
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 05:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37540)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hbiLJ-0005G8-V7
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hbiLH-0001j2-QN
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:17:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hbiLC-0001fm-S1; Fri, 14 Jun 2019 05:17:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C5A643082126;
 Fri, 14 Jun 2019 09:17:42 +0000 (UTC)
Received: from work-vm (ovpn-117-220.ams2.redhat.com [10.36.117.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E59D1001938;
 Fri, 14 Jun 2019 09:17:37 +0000 (UTC)
Date: Fri, 14 Jun 2019 10:17:35 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190614091733.GA2785@work-vm>
References: <20190613153405.24769-1-kwolf@redhat.com>
 <20190613153405.24769-12-kwolf@redhat.com>
 <87y324fud1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y324fud1.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 14 Jun 2019 09:17:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 11/15] monitor: Split out monitor/hmp.c
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
Cc: Kevin Wolf <kwolf@redhat.com>, berrange@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Move HMP infrastructure from monitor/misc.c to monitor/hmp.c. This is
> > code that can be shared for all targets, so compile it only once.
> >
> > The amount of function and particularly extern variables in
> > monitor_int.h is probably a bit larger than it needs to be, but this way
> > no non-trivial code modifications are needed. The interfaces between HMP
> > and the monitor core can be cleaned up later.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> [...]
> > diff --git a/monitor/hmp.c b/monitor/hmp.c
> > new file mode 100644
> > index 0000000000..3621b195ed
> > --- /dev/null
> > +++ b/monitor/hmp.c
> > @@ -0,0 +1,1415 @@
> [...]
> > +static int64_t expr_unary(Monitor *mon)
> > +{
> > +    int64_t n;
> > +    char *p;
> > +    int ret;
> > +
> > +    switch (*pch) {
> > +    case '+':
> > +        next();
> > +        n = expr_unary(mon);
> > +        break;
> > +    case '-':
> > +        next();
> > +        n = -expr_unary(mon);
> > +        break;
> > +    case '~':
> > +        next();
> > +        n = ~expr_unary(mon);
> > +        break;
> > +    case '(':
> > +        next();
> > +        n = expr_sum(mon);
> > +        if (*pch != ')') {
> > +            expr_error(mon, "')' expected");
> > +        }
> > +        next();
> > +        break;
> > +    case '\'':
> > +        pch++;
> > +        if (*pch == '\0') {
> > +            expr_error(mon, "character constant expected");
> > +        }
> > +        n = *pch;
> > +        pch++;
> > +        if (*pch != '\'') {
> > +            expr_error(mon, "missing terminating \' character");
> > +        }
> > +        next();
> > +        break;
> > +    case '$':
> > +        {
> > +            char buf[128], *q;
> > +            int64_t reg = 0;
> > +
> > +            pch++;
> > +            q = buf;
> > +            while ((*pch >= 'a' && *pch <= 'z') ||
> > +                   (*pch >= 'A' && *pch <= 'Z') ||
> > +                   (*pch >= '0' && *pch <= '9') ||
> > +                   *pch == '_' || *pch == '.') {
> > +                if ((q - buf) < sizeof(buf) - 1) {
> > +                    *q++ = *pch;
> > +                }
> > +                pch++;
> > +            }
> > +            while (qemu_isspace(*pch)) {
> > +                pch++;
> > +            }
> > +            *q = 0;
> > +            ret = get_monitor_def(&reg, buf);
> > +            if (ret < 0) {
> > +                expr_error(mon, "unknown register");
> > +            }
> > +            n = reg;
> > +        }
> > +        break;
> > +    case '\0':
> > +        expr_error(mon, "unexpected end of expression");
> > +        n = 0;
> > +        break;
> > +    default:
> > +        errno = 0;
> > +        n = strtoull(pch, &p, 0);
> 
> checkpatch.pl gripes:
> 
>     ERROR: consider using qemu_strtoull in preference to strtoull
> 
> 
> Let's add a TODO comment.  
> 
> > +        if (errno == ERANGE) {
> > +            expr_error(mon, "number too large");
> > +        }
> > +        if (pch == p) {
> > +            expr_error(mon, "invalid char '%c' in expression", *p);
> > +        }
> > +        pch = p;
> > +        while (qemu_isspace(*pch)) {
> > +            pch++;
> > +        }
> > +        break;
> > +    }
> > +    return n;
> > +}
> [...]
> > +static void monitor_find_completion(void *opaque,
> > +                                    const char *cmdline)
> > +{
> > +    MonitorHMP *mon = opaque;
> > +    char *args[MAX_ARGS];
> > +    int nb_args, len;
> > +
> > +    /* 1. parse the cmdline */
> > +    if (parse_cmdline(cmdline, &nb_args, args) < 0) {
> > +        return;
> > +    }
> > +
> > +    /* if the line ends with a space, it means we want to complete the
> > +     * next arg */
> 
> checkpatch.pl again:
> 
>     WARNING: Block comments use a leading /* on a separate line
>     WARNING: Block comments use a trailing */ on a separate line
> 
> Can touch up in my tree.

I wouldn't worry too much about fixing the existing problems here -
let's get the reorg done through kwolf's patches and then it's easier
to clean up later.

Dave

> > +    len = strlen(cmdline);
> > +    if (len > 0 && qemu_isspace(cmdline[len - 1])) {
> > +        if (nb_args >= MAX_ARGS) {
> > +            goto cleanup;
> > +        }
> > +        args[nb_args++] = g_strdup("");
> > +    }
> > +
> > +    /* 2. auto complete according to args */
> > +    monitor_find_completion_by_table(mon, hmp_cmds, args, nb_args);
> > +
> > +cleanup:
> > +    free_cmdline_args(args, nb_args);
> > +}
> [...]
> > diff --git a/monitor/misc.c b/monitor/misc.c
> > index 368b8297d4..c8289959c0 100644
> > --- a/monitor/misc.c
> > +++ b/monitor/misc.c
> [...]
> > @@ -612,245 +580,27 @@ out:
> >      return output;
> >  }
> >  
> > -static int compare_cmd(const char *name, const char *list)
> > +/**
> > + * Is @name in the '|' separated list of names @list?
> > + */
> > +int hmp_compare_cmd(const char *name, const char *list)
> >  {
> >      const char *p, *pstart;
> >      int len;
> >      len = strlen(name);
> >      p = list;
> > -    for(;;) {
> > +    for (;;) {
> >          pstart = p;
> >          p = qemu_strchrnul(p, '|');
> > -        if ((p - pstart) == len && !memcmp(pstart, name, len))
> > +        if ((p - pstart) == len && !memcmp(pstart, name, len)) {
> >              return 1;
> 
> The diff gets confusing here.  The function remains unchanged.  Good.
> 
> > -        if (*p == '\0')
> > -            break;
> > -        p++;
> > -    }
> > -    return 0;
> > -}
> > -
> > -static int get_str(char *buf, int buf_size, const char **pp)
> > -{
> > -    const char *p;
> > -    char *q;
> > -    int c;
> > -
> > -    q = buf;
> > -    p = *pp;
> > -    while (qemu_isspace(*p)) {
> > -        p++;
> > -    }
> > -    if (*p == '\0') {
> > -    fail:
> > -        *q = '\0';
> > -        *pp = p;
> > -        return -1;
> > -    }
> > -    if (*p == '\"') {
> > -        p++;
> > -        while (*p != '\0' && *p != '\"') {
> > -            if (*p == '\\') {
> > -                p++;
> > -                c = *p++;
> > -                switch (c) {
> > -                case 'n':
> > -                    c = '\n';
> > -                    break;
> > -                case 'r':
> > -                    c = '\r';
> > -                    break;
> > -                case '\\':
> > -                case '\'':
> > -                case '\"':
> > -                    break;
> > -                default:
> > -                    printf("unsupported escape code: '\\%c'\n", c);
> > -                    goto fail;
> > -                }
> > -                if ((q - buf) < buf_size - 1) {
> > -                    *q++ = c;
> > -                }
> > -            } else {
> > -                if ((q - buf) < buf_size - 1) {
> > -                    *q++ = *p;
> > -                }
> > -                p++;
> > -            }
> > -        }
> > -        if (*p != '\"') {
> > -            printf("unterminated string\n");
> > -            goto fail;
> > -        }
> > -        p++;
> > -    } else {
> > -        while (*p != '\0' && !qemu_isspace(*p)) {
> > -            if ((q - buf) < buf_size - 1) {
> > -                *q++ = *p;
> > -            }
> > -            p++;
> > -        }
> > -    }
> > -    *q = '\0';
> > -    *pp = p;
> > -    return 0;
> > -}
> > -
> > -#define MAX_ARGS 16
> > -
> > -static void free_cmdline_args(char **args, int nb_args)
> > -{
> > -    int i;
> > -
> > -    assert(nb_args <= MAX_ARGS);
> > -
> > -    for (i = 0; i < nb_args; i++) {
> > -        g_free(args[i]);
> > -    }
> > -
> > -}
> > -
> > -/*
> > - * Parse the command line to get valid args.
> > - * @cmdline: command line to be parsed.
> > - * @pnb_args: location to store the number of args, must NOT be NULL.
> > - * @args: location to store the args, which should be freed by caller, must
> > - *        NOT be NULL.
> > - *
> > - * Returns 0 on success, negative on failure.
> > - *
> > - * NOTE: this parser is an approximate form of the real command parser. Number
> > - *       of args have a limit of MAX_ARGS. If cmdline contains more, it will
> > - *       return with failure.
> > - */
> > -static int parse_cmdline(const char *cmdline,
> > -                         int *pnb_args, char **args)
> > -{
> > -    const char *p;
> > -    int nb_args, ret;
> > -    char buf[1024];
> > -
> > -    p = cmdline;
> > -    nb_args = 0;
> > -    for (;;) {
> > -        while (qemu_isspace(*p)) {
> > -            p++;
> >          }
> >          if (*p == '\0') {
> >              break;
> >          }
> > -        if (nb_args >= MAX_ARGS) {
> > -            goto fail;
> > -        }
> > -        ret = get_str(buf, sizeof(buf), &p);
> > -        if (ret < 0) {
> > -            goto fail;
> > -        }
> > -        args[nb_args] = g_strdup(buf);
> > -        nb_args++;
> > +        p++;
> >      }
> > -    *pnb_args = nb_args;
> >      return 0;
> > -
> > - fail:
> > -    free_cmdline_args(args, nb_args);
> > -    return -1;
> > -}
> > -
> > -/*
> > - * Can command @cmd be executed in preconfig state?
> > - */
> > -static bool cmd_can_preconfig(const HMPCommand *cmd)
> > -{
> > -    if (!cmd->flags) {
> > -        return false;
> > -    }
> > -
> > -    return strchr(cmd->flags, 'p');
> > -}
> > -
> > -static void help_cmd_dump_one(Monitor *mon,
> > -                              const HMPCommand *cmd,
> > -                              char **prefix_args,
> > -                              int prefix_args_nb)
> > -{
> > -    int i;
> > -
> > -    if (runstate_check(RUN_STATE_PRECONFIG) && !cmd_can_preconfig(cmd)) {
> > -        return;
> > -    }
> > -
> > -    for (i = 0; i < prefix_args_nb; i++) {
> > -        monitor_printf(mon, "%s ", prefix_args[i]);
> > -    }
> > -    monitor_printf(mon, "%s %s -- %s\n", cmd->name, cmd->params, cmd->help);
> > -}
> > -
> > -/* @args[@arg_index] is the valid command need to find in @cmds */
> > -static void help_cmd_dump(Monitor *mon, const HMPCommand *cmds,
> > -                          char **args, int nb_args, int arg_index)
> > -{
> > -    const HMPCommand *cmd;
> > -    size_t i;
> > -
> > -    /* No valid arg need to compare with, dump all in *cmds */
> > -    if (arg_index >= nb_args) {
> > -        for (cmd = cmds; cmd->name != NULL; cmd++) {
> > -            help_cmd_dump_one(mon, cmd, args, arg_index);
> > -        }
> > -        return;
> > -    }
> > -
> > -    /* Find one entry to dump */
> > -    for (cmd = cmds; cmd->name != NULL; cmd++) {
> > -        if (compare_cmd(args[arg_index], cmd->name) &&
> > -            ((!runstate_check(RUN_STATE_PRECONFIG) ||
> > -                cmd_can_preconfig(cmd)))) {
> > -            if (cmd->sub_table) {
> > -                /* continue with next arg */
> > -                help_cmd_dump(mon, cmd->sub_table,
> > -                              args, nb_args, arg_index + 1);
> > -            } else {
> > -                help_cmd_dump_one(mon, cmd, args, arg_index);
> > -            }
> > -            return;
> > -        }
> > -    }
> > -
> > -    /* Command not found */
> > -    monitor_printf(mon, "unknown command: '");
> > -    for (i = 0; i <= arg_index; i++) {
> > -        monitor_printf(mon, "%s%s", args[i], i == arg_index ? "'\n" : " ");
> > -    }
> > -}
> > -
> > -static void help_cmd(Monitor *mon, const char *name)
> > -{
> > -    char *args[MAX_ARGS];
> > -    int nb_args = 0;
> > -
> > -    /* 1. parse user input */
> > -    if (name) {
> > -        /* special case for log, directly dump and return */
> > -        if (!strcmp(name, "log")) {
> > -            const QEMULogItem *item;
> > -            monitor_printf(mon, "Log items (comma separated):\n");
> > -            monitor_printf(mon, "%-10s %s\n", "none", "remove all logs");
> > -            for (item = qemu_log_items; item->mask != 0; item++) {
> > -                monitor_printf(mon, "%-10s %s\n", item->name, item->help);
> > -            }
> > -            return;
> > -        }
> > -
> > -        if (parse_cmdline(name, &nb_args, args) < 0) {
> > -            return;
> > -        }
> > -    }
> > -
> > -    /* 2. dump the contents according to parsed args */
> > -    help_cmd_dump(mon, hmp_cmds, args, nb_args, 0);
> > -
> > -    free_cmdline_args(args, nb_args);
> >  }
> [...]
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

