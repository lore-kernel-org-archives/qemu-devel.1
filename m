Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9497C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32B242168B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+//L9Ys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B242168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFGkK-0002cd-3A
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 08:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFGj8-0001dz-Cy
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:58:30 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFGj6-0004q1-5G
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:58:29 -0400
Received: by mail-wr1-x443.google.com with SMTP id c15so15676727wrs.11
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 05:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=rqp0Kaxpy9plq0/imRxAkgl3f9MbkKLg68mMl7SPHwg=;
 b=C+//L9YsoEn0//TqO0sa00Hmk6Ytzmp5KpzuzSIjcRHnFcRyBsIUPhuu2RrCZo2TCP
 BOUD6HFqo8cCY8uh2WbTRPaIqFcjaynDkMf7h60LSpbKLH3A4bwwdTw2CTGZV6tHq8iQ
 lFl36SsfhU/HOctSbIr3N3jzIxMIeN+i5T/eOVMrDAoumjMsY+E43MXIY6TGfOKEoLAS
 nXfypVHM1g+9r5m1L+n4pTmE7VQMGbHr2umWD8I2acZ007k6YiXIFsHZ163p6X4tPhck
 vOjGwyB1oMvaesVyiYYnbudbVeCUFEsbfjcsiPOo1V95DIpmbNBTYZPmVFfEa4sFgSjp
 8TvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=rqp0Kaxpy9plq0/imRxAkgl3f9MbkKLg68mMl7SPHwg=;
 b=qPdPdlD7Lcyq1WKG3uIp5rtHA45QqjKQVcVYGive6Xd22jT93H/fyDWHcfvY2Js/WU
 1UjpA9ALr1UoGUUuzGzaGkeuluelSzHym+hkhxsIHDwjvnwSB996AEo2woLHgp2IP6Nz
 eArPFDlFoI+tAHS+epQw9AjgRveqxeq6SF+6OFVcsqYrvCvQD33w4Egdz8NF7tWa2+3P
 pmqHQoswUXdZPLmmtO+5fC0orrQTuBzykfF0w3w8W4Rme+0YNioAWBQhdSO18hjKYewi
 lEZgOvQu6ots2v4ibQF+CEmYwvnfRp5G2bf3UsCFAWq/PPLzDOz2hO9VE/DZBaU7HqeH
 utjw==
X-Gm-Message-State: AOAM531wPxnxJLR72i78WGUSPvkE8P5o0+GBYjAE9oGagbDVyxZKo1Ij
 Ntqss0CGQVRiweBW5+WU7hVsPQ==
X-Google-Smtp-Source: ABdhPJwKDkGcF3TC/fcYBCgCuYJf+/PFXg11B3mQZ2r/7nR9xLrhTq/76PdGlHY9aCfXhmJimbDC5g==
X-Received: by 2002:adf:e9c3:: with SMTP id l3mr21143742wrn.63.1599483504374; 
 Mon, 07 Sep 2020 05:58:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 70sm29505042wme.15.2020.09.07.05.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 05:58:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8983A1FF7E;
 Mon,  7 Sep 2020 13:58:22 +0100 (BST)
References: <159903454714.28509.7439453309116734374.stgit@pasha-ThinkPad-X280>
 <159903459923.28509.4300111201059622860.stgit@pasha-ThinkPad-X280>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH v3 09/15] replay: implement replay-seek command
In-reply-to: <159903459923.28509.4300111201059622860.stgit@pasha-ThinkPad-X280>
Date: Mon, 07 Sep 2020 13:58:22 +0100
Message-ID: <87sgbtrbf5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, pbonzini@redhat.com, mreitz@redhat.com,
 philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:

> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>
> This patch adds hmp/qmp commands replay_seek/replay-seek that proceed
> the execution to the specified instruction count.
> The command automatically loads nearest snapshot and replays the execution
> to find the desired instruction count.

Should there be an initial snapshot created at instruction 0? Using a
separate monitor channel:

  (qemu) replay_break 190505
  replay_break 190505
  (qemu) c
  (qemu) info replay
  info replay
  Replaying execution 'record.out': instruction count =3D 190505
  (qemu) replay_seek 190000
  replay_seek 190000
  snapshotting is disabled

And then the guest dies with a sigabort:

  ./qemu-system-aarch64 -cpu cortex-a53 -display none -serial stdio -machin=
e virt -kernel zephyr.elf -net none -icount shift=3D6,align=3Doff,sleep=3Do=
ff,rr=3Dreplay,rrfile=3Drecord.out -drive file=3Drecord.qcow2,if=3Dnone,sna=
pshot,id=3Drr -monitor telnet:127.0.0.1:4444 -S
  *** Booting Zephyr OS build zephyr-v2.3.0-1183-ge5628ad0faf3  ***
  Hello World! qemu_cortex_a53
  double free or corruption (out)
  fish: =E2=80=9C./qemu-system-aarch64 -cpu cort=E2=80=A6=E2=80=9D terminat=
ed by signal SIGABRT (Abort)

