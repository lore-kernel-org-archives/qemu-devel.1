Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B815CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C847E20731
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wbUpfrXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C847E20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYanS-0005xe-U9
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 15:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYagE-0002fo-Fo
 for qemu-devel@nongnu.org; Tue, 12 May 2020 15:35:06 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYagC-0002Ot-Oo
 for qemu-devel@nongnu.org; Tue, 12 May 2020 15:35:06 -0400
Received: by mail-wr1-x442.google.com with SMTP id s8so17235848wrt.9
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 12:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=KcxF8DVQAqh0pqWSpwPkYBoajfccQl1VsHrDvMroOmI=;
 b=wbUpfrXkjrcBIRoQH/bxnrVYm+/3mIaRCbBO0djoeUVi9xlGXhOAPrVZCwtTWQeVRO
 tTgoKYNU/i1DecECrC6XfqOvr6J1+2mk6cLn15SsjJkkNvf22sBdgh/zqY1WJuuKv9LI
 KdpaaxjDc3zRxt9Vo7NU2vrdLIqMISF2ORF8ca/SQUvE0ZcGJek8tJEfc2Cujxq7GDM+
 Mexv3P91wvfXT3dt5OQfMImhWkA4+B1WlpMRsDROps+8r4SkPylzSihP/Qu56EJfNj7d
 1coc8NwIJc+v1XF0iE6F2Grh3Y9TsxFoZ05kTdFdgUEa/k264IpE80JGcABr9rWs9E76
 guwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=KcxF8DVQAqh0pqWSpwPkYBoajfccQl1VsHrDvMroOmI=;
 b=hw5JnRVs4ZOQV0nRe9Oi3GYSz1RQIc+Apcc9iAsv2QhvP9bMTDkxhcj7AmFC68B1rw
 LA14VNwkTZoXgLemQRTKr1lIfSy2xkmHp8BSz7Y1VZNO+f6h4Rg/0JZooIlpnkiLXmOF
 s6rxD95mR2AWExYJ4XJbhqeAyiJ+cqAVSFjG9mpjPXeGJmkjV+bVlaX4rd81P/DdkMCe
 ZxP7RqCsAeawaF2reuXuvx2cdiBOwiIPgZTzJrwyduW9AD0HSaGix3BIuXHyc2w+GhoL
 UX0LeFba3hZVMdxsha0yaGBN6q4jokPnRZ6mTL9qHHMKgH32CeNkvMnYAqBorW1fnLPl
 wgZw==
X-Gm-Message-State: AGi0PubgnEiodcQHDeg80Q5mzIAtXTVLEBgmA772DZgZOeHsp7JFFMmP
 4ub+8Dxwrg+oTelPWXi/2jONwQ==
X-Google-Smtp-Source: APiQypIUwM3+giysVFlfVbMfnlo3ZqX1Q0syj3NWOErlKm35HaVzBESt7XGu9u49b36W0KYCBaQ06w==
X-Received: by 2002:adf:e784:: with SMTP id n4mr28189117wrm.170.1589312102954; 
 Tue, 12 May 2020 12:35:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f128sm20946066wme.1.2020.05.12.12.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 12:35:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 315F21FF7E;
 Tue, 12 May 2020 20:35:00 +0100 (BST)
References: <CAEme+7FPF+inSJSXQPmuv8Up3Eam0N7fT03zqM-RvcvKsxjfVQ@mail.gmail.com>
 <f4feb648-7dc5-ac54-bc0b-db650dd176f1@vivier.eu>
 <CAEme+7EtF6B2+2U_yF2dd-g2m+=S3P5=DL1oLmHfmWw2S7PYAw@mail.gmail.com>
 <20200509230016.GA109593@sff>
 <CAEme+7H82A2RNk5g09rmhThxW4=6sqWP5o65OCsJ8zf1L-nb+w@mail.gmail.com>
 <20200512005521.GA198983@sff>
 <CAEme+7E+d4Obmc=6bDcZgP5oEx9F57qe9RE2X=iFw+Yo=+i9_A@mail.gmail.com>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nikolay Igotti <igotti@gmail.com>
Subject: Re: [PATCH 3/3] plugins: avoid failing plugin when CPU is inited
 several times
In-reply-to: <CAEme+7E+d4Obmc=6bDcZgP5oEx9F57qe9RE2X=iFw+Yo=+i9_A@mail.gmail.com>
Date: Tue, 12 May 2020 20:35:00 +0100
Message-ID: <873685eyl7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Riku Voipio <riku.voipio@iki.fi>, "Emilio G. Cota" <cota@braap.org>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Nikolay Igotti <igotti@gmail.com> writes:

