Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED35C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 21:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7D7420748
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 21:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAdUKanN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D7420748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8rh4-0003eQ-0j
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 17:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k8rgC-00033U-EN
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 17:01:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44605
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k8rg9-0003hx-TO
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 17:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597957255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1UGKsi1wGGjTSlpR7HYDjqMwlxea6yaINbGOF1ZAbDg=;
 b=eAdUKanNv65WFsKSuXLVYr4nUiyuQpiFaS2FUf5irRK74eUGYSCVA4gv9cjZvw9WUNV7Jp
 13lZiwMKbFizXdLLb6SaXjS3W4dptEAAauXxcWEq1bPAa4FRgGzXGtEaKTz/RC9GSfGclL
 kEOsj7qgx+7mf+9YEKfUZTUaRFbNC2Q=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-UCe0wfnXMtWfiG3L1T247Q-1; Thu, 20 Aug 2020 17:00:51 -0400
X-MC-Unique: UCe0wfnXMtWfiG3L1T247Q-1
Received: by mail-oo1-f71.google.com with SMTP id i25so1741649ooe.14
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 14:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1UGKsi1wGGjTSlpR7HYDjqMwlxea6yaINbGOF1ZAbDg=;
 b=Gedj8+4KUA7Di1muU928ywnroA2+B+20VjeSpTcdo3GxAPXRnmIziK4B1xtAMmPt4H
 ys94zLXSjXsNHHKprXz4aq/lg6ht3DNTx7yDHbjKqjhH/mreVaYgb6qiekFvkbBy9U4x
 AGS88qPgA/Yidwex5YCYXSRHzL54kc68MoS9ZogKAf6jOyTzl7gHP5u3QmFGui9WD0/K
 Kc/4HesRheH8qc6zMK0uuc84bnKIMxyE1sf9EuTMTLznwngXHQCz8tjc6whAtDjMcKpI
 AYU/XjcDzP+ndhh8yGelYh54AaFSccNHSWPANsfcz8J6W+9Nck6rGPglXjcgPj1biZZN
 B/Hw==
X-Gm-Message-State: AOAM533f40FrB0PCmxnLPIok5JRwKPa+qQTQRDLeu/k9VwT7MLpX/viT
 PwKi2vG7n7acz6crpirRoL08Xu48MqZmQqR46fGMPw2YsqJNSl1K4hoN54LZ9X+22G5pkdUFbtk
 2ulZG8a0cEaioJbpv6PrAHS2PbP0xLu8=
X-Received: by 2002:a9d:6f85:: with SMTP id h5mr405143otq.81.1597957250644;
 Thu, 20 Aug 2020 14:00:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmZUEkeHLVsl7MsOKYqztpxs2YTHJ+cA7u35ZVWpBi+NH98nNTRvRE7bIdahozv8tgafARFrwBdiG16Erzbks=
X-Received: by 2002:a9d:6f85:: with SMTP id h5mr405127otq.81.1597957250380;
 Thu, 20 Aug 2020 14:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200820183950.13109-1-vsementsov@virtuozzo.com>
 <20200820183950.13109-9-vsementsov@virtuozzo.com>
In-Reply-To: <20200820183950.13109-9-vsementsov@virtuozzo.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Fri, 21 Aug 2020 00:00:34 +0300
Message-ID: <CAMRbyyvpPyu9ONLUVax_xssXaS5f2O5pkaK7um0X7dWbng=2Jw@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] iotests.py: add verify_o_direct helper
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=nsoffer@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 17:00:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 20, 2020 at 9:49 PM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> Add python notrun-helper similar to _check_o_direct for bash tests.
> To be used in the following commit.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 717b5b652c..369e9918b4 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -1083,6 +1083,12 @@ def _verify_aio_mode(supported_aio_modes: Sequence[str] = ()) -> None:
>      if supported_aio_modes and (aiomode not in supported_aio_modes):
>          notrun('not suitable for this aio mode: %s' % aiomode)
>
> +def verify_o_direct() -> None:
> +    with FilePath('test_o_direct') as f:
> +        qemu_img_create('-f', 'raw', f, '1M')
> +        if 'O_DIRECT' in qemu_io('-f', 'raw', '-t', 'none', '-c', 'quit', f):
> +            notrun(f'file system at {test_dir} does not support O_DIRECT')

Why not:

    with FilePath('test_o_direct') as f:
        try:
            fd = os.open(f, os.O_DIRECT | os.O_CREAT | os.O_RDWR)
        except OSError as e:
            if e.errno != errno.EINVAL:
                raise
            notrun(...)
        else:
           os.close(fd)

More verbose, but the intent is more clear, and we do not depend on the output
of qemu-io which is not a public API. For example if someone improves qemu-io
to fail with:

    Direct I/O is not supported

It would break the tests using this helper.

Nir

> +
>  def supports_quorum():
>      return 'quorum' in qemu_img_pipe('--help')
>
> --
> 2.21.3
>
>


