Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAFFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575AA206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sotSEZS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575AA206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRvNO-0001UP-7d
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kRvMR-00012y-DN
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 06:47:23 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kRvMN-00017v-CO
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 06:47:22 -0400
Received: by mail-wm1-x342.google.com with SMTP id f21so16752608wml.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 03:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=p7+ubA6/CqNz5OECz5Z4SK5FxAqU8YO8nJQSEcdHzWA=;
 b=sotSEZS27/bj5nDMpNPRLVtTjN1uikEweKtYblW47brpiCuy4SrMNbam2mPhxJH8au
 utPpPYSBWc7EH83wSJxVn3ikYMP711Zh4JvP4HyhmzGlb1Sr5XdXuNKTi96NECtpS71O
 5MH4vhp7+tPzj9JOF4jdKJUHlPmsE7vn4ngh7myqjDNi5H676uxa/HmscwTBs/kAahat
 8MTjIQIutaSREGthKwK8tZtOvM2hS7sU8VLKhTKH56fWNfOcmKNIJiui8i7+FYjaERFw
 hc86iOy6oHCBICokidY2p+cOZPmYFqjFRAXfkAE5/RdUg9eIdAW+I+oshOlYjsd0zdrP
 kkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=p7+ubA6/CqNz5OECz5Z4SK5FxAqU8YO8nJQSEcdHzWA=;
 b=V4t59cG4HwTMHbYR/QTPlnU4rId7mfaiVekL6AR345VdUo6RLk2tLp/kIzcEsDaZF7
 tmhEbM29BdZRUdqpFndlF5ywSBieDxL5OYSq780Ua6+VjJ9lVUFo3ei+UYZgWcgrKekC
 BFbZ/LKMCLTL8eNvtcV/9Zea2eUxXY9CweBRs6iULkqQgbuJOgmehUsLjjuuyr3MDJqP
 QzYiW4hFrXxkDfvCh5cIiPsmuGc68KDnr5dEclVXEZiyuKUAVI/oChBci7ZzBKWCYWFx
 iz7D8vdkPXCYYIBeLSjAbVirGinkUW1yDysDI1Mk2h4yYszjXEBXNyLdXaXlMnR2tVIe
 9cjw==
X-Gm-Message-State: AOAM533ryFIhB+GgIaUsrWJogWuoNAlxL5dpafr8S+NSTRXk0NDPjIiO
 7CFS0uIzCgSWnRjFFL07Btbdkw==
X-Google-Smtp-Source: ABdhPJx1Vd7kgXAtVLbqk63kJ8KE8gYP9nSEUtg671OinT/qerPtJUjTMDvub5LrwyOEBVNSZ3mFgA==
X-Received: by 2002:a1c:111:: with SMTP id 17mr6106943wmb.74.1602499636832;
 Mon, 12 Oct 2020 03:47:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j134sm22851547wmj.7.2020.10.12.03.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 03:47:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D7D5E1FF7E;
 Mon, 12 Oct 2020 11:47:14 +0100 (BST)
References: <20201009063432.303441-1-armbru@redhat.com>
 <20201009063432.303441-10-armbru@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PULL 09/14] qmp: Move dispatcher to a coroutine
In-reply-to: <20201009063432.303441-10-armbru@redhat.com>
Date: Mon, 12 Oct 2020 11:47:14 +0100
Message-ID: <87zh4rzpot.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster <armbru@redhat.com> writes:

> From: Kevin Wolf <kwolf@redhat.com>
>
> This moves the QMP dispatcher to a coroutine and runs all QMP command
> handlers that declare 'coroutine': true in coroutine context so they
> can avoid blocking the main loop while doing I/O or waiting for other
> events.

This subtly changes the replay behaviour leading to a hang in:

  10:55:18 [alex.bennee@hackbox2:~/l/q/b/bisect] (625581c2=E2=80=A6)|=E2=9C=