>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hmp-commands.hx           |   18 +++++++++
>  include/monitor/hmp.h     |    1=20
>  qapi/replay.json          |   20 ++++++++++
>  replay/replay-debugging.c |   92 +++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 131 insertions(+)
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index e8ce385879..4288274c4e 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1851,6 +1851,24 @@ SRST
>    The command is ignored when there are no replay breakpoints.
>  ERST
>=20=20
> +    {
> +        .name       =3D "replay_seek",
> +        .args_type  =3D "icount:i",
> +        .params     =3D "icount",
> +        .help       =3D "replay execution to the specified instruction c=
ount",
> +        .cmd        =3D hmp_replay_seek,
> +    },
> +
> +SRST
> +``replay_seek`` *icount*
> +Automatically proceed to the instruction count *icount*, when
> +replaying the execution. The command automatically loads nearest
> +snapshot and replays the execution to find the desired instruction.
> +When there is no preceding snapshot or the execution is not replayed,
> +then the command fails.
> +*icount* for the reference may be observed with ``info replay`` command.
> +ERST
> +
>      {
>          .name       =3D "info",
>          .args_type  =3D "item:s?",
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index 21849bdda5..655eb81a4c 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -133,5 +133,6 @@ void hmp_info_sev(Monitor *mon, const QDict *qdict);
>  void hmp_info_replay(Monitor *mon, const QDict *qdict);
>  void hmp_replay_break(Monitor *mon, const QDict *qdict);
>  void hmp_replay_delete_break(Monitor *mon, const QDict *qdict);
> +void hmp_replay_seek(Monitor *mon, const QDict *qdict);
>=20=20
>  #endif
> diff --git a/qapi/replay.json b/qapi/replay.json
> index 173ba76107..bfd83d7591 100644
> --- a/qapi/replay.json
> +++ b/qapi/replay.json
> @@ -99,3 +99,23 @@
>  #
>  ##
>  { 'command': 'replay-delete-break' }
> +
> +##
> +# @replay-seek:
> +#
> +# Automatically proceed to the instruction count @icount, when
> +# replaying the execution. The command automatically loads nearest
> +# snapshot and replays the execution to find the desired instruction.
> +# When there is no preceding snapshot or the execution is not replayed,
> +# then the command fails.
> +# icount for the reference may be obtained with @query-replay command.
> +#
> +# @icount: target instruction count
> +#
> +# Since: 5.2
> +#
> +# Example:
> +#
> +# -> { "execute": "replay-seek", "data": { "icount": 220414 } }
> +##
> +{ 'command': 'replay-seek', 'data': { 'icount': 'int' } }
> diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
> index 86e19bb217..cfd0221692 100644
> --- a/replay/replay-debugging.c
> +++ b/replay/replay-debugging.c
> @@ -19,6 +19,8 @@
>  #include "qapi/qapi-commands-replay.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qemu/timer.h"
> +#include "block/snapshot.h"
> +#include "migration/snapshot.h"
>=20=20
>  void hmp_info_replay(Monitor *mon, const QDict *qdict)
>  {
> @@ -127,3 +129,93 @@ void hmp_replay_delete_break(Monitor *mon, const QDi=
ct *qdict)
>          return;
>      }
>  }
> +
> +static char *replay_find_nearest_snapshot(int64_t icount,
> +                                          int64_t *snapshot_icount)
> +{
> +    BlockDriverState *bs;
> +    QEMUSnapshotInfo *sn_tab;
> +    QEMUSnapshotInfo *nearest =3D NULL;
> +    char *ret =3D NULL;
> +    int nb_sns, i;
> +    AioContext *aio_context;
> +
> +    *snapshot_icount =3D -1;
> +
> +    bs =3D bdrv_all_find_vmstate_bs();
> +    if (!bs) {
> +        goto fail;
> +    }
> +    aio_context =3D bdrv_get_aio_context(bs);
> +
> +    aio_context_acquire(aio_context);
> +    nb_sns =3D bdrv_snapshot_list(bs, &sn_tab);
> +    aio_context_release(aio_context);
> +
> +    for (i =3D 0; i < nb_sns; i++) {
> +        if (bdrv_all_find_snapshot(sn_tab[i].name, &bs) =3D=3D 0) {
> +            if (sn_tab[i].icount !=3D -1ULL
> +                && sn_tab[i].icount <=3D icount
> +                && (!nearest || nearest->icount < sn_tab[i].icount)) {
> +                nearest =3D &sn_tab[i];
> +            }
> +        }
> +    }
> +    if (nearest) {
> +        ret =3D g_strdup(nearest->name);
> +        *snapshot_icount =3D nearest->icount;
> +    }
> +    g_free(sn_tab);
> +
> +fail:
> +    return ret;
> +}
> +
> +static void replay_seek(int64_t icount, QEMUTimerCB callback, Error **er=
rp)
> +{
> +    char *snapshot =3D NULL;
> +    int64_t snapshot_icount;
> +
> +    if (replay_mode !=3D REPLAY_MODE_PLAY) {
> +        error_setg(errp, "replay must be enabled to seek");
> +        return;
> +    }
> +    if (!replay_snapshot) {
> +        error_setg(errp, "snapshotting is disabled");
> +        return;
> +    }
> +
> +    snapshot =3D replay_find_nearest_snapshot(icount, &snapshot_icount);
> +    if (snapshot) {
> +        if (icount < replay_get_current_icount()
> +            || replay_get_current_icount() < snapshot_icount) {
> +            vm_stop(RUN_STATE_RESTORE_VM);
> +            load_snapshot(snapshot, errp);
> +        }
> +        g_free(snapshot);
> +    }
> +    if (replay_get_current_icount() <=3D icount) {
> +        replay_break(icount, callback, NULL);
> +        vm_start();
> +    } else {
> +        error_setg(errp, "cannot seek to the specified instruction count=
");
> +    }
> +}
> +
> +void qmp_replay_seek(int64_t icount, Error **errp)
> +{
> +    replay_seek(icount, replay_stop_vm, errp);
> +}
> +
> +void hmp_replay_seek(Monitor *mon, const QDict *qdict)
> +{
> +    int64_t icount =3D qdict_get_try_int(qdict, "icount", -1LL);
> +    Error *err =3D NULL;
> +
> +    qmp_replay_seek(icount, &err);
> +    if (err) {
> +        error_report_err(err);
> +        error_free(err);
> +        return;
> +    }
> +}


--=20
Alex Benn=C3=A9e

