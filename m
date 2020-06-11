Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872F9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 17:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42835206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 17:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cpnkKt8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42835206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQew-0001dc-EF
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 13:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jjQda-0000WX-CX
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 13:05:10 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134]:37947)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jjQdX-0007bU-EW
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 13:05:09 -0400
Received: by mail-lf1-x134.google.com with SMTP id 202so3916646lfe.5
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=D2xla/WfsN7t2Ip84+wDk+K/RuIrJG54uBgQqjd259E=;
 b=cpnkKt8KmfwbXWRJF4nTCEAtPBoAtVyrpZINfF1SV169zpd2mqszCI0JrV8B4mv1RY
 HEFQOU5K8hJaJCGhvvmgp7gGTFX0gbIQW/WYVBM6eBUWPmZQAfVVGh7hOUdt+TbUgnde
 a95b+nMdZZnL33RZ50nB3NlYX9dESg/D8O8ILDKRCCRXVHsm3zzzlaC+yl+MbUrxbvKH
 v0jk3X2LYYy6zIFnVXeL30xK4GWW474gs5EqpksZush1cbZEDUI03wZKFZ5/FWCVx0HP
 T1lVrmLDLJba6N3dW5VB58VFxCWrFmzh3x7BYDrCKPpcuGVHDDrMGM0/smSswUcZSLIN
 L00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=D2xla/WfsN7t2Ip84+wDk+K/RuIrJG54uBgQqjd259E=;
 b=bg2kBqOVdes1V/q2ywh8JfEKRRUrvTxJChMZXti7VT9QO88zZxQ8hkZckpdIQ4/Dk4
 H8KkbFGqttXDX9xedV5/uMTl1/Mb/Zelvb25jpnhiorpK+B2tbnkoRhWUPRBDRzFxX28
 6m4/FtTmwDASbUDXzWNFrnPRgKP8TzE3eZWheh8qFR2bwyByNjWQ8/XGMdWB2QlOj7uC
 YXYh59i44Hbx4IhhoM73d8PDijee4ielwNsCaNode02Cl8FUbetCvhFQz6n9lfzHZYzf
 nOAwi1jhJI9VxwfLXd4ub9vStXYEsfqY6Cl4xo6Co4WPyURFgG6g7nGbebgpvAf8szHn
 1ACQ==
X-Gm-Message-State: AOAM530pyiYCyn1BvADLc1FkbH05jws+GpJPGg7j61Kmm1CJQj8YJlGy
 WAPskAXWjQLqvvG7YetcdXBpZIYQ6QZnysN4Zvb/nA==
X-Google-Smtp-Source: ABdhPJwA4fh2B3zoO8eYYLsBrXqJmJPP3Jx+6dzewN3AiSyuV430SWO90HZJGtvA3X7kMeEMJ9fZtod8WyTi+/wluCI=
X-Received: by 2002:a19:550e:: with SMTP id n14mr4868497lfe.81.1591895097236; 
 Thu, 11 Jun 2020 10:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200610155509.12850-1-alex.bennee@linaro.org>
 <20200610155509.12850-3-alex.bennee@linaro.org>
In-Reply-To: <20200610155509.12850-3-alex.bennee@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Thu, 11 Jun 2020 13:04:58 -0400
Message-ID: <CAEyhzFvvEDLE6U_s-+=1uDP1zecm3LHubai8hRxxrJtaqZv0gg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] plugins: new lockstep plugin for debugging TCG
 changes
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=robert.foley@linaro.org; helo=mail-lf1-x134.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, "Emilio G. Cota" <cota@braap.org>,
 kuhn.chenqun@huawei.com, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Robert Foley <robert.foley@linaro.org>
Tested-by: Robert Foley <robert.foley@linaro.org>

The testing was mostly bringing up pairs of aarch64 VMs and
either waiting for the divergence or exiting out before divergence
with ctrl-a x at various stages of boot.