=9A1(+1/-1) + ./tests/venv/bin/avocado run tests/acceptance/replay_kernel.p=
y:ReplayKernel.test_arm_virt
  Fetching asset from tests/acceptance/replay_kernel.py:ReplayKernel.test_a=
rm_virt
  JOB ID     : ec11fd2544f06e6c0d421f16afa757b49f7ed734
  JOB LOG    : /home/alex.bennee/avocado/job-results/job-2020-10-12T11.40-e=
c11fd2/job.log
   (1/1) tests/acceptance/replay_kernel.py:ReplayKernel.test_arm_virt: ERRO=
R: Could not perform graceful shutdown (26.27 s)
  RESULTS    : PASS 0 | ERROR 1 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | =
CANCEL 0
  JOB TIME   : 27.77 s

Looking at the log:

  2020-10-12 11:40:31,426 __init__         L0085 DEBUG| [    3.887411] rtc-=
pl031 9010000.pl031: setting system clock to 2020-10-12 10:40:31 UTC (16024=
99231)
  2020-10-12 11:40:31,428 __init__         L0085 DEBUG| [    3.887431] sr_i=
nit: No PMIC hook to init smartreflex
  2020-10-12 11:40:31,447 __init__         L0085 DEBUG| [    3.897193] uart=
-pl011 9000000.pl011: no DMA platform data
  2020-10-12 11:40:31,460 __init__         L0085 DEBUG| [    3.897242] md: =
Waiting for all devices to be available before autodetect
  2020-10-12 11:40:31,462 __init__         L0085 DEBUG| [    3.897259] md: =
If you don't use raid, use raid=3Dnoautodetect
  2020-10-12 11:40:31,475 __init__         L0085 DEBUG| [    3.897819] md: =
Autodetecting RAID arrays.
  2020-10-12 11:40:31,476 __init__         L0085 DEBUG| [    3.897832] md: =
autorun ...
  2020-10-12 11:40:31,477 __init__         L0085 DEBUG| [    3.897842] md: =
