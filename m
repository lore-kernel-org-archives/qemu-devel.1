Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5C6C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1ACA206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1ACA206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoh0-0002HN-Gh
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:37:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lwhsu.freebsd@gmail.com>) id 1igoRh-0006FN-9Y
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:21:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lwhsu.freebsd@gmail.com>) id 1igoRg-0007bm-7E
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:21:49 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33156)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lwhsu.freebsd@gmail.com>)
 id 1igoRg-0007aZ-3R
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:21:48 -0500
Received: by mail-yb1-f194.google.com with SMTP id o63so2729090ybc.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:21:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bfIcnD34X2uvXZlHhVSSGi/Q/WdtTaqXAU4VpgLB46M=;
 b=AFl80nTGsZKvRokzG2mEn6vdTSn/LzqhfzKYXy/bjfl/QbV5MQJci7pwaKHvy3w2pg
 6ImzvIPco4QehPTfyvaEh1VM3L/+LMt5tziHXXNeka0FvcVLqNy6SspvNLS1t/M2G4W/
 nVdF/C29IuK8edaMsJVpGSp/C9AXXgiyHFvPZ53H9q1DwK5IuKaCZRZZvpvA/4BlUOFT
 L1PoVO6fvqzpPQE/G6hiBjkUmBFSNTWNu03Iac4b114wB1j+afv1WZaBdJVS6MihZIBu
 y9QuFANgATdlyHA//EJ201oSngrULIcOSC9zr1LgQN+OB7REwTpnre3D3SgyPDsoZOy4
 pgyQ==
X-Gm-Message-State: APjAAAWK0tBN97Bg3PaaahLATNqdE/vtfvzOYg45kSX1rCHp8Qurnehu
 oFhPstEBd94AHOoP7jLzSIgKGBW71f6LFszN4BM=
X-Google-Smtp-Source: APXvYqyWAALZBEJMU2QFpP0KgRgzR8J+5U+6N9wDjdOHNSwVCsw686SWkzJ4V6Tlb6fhnqsf9BjzYadVyVD/2rxX5DM=
X-Received: by 2002:a25:8087:: with SMTP id n7mr13770846ybk.451.1576495306875; 
 Mon, 16 Dec 2019 03:21:46 -0800 (PST)
MIME-Version: 1.0
References: <20191216110732.24027-1-alex.bennee@linaro.org>
 <20191216110732.24027-11-alex.bennee@linaro.org>
In-Reply-To: <20191216110732.24027-11-alex.bennee@linaro.org>
From: Li-Wen Hsu <lwhsu@freebsd.org>
Date: Mon, 16 Dec 2019 19:21:34 +0800
Message-ID: <CAKBkRUzFwxiiwpptiNG7OEap6m6788eqc25k32TVk_X1bVRDUw@mail.gmail.com>
Subject: Re: [PATCH v1 10/16] ci: build out-of-tree
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.219.194
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Ed Maste <emaste@freebsd.org>, cota@braap.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 16, 2019 at 7:07 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
> From: Paolo Bonzini <pbonzini@redhat.com>
>
> Most developers are using out-of-tree builds and it was discussed in the =
past
> to only allow those.  To prepare for the transition, use out-of-tree buil=
ds
> in all continuous integration jobs.
>
> Based on a patch by Marc-Andr=C3=A9 Lureau.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

On Mon, Apr 29, 2019 at 12:55 AM Thomas Huth <thuth@redhat.com> wrote:
>
> We are going to enable the qemu-iotests during "make check" again,
> and for running the iotests, we need bash and gnu-sed.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Li-Wen Hsu <lwhsu@freebsd.org>

