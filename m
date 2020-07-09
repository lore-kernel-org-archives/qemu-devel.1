Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75090C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD6D2077D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zwyk41OJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD6D2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jta79-0006i6-IK
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 13:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jta6B-0005bc-JV
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 13:12:39 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:40161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jta69-0003EI-Je
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 13:12:39 -0400
Received: by mail-lj1-x241.google.com with SMTP id j11so3251609ljo.7
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 10:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VZw3hsv4qH3PqD3OGEL0HYAcWbD07TY01E77mFXa2pA=;
 b=Zwyk41OJdwICrYIYfSatOc+2AIVkNey2/LKilJsj4C/Uu/S4l+PbfElBDriXa70JwZ
 DCOiitwFDToEPHOjqkqYGzoBOpBpfnNMMlj9ARgzoDboBViEKLDEBC1uWb2zR5NOrebf
 fv781PujwLljpGlKIHjaHMS1PNncadj4DpZc62lq9ASjo9xMkVuKpkBqVxBYV+rju+7+
 A4K4NQG7H5Iy4SPKjnTVFbmHF5qFnlkoe8iPWMYSYq0bTS1LTgqT8Md1cpJzpjmsF5Vk
 ou/ZDzBAVeJIZ6z/OTchV5sIcKnYfVs5CXho1KVN8CrAq5DE0fUFetGmuzToBZ0Wt6pP
 cuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VZw3hsv4qH3PqD3OGEL0HYAcWbD07TY01E77mFXa2pA=;
 b=cDvAzMhIUitYvmuX4vU5UwfqP/DliU0L3cyE1bO1zAFdNlYNBOVUbFOuJJkP2+1Uhv
 BIwnC3GQMtrGtLLzunFHZy9Yhw1o1C7SkCQEE8JFUWGKdHrttCmaTs0YUt/ESHPvw9kN
 WelP97H0qYq+8OWl2PBzXDkPNTExooPmO2HLdanxEdecflnUyz0U8a1VL0DcAHkPt/bn
 Z1qAdDPuaC/Lys24VcAT9sCD9knFNOkyPoieIafCzDbMSpO3JI5vLDYNgLh6F4bwbwzS
 5TcK59OaMdw+HEBLf/rKqmHAE+yAMiqGK/GISfoRJ1RMXL7gyOjPXBhk+lSSAXlay8Hd
 sbZA==
X-Gm-Message-State: AOAM531UjUoRThyV1Dn/3r7nI1kjBKRMTx8lJNXjzJdox62WZiPX89zB
 KtO39rms7u3nv1T3Q/tSdLLYcVqH6w39EcgO2Du/Sw==
X-Google-Smtp-Source: ABdhPJwrPYK2MQqMDg2VFGekIvJzrSYpGNEK8mDfBnw4amXLnU7AAhBgKbPIWmYG1kBh1DI7d0exDS8mwO/oZ012N30=
X-Received: by 2002:a2e:9855:: with SMTP id e21mr34338896ljj.424.1594314754675; 
 Thu, 09 Jul 2020 10:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-9-alex.bennee@linaro.org>
In-Reply-To: <20200709141327.14631-9-alex.bennee@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Thu, 9 Jul 2020 13:12:39 -0400
Message-ID: <CAEyhzFtKVXUy7xy_NOqGhK__VkfxbZeODCJd7k+QgxMLDYDAgQ@mail.gmail.com>
Subject: Re: [PATCH v1 08/13] plugins: expand the bb plugin to be thread safe
 and track per-cpu
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, robhenry@microsoft.com,
 f4bug@amsat.org, aaron@os.amperecomputing.com,
 "Emilio G. Cota" <cota@braap.org>, Dave Bort <dbort@dbort.com>,
 kuhn.chenqun@huawei.com, Peter Puhov <peter.puhov@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Robert Foley <robert.foley@linaro.org>

