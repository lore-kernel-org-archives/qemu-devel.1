Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E513BC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E3D620674
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7qQKjX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3D620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYQRR-0002BC-R6
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 04:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <igotti@gmail.com>) id 1jYQQo-0001b3-Qq
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:38:30 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:33136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <igotti@gmail.com>) id 1jYQQn-0008Fx-BE
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:38:30 -0400
Received: by mail-lj1-x244.google.com with SMTP id w10so1913403ljo.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 01:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IfM3S3EcK++cJ1NJ5WG+UqIBxGu8PlGAf6BsccJ5Odo=;
 b=A7qQKjX7i9a79U7aX36LracRzSY+XhOhdWamBBoBihD/9I6eThgkpkjrK3nEJDrFSj
 uy46s0DAkxq/2gf6gR6yUd5YCZDHXud4oRWulUQFe+l28rFgcvp92LiIeMXfvjOo7/O7
 ezxIJ5O9SkKp3LIcXZgtfcRLfUoI4oD+97FNqI9g28g6PMi5gTdbkHLag8LIez77BERQ
 c5JheM3sfZ1dW04DeUQxSxAJck4giHK8Dfz7UaXpC4hY3g+8rtye0PFJ9UdzvHa4pxrf
 SJaVM3FFv2faViRtcMQENIEVQFMf8XrDZU55q8KZTWGtt6D/Ze2YIm8aOTymT8ufl388
 i2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IfM3S3EcK++cJ1NJ5WG+UqIBxGu8PlGAf6BsccJ5Odo=;
 b=Rw39/317LBFx7rukzoCXZaIDpwmSTQ8WdrD3e9LyA6+wscVUsxW9y7sH5sqXCp8cg2
 9sf7sUCAtpxfhkb3PY8EoOz/are1i2xmABlFIUi+fwpk+xR4frhohhRtlwIEEDmZLutk
 oslt9qiQn41tG0RRhkPTcNpt1yNzwIj57X19sH2PRGJB4HMuY25oHyOS9/2mjuJqOGlQ
 QHZXKYzAAOFv9xqb/yiiFf6HCBViUpGVIxIrj8EEmE8M/TZGsudxp2ChpLO8q/SdlqV9
 sHYnNJLtEdfBPDXiwinWLrIiYQ4hd5M/tiZumqLoNKlOOrzI5xUS/PMJ/kV+BSDxoQdr
 zwTQ==
X-Gm-Message-State: AOAM533Gl9Z/Aui/lB/ToZF5BJF6piiq7up0LbrZsCRo6W/eEFF9ndXd
 oHDK563z8MllG//H7STGyfVRcfCw0cM+G/Lw02k=
X-Google-Smtp-Source: ABdhPJwi9K/BpFaWroO9p+6ggxo8SIkuJhO6fKLMsOhodAH0HxeEViyUo/Cs2KaFVK11llQu6lmE9IdCtlyQ+m2zwrM=
X-Received: by 2002:a2e:b248:: with SMTP id n8mr12736301ljm.207.1589272707507; 
 Tue, 12 May 2020 01:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAEme+7FPF+inSJSXQPmuv8Up3Eam0N7fT03zqM-RvcvKsxjfVQ@mail.gmail.com>
 <f4feb648-7dc5-ac54-bc0b-db650dd176f1@vivier.eu>
 <CAEme+7EtF6B2+2U_yF2dd-g2m+=S3P5=DL1oLmHfmWw2S7PYAw@mail.gmail.com>
 <20200509230016.GA109593@sff>
 <CAEme+7H82A2RNk5g09rmhThxW4=6sqWP5o65OCsJ8zf1L-nb+w@mail.gmail.com>
 <20200512005521.GA198983@sff>
In-Reply-To: <20200512005521.GA198983@sff>
From: Nikolay Igotti <igotti@gmail.com>
Date: Tue, 12 May 2020 11:38:16 +0300
Message-ID: <CAEme+7E+d4Obmc=6bDcZgP5oEx9F57qe9RE2X=iFw+Yo=+i9_A@mail.gmail.com>
Subject: Re: [PATCH 3/3] plugins: avoid failing plugin when CPU is inited
 several times