When we exit from the VM before divergence, we observe the below:
we seem to get "No divergence :-)" and also immediately
"too much divergence... giving up".  Not sure if this is expected in this c=
ase.

See below for an example.

No divergence :-)
Executed 1318101/1308985 blocks
Executed ~3052742 instructions
@ 0x005631f2aa0fb0 vs 0x000000000124e8 (1/0 since last)
@ 0x007fc04923e410 vs 0x00000000012f2c (2/1 since last)
@ 0x007fc04923e550 vs 0x00000000012f08 (3/1 since last)
=CE=94 insn_count @ 0x007fc04923e550 (3052937) vs 0x00000000012f08 (3052937=
)
  previously @ 0x007fc04923e410/1 (3052937 insns)
  previously @ 0x005631f2aa0fb0/2 (3052936 insns)
  previously @ 0x007fc04923e390/3 (3052934 insns)
  previously @ 0x007fc04923e550/2 (3052931 insns)
  previously @ 0x007fc04923e410/1 (3052929 insns)
too much divergence... giving up.

On Wed, 10 Jun 2020 at 11:55, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> When we make changes to the TCG we sometimes cause regressions that
> are deep into the execution cycle of the guest. Debugging this often
> requires comparing large volumes of trace information to figure out
> where behaviour has diverged.
>
> The lockstep plugin utilises a shared socket so two QEMU's running
> with the plugin will write their current execution position and wait
> to receive the position of their partner process. When execution
> diverges the plugins output where they were and the previous few
> blocks before unloading themselves and letting execution continue.
>
> Originally I planned for this to be most useful with -icount but it
> turns out you can get divergence pretty quickly due to asynchronous
> qemu_cpu_kick_rr_cpus() events causing one side to eventually run into
> a short block a few cycles before the other side. For this reason I've
> added a bit of tracking and I think the divergence reporting could be
> finessed to report only if we really start to diverge in execution.
>
> An example run would be:
>
>   qemu-system-sparc -monitor none -parallel none -net none \
>     -M SS-20 -m 256 -kernel day11/zImage.elf \
>     -plugin ./tests/plugin/liblockstep.so,arg=3Dlockstep-sparc.sock \
>     -d plugin,nochain
>
> with an identical command in another window in the same working
> directory.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Message-Id: <20200429200754.18327-1-alex.bennee@linaro.org>
>
> ---
> v3
>   - added verbose flag
>   - basic heuristics to detect "real" divergence
>   - checkpatch tweaks
> ---
>  tests/plugin/lockstep.c   | 340 ++++++++++++++++++++++++++++++++++++++
>  tests/plugin/Makefile     |   1 +
>  tests/tcg/Makefile.target |   2 +-
>  3 files changed, 342 insertions(+), 1 deletion(-)
>  create mode 100644 tests/plugin/lockstep.c
>
> diff --git a/tests/plugin/lockstep.c b/tests/plugin/lockstep.c
> new file mode 100644
> index 00000000000..a696673dff3
> --- /dev/null
> +++ b/tests/plugin/lockstep.c
> @@ -0,0 +1,340 @@
> +/*
> + * Lockstep Execution Plugin
> + *
> + * Allows you to execute two QEMU instances in lockstep and report
> + * when their execution diverges. This is mainly useful for developers
> + * who want to see where a change to TCG code generation has
> + * introduced a subtle and hard to find bug.
> + *
> + * Caveats:
> + *   - single-threaded linux-user apps only with non-deterministic sysca=
lls
> + *   - no MTTCG enabled system emulation (icount may help)
> + *
> + * While icount makes things more deterministic it doesn't mean a
> + * particular run may execute the exact same sequence of blocks. An
> + * asynchronous event (for example X11 graphics update) may cause a
> + * block to end early and a new partial block to start. This means
> + * serial only test cases are a better bet. -d nochain may also help.
> + *
> + * This code is not thread safe!
> + *
> + * Copyright (c) 2020 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <glib.h>
> +#include <inttypes.h>
> +#include <unistd.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +#include <stdio.h>
> +#include <errno.h>
> +
> +#include <qemu-plugin.h>
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> +
> +/* saved so we can uninstall later */
> +static qemu_plugin_id_t our_id;
> +
> +static unsigned long bb_count;
> +static unsigned long insn_count;
> +
> +/* Information about a translated block */
> +typedef struct {
> +    uint64_t pc;
> +    uint64_t insns;
> +} BlockInfo;
> +
> +/* Information about an execution state in the log */
> +typedef struct {
> +    BlockInfo *block;
> +    unsigned long insn_count;
> +    unsigned long block_count;
> +} ExecInfo;
> +
> +/* The execution state we compare */
> +typedef struct {
> +    uint64_t pc;
> +    unsigned long insn_count;
> +} ExecState;
> +
> +typedef struct {
> +    GSList *log_pos;
> +    int distance;
> +} DivergeState;
> +
> +/* list of translated block info */
> +static GSList *blocks;
> +
> +/* execution log and points of divergence */
> +static GSList *log, *divergence_log;
> +
> +static int socket_fd;
> +static char *path_to_unlink;
> +
> +static bool verbose;
> +
> +static void plugin_cleanup(qemu_plugin_id_t id)
> +{
> +    /* Free our block data */
> +    g_slist_free_full(blocks, &g_free);
> +    g_slist_free_full(log, &g_free);
> +    g_slist_free(divergence_log);
> +
> +    close(socket_fd);
> +    if (path_to_unlink) {
> +        unlink(path_to_unlink);
> +    }
> +}
> +
> +static void plugin_exit(qemu_plugin_id_t id, void *p)
> +{
> +    g_autoptr(GString) out =3D g_string_new("No divergence :-)\n");
> +    g_string_append_printf(out, "Executed %ld/%d blocks\n",
> +                           bb_count, g_slist_length(log));
> +    g_string_append_printf(out, "Executed ~%ld instructions\n", insn_cou=
nt);
> +    qemu_plugin_outs(out->str);
> +
> +    plugin_cleanup(id);
> +}
> +
> +static void report_divergance(ExecState *us, ExecState *them)
> +{
> +    DivergeState divrec =3D { log, 0 };
> +    g_autoptr(GString) out =3D g_string_new("");
> +    bool diverged =3D false;
> +
> +    /*
> +     * If we have diverged before did we get back on track or are we
> +     * totally loosing it?
> +     */
> +    if (divergence_log) {
> +        DivergeState *last =3D (DivergeState *) divergence_log->data;
> +        GSList *entry;
> +
> +        for (entry =3D log; g_slist_next(entry); entry =3D g_slist_next(=
entry)) {
> +            if (entry =3D=3D last->log_pos) {
> +                break;
> +            }
> +            divrec.distance++;
> +        }
> +
> +        /*
> +         * If the last two records are so close it is likely we will
> +         * not recover synchronisation with the other end.
> +         */
> +        if (divrec.distance =3D=3D 1 && last->distance =3D=3D 1) {
> +            diverged =3D true;
> +        }
> +    }
> +    divergence_log =3D g_slist_prepend(divergence_log,
> +                                     g_memdup(&divrec, sizeof(divrec)));
> +
> +    /* Output short log entry of going out of sync... */
> +    if (verbose || divrec.distance =3D=3D 1 || diverged) {
> +        g_string_printf(out, "@ %#016lx vs %#016lx (%d/%d since last)\n"=
,
> +                        us->pc, them->pc, g_slist_length(divergence_log)=
,
> +                        divrec.distance);
> +        qemu_plugin_outs(out->str);
> +    }
> +
> +    if (diverged) {
> +        int i;
> +        GSList *entry;
> +
> +        g_string_printf(out, "=CE=94 insn_count @ %#016lx (%ld) vs %#016=
lx (%ld)\n",
> +                        us->pc, us->insn_count, them->pc, them->insn_cou=
nt);
> +
> +        for (entry =3D log, i =3D 0;
> +             g_slist_next(entry) && i < 5;
> +             entry =3D g_slist_next(entry), i++) {
> +            ExecInfo *prev =3D (ExecInfo *) entry->data;
> +            g_string_append_printf(out,
> +                                   "  previously @ %#016lx/%ld (%ld insn=
s)\n",
> +                                   prev->block->pc, prev->block->insns,
> +                                   prev->insn_count);
> +        }
> +        qemu_plugin_outs(out->str);
> +        qemu_plugin_outs("too much divergence... giving up.");
> +        qemu_plugin_uninstall(our_id, plugin_cleanup);
> +    }
> +}
> +
> +static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
> +{
> +    BlockInfo *bi =3D (BlockInfo *) udata;
> +    ExecState us, them;
> +    ssize_t bytes;
> +    ExecInfo *exec;
> +
> +    us.pc =3D bi->pc;
> +    us.insn_count =3D insn_count;
> +
> +    /*
> +     * Write our current position to the other end. If we fail the
> +     * other end has probably died and we should shut down gracefully.
> +     */
> +    bytes =3D write(socket_fd, &us, sizeof(ExecState));
> +    if (bytes < sizeof(ExecState)) {
> +        qemu_plugin_outs(bytes < 0 ?
> +                         "problem writing to socket" :
> +                         "wrote less than expected to socket");
> +        qemu_plugin_uninstall(our_id, plugin_cleanup);
> +        return;
> +    }
> +
> +    /*
> +     * Now read where our peer has reached. Again a failure probably
> +     * indicates the other end died and we should close down cleanly.
> +     */
> +    bytes =3D read(socket_fd, &them, sizeof(ExecState));
> +    if (bytes < sizeof(ExecState)) {
> +        qemu_plugin_outs(bytes < 0 ?
> +                         "problem reading from socket" :
> +                         "read less than expected");
> +        qemu_plugin_uninstall(our_id, plugin_cleanup);
> +        return;
> +    }
> +
> +    /*
> +     * Compare and report if we have diverged.
> +     */
> +    if (us.pc !=3D them.pc) {
> +        report_divergance(&us, &them);
> +    }
> +
> +    /*
> +     * Assume this block will execute fully and record it
> +     * in the execution log.
> +     */
> +    insn_count +=3D bi->insns;
> +    bb_count++;
> +    exec =3D g_new0(ExecInfo, 1);
> +    exec->block =3D bi;
> +    exec->insn_count =3D insn_count;
> +    exec->block_count =3D bb_count;
> +    log =3D g_slist_prepend(log, exec);
> +}
> +
> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb=
)
> +{
> +    BlockInfo *bi =3D g_new0(BlockInfo, 1);
> +    bi->pc =3D qemu_plugin_tb_vaddr(tb);
> +    bi->insns =3D qemu_plugin_tb_n_insns(tb);
> +
> +    /* save a reference so we can free later */
> +    blocks =3D g_slist_prepend(blocks, bi);
> +    qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
> +                                         QEMU_PLUGIN_CB_NO_REGS, (void *=
)bi);
> +}
> +
> +
> +/*
> + * Instead of encoding master/slave status into what is essentially
> + * two peers we shall just take the simple approach of checking for
> + * the existence of the pipe and assuming if it's not there we are the
> + * first process.
> + */
> +static bool setup_socket(const char *path)
> +{
> +    struct sockaddr_un sockaddr;
> +    int fd;
> +
> +    fd =3D socket(AF_UNIX, SOCK_STREAM, 0);
> +    if (fd < 0) {
> +        perror("create socket");
> +        return false;
> +    }
> +
> +    sockaddr.sun_family =3D AF_UNIX;
> +    g_strlcpy(sockaddr.sun_path, path, sizeof(sockaddr.sun_path) - 1);
> +    if (bind(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr)) < 0) {
> +        perror("bind socket");
> +        close(fd);
> +        return false;
> +    }
> +
> +    /* remember to clean-up */
> +    path_to_unlink =3D g_strdup(path);
> +
> +    if (listen(fd, 1) < 0) {
> +        perror("listen socket");
> +        close(fd);
> +        return false;
> +    }
> +
> +    socket_fd =3D accept(fd, NULL, NULL);
> +    if (socket_fd < 0 && errno !=3D EINTR) {
> +        perror("accept socket");
> +        return false;
> +    }
> +
> +    qemu_plugin_outs("setup_socket::ready\n");
> +
> +    return true;
> +}
> +
> +static bool connect_socket(const char *path)
> +{
> +    int fd;
> +    struct sockaddr_un sockaddr;
> +
> +    fd =3D socket(AF_UNIX, SOCK_STREAM, 0);
> +    if (fd < 0) {
> +        perror("create socket");
> +        return false;
> +    }
> +
> +    sockaddr.sun_family =3D AF_UNIX;
> +    g_strlcpy(sockaddr.sun_path, path, sizeof(sockaddr.sun_path) - 1);
> +
> +    if (connect(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr)) < 0)=
 {
> +        perror("failed to connect");
> +        return false;
> +    }
> +
> +    qemu_plugin_outs("connect_socket::ready\n");
> +
> +    socket_fd =3D fd;
> +    return true;
> +}
> +
> +static bool setup_unix_socket(const char *path)
> +{
> +    if (g_file_test(path, G_FILE_TEST_EXISTS)) {
> +        return connect_socket(path);
> +    } else {
> +        return setup_socket(path);
> +    }
> +}
> +
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> +                                           const qemu_info_t *info,
> +                                           int argc, char **argv)
> +{
> +    int i;
> +
> +    if (!argc || !argv[0]) {
> +        qemu_plugin_outs("Need a socket path to talk to other instance."=
);
> +        return -1;
> +    }
> +
> +    for (i =3D 0; i < argc; i++) {
> +        char *p =3D argv[i];
> +        if (strcmp(p, "verbose") =3D=3D 0) {
> +            verbose =3D true;
> +        } else if (!setup_unix_socket(argv[0])) {
> +            qemu_plugin_outs("Failed to setup socket for communications.=
");
> +            return -1;
> +        }
> +    }
> +
> +    our_id =3D id;
> +
> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> +    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> +    return 0;
> +}
> diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
> index 75467b6db85..b3250e2504c 100644
> --- a/tests/plugin/Makefile
> +++ b/tests/plugin/Makefile
> @@ -13,6 +13,7 @@ NAMES +=3D mem
>  NAMES +=3D hotblocks
>  NAMES +=3D howvec
>  NAMES +=3D hotpages
> +NAMES +=3D lockstep
>
>  SONAMES :=3D $(addsuffix .so,$(addprefix lib,$(NAMES)))
>
> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> index b3cff3cad1a..075daf3d22d 100644
> --- a/tests/tcg/Makefile.target
> +++ b/tests/tcg/Makefile.target
> @@ -128,7 +128,7 @@ RUN_TESTS=3D$(patsubst %,run-%, $(TESTS))
>  ifeq ($(CONFIG_PLUGIN),y)
>  PLUGIN_DIR=3D../../plugin
>  VPATH+=3D$(PLUGIN_DIR)
> -PLUGINS=3D$(notdir $(wildcard $(PLUGIN_DIR)/*.so))
> +PLUGINS=3D$(filter-out liblockstep.so,$(notdir $(wildcard $(PLUGIN_DIR)/=
*.so)))
>
>  # We need to ensure expand the run-plugin-TEST-with-PLUGIN
>  # pre-requistes manually here as we can't use stems to handle it. We
> --
> 2.20.1
>