On Thu, 9 Jul 2020 at 10:13, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> While there isn't any easy way to make the inline counts thread safe
> we can ensure the callback based ones are. While we are at it we can
> reduce introduce a new option ("idle") to dump a report of the current
> bb and insn count each time a vCPU enters the idle state.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Dave Bort <dbort@dbort.com>
>
> ---
> v2
>   - fixup for non-inline linux-user case
>   - minor cleanup and re-factor
> ---
>  tests/plugin/bb.c | 96 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 83 insertions(+), 13 deletions(-)
>
> diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
> index df19fd359df3..89c373e19cd8 100644
> --- a/tests/plugin/bb.c
> +++ b/tests/plugin/bb.c
> @@ -16,24 +16,67 @@
>
>  QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
>
> -static uint64_t bb_count;
> -static uint64_t insn_count;
> +typedef struct {
> +    GMutex lock;
> +    int index;
> +    uint64_t bb_count;
> +    uint64_t insn_count;
> +} CPUCount;
> +
> +/* Used by the inline & linux-user counts */
>  static bool do_inline;
> +static CPUCount inline_count;
> +
> +/* Dump running CPU total on idle? */
> +static bool idle_report;
> +static GPtrArray *counts;
> +static int max_cpus;
> +
> +static void gen_one_cpu_report(CPUCount *count, GString *report)
> +{
> +    if (count->bb_count) {
> +        g_string_append_printf(report, "CPU%d: "
> +                               "bb's: %" PRIu64", insns: %" PRIu64 "\n",
> +                               count->index,
> +                               count->bb_count, count->insn_count);
> +    }
> +}
>
>  static void plugin_exit(qemu_plugin_id_t id, void *p)
>  {
> -    g_autofree gchar *out =3D g_strdup_printf(
> -        "bb's: %" PRIu64", insns: %" PRIu64 "\n",
> -        bb_count, insn_count);
> -    qemu_plugin_outs(out);
> +    g_autoptr(GString) report =3D g_string_new("");
> +
> +    if (do_inline || !max_cpus) {
> +        g_string_printf(report, "bb's: %" PRIu64", insns: %" PRIu64 "\n"=
,
> +                        inline_count.bb_count, inline_count.insn_count);
> +    } else {
> +        g_ptr_array_foreach(counts, (GFunc) gen_one_cpu_report, report);
> +    }
> +    qemu_plugin_outs(report->str);
> +}
> +
> +static void vcpu_idle(qemu_plugin_id_t id, unsigned int cpu_index)
> +{
> +    CPUCount *count =3D g_ptr_array_index(counts, cpu_index);
> +    g_autoptr(GString) report =3D g_string_new("");
> +    gen_one_cpu_report(count, report);
> +
> +    if (report->len > 0) {
> +        g_string_prepend(report, "Idling ");
> +        qemu_plugin_outs(report->str);
> +    }
>  }
>
>  static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>  {
> -    unsigned long n_insns =3D (unsigned long)udata;
> +    CPUCount *count =3D max_cpus ?
> +        g_ptr_array_index(counts, cpu_index) : &inline_count;
>
> -    insn_count +=3D n_insns;
> -    bb_count++;
> +    unsigned long n_insns =3D (unsigned long)udata;
> +    g_mutex_lock(&count->lock);
> +    count->insn_count +=3D n_insns;
> +    count->bb_count++;
> +    g_mutex_unlock(&count->lock);
>  }
>
>  static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb=
)
> @@ -42,9 +85,9 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct q=
emu_plugin_tb *tb)
>
>      if (do_inline) {
>          qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_=
ADD_U64,
> -                                                 &bb_count, 1);
> +                                                 &inline_count.bb_count,=
 1);
>          qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_=
ADD_U64,
> -                                                 &insn_count, n_insns);
> +                                                 &inline_count.insn_coun=
t, n_insns);
>      } else {
>          qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
>                                               QEMU_PLUGIN_CB_NO_REGS,
> @@ -56,8 +99,35 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin=
_id_t id,
>                                             const qemu_info_t *info,
>                                             int argc, char **argv)
>  {
> -    if (argc && strcmp(argv[0], "inline") =3D=3D 0) {
> -        do_inline =3D true;
> +    int i;
> +
> +    for (i =3D 0; i < argc; i++) {
> +        char *opt =3D argv[i];
> +        if (g_strcmp0(opt, "inline") =3D=3D 0) {
> +            do_inline =3D true;
> +        } else if (g_strcmp0(opt, "idle") =3D=3D 0) {
> +            idle_report =3D true;
> +        } else {
> +            fprintf(stderr, "option parsing failed: %s\n", opt);
> +            return -1;
> +        }
> +    }
> +
> +    if (info->system_emulation && !do_inline) {
> +        max_cpus =3D info->system.max_vcpus;
> +        counts =3D g_ptr_array_new();
> +        for (i =3D 0; i < max_cpus; i++) {
> +            CPUCount *count =3D g_new0(CPUCount, 1);
> +            g_mutex_init(&count->lock);
> +            count->index =3D i;
> +            g_ptr_array_add(counts, count);
> +        }
> +    } else if (!do_inline) {
> +        g_mutex_init(&inline_count.lock);
> +    }
> +
> +    if (idle_report) {
> +        qemu_plugin_register_vcpu_idle_cb(id, vcpu_idle);
>      }
>
>      qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> --
> 2.20.1
>

