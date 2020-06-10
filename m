Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5A3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15247206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KgKb1y/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15247206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj3nd-00055B-CQ
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 12:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jj3kQ-0008OT-Q9
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 12:38:42 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34393)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jj3kP-0007jY-JC
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 12:38:42 -0400
Received: by mail-wr1-x441.google.com with SMTP id r7so3046588wro.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 09:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=a4H0GyOh+ITLHkPVVOD0Qbr+C0eCDhoxJA78z7QZ8mU=;
 b=KgKb1y/bbgx+vFnPdNVbQZp/8Xn/+BwqFJzpHgrHxXHecdHAAx9l5M/rjCgdhwKb7e
 gjD3zONCFn9FkkXVZEEiUyFgGSynpti67pAt4Q1myPKfhDxqoEBWPGSEQgf2uWGNHoGE
 VV1GkVj0Jp+oexRjffqWaxdYmMAjaf+TeGU3InrpXEC1o137mFzKtIS7PkZQY5WdRfy/
 DAMXNW8RdzlYjFwo2YB09OQao3g0xA0FGTWDPs5Ih/ZpKckp2D6oI+CGX4w/d/8rv5q6
 l6gYW8pHYx93VlkL5eyuCWwxNc8gCJDr9VH5W8Jcn1gR4KcE6r0zCPVCASoFoFnOPtKX
 l3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=a4H0GyOh+ITLHkPVVOD0Qbr+C0eCDhoxJA78z7QZ8mU=;
 b=cbtQJAcdN8AdOz7DO466ojMtn61AS/3J1P8ViW7s/W9d17tV3RSQhBAVvT9MrJXJsq
 wNapKGajeagy57Tj8M+KgdisBWKE93TnVZPbSi4q079EeAsnfVfstus1uNdqKVdVyHBw
 jp0/Hn+RsxBavY72JnFfn6CPng8o6QsDvZT6HhmIGia1MI/QUzA2siGFZqetVv1m40XT
 t74Ho57KkEVGeqxwOBCWlV2ag0u1gReFB2DFKElQ8kEpl5flc09+FDgmqjwzjLaFg+ah
 MlLZRZZFZdyGIyL0857vl7k/d+meCcWC7jrq+fpqKNovxHved12qwgik1/xyEilWiJs7
 +0WA==
X-Gm-Message-State: AOAM531EZ+IfJV4RA4HpMs/fKXgqFlp+b12ac2aMzJJvn2iQaJQtA1bP
 3/iS4i9UOVGfOXGX9VXbS7o7Rg==
X-Google-Smtp-Source: ABdhPJxgmEbYMRjAM/x2r/7+6/9Pv45FAxUY8RB8vTUIZz/7Fs8NgWehe3OgF4YSLpbeQm9xCKvtvw==
X-Received: by 2002:adf:b354:: with SMTP id k20mr4657772wrd.412.1591807113251; 
 Wed, 10 Jun 2020 09:38:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q5sm463918wrm.62.2020.06.10.09.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 09:38:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 143371FF7E;
 Wed, 10 Jun 2020 17:38:30 +0100 (BST)
References: <20200610155509.12850-1-alex.bennee@linaro.org>
 <20200610155509.12850-2-alex.bennee@linaro.org>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH  v2 1/6] iotests: 194: wait migration completion on
 target too
In-reply-to: <20200610155509.12850-2-alex.bennee@linaro.org>
Date: Wed, 10 Jun 2020 17:38:30 +0100
Message-ID: <87pna65115.fsf@linaro.org>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 robert.foley@linaro.org, "open list:Block layer core" <qemu-block@nongnu.org>,
 Alex =?utf-8?Q?Benn?= =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 robhenry@microsoft.com, Max Reitz <mreitz@redhat.com>,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> It is possible, that shutdown on target occurs earlier than migration
> finish. In this case we crash in bdrv_release_dirty_bitmap_locked()
> on assertion "assert(!bdrv_dirty_bitmap_busy(bitmap));" as we do have
> busy bitmap, as bitmap migration is ongoing.
>
> We'll fix bitmap migration to gracefully cancel on early shutdown soon.
> Now let's fix iotest 194 to wait migration completion before shutdown.
>
> Note that in this test dest_vm.shutdown() is called implicitly, as vms
> used as context-providers, see __exit__() method of QEMUMachine class.
>
> Actually, not waiting migration finish is a wrong thing, but the test
> started to crash after commit ae00aa239847682
> "iotests: 194: test also migration of dirty bitmap", which added dirty
> bitmaps here. So, Fixes: tag won't hurt.
>
> Fixes: ae00aa2398476824f0eca80461da215e7cdc1c3b
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20200604083341.26978-1-vsementsov@virtuozzo.com>

Obviously this patch isn't going in via plugins/next - I had it in my
tree to keep CI green and forgot to take that into account when
generating the series!

--=20
Alex Benn=C3=A9e