> --- counter.c
>
> #include <assert.h>
> #include <pthread.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
>
> #include <glib.h>
>
> #include <qemu-plugin.h>
>
> QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
>
> // Files with descriptors after this one are intercepted for instruction
> counting marks.
> #define CATCH_BASE 0xcafebabe
>
> static uint64_t insn_count =3D 0;
> static pthread_t counting =3D false;
> static pthread_t counting_for =3D 0;
> static bool on_every_close =3D false;
>
> static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
> {
>     if (counting && pthread_self() =3D=3D counting_for)
>         insn_count++;
> }
>
> static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> {
>     size_t n =3D qemu_plugin_tb_n_insns(tb);
>     size_t i;
>
>     for (i =3D 0; i < n; i++) {
>         struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, i);
>
>         // TODO: do this call only on first insn in bb.
>         qemu_plugin_register_vcpu_insn_exec_cb(
>             insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS, NULL);
>     }
> }
>
> static void print_insn_count(void) {
>     g_autofree gchar *out =3D g_strdup_printf("executed %" PRIu64 "
> instructions\n", insn_count);
>     qemu_plugin_outs(out);
> }
>
> static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
>                         int64_t num, uint64_t a1, uint64_t a2,
>                         uint64_t a3, uint64_t a4, uint64_t a5,
>                         uint64_t a6, uint64_t a7, uint64_t a8)
> {
>     // We put our listener on fd reads in range [CATCH_BASE, CATCH_BASE +=
 1]
>     if (num =3D=3D 0) { // sys_read
>         switch (a1)
>         {
>             case CATCH_BASE + 0:
>                 counting =3D true;
>                 counting_for =3D pthread_self();
>                 insn_count =3D 0;
>                 break;
>             case CATCH_BASE + 1: {
>                 counting =3D false;
>                 counting_for =3D 0;
>                 if (a3 =3D=3D 8) {
>                     // In case of user emulation in QEMU, addresses are 1=
:1
> translated, so we can tell the caller
>                     // number of executed instructions by just writing in=
to
> the buffer argument of read.
>                     *(uint64_t*)a2 =3D insn_count;

Hmm this was certainly unintentional - is it the host or guest address
you are messing with here? I wouldn't count on it pointing where you
think and relying on it to pass information back to the instrumented
guest.

Anyway I have a replication - we are trying to insert the same id into
the plugin cpu index hash table twice.=20

>                 }
>                 print_insn_count();
>                 break;
>             }
>             default:
>                 break;
>         }
>     }
>     if (num =3D=3D 3 && on_every_close) { // sys_close
>         print_insn_count();
>     }
> }
>
> QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                                            const qemu_info_t *info,
>                                            int argc, char **argv)
> {
>     int i;
>     for (i =3D 0; i < argc; i++) {
>         if (!strcmp(argv[i], "on_every_close")) {
>             on_every_close =3D true;
>             counting =3D true;
>             counting_for =3D pthread_self();
>         }
>     }
>
>     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>     qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
>     return 0;
> }
>
> --- test.c
>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <pthread.h>
>
> #define CATCH_BASE 0xcafebabe
>
> static void start_counting() {
>     char buf;
>     int rv =3D read(CATCH_BASE, &buf, 1);
>     (void)rv;
> }
>
> static void end_counting() {
>     uint64_t counter =3D 0;
>     int rv =3D read(CATCH_BASE + 1, &counter, sizeof(counter));
>     (void)rv;
>     printf("We got %lld from TCG\n", counter);
> }
>
> int global =3D 0;
>
> typedef struct {
>     int delay;
> } ThreadArg;
>
> static void* thread_fn(void* varg)  {
>     ThreadArg* arg =3D varg;
>     usleep(arg->delay);
>     free(arg);
>     return NULL;
> }
>
> int main(int argc, char** argv) {
>     int i;
>     int repeat =3D 100;
> #define THREAD_NUM 10
>     pthread_t threads[THREAD_NUM];
>
>     if (argc > 1) {
>         repeat =3D atoi(argv[1]);
>     }
>
>     for (i =3D 0; i < THREAD_NUM; i++) {
>         ThreadArg* arg =3D calloc(sizeof(ThreadArg), 1);
>         arg->delay =3D i * 100;
>         pthread_create(threads + i, NULL, thread_fn, arg);
>     }
>
>     start_counting();
>     for (i =3D 0; i < repeat; i++) {
>         global +=3D i;
>     }
>     end_counting();
>
>     for (i =3D 0; i < THREAD_NUM; i++) {
>         pthread_join(threads[i], NULL);
>     }
>
>     return 0;
> }
>
> On Tue, May 12, 2020 at 3:55 AM Emilio G. Cota <cota@braap.org> wrote:
>
>> On Mon, May 11, 2020 at 18:53:19 +0300, Nikolay Igotti wrote:
>> > Attached to the mail counter.c when running with attached test.c compi=
led
>> > to Linux standalone binary shows failing assert, unless the patch is
>> > applied.
>>
>> I didn't get the attachment. Can you paste the code at the end of your
>> reply?
>>
>> Thanks,
>>                 Emilio
>>


--=20
Alex Benn=C3=A9e