To: "Emilio G. Cota" <cota@braap.org>
Content-Type: multipart/alternative; boundary="0000000000002ea93605a56f63a9"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=igotti@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002ea93605a56f63a9
Content-Type: text/plain; charset="UTF-8"

--- counter.c

#include <assert.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <glib.h>

#include <qemu-plugin.h>

QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;

// Files with descriptors after this one are intercepted for instruction
counting marks.
#define CATCH_BASE 0xcafebabe

static uint64_t insn_count = 0;
static pthread_t counting = false;
static pthread_t counting_for = 0;
static bool on_every_close = false;

static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
{
    if (counting && pthread_self() == counting_for)
        insn_count++;
}

static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
{
    size_t n = qemu_plugin_tb_n_insns(tb);
    size_t i;

    for (i = 0; i < n; i++) {
        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);

        // TODO: do this call only on first insn in bb.
        qemu_plugin_register_vcpu_insn_exec_cb(
            insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS, NULL);
    }
}

static void print_insn_count(void) {
    g_autofree gchar *out = g_strdup_printf("executed %" PRIu64 "
instructions\n", insn_count);
    qemu_plugin_outs(out);
}

static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
                        int64_t num, uint64_t a1, uint64_t a2,
                        uint64_t a3, uint64_t a4, uint64_t a5,
                        uint64_t a6, uint64_t a7, uint64_t a8)
{
    // We put our listener on fd reads in range [CATCH_BASE, CATCH_BASE + 1]
    if (num == 0) { // sys_read
        switch (a1)
        {
            case CATCH_BASE + 0:
                counting = true;
                counting_for = pthread_self();
                insn_count = 0;
                break;
            case CATCH_BASE + 1: {
                counting = false;
                counting_for = 0;
                if (a3 == 8) {
                    // In case of user emulation in QEMU, addresses are 1:1
translated, so we can tell the caller
                    // number of executed instructions by just writing into
the buffer argument of read.
                    *(uint64_t*)a2 = insn_count;
                }
                print_insn_count();
                break;
            }
            default:
                break;
        }
    }
    if (num == 3 && on_every_close) { // sys_close
        print_insn_count();
    }
}

QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                           const qemu_info_t *info,
                                           int argc, char **argv)
{
    int i;
    for (i = 0; i < argc; i++) {
        if (!strcmp(argv[i], "on_every_close")) {
            on_every_close = true;
            counting = true;
            counting_for = pthread_self();
        }
    }

    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
    qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
    return 0;
}

--- test.c

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

#define CATCH_BASE 0xcafebabe

static void start_counting() {
    char buf;
    int rv = read(CATCH_BASE, &buf, 1);
    (void)rv;
}

static void end_counting() {
    uint64_t counter = 0;
    int rv = read(CATCH_BASE + 1, &counter, sizeof(counter));
    (void)rv;
    printf("We got %lld from TCG\n", counter);
}

int global = 0;

typedef struct {
    int delay;
} ThreadArg;

static void* thread_fn(void* varg)  {
    ThreadArg* arg = varg;
    usleep(arg->delay);
    free(arg);
    return NULL;
}

int main(int argc, char** argv) {
    int i;
    int repeat = 100;
#define THREAD_NUM 10
    pthread_t threads[THREAD_NUM];

    if (argc > 1) {
        repeat = atoi(argv[1]);
    }

    for (i = 0; i < THREAD_NUM; i++) {
        ThreadArg* arg = calloc(sizeof(ThreadArg), 1);
        arg->delay = i * 100;
        pthread_create(threads + i, NULL, thread_fn, arg);
    }

    start_counting();
    for (i = 0; i < repeat; i++) {
        global += i;
    }
    end_counting();

    for (i = 0; i < THREAD_NUM; i++) {
        pthread_join(threads[i], NULL);
    }

    return 0;
}

On Tue, May 12, 2020 at 3:55 AM Emilio G. Cota <cota@braap.org> wrote:

> On Mon, May 11, 2020 at 18:53:19 +0300, Nikolay Igotti wrote:
> > Attached to the mail counter.c when running with attached test.c compiled
> > to Linux standalone binary shows failing assert, unless the patch is
> > applied.
>
> I didn't get the attachment. Can you paste the code at the end of your
> reply?
>
> Thanks,
>                 Emilio
>

--0000000000002ea93605a56f63a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>--- counter.c</div><div><br></div>#include &lt;assert=
.h&gt;<br>#include &lt;pthread.h&gt;<br>#include &lt;stdio.h&gt;<br>#includ=
e &lt;stdlib.h&gt;<br>#include &lt;string.h&gt;<br>#include &lt;unistd.h&gt=
;<br><br>#include &lt;glib.h&gt;<br><br>#include &lt;qemu-plugin.h&gt;<br><=
br>QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;<br><=
br>// Files with descriptors after this one are intercepted for instruction=
 counting marks.<br>#define CATCH_BASE 0xcafebabe<br><br>static uint64_t in=
sn_count =3D 0;<br>static pthread_t counting =3D false;<br>static pthread_t=
 counting_for =3D 0;<br>static bool on_every_close =3D false;<br><br>static=
 void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)<br>{<br>=
=C2=A0 =C2=A0 if (counting &amp;&amp; pthread_self() =3D=3D counting_for)<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 insn_count++;<br>}<br><br>static void vcpu_tb=
_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)<br>{<br>=C2=A0 =C2=
=A0 size_t n =3D qemu_plugin_tb_n_insns(tb);<br>=C2=A0 =C2=A0 size_t i;<br>=
<br>=C2=A0 =C2=A0 for (i =3D 0; i &lt; n; i++) {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, i);<br=
><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 // TODO: do this call only on first insn i=
n bb.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_plugin_register_vcpu_insn_exec_cb=
(<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 insn, vcpu_insn_exec_before,=
 QEMU_PLUGIN_CB_NO_REGS, NULL);<br>=C2=A0 =C2=A0 }<br>}<br><br>static void =
print_insn_count(void) {<br>=C2=A0 =C2=A0 g_autofree gchar *out =3D g_strdu=
p_printf(&quot;executed %&quot; PRIu64 &quot; instructions\n&quot;, insn_co=
unt);<br>=C2=A0 =C2=A0 qemu_plugin_outs(out);<br>}<br><br>static void vcpu_=
syscall(qemu_plugin_id_t id, unsigned int vcpu_index,<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t =
num, uint64_t a1, uint64_t a2,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t a3, uint64_t a4, uint64=
_t a5,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 uint64_t a6, uint64_t a7, uint64_t a8)<br>{<br>=C2=A0 =
=C2=A0 // We put our listener on fd reads in range [CATCH_BASE, CATCH_BASE =
+ 1]<br>=C2=A0 =C2=A0 if (num =3D=3D 0) { // sys_read<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 switch (a1)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case CATCH_BASE + 0:<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 counting =3D true;<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 counting_for =3D pthread_self();<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 insn_count =3D 0;<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case CATCH_BASE + 1: {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 counting =3D false;<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 counting_for =3D 0;<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (a3 =3D=3D 8) {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // In ca=
se of user emulation in QEMU, addresses are 1:1 translated, so we can tell =
the caller<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 // number of executed instructions by just writing into the buff=
er argument of read.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 *(uint64_t*)a2 =3D insn_count;<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 print_insn_count();<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 if (num =3D=3D 3 &amp;&=
amp; on_every_close) { // sys_close<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 print_in=
sn_count();<br>=C2=A0 =C2=A0 }<br>}<br><br>QEMU_PLUGIN_EXPORT int qemu_plug=
in_install(qemu_plugin_id_t id,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const qemu_info_t *info,<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in=
t argc, char **argv)<br>{<br>=C2=A0 =C2=A0 int i;<br>=C2=A0 =C2=A0 for (i =
=3D 0; i &lt; argc; i++) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strcmp(argv[=
i], &quot;on_every_close&quot;)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 on_every_close =3D true;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 counting =3D true;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 countin=
g_for =3D pthread_self();<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0=
 }<br><br>=C2=A0 =C2=A0 qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_t=
