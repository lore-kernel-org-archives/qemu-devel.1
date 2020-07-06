Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFE9C433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 19:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 471B3207D0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 19:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LoU0Q+CQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471B3207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsXDq-0002xF-G3
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 15:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jsXDH-0002Vc-LL
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 15:55:39 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jsXDF-0002kq-Hv
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 15:55:39 -0400
Received: by mail-wm1-x341.google.com with SMTP id g75so40510650wme.5
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 12:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=MwrPC/PYK/mBU7BgGeixn2XBBDUkumgDih00piu6sTc=;
 b=LoU0Q+CQh+Zj3cAjuMB+vra3KSIvWvzrMr4AGbv63LsqVahGe+q7RChl1DeY23VaPX
 s4gn8bJEE0koVJQagTiWYDlY0q2Y0y80oHpEA+al5AhpURhp0A0cbK3qZNTSPj6ZvlJq
 HeIs+ICMJkn403FzPHwZq7Lr1td+QR4ugkajsLR8zrQtEYe0AAe3TMoBK0PbzZTUKPp/
 VIPIbkwLX0DNMVGSo6JVxSgYvhz20gYjZ/ivCKBtIfAWqCjAcgi9A2d6O/Z+ICbD/U3C
 l0lejvfL6pWLXmE+Ev8/oQq9AElB6PCbLSrQJwx4trZYoeJyy2b1wuyE9Lm+0SxNAP3w
 4Zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=MwrPC/PYK/mBU7BgGeixn2XBBDUkumgDih00piu6sTc=;
 b=rSGI6r9QydYWukSO1/5VX7qyI8QpxM/C52Bt3+i74C8SUdOmlmZAHlB4nUvYMn6V0h
 vUVlqcf5x3fdKSQUQU7ecAgVJ+QQ8rDi5TvwxzJTkWES8bQEecRKd2Zd+CLjXvE7xGEo
 QgzZgyzRovSUaiMYDt/novEZfTn2PQQBL775PwZ1znIh8yowvbXxdkLcIwya7wtYmWko
 yMU3kBQc/vOABHw/6ZVrmTm6Tfso8F6/ms8FHbx+gYBN0YQgAguqar49P2tp3pt3B6FT
 oI0+sXO1/GOmKZQLsXQ6DW7SFO0vyfI0Pb5Dz+gCHUUhGaoWCgz1qLagw7CGz2aSCuHA
 a/lg==
X-Gm-Message-State: AOAM532pxoShS6rQAu7qGZBaeJL2qSoHXB+aBgxYIKTlZ/UGygsQktum
 clMBJkj6kfU3BxWSnLaEC93SPQ==
X-Google-Smtp-Source: ABdhPJzFD4kZniEaa8ONmriEUN+votKkL6YgNzPuJI0ATPDDVxLoWyrbHA98lAiw7BGWFA+wOyuXjQ==
X-Received: by 2002:a7b:c406:: with SMTP id k6mr741404wmi.130.1594065335931;
 Mon, 06 Jul 2020 12:55:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p29sm527453wmi.43.2020.07.06.12.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 12:55:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E404F1FF7E;
 Mon,  6 Jul 2020 20:55:33 +0100 (BST)
References: <159316678008.10508.6615172353109944370.stgit@pasha-ThinkPad-X280>
 <dfc29ce7-1560-6c07-fac7-7aa7f90f9616@ispras.ru>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH 00/13] Reverse debugging
In-reply-to: <dfc29ce7-1560-6c07-fac7-7aa7f90f9616@ispras.ru>
Date: Mon, 06 Jul 2020 20:55:33 +0100
Message-ID: <87lfjwpgei.fsf@linaro.org>
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

> Ping.

I started going through this and then ran into some merge conflicts. Are
all the pre-requisite patches now merged via Paolo's tree?

--=20
Alex Benn=C3=A9e

