Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC450C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA69120702
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5M+udPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA69120702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9AuG-0006ig-VL
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k9Aqy-0000x2-CY
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:29:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k9Aqw-00018t-2x
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598030960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yssBjCFkhYJVn7rBgQ1cqCi+A+IaGus95z6duwo+VdQ=;
 b=f5M+udPsWos56C/unxZHrKKTTE8rxguwJwiqKNte+xvi8sp1pek0rv/QA4HMm/p/o0hi4f
 lOr1a4NyJ3fX2PNwqtXYNoSjZqCyCK44PcaRA9S2f+bZJobpMD+NaQwB/+SalDc18tMCRi
 jzfolWdNcc1vm1nLzToOgkdOHVrSpUQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-3ykJWb4NOO65Ocwgcj9N-Q-1; Fri, 21 Aug 2020 13:29:17 -0400
X-MC-Unique: 3ykJWb4NOO65Ocwgcj9N-Q-1
Received: by mail-oo1-f69.google.com with SMTP id j9so1272711oom.9
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yssBjCFkhYJVn7rBgQ1cqCi+A+IaGus95z6duwo+VdQ=;
 b=DM+Nlpb2s3VB77q0d9y7tceko6u2QUTMD80mKsn7p2Eslor81w8ye+GWtJiMWm/o4W
 mtzZxSsX+4aKG7fkhvDGmZ6tkMW/lVKcy0uXLxj5lfRpRWcvO2dgqhPVgcTsdWwG0ZCS
 +lL0+/qcApX8mLNYIyBqYyC4I03DGOdOCyBaMLXhUR8qgy1NIYEEmTU7y4iXChMn6YUh
 KnUPNfiTkSPo2qVFsA1Tywjv0elzgbYC9wB27MA/ppTQVlwosdhfkaFxkGUELTW8MKJq
 3hy4OMgJ6B1+4uBTC32WENyToQjqIbSuz8r4TYem3iXWDLmYTtsrDIbXxKVIYjB3WeD7
 j7jQ==
X-Gm-Message-State: AOAM5336YbF9RREV+VYgzTdiJQXV48GA/eKn9f6kM6PVawVCTMiaA8Th
 etWBsiSi9C4WPIEF7Sd0+PcyAsp2MR3ytVPduGkus5JT3/9ioVxTbsDZdRMu55lMxJFz9HGOeCM
 qxoDrwCUqghQ+cwwOra6Zdzufnyum0rE=
X-Received: by 2002:a4a:101:: with SMTP id 1mr3071544oor.16.1598030956409;
 Fri, 21 Aug 2020 10:29:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1SBhbbTSVTB8M3JSZG9PbOhVQnAOOGPNo9SgbLdm2yDn2aO2ruHMlWX1uARmEu3f5bcyMTeTeMQCZTvfiplM=
X-Received: by 2002:a4a:101:: with SMTP id 1mr3071524oor.16.1598030956158;
 Fri, 21 Aug 2020 10:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
 <20200821141123.28538-9-vsementsov@virtuozzo.com>
In-Reply-To: <20200821141123.28538-9-vsementsov@virtuozzo.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Fri, 21 Aug 2020 20:29:00 +0300
Message-ID: <CAMRbyyvdbxJj_PZVKMLepH0m97sCtp-AMX7RLXw-czBJuayfFg@mail.gmail.com>
Subject: Re: [PATCH v5 08/10] iotests.py: add verify_o_direct helper
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=nsoffer@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 den@openvz.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 5:12 PM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> Add python notrun-helper similar to _check_o_direct for bash tests.
> To be used in the following commit.
>
> Suggested-by: Nir Soffer <nsoffer@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/iotests.py | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 717b5b652c..7f1aa187a9 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -29,6 +29,7 @@ import struct
>  import subprocess
>  import sys
>  import time
> +import errno
>  from typing import (Any, Callable, Dict, Iterable,
>                      List, Optional, Sequence, Tuple, TypeVar)
>  import unittest
> @@ -1083,6 +1084,17 @@ def _verify_aio_mode(supported_aio_modes: Sequence[str] = ()) -> None:
>      if supported_aio_modes and (aiomode not in supported_aio_modes):
>          notrun('not suitable for this aio mode: %s' % aiomode)
>
> +def verify_o_direct() -> None:
> +    with FilePath('test_o_direct') as f:
> +        try:
> +            fd = os.open(f, os.O_DIRECT | os.O_CREAT | os.O_RDWR)
> +        except OSError as e:
> +            if e.errno != errno.EINVAL:
> +                raise
> +            notrun(f'file system at {test_dir} does not support O_DIRECT')
> +        else:
> +            os.close(fd)
> +
>  def supports_quorum():
>      return 'quorum' in qemu_img_pipe('--help')
>
> --
> 2.21.3
>

Reviewed-by: Nir Soffer <nsoffer@redhat.com>


