Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E02C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 10:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E3520708
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 10:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ztFQWVar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E3520708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTjoG-0000Jp-FJ
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 06:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTjnE-0008Im-4h
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 06:50:33 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:35334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTjnC-0007fe-1R
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 06:50:31 -0400
Received: by mail-ed1-x542.google.com with SMTP id cq12so5340954edb.2
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 03:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IuxQG69JBE57RLDbG16ZdlmpAednQVXKs8Yr9zaGbJU=;
 b=ztFQWVarMQo3iUjIh+qD289CBInipgsFhK2G+noWiQn0PeKnWQs/q7GefhwGAJjWG3
 M+1LOhRNsvjpK95c/em9Sy7A0D1AXWOFkZ62JY85sKU4cimQcJTYDbqIJd9HdsyjWSCU
 cbkTjrzXCx7wif8bMKfU8IccAOFtK3a6+/uuSwD+Cqp0J7qRkm5VZl3zGGtxKeVvF6OA
 TzaHEEywy3r5nxhLaEOV96h7oJpwFP+dO7ai/TPaf8w79OqAgY/YMbup3X5Vc0oQCksZ
 2iU2Nf0s0CtWKausPUE9DZJOY2CHZhVteVJaZkhYFWzetEsyZzxNHCkRqMIWlcIy0esy
 evKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IuxQG69JBE57RLDbG16ZdlmpAednQVXKs8Yr9zaGbJU=;
 b=NXDDA86qrEyrlHCidjTsobUz696rqo9q0qAaItM0nSAzoNJYnux6weDEkN1SMg3XnP
 CW6Y5TRrTYCfeO9baEP30HOEOfHgGkldC4w7TEAAT2iugoXU7vANJVdo94ox56bBMODZ
 0gUCZ04Scc1eIMYIZiTttuTCZR+r2rRNBYwxv71ZVI3uUyg5RneO/VlYniRwMZoS/Iuq
 w1R1jx1lS9nn4VJhDzTyzMCX9cjuFhxY0tIb2BER90JkbmouXkFv9YOl62S2q8WcN+CO
 sZ9HDJS3a3ol00uH7eKnjJkYwQkzjZDG066KT4W4jhtYu5VJvLEiOOZGDZhbckZVLyyX
 821A==
X-Gm-Message-State: AOAM530hjIfWvTSfBqJvcGN2P5kpltXEaPQc1KLYYPEAawnyva7hcq9S
 tc+/oXkEMW6rifzFkowJ+e6Sjehq5sOUVvyy7JOetocdEamm/w==
X-Google-Smtp-Source: ABdhPJzdlRVBPRBdKywzQaNNiZzr2XNQzbSXJZbW4kPbWOC18spxfHOHZL1HQZpt1TF0l/V6i9htR+J1WFV5QCpALWg=
X-Received: by 2002:a50:c34a:: with SMTP id q10mr8989879edb.36.1602931824831; 
 Sat, 17 Oct 2020 03:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602771296.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1602771296.git.qemu_oss@crudebyte.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2020 11:50:13 +0100
Message-ID: <CAFEAcA_ygiXU=Lh1iOPUDOsXu-cuVze-wDhc90wZ+r7C-BBesA@mail.gmail.com>
Subject: Re: [PULL 0/5] 9p queue 2020-10-15
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 15 Oct 2020 at 22:04, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> The following changes since commit 57c98ea9acdcef5021f5671efa6475a5794a51c4:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20201014-pull-request' into staging (2020-10-14 13:56:06 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cschoenebeck/qemu.git tags/pull-9p-20201015
>
> for you to fetch changes up to 97a64ec211d051439b654950ed3f7cffc47d489b:
>
>   tests/9pfs: add local Tmkdir test (2020-10-15 16:11:17 +0200)
>
> ----------------------------------------------------------------
> 9pfs: add tests using local fs driver
>
> The currently existing 9pfs test cases are all solely using the 9pfs 'synth'
> fileystem driver, which is a very simple and purely simulated (in RAM only)
> filesystem. There are issues though where the 'synth' fs driver is not
> sufficient. For example the following two bugs need test cases running the
> 9pfs 'local' fs driver:
>
> https://bugs.launchpad.net/qemu/+bug/1336794
> https://bugs.launchpad.net/qemu/+bug/1877384
>
> This patch set for that reason introduces 9pfs test cases using the 9pfs
> 'local' filesystem driver along to the already existing tests on 'synth'.

Build failure, OSX:

Compiling C object tests/qtest/libqos/libqos.fa.p/virtio-9p.c.o
../../tests/qtest/libqos/virtio-9p.c:37:17: error: implicit
declaration of function 'get_current_dir_name' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
    char *pwd = get_current_dir_name();
                ^
../../tests/qtest/libqos/virtio-9p.c:37:17: error: this function
declaration is not a prototype [-Werror,-Wstrict-prototypes]
../../tests/qtest/libqos/virtio-9p.c:37:11: error: incompatible
integer to pointer conversion initializing 'char *' with an expression
of type 'int' [-Werror,-Wint-conversion]
    char *pwd = get_current_dir_name();


thanks
-- PMM

