Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A49C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD96822227
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTdxB+TO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD96822227
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSkT5-0003bs-Qn
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 13:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kSkS8-0002iO-8n
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 13:20:41 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kSkS3-0002wl-TR
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 13:20:38 -0400
Received: by mail-wr1-x441.google.com with SMTP id t9so4763863wrq.11
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 10:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=f2LAvOLCtg+gBBtP37v3rG4sVgYob1xV6cJ5nHPj0Rg=;
 b=eTdxB+TO87uCLfr61w4YTOYzcrq6932KBjV8kddHGjgZWaCu/eP9BSOQg3BYfhgxiZ
 B+iBS2iGH+m9tQWWlJ7e0/jbYElEn8xiNKduJV/fmYtA5uMIWnVNuOfGfQYimXHljojU
 TTnULG/YIAZm+fUS5uH3VUKdjoFxve7b0gM6T/T8tElGIIxxiNnimrqtZe6KQWuFjm2e
 OnL9THOmYySZKa1mkWd0vW+m9ygktJc8eRohI6Pt96/dxKUCMDxORmSg1k2O1V03j281
 kE1N/78ElMk94d7ccXhLyNkyfCQMbz1EOSX6X9y9KsM5hfok3do/5cx+VuMk4Uj6+sYe
 ZvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=f2LAvOLCtg+gBBtP37v3rG4sVgYob1xV6cJ5nHPj0Rg=;
 b=sPgMy5TKh4PWATUyf5jxCP73vczYytzAYuU7qIMDORt+7W+Mzig9ycRgvxDDGBy/an
 zgHO/v1NIi54CA5BRnqrZyVYjtciW28YbaFnsvCPWnw5A5kAtAuF5me2FvevOihjsEDv
 bTtHqWXrCSzKRajvY93XHWL/ZEP/DV1u5zBXZR+QvzxwqBEt0qFG5q+x3ZSlelctReJL
 b0tK/8jWFz4LDycFoLjE0FhuJOTGMwnIyf29IT4fpnRg2VJZqcLM3PMkivevbnn6wcu7
 OAOAM0WBwPvmdOEg5zqFrhEetYoXGgKZ83NoBxhXh0in+rISB/kExL8SEBupCEzW+yHr
 i/9A==
X-Gm-Message-State: AOAM533LrGdLskJ00k538dhMVv50BKtvKL6DS4B4fZXyMmoCr4nvwGpE
 tt6wvBddPR+pYf9smMdmj5WfeA==
X-Google-Smtp-Source: ABdhPJyWsb5xYuuoWa8qVf75WjF1I9GQBozPiX/j3Tik78VqnSX+Wm1CoMr7+oM8/TbViw5HK3TjJw==
X-Received: by 2002:a5d:654d:: with SMTP id z13mr6800813wrv.6.1602696034309;
 Wed, 14 Oct 2020 10:20:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n2sm5789987wrt.82.2020.10.14.10.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 10:20:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8D4A51FF7E;
 Wed, 14 Oct 2020 18:20:32 +0100 (BST)
References: <20201013125027.41003-1-kwolf@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] monitor: Fix order in monitor_cleanup()
In-reply-to: <20201013125027.41003-1-kwolf@redhat.com>
Date: Wed, 14 Oct 2020 18:20:32 +0100
Message-ID: <878sc8yba7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: f4bug@amsat.org, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Kevin Wolf <kwolf@redhat.com> writes:

> We can only destroy Monitor objects after we're sure that they are not
> in use by the dispatcher coroutine any more. This fixes crashes like the
> following where we tried to destroy a monitor mutex while the dispatcher
> coroutine still holds it:
>
>  (gdb) bt
>  #0  0x00007fe541cf4bc5 in raise () at /lib64/libc.so.6
>  #1  0x00007fe541cdd8a4 in abort () at /lib64/libc.so.6
>  #2  0x000055c24e965327 in error_exit (err=3D16, msg=3D0x55c24eead3a0 <__=
func__.33> "qemu_mutex_destroy") at ../util/qemu-thread-posix.c:37
>  #3  0x000055c24e9654c3 in qemu_mutex_destroy (mutex=3D0x55c25133e0f0) at=
 ../util/qemu-thread-posix.c:70
>  #4  0x000055c24e7cfaf1 in monitor_data_destroy_qmp (mon=3D0x55c25133dfd0=
) at ../monitor/qmp.c:439
>  #5  0x000055c24e7d23bc in monitor_data_destroy (mon=3D0x55c25133dfd0) at=
 ../monitor/monitor.c:615
>  #6  0x000055c24e7d253a in monitor_cleanup () at ../monitor/monitor.c:644
>  #7  0x000055c24e6cb002 in qemu_cleanup () at ../softmmu/vl.c:4549
>  #8  0x000055c24e0d259b in main (argc=3D24, argv=3D0x7ffff66b0d58, envp=
=3D0x7ffff66b0e20) at ../softmmu/main.c:51
>
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

LGTM:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Who's tree is going to take it?

--=20
Alex Benn=C3=A9e

