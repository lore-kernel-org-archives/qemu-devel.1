Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E4DC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:01:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1AE62085B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aF3tdoYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1AE62085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNwLF-0003ZS-1T
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 07:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kNwJv-00032K-Md
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 07:00:19 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kNwJs-00050O-8F
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 07:00:19 -0400
Received: by mail-wm1-x341.google.com with SMTP id s13so2427724wmh.4
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 04:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=YPJuvK5ZIjy/kTBTbihqttXu00ZpV6BySdLYc66MF4E=;
 b=aF3tdoYLPLfSfHFjrgQWmnPD3XTmOH0ER26Il8o3n//UeqmyaIu0b8ZbgRuOKFAu5H
 Rr51BRYAJ5Nud2mXutC6QU+Fh5pnIyNmc+rxGapZWOM77nsirsMD375Wj7g0cgInETao
 /mVZRMI0LQlyumUryvg/FlpJ4ULdlJlqpKC/oznLjkVFqpNSssIntE5j7XBHYS4FpDTr
 akXpwViFRMkiydpqjzdezMqGn1XDoaY9GNXonD59D5dQmmnRiaoDWstTVTpQeUNDdF75
 moJUBL0jxWgQ5JfY780qxYBUY3EalFpf1l11uhsB35/KVcnqHiqvEzZORchnwwjNG5DW
 OJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=YPJuvK5ZIjy/kTBTbihqttXu00ZpV6BySdLYc66MF4E=;
 b=bqQASjjfN8OaBWYGhrfugGGPiD8N1052LJpdi2e/EeEXYXsJ5Zfsi8vfjTtCUvLJCJ
 pXnZCQCOfnI7Z5VgJVCDGiHHrgiN3Qzqt5FJl+JNGFJyJvLsg+q1phY8v7ydyOXbRs3m
 /+eFvxNzwx/OWTHW26yPkT/dkZWjYuEXXCsRJuv/OhUtXQZB3L2jrL4Kb+Y9E7Ns1pCN
 qB7aTBvVvk+C65q3ShT0Mn1/6G710OGSx9O62DXidce9bvH3qt+DCUlJ5MrbYk5mpOJp
 IcD9NeqSuaP6Ejap40Ckphtq4EjZ7MzhfjB4GziIo+YUpihMCtfWSQbMNnKNBGSyzAP5
 iWCA==
X-Gm-Message-State: AOAM530qZqCmkeYUf+HYVRKLH/f5oYs15SyU2JszK2+02yKaln/yOMBM
 ZBYsX0psqij28u4EGy9sfGTVfQ==
X-Google-Smtp-Source: ABdhPJwh8N9Gdz75yn5GLHySevYfPu2t3fgIo9ifcxdHFsdgvtrhjvDeiTilC/VFO96rFgDP2MebiQ==
X-Received: by 2002:a1c:5f54:: with SMTP id t81mr2249102wmb.142.1601550012443; 
 Thu, 01 Oct 2020 04:00:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k6sm7480436wmi.1.2020.10.01.04.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 04:00:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7062B1FF7E;
 Thu,  1 Oct 2020 12:00:10 +0100 (BST)
References: <160137726426.31007.12061315974029139983.stgit@pasha-ThinkPad-X280>
 <160137729342.31007.12705791813674207702.stgit@pasha-ThinkPad-X280>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH v6 05/14] qapi: introduce replay.json for
 record/replay-related stuff
In-reply-to: <160137729342.31007.12705791813674207702.stgit@pasha-ThinkPad-X280>
Date: Thu, 01 Oct 2020 12:00:10 +0100
Message-ID: <87ft6ynrd1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
> This patch adds replay.json file. It will be
> used for adding record/replay-related data structures and commands.
>
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Just to note there are now some minor conflicts in qapi/misc.json and
meson.build which meant this didn't apply cleanly.

--=20
Alex Benn=C3=A9e