... autorun DONE.
  2020-10-12 11:40:31,483 __init__         L0085 DEBUG| [    3.897962] VFS:=
 Cannot open root device "(null)" or unknown-block(0,0): error -6
  2020-10-12 11:40:31,483 qmp              L0245 DEBUG| >>> {'execute': 'qu=
it'}
  2020-10-12 11:40:31,495 qmp              L0145 DEBUG| <<< {'timestamp': {=
'seconds': 1602499231, 'microseconds': 493379}, 'event': 'SHUTDOWN', 'data'=
: {'guest': True, 'reason': 'guest-reset'}}
  2020-10-12 11:40:31,733 machine          L0325 WARNI| qemu received signa=
l 6; command: "./qemu-system-arm -display none -vga none -chardev socket,id=
=3Dmon,path=3D/var/tmp/tmpzls53khe/qemu-8487-monitor.sock -mon chardev=3Dmo=
n,mode=3Dcontrol -machine virt -chardev socket,id=3Dconsole,path=3D/var/tmp=
/tmpzls53khe/qemu-8487-console.sock,server,nowait -serial chardev:console -=
icount shift=3D1,rr=3Drecord,rrfile=3D/var/tmp/avocado_n00stdrf/avocado_job=
_aw60qdul/1-tests_acceptance_replay_kernel.py_ReplayKernel.test_arm_virt/re=
play.bin -kernel /home/alex.bennee/avocado/data/cache/by_location/62750ce9e=
069e69e6a7ff04ff54c382ee660b92a/vmlinuz -append printk.time=3D1 panic=3D-1 =
console=3DttyAMA0 -net none -no-reboot"
  2020-10-12 11:40:31,734 stacktrace       L0039 ERROR|
  2020-10-12 11:40:31,734 stacktrace       L0042 ERROR| Reproduced tracebac=
k from: /home/alex.bennee/lsrc/qemu.git/builds/bisect/tests/venv/lib/python=
3.6/site-packages/avocado/core/test.py:767
  2020-10-12 11:40:31,735 stacktrace       L0045 ERROR| Traceback (most rec=
ent call last):
  2020-10-12 11:40:31,735 stacktrace       L0045 ERROR|   File "/home/alex.=
bennee/lsrc/qemu.git/python/qemu/machine.py", line 435, in _do_shutdown
  2020-10-12 11:40:31,735 stacktrace       L0045 ERROR|     self._soft_shut=
down(timeout, has_quit)
  2020-10-12 11:40:31,735 stacktrace       L0045 ERROR|   File "/home/alex.=
bennee/lsrc/qemu.git/python/qemu/machine.py", line 415, in _soft_shutdown
  2020-10-12 11:40:31,735 stacktrace       L0045 ERROR|     self._qmp.cmd('=
quit')
  2020-10-12 11:40:31,735 stacktrace       L0045 ERROR|   File "/home/alex.=
bennee/lsrc/qemu.git/python/qemu/qmp.py", line 266, in cmd
  2020-10-12 11:40:31,735 stacktrace       L0045 ERROR|     return self.cmd=
_obj(qmp_cmd)
  2020-10-12 11:40:31,735 stacktrace       L0045 ERROR|   File "/home/alex.=
bennee/lsrc/qemu.git/python/qemu/qmp.py", line 249, in cmd_obj
  2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|     raise QMPConnec=
tError("Unexpected empty reply from server")
  2020-10-12 11:40:31,736 stacktrace       L0045 ERROR| qemu.qmp.QMPConnect=
Error: Unexpected empty reply from server
  2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|
  2020-10-12 11:40:31,736 stacktrace       L0045 ERROR| The above exception=
 was the direct cause of the following exception:
  2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|
  2020-10-12 11:40:31,736 stacktrace       L0045 ERROR| Traceback (most rec=
ent call last):
  2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|   File "/home/alex.=
bennee/lsrc/qemu.git/builds/bisect/tests/acceptance/replay_kernel.py", line=
 128, in test_arm_virt
  2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|     self.run_rr(ker=
nel_path, kernel_command_line, console_pattern, shift=3D1)
  2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|   File "/home/alex.=
bennee/lsrc/qemu.git/builds/bisect/tests/acceptance/replay_kernel.py", line=
 71, in run_rr
  2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|     True, shift, ar=
gs, replay_path)
  2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|   File "/home/alex.=
bennee/lsrc/qemu.git/builds/bisect/tests/acceptance/replay_kernel.py", line=
 57, in run_vm
  2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|     vm.shutdown()
  2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|   File "/home/alex.=
bennee/lsrc/qemu.git/python/qemu/machine.py", line 465, in shutdown
  2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|     self._do_shutdo=
wn(timeout, has_quit)
  2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|   File "/home/alex.=
bennee/lsrc/qemu.git/python/qemu/machine.py", line 439, in _do_shutdown
  2020-10-12 11:40:31,736 stacktrace       L0045 ERROR|     from exc
  2020-10-12 11:40:31,737 stacktrace       L0045 ERROR| qemu.machine.Abnorm=
alShutdown: Could not perform graceful shutdown

The commit before:

  2020-10-12 11:44:02,803 __init__         L0085 DEBUG| [    3.897837] md: =
... autorun DONE.
  2020-10-12 11:44:02,806 __init__         L0085 DEBUG| [    3.897958] VFS:=
 Cannot open root device "(null)" or unknown-block(0,0): error -6
  2020-10-12 11:44:02,806 qmp              L0245 DEBUG| >>> {'execute': 'qu=
it'}
  2020-10-12 11:44:02,814 qmp              L0250 DEBUG| <<< {'return': {}}
  2020-10-12 11:44:02,879 replay_kernel    L0059 INFO | finished the record=
ing with log size 237596 bytes
  2020-10-12 11:44:02,879 replay_kernel    L0064 INFO | elapsed time 24.35 =
sec
  2020-10-12 11:44:02,888 replay_kernel    L0044 INFO | replaying the execu=
tion...
  2020-10-12 11:44:02,889 machine          L0362 DEBUG| VM launch command: =
'./qemu-system-arm -display none -vga none -chardev socket,id=3Dmon,path=3D=
/var/tmp/tmpihqswp6_/qemu-7747-monitor.sock -mon chardev=3Dmon,mode=3Dcontr=
ol -machine virt -chardev socket,id=3Dconsole,path=3D/var/tmp/tmpihqswp6_/q=
emu-7747-console.sock,server,nowait -serial chardev:console
  -icount shift=3D1,rr=3Dreplay,rrfile=3D/var/tmp/avocado_o3pfy2he/avocado_=
job_nf30vjqg/1-tests_acceptance_replay_kernel.py_ReplayKernel.test_arm_virt=
/replay.bin -kernel /home/alex.bennee/avocado/data/cache/by_location/62750c=
e9e069e69e6a7ff04ff54c382ee660b92a/vmlinuz -append printk.time=3D1 panic=3D=
-1 console=3DttyAMA0 -net none -no-reboot'
  2020-10-12 11:44:03,001 qmp              L0245 DEBUG| >>> {'execute': 'qm=
p_capabilities'}
  2020-10-12 11:44:03,172 qmp              L0250 DEBUG| <<< {'return': {}}
  2020-10-12 11:44:04,899 __init__         L0085 DEBUG| [    0.000000] Boot=
ing Linux on physical CPU 0x0
  2020-10-12 11:44:04,904 __init__         L0085 DEBUG| [    0.000000] Linu=
x version 4.18.16-300.fc29.armv7hl (mockbuild@buildvm-armv7-06.arm.fedorapr=
oject.org) (gcc version 8.2.1 20180801 (Red Hat 8.2.1-2) (GCC)) #1 SMP Sun =
Oct 21 00:56:28 UTC 2018


>
> For commands that are not declared safe to run in a coroutine, the
> dispatcher drops out of coroutine context by calling the QMP command
> handler from a bottom half.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <20201005155855.256490-10-kwolf@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/qmp/dispatch.h |   1 +
>  monitor/monitor-internal.h  |   6 +-
>  monitor/monitor.c           |  55 +++++++++++++---
>  monitor/qmp.c               | 122 +++++++++++++++++++++++++++---------
>  qapi/qmp-dispatch.c         |  63 +++++++++++++++++--
>  qapi/qmp-registry.c         |   3 +
>  util/aio-posix.c            |   8 ++-
>  7 files changed, 213 insertions(+), 45 deletions(-)
>
> diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
> index 9fd2b720a7..af8d96c570 100644
> --- a/include/qapi/qmp/dispatch.h
> +++ b/include/qapi/qmp/dispatch.h
> @@ -31,6 +31,7 @@ typedef enum QmpCommandOptions
>  typedef struct QmpCommand
>  {
>      const char *name;
> +    /* Runs in coroutine context if QCO_COROUTINE is set */
>      QmpCommandFunc *fn;
>      QmpCommandOptions options;
>      QTAILQ_ENTRY(QmpCommand) node;
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index b39e03b744..b55d6df07f 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -155,7 +155,9 @@ static inline bool monitor_is_qmp(const Monitor *mon)
>=20=20
>  typedef QTAILQ_HEAD(MonitorList, Monitor) MonitorList;
>  extern IOThread *mon_iothread;
> -extern QEMUBH *qmp_dispatcher_bh;
> +extern Coroutine *qmp_dispatcher_co;
> +extern bool qmp_dispatcher_co_shutdown;
> +extern bool qmp_dispatcher_co_busy;
>  extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
>  extern QemuMutex monitor_lock;
>  extern MonitorList mon_list;
> @@ -173,7 +175,7 @@ void monitor_fdsets_cleanup(void);
>=20=20
>  void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
>  void monitor_data_destroy_qmp(MonitorQMP *mon);
> -void monitor_qmp_bh_dispatcher(void *data);
> +void coroutine_fn monitor_qmp_dispatcher_co(void *data);
>=20=20
>  int get_monitor_def(int64_t *pval, const char *name);
>  void help_cmd(Monitor *mon, const char *name);
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index ef68ca9d21..ceffe1a83b 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -55,8 +55,32 @@ typedef struct {
>  /* Shared monitor I/O thread */
>  IOThread *mon_iothread;
>=20=20
> -/* Bottom half to dispatch the requests received from I/O thread */
> -QEMUBH *qmp_dispatcher_bh;
> +/* Coroutine to dispatch the requests received from I/O thread */
> +Coroutine *qmp_dispatcher_co;
> +
> +/* Set to true when the dispatcher coroutine should terminate */
> +bool qmp_dispatcher_co_shutdown;
> +
> +/*
> + * qmp_dispatcher_co_busy is used for synchronisation between the
> + * monitor thread and the main thread to ensure that the dispatcher
> + * coroutine never gets scheduled a second time when it's already
> + * scheduled (scheduling the same coroutine twice is forbidden).
> + *
> + * It is true if the coroutine is active and processing requests.
> + * Additional requests may then be pushed onto mon->qmp_requests,
> + * and @qmp_dispatcher_co_shutdown may be set without further ado.
> + * @qmp_dispatcher_co_busy must not be woken up in this case.
> + *
> + * If false, you also have to set @qmp_dispatcher_co_busy to true and
> + * wake up @qmp_dispatcher_co after pushing the new requests.
> + *
> + * The coroutine will automatically change this variable back to false
> + * before it yields.  Nobody else may set the variable to false.
> + *
> + * Access must be atomic for thread safety.
> + */
> +bool qmp_dispatcher_co_busy;
>=20=20
>  /*
>   * Protects mon_list, monitor_qapi_event_state, coroutine_mon,
> @@ -623,9 +647,24 @@ void monitor_cleanup(void)
>      }
>      qemu_mutex_unlock(&monitor_lock);
>=20=20
> -    /* QEMUBHs needs to be deleted before destroying the I/O thread */
> -    qemu_bh_delete(qmp_dispatcher_bh);
> -    qmp_dispatcher_bh =3D NULL;
> +    /*
> +     * The dispatcher needs to stop before destroying the I/O thread.
> +     *
> +     * We need to poll both qemu_aio_context and iohandler_ctx to make
> +     * sure that the dispatcher coroutine keeps making progress and
> +     * eventually terminates.  qemu_aio_context is automatically
> +     * polled by calling AIO_WAIT_WHILE on it, but we must poll
> +     * iohandler_ctx manually.
> +     */
> +    qmp_dispatcher_co_shutdown =3D true;
> +    if (!qatomic_xchg(&qmp_dispatcher_co_busy, true)) {
> +        aio_co_wake(qmp_dispatcher_co);
> +    }
> +
> +    AIO_WAIT_WHILE(qemu_get_aio_context(),
> +                   (aio_poll(iohandler_get_aio_context(), false),
> +                    qatomic_mb_read(&qmp_dispatcher_co_busy)));
> +
>      if (mon_iothread) {
>          iothread_destroy(mon_iothread);
>          mon_iothread =3D NULL;
> @@ -649,9 +688,9 @@ void monitor_init_globals_core(void)
>       * have commands assuming that context.  It would be nice to get
>       * rid of those assumptions.
>       */
> -    qmp_dispatcher_bh =3D aio_bh_new(iohandler_get_aio_context(),
> -                                   monitor_qmp_bh_dispatcher,
> -                                   NULL);
> +    qmp_dispatcher_co =3D qemu_coroutine_create(monitor_qmp_dispatcher_c=
o, NULL);
> +    qatomic_mb_set(&qmp_dispatcher_co_busy, true);
> +    aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
>  }
>=20=20
>  int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index e746b3575d..b42f8c6af3 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -133,6 +133,10 @@ static void monitor_qmp_respond(MonitorQMP *mon, QDi=
ct *rsp)
>      }
>  }
>=20=20
> +/*
> + * Runs outside of coroutine context for OOB commands, but in
> + * coroutine context for everything else.
> + */
>  static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
>  {
>      QDict *rsp;
> @@ -206,43 +210,99 @@ static QMPRequest *monitor_qmp_requests_pop_any_wit=
h_lock(void)
>      return req_obj;
>  }
>=20=20
> -void monitor_qmp_bh_dispatcher(void *data)
> +void coroutine_fn monitor_qmp_dispatcher_co(void *data)
>  {
> -    QMPRequest *req_obj =3D monitor_qmp_requests_pop_any_with_lock();
> +    QMPRequest *req_obj =3D NULL;
>      QDict *rsp;
>      bool need_resume;
>      MonitorQMP *mon;
>=20=20
> -    if (!req_obj) {
> -        return;
> -    }
> +    while (true) {
> +        assert(qatomic_mb_read(&qmp_dispatcher_co_busy) =3D=3D true);
>=20=20
> -    mon =3D req_obj->mon;
> -    /*  qmp_oob_enabled() might change after "qmp_capabilities" */
> -    need_resume =3D !qmp_oob_enabled(mon) ||
> -        mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1;
> -    qemu_mutex_unlock(&mon->qmp_queue_lock);
> -    if (req_obj->req) {
> -        QDict *qdict =3D qobject_to(QDict, req_obj->req);
> -        QObject *id =3D qdict ? qdict_get(qdict, "id") : NULL;
> -        trace_monitor_qmp_cmd_in_band(qobject_get_try_str(id) ?: "");
> -        monitor_qmp_dispatch(mon, req_obj->req);
> -    } else {
> -        assert(req_obj->err);
> -        rsp =3D qmp_error_response(req_obj->err);
> -        req_obj->err =3D NULL;
> -        monitor_qmp_respond(mon, rsp);
> -        qobject_unref(rsp);
> -    }
> +        /*
> +         * Mark the dispatcher as not busy already here so that we
> +         * don't miss any new requests coming in the middle of our
> +         * processing.
> +         */
> +        qatomic_mb_set(&qmp_dispatcher_co_busy, false);
>=20=20
> -    if (need_resume) {
> -        /* Pairs with the monitor_suspend() in handle_qmp_command() */
> -        monitor_resume(&mon->common);
> -    }
> -    qmp_request_free(req_obj);
> +        while (!(req_obj =3D monitor_qmp_requests_pop_any_with_lock())) {
> +            /*
> +             * No more requests to process.  Wait to be reentered from
> +             * handle_qmp_command() when it pushes more requests, or
> +             * from monitor_cleanup() when it requests shutdown.
> +             */
> +            if (!qmp_dispatcher_co_shutdown) {
> +                qemu_coroutine_yield();
>=20=20
> -    /* Reschedule instead of looping so the main loop stays responsive */
> -    qemu_bh_schedule(qmp_dispatcher_bh);
> +                /*
> +                 * busy must be set to true again by whoever
> +                 * rescheduled us to avoid double scheduling
> +                 */
> +                assert(qatomic_xchg(&qmp_dispatcher_co_busy, false) =3D=
=3D true);
> +            }
> +
> +            /*
> +             * qmp_dispatcher_co_shutdown may have changed if we
> +             * yielded and were reentered from monitor_cleanup()
> +             */
> +            if (qmp_dispatcher_co_shutdown) {
> +                return;
> +            }
> +        }
> +
> +        if (qatomic_xchg(&qmp_dispatcher_co_busy, true) =3D=3D true) {
> +            /*
> +             * Someone rescheduled us (probably because a new requests
> +             * came in), but we didn't actually yield. Do that now,
> +             * only to be immediately reentered and removed from the
> +             * list of scheduled coroutines.
> +             */
> +            qemu_coroutine_yield();
> +        }
> +
> +        /*
> +         * Move the coroutine from iohandler_ctx to qemu_aio_context for
> +         * executing the command handler so that it can make progress if=
 it
> +         * involves an AIO_WAIT_WHILE().
> +         */
> +        aio_co_schedule(qemu_get_aio_context(), qmp_dispatcher_co);
> +        qemu_coroutine_yield();
> +
> +        mon =3D req_obj->mon;
> +        /* qmp_oob_enabled() might change after "qmp_capabilities" */
> +        need_resume =3D !qmp_oob_enabled(mon) ||
> +            mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1;
> +        qemu_mutex_unlock(&mon->qmp_queue_lock);
> +        if (req_obj->req) {
> +            QDict *qdict =3D qobject_to(QDict, req_obj->req);
> +            QObject *id =3D qdict ? qdict_get(qdict, "id") : NULL;
> +            trace_monitor_qmp_cmd_in_band(qobject_get_try_str(id) ?: "");
> +            monitor_qmp_dispatch(mon, req_obj->req);
> +        } else {
> +            assert(req_obj->err);
> +            rsp =3D qmp_error_response(req_obj->err);
> +            req_obj->err =3D NULL;
> +            monitor_qmp_respond(mon, rsp);
> +            qobject_unref(rsp);
> +        }
> +
> +        if (need_resume) {
> +            /* Pairs with the monitor_suspend() in handle_qmp_command() =
*/
> +            monitor_resume(&mon->common);
> +        }
> +        qmp_request_free(req_obj);
> +
> +        /*
> +         * Yield and reschedule so the main loop stays responsive.
> +         *
> +         * Move back to iohandler_ctx so that nested event loops for
> +         * qemu_aio_context don't start new monitor commands.
> +         */
> +        aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
> +        qemu_coroutine_yield();
> +    }
>  }
>=20=20
>  static void handle_qmp_command(void *opaque, QObject *req, Error *err)
> @@ -303,7 +363,9 @@ static void handle_qmp_command(void *opaque, QObject =
*req, Error *err)
>      qemu_mutex_unlock(&mon->qmp_queue_lock);
>=20=20
>      /* Kick the dispatcher routine */
> -    qemu_bh_schedule(qmp_dispatcher_bh);
> +    if (!qatomic_xchg(&qmp_dispatcher_co_busy, true)) {
> +        aio_co_wake(qmp_dispatcher_co);
> +    }
>  }
>=20=20
>  static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index 5677ba92ca..9a2d7dd29a 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -12,12 +12,16 @@
>   */
>=20=20
>  #include "qemu/osdep.h"
> +
> +#include "block/aio.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/dispatch.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qjson.h"
>  #include "sysemu/runstate.h"
>  #include "qapi/qmp/qbool.h"
> +#include "qemu/coroutine.h"
> +#include "qemu/main-loop.h"
>=20=20
>  static QDict *qmp_dispatch_check_obj(QDict *dict, bool allow_oob,
>                                       Error **errp)
> @@ -88,6 +92,30 @@ bool qmp_is_oob(const QDict *dict)
>          && !qdict_haskey(dict, "execute");
>  }
>=20=20
> +typedef struct QmpDispatchBH {
> +    const QmpCommand *cmd;
> +    Monitor *cur_mon;
> +    QDict *args;
> +    QObject **ret;
> +    Error **errp;
> +    Coroutine *co;
> +} QmpDispatchBH;
> +
> +static void do_qmp_dispatch_bh(void *opaque)
> +{
> +    QmpDispatchBH *data =3D opaque;
> +
> +    assert(monitor_cur() =3D=3D NULL);
> +    monitor_set_cur(qemu_coroutine_self(), data->cur_mon);
> +    data->cmd->fn(data->args, data->ret, data->errp);
> +    monitor_set_cur(qemu_coroutine_self(), NULL);
> +    aio_co_wake(data->co);
> +}
> +
> +/*
> + * Runs outside of coroutine context for OOB commands, but in coroutine
> + * context for everything else.
> + */
>  QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
>                      bool allow_oob, Monitor *cur_mon)
>  {
> @@ -153,12 +181,39 @@ QDict *qmp_dispatch(const QmpCommandList *cmds, QOb=
ject *request,
>          qobject_ref(args);
>      }
>=20=20
> +    assert(!(oob && qemu_in_coroutine()));
>      assert(monitor_cur() =3D=3D NULL);
> -    monitor_set_cur(qemu_coroutine_self(), cur_mon);
> +    if (!!(cmd->options & QCO_COROUTINE) =3D=3D qemu_in_coroutine()) {
> +        monitor_set_cur(qemu_coroutine_self(), cur_mon);
> +        cmd->fn(args, &ret, &err);
> +        monitor_set_cur(qemu_coroutine_self(), NULL);
> +    } else {
> +       /*
> +        * Actual context doesn't match the one the command needs.
> +        *
> +        * Case 1: we are in coroutine context, but command does not
> +        * have QCO_COROUTINE.  We need to drop out of coroutine
> +        * context for executing it.
> +        *
> +        * Case 2: we are outside coroutine context, but command has
> +        * QCO_COROUTINE.  Can't actually happen, because we get here
> +        * outside coroutine context only when executing a command
> +        * out of band, and OOB commands never have QCO_COROUTINE.
> +        */
> +        assert(!oob && qemu_in_coroutine() && !(cmd->options & QCO_COROU=
TINE));
>=20=20
> -    cmd->fn(args, &ret, &err);
> -
> -    monitor_set_cur(qemu_coroutine_self(), NULL);
> +        QmpDispatchBH data =3D {
> +            .cur_mon    =3D cur_mon,
> +            .cmd        =3D cmd,
> +            .args       =3D args,
> +            .ret        =3D &ret,
> +            .errp       =3D &err,
> +            .co         =3D qemu_coroutine_self(),
> +        };
> +        aio_bh_schedule_oneshot(qemu_get_aio_context(), do_qmp_dispatch_=
bh,
> +                                &data);
> +        qemu_coroutine_yield();
> +    }
>      qobject_unref(args);
>      if (err) {
>          /* or assert(!ret) after reviewing all handlers: */
> diff --git a/qapi/qmp-registry.c b/qapi/qmp-registry.c
> index d0f9a1d3e3..58c65b5052 100644
> --- a/qapi/qmp-registry.c
> +++ b/qapi/qmp-registry.c
> @@ -20,6 +20,9 @@ void qmp_register_command(QmpCommandList *cmds, const c=
har *name,
>  {
>      QmpCommand *cmd =3D g_malloc0(sizeof(*cmd));
>=20=20
> +    /* QCO_COROUTINE and QCO_ALLOW_OOB are incompatible for now */
> +    assert(!((options & QCO_COROUTINE) && (options & QCO_ALLOW_OOB)));
> +
>      cmd->name =3D name;
>      cmd->fn =3D fn;
>      cmd->enabled =3D true;
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index 280f27bb99..30f5354b1e 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -15,6 +15,7 @@
>=20=20
>  #include "qemu/osdep.h"
>  #include "block/block.h"
> +#include "qemu/main-loop.h"
>  #include "qemu/rcu.h"
>  #include "qemu/rcu_queue.h"
>  #include "qemu/sockets.h"
> @@ -558,8 +559,13 @@ bool aio_poll(AioContext *ctx, bool blocking)
>       * There cannot be two concurrent aio_poll calls for the same AioCon=
text (or
>       * an aio_poll concurrent with a GSource prepare/check/dispatch call=
back).
>       * We rely on this below to avoid slow locked accesses to ctx->notif=
y_me.
> +     *
> +     * aio_poll() may only be called in the AioContext's thread. iohandl=
er_ctx
> +     * is special in that it runs in the main thread, but that thread's =
context
> +     * is qemu_aio_context.
>       */
> -    assert(in_aio_context_home_thread(ctx));
> +    assert(in_aio_context_home_thread(ctx =3D=3D iohandler_get_aio_conte=
xt() ?
> +                                      qemu_get_aio_context() : ctx));
>=20=20
>      qemu_lockcnt_inc(&ctx->list_lock);


--=20
Alex Benn=C3=A9e

