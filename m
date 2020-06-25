Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F76C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 690BE2082F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Del1BjBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690BE2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUab-0003nP-Nx
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1joUZz-0003Ml-7A
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:18:23 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1joUZx-0007XX-Gl
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:18:22 -0400
Received: by mail-wm1-x341.google.com with SMTP id j18so6147330wmi.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 09:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=od8sozI683BO+ZDHrbGo9BSDndLwK1sRDaOHA2KvMKM=;
 b=Del1BjBGVmEzMc8mjGHrkaigGh8CV4/OeeJ8mz6BZTg/4Un7zuVij1jQyBdJrKLrbq
 dffVVAkyuJbm2lE+jJIIAhEm+1QLrbxcP2AQFLjdCAmj1Ro/l6EXOyVviNMcyxV0Q5JM
 zpbPbByYk40q2fvhhXFeZU6SJ4BUE1JvT9BXg14+Tm6ElViKJz8GBIXkCaWyD4RdwqGC
 6pPPxzlHRu9N5+W5RTzISXks/RK7umyl+KnxfErWVCtXsnuIvLidiKm/bwfrfRmH0v6Y
 hSAdFFyuim0/xHq9SDXqLRL5a5LASBRtxdW5tjAMGH3gFQICpjOs4/aHp3T7+4Lbd+we
 Tofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=od8sozI683BO+ZDHrbGo9BSDndLwK1sRDaOHA2KvMKM=;
 b=Bm3wtmZK5B141f6ONxa3JkSosRNO1kvQ+rvDDSstCk8Wu50rdA30fQvs42bVKDJ/30
 eU7JDGa0ZiHZl5rAGXHUK+PVU0YjIy/LeHh3X/xVC1/tYwLothD8wZkfaTCNm134xCtF
 0/qKRFNNb4GGW7ws67kf5x08WGyx4z21pIPE2FoGKR/VsyUgRADNJPjituR+31hnACzM
 FLxLQrvQfa5G/+BSpS4NQJpwKhiHMptimZKjGIYOWhbi/BjT+eABirXEDcSLXxlR++gF
 ousWWdMxddjj6Hx/w7o4xXtpqTXEgUegBxm6w5YbjXb0fw2yWeBprF7ei9CzAKTG5Iv/
 RMiw==
X-Gm-Message-State: AOAM533ldqMPSf72qdP5abLpvSa9sNz7wYFGrnn0nf+bvTkoWSqZ6QwG
 Zn2nfLfc+938y9KnV19qjAgC3pPSZ3Q=
X-Google-Smtp-Source: ABdhPJwMCGbC11iqaAlDIe7J8boFIBlAkka0XwzKNNlxypCuuHL3UGqnFnYxl+saqYEwa+7LcBxOxQ==
X-Received: by 2002:a1c:b686:: with SMTP id g128mr4337036wmf.145.1593101899030; 
 Thu, 25 Jun 2020 09:18:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n5sm8776078wmi.34.2020.06.25.09.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 09:18:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 13D761FF7E;
 Thu, 25 Jun 2020 17:18:16 +0100 (BST)
References: <20200625151627.24986-1-thuth@redhat.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] gitlab-ci: Fix the change rules after moving the YML files
In-reply-to: <20200625151627.24986-1-thuth@redhat.com>
Date: Thu, 25 Jun 2020 17:18:16 +0100
Message-ID: <87y2ob5dbr.fsf@linaro.org>
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> The edk2.yml and opensbi.yml files have recently been moved/renamed,
> but the change has not been reflected in the rules in the YML files
> yet.
>
> Fixes: 922febe2af ("Move edk2 and opensbi YAML files to .gitlab-ci.d fold=
er")
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e

