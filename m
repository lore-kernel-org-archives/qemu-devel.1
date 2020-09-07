Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9342C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:46:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257462166E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vagf9jPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257462166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFGXH-0003dL-9w
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 08:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFGWP-0002zb-4W
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:45:21 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFGWM-0003EH-TC
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:45:20 -0400
Received: by mail-wr1-x442.google.com with SMTP id a17so15654175wrn.6
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 05:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ugk4Y3geD9ifOgEK6ReNGaZP56sAkkVxDXbT3ilG3eM=;
 b=Vagf9jPqO1tCmxgJrg4cGX8bRXZI9yu9R8j+N7I/BY3mDy3LIC6zqopE+QQ7EMmJU1
 xQevN0ROV3UE5hP7fgL+qru6Lz0iwyT84IaZsfS31cCkGpO0nJzw0KBRHJFUCJFdINW8
 qXK871PkPt6gXSyLfQ5c7675vENoaH0BazZZumZ6I1pVdbaZcy0T+CN6NOVSJ/I8DwSV
 p+mrlry9AtDNwCk1wWQK6IEB1JdA0PQZd7Ls+iDT0nPY77odckRXvj0BDVdm1e/eUSpO
 qu1sKhE2uahCCR2Yfx27/rWaF/GZI98Qk/OuYuTDUZ3ITgugpa+faxT6XwF+hYlFJa4L
 41zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ugk4Y3geD9ifOgEK6ReNGaZP56sAkkVxDXbT3ilG3eM=;
 b=phHtRqndR+M2nhH/CUeKyf7/DcpjYpQRvql141mWw2kcnCpJFll8wPxlBIMrecYAyR
 UTW/4iRtaPOv/u7sezswyegljuglfwjrcRy+vjDBmKGbplSdgHYzfZv2IlnmwUADR3/T
 ehyQt741T4A6QCyv81afX1eMLTTZDLxNxnNzBIxH6gwsBw6VD0QJU+RAbw1bDN0JG44b
 QfVz6z0toIVlNhZHdUkN4f8LfkPSwTa0457oo5Tc8FPsyK9a4UVmvILSFNiG9GoajBKM
 2s+tlI5yujEiz2sJVp37A5PNcNTC+qCSJGUtPrjEVTe9zUl+Xm0ctnS54xnGSP4ZWkAn
 C7hg==
X-Gm-Message-State: AOAM533fVdtvFJ9Y7wC0il1RaQEM+5Byu+7irAq75vUAqN5eidXdJD1q
 dgH+VRzAzUOX90K8hz+eW09dcA==
X-Google-Smtp-Source: ABdhPJyl9Ajq0+rZfRPB0KFi+mIAULdvizIx5qytF1wG7TASW62NGpzAAbOAzMf/Pm2whPayI71BQg==
X-Received: by 2002:adf:fe42:: with SMTP id m2mr21033149wrs.367.1599482717055; 
 Mon, 07 Sep 2020 05:45:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p18sm8692987wrx.47.2020.09.07.05.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 05:45:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 69F791FF7E;
 Mon,  7 Sep 2020 13:45:15 +0100 (BST)
References: <159903454714.28509.7439453309116734374.stgit@pasha-ThinkPad-X280>
 <159903459923.28509.4300111201059622860.stgit@pasha-ThinkPad-X280>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH v3 09/15] replay: implement replay-seek command
In-reply-to: <159903459923.28509.4300111201059622860.stgit@pasha-ThinkPad-X280>
Date: Mon, 07 Sep 2020 13:45:15 +0100
Message-ID: <87v9gprc10.fsf@linaro.org>
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


This seems to break the build:

  Warning, treated as error:
  /home/alex/lsrc/qemu.git/docs/../hmp-commands.hx:1863:Definition list end=
s without a blank line; unexpected unindent.



--=20
Alex Benn=C3=A9e

