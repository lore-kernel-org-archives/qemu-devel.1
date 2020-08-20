Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C627FC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 21:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A98220FC3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 21:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoTPiBnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A98220FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8sJu-0004Dl-LD
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 17:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k8sJG-0003jr-4o
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 17:41:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24634
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k8sJD-0008Ow-OZ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 17:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597959678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FZh1+Bjojgr0PCKPqPB4HPtt6csDLCH9Lh8hQw83o3M=;
 b=WoTPiBnNuoHzpBkTEagjoXxwbn3C50IQGDoymgQ8CgZMqXYCb0Qm5EFUkrYaUQRz2O80gd
 LXflSzrmzE8gATr21xfXhrtA/Kb5el+fSRy9IkqFWsIp9YEw9PugVGzS29SzYRJAEAVM87
 gxBb/QgUg3jdepKEbxB3i1CTEoEbDDE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-3ShuvPB6Oc6-WIgwDTvIsw-1; Thu, 20 Aug 2020 17:41:16 -0400
X-MC-Unique: 3ShuvPB6Oc6-WIgwDTvIsw-1
Received: by mail-ot1-f70.google.com with SMTP id n22so1557591otj.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 14:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FZh1+Bjojgr0PCKPqPB4HPtt6csDLCH9Lh8hQw83o3M=;
 b=kzkW50gKym4HMHr97iFCc15+aLt0JJVxiu8juZo5oO3TI1r5Mtv7gdKW9Ns4PSr74A
 NnKXMtpVMNhSiu8oSlj4AWSl27IcBnxVfvku8yC7mYyQcZFn9znalJpPTMvhPBkWQVvq
 RRapkjKvS/CyZIXDuntmPtPZS2cwQZFlU8ZHoq7v6G6xXRnuaXs/dYe67vs7U2cq7bzh
 SC/rnndluXkbm/1JF4rZh0XNAkaTmcmmQeM9HUxCpW+5rd+I/kWyMPp1sDwiXYoF5IHf
 IV0SmyLJjQolZB8V643sF7SVje1taEdXONqG4gPGOGe1me9ZcEiqS0NcLFG9H4f7YAJ2
 Ht+A==
X-Gm-Message-State: AOAM5309othjsG4eB7+xYDCpTuH1t4JceOnq+Rop3BSwLWqQ8EQnPSoQ
 Lwli7HkwE7FVRo3ldRTk119sVIaPUNkHhiIFtdMYBySTak2pVnxxxcKLBbBBBZ8emzdkiRF2SC4
 sv3LkgHDQZEXZ5t3kahbNsDfCYnP4vrw=
X-Received: by 2002:a4a:4f16:: with SMTP id c22mr458012oob.33.1597959675733;
 Thu, 20 Aug 2020 14:41:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvb/ePjT1sIAaUOHWonBRV3XwPowAdFYD515Z/7/b+khk0xoeBFKPeRxUlPHBazhra16lpxW4lYr2cXavGhwE=
X-Received: by 2002:a4a:4f16:: with SMTP id c22mr457998oob.33.1597959675521;
 Thu, 20 Aug 2020 14:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200820211905.223523-1-nsoffer@redhat.com>
 <ecc6a1ca-fb1a-efbe-c388-7aa5632c99e5@redhat.com>
 <1c5963e6-e85c-a46e-9133-fb8a072434dd@redhat.com>
In-Reply-To: <1c5963e6-e85c-a46e-9133-fb8a072434dd@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Fri, 21 Aug 2020 00:40:58 +0300
Message-ID: <CAMRbyysNd0Zc9ZC=6VZCS+WOsxS66n=zNhAqncqu2zY3Bdj0DQ@mail.gmail.com>
Subject: Re: [PATCH] qemu-iotests: Fix FilePaths cleanup
To: Eric Blake <eblake@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=nsoffer@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 17:41:18
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nirsof@gmail.com>,
 qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 12:33 AM Eric Blake <eblake@redhat.com> wrote:
>
> On 8/20/20 4:29 PM, Eric Blake wrote:
> > On 8/20/20 4:19 PM, Nir Soffer wrote:
> >> If os.remove() fails to remove one of the paths, for example if the file
> >> was removed by the test, the cleanup loop would exit silently, without
> >> removing the rest of the files.
> >>
> >> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> >> ---
> >>   dtc                           | 2 +-
> >>   tests/qemu-iotests/iotests.py | 8 ++++----
> >>   2 files changed, 5 insertions(+), 5 deletions(-)
>
> >
> > Reviewed-by: Eric Blake <eblake@redhat.com>
>
> By the way, what test did you hit this on? If possible, I'd like to add
> a Fixes: tag pointing to a commit that includes the problem.

I did not hit this issue, found it while reviewing another patch,
while trying to
understand what FilePath is doing.

The error was introduced in:

commit de263986b5dc7571d12a95305ffc7ddd2f349431
Author: John Snow <jsnow@redhat.com>
Date:   Mon Jul 29 16:35:54 2019 -0400

    iotests: teach FilePath to produce multiple paths

    Use "FilePaths" instead of "FilePath" to request multiple files be
    cleaned up after we leave that object's scope.

    This is not crucial; but it saves a little typing.

    Signed-off-by: John Snow <jsnow@redhat.com>
    Reviewed-by: Max Reitz <mreitz@redhat.com>
    Message-id: 20190709232550.10724-16-jsnow@redhat.com
    Signed-off-by: John Snow <jsnow@redhat.com>