rans);<br>=C2=A0 =C2=A0 qemu_plugin_register_vcpu_syscall_cb(id, vcpu_sysca=
ll);<br>=C2=A0 =C2=A0 return 0;<br>}<br><div><br></div><div>--- test.c</div=
><div><br></div><div>#include &lt;stdint.h&gt;<br>#include &lt;stdio.h&gt;<=
br>#include &lt;stdlib.h&gt;<br>#include &lt;unistd.h&gt;<br>#include &lt;p=
thread.h&gt;<br><br>#define CATCH_BASE 0xcafebabe<br><br>static void start_=
counting() {<br>=C2=A0 =C2=A0 char buf;<br>=C2=A0 =C2=A0 int rv =3D read(CA=
TCH_BASE, &amp;buf, 1);<br>=C2=A0 =C2=A0 (void)rv;<br>}<br><br>static void =
end_counting() {<br>=C2=A0 =C2=A0 uint64_t counter =3D 0;<br>=C2=A0 =C2=A0 =
int rv =3D read(CATCH_BASE + 1, &amp;counter, sizeof(counter));<br>=C2=A0 =
=C2=A0 (void)rv;<br>=C2=A0 =C2=A0 printf(&quot;We got %lld from TCG\n&quot;=
, counter);<br>}<br><br>int global =3D 0;<br><br>typedef struct {<br>=C2=A0=
 =C2=A0 int delay;<br>} ThreadArg;<br><br>static void* thread_fn(void* varg=
) =C2=A0{<br>=C2=A0 =C2=A0 ThreadArg* arg =3D varg;<br>=C2=A0 =C2=A0 usleep=
(arg-&gt;delay);<br>=C2=A0 =C2=A0 free(arg);<br>=C2=A0 =C2=A0 return NULL;<=
br>}<br><br>int main(int argc, char** argv) {<br>=C2=A0 =C2=A0 int i;<br>=
=C2=A0 =C2=A0 int repeat =3D 100;<br>#define THREAD_NUM 10<br>=C2=A0 =C2=A0=
 pthread_t threads[THREAD_NUM];<br><br>=C2=A0 =C2=A0 if (argc &gt; 1) {<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 repeat =3D atoi(argv[1]);<br>=C2=A0 =C2=A0 }<br=
><br>=C2=A0 =C2=A0 for (i =3D 0; i &lt; THREAD_NUM; i++) {<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ThreadArg* arg =3D calloc(sizeof(ThreadArg), 1);<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 arg-&gt;delay =3D i * 100;<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 pthread_create(threads + i, NULL, thread_fn, arg);<br>=C2=A0 =C2=A0 }<b=
r><br>=C2=A0 =C2=A0 start_counting();<br>=C2=A0 =C2=A0 for (i =3D 0; i &lt;=
 repeat; i++) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 global +=3D i;<br>=C2=A0 =C2=
=A0 }<br>=C2=A0 =C2=A0 end_counting();<br><br>=C2=A0 =C2=A0 for (i =3D 0; i=
 &lt; THREAD_NUM; i++) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_join(thread=
s[i], NULL);<br>=C2=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 return 0;<br>}<br></di=
v></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Tue, May 12, 2020 at 3:55 AM Emilio G. Cota &lt;<a href=3D"mailto:cota=
@braap.org">cota@braap.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On Mon, May 11, 2020 at 18:53:19 +0300, Nikolay I=
gotti wrote:<br>
&gt; Attached to the mail counter.c when running with attached test.c compi=
led<br>
&gt; to Linux standalone binary shows failing assert, unless the patch is<b=
r>
&gt; applied.<br>
<br>
I didn&#39;t get the attachment. Can you paste the code at the end of your<=
br>
reply?<br>
<br>
Thanks,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Emilio<br>
</blockquote></div>

--0000000000002ea93605a56f63a9--

