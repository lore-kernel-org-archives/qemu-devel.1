Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6006C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 21:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FAE020674
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 21:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqttkOmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FAE020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8sY5-0000Gv-L8
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 17:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k8sXE-0007i9-VY
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 17:55:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k8sXC-0001HA-Ny
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 17:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597960545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b/czrK+1C4KbXOfU1Eyn03cM+6ZRtffM/fNAKeMrzk0=;
 b=PqttkOmUnsjhYpNREw+cBXGxvHFnceJGADYHRI2u7FPJ1tpKGmCEISr4G3mwSeTBMzpRa1
 QcuUxRYVBUTbZl6Oasgwtt1nL573nfCCEedW2T7OkPKR+Be0v+UbmRSXhRnJD+b0z6aGzu
 tWS2+LW4xp4VeSWWy85tk58NI1HWUoQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-10iMm2VJNc2hHlk-pprhHQ-1; Thu, 20 Aug 2020 17:55:44 -0400
X-MC-Unique: 10iMm2VJNc2hHlk-pprhHQ-1
Received: by mail-oo1-f69.google.com with SMTP id v21so1792469ooq.12
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 14:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b/czrK+1C4KbXOfU1Eyn03cM+6ZRtffM/fNAKeMrzk0=;
 b=qsnH7+Mmpn7A03dNhGWabv0ES52JIEmGfxFvb4BWqXWyxBgUkfya2HodxHVkQAfqBJ
 JhoqXuZWdIkQJuXYAVUc47PPPH5pBK8axAdwUF975KtuDzGqW1MT00m86FPLcpwp9MEz
 emj5jmBSpDMbKBx+dHVt3jsFhlZ1sx1KlEdnPRef/f8+qQPXOGmwalAWy5z48gHojHB8
 Xgfe/n2VJ9Bkchx4dg3MKaEzndO6J7LHn/W+OE+OkoxiqBoWLJvdmW+eB/sJt0aa9elz
 1nShJzJhcjHL3dCtCS0Tfa/S6v05QUW9TuUXPjr2ZuN1pjkLMIc/hEmn9yh63ztJJroI
 GPaQ==
X-Gm-Message-State: AOAM530LZ9uaRd9mSmopNEYk4j2G3EA1E4K4YRrnNgxgZwi8qTuEjRx2
 bEILzHZUAJMIFgAKuDU0vc7NRTz3EZDb7rsIIi/iezVSTz9XCrniSrCY/tJYMyJ1CNRLYu1+6wU
 234jZaOb8730MUhBlMuNGjfR4JMb8+nQ=
X-Received: by 2002:a9d:6f85:: with SMTP id h5mr537687otq.81.1597960542781;
 Thu, 20 Aug 2020 14:55:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCM72bzi2LdA0kmCJoiSbx3cIBQlCg5WMbf/eCX8KcLwuWLmHdgpZByVeNzsNxSp2m9ZXRbtw1Yko0zwVSFqA=
X-Received: by 2002:a9d:6f85:: with SMTP id h5mr537678otq.81.1597960542579;
 Thu, 20 Aug 2020 14:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200820211905.223523-1-nsoffer@redhat.com>
 <ecc6a1ca-fb1a-efbe-c388-7aa5632c99e5@redhat.com>
 <1c5963e6-e85c-a46e-9133-fb8a072434dd@redhat.com>
 <CAMRbyysNd0Zc9ZC=6VZCS+WOsxS66n=zNhAqncqu2zY3Bdj0DQ@mail.gmail.com>
In-Reply-To: <CAMRbyysNd0Zc9ZC=6VZCS+WOsxS66n=zNhAqncqu2zY3Bdj0DQ@mail.gmail.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Fri, 21 Aug 2020 00:55:26 +0300
Message-ID: <CAMRbyyvdi58ttXCYtiktN65atwNLKmadbnmX5YwXrq6qNV8dFA@mail.gmail.com>
Subject: Re: [PATCH] qemu-iotests: Fix FilePaths cleanup
To: Eric Blake <eblake@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=nsoffer@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 17:32:49
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nirsof@gmail.com>,
 qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 12:40 AM Nir Soffer <nsoffer@redhat.com> wrote:
>
> On Fri, Aug 21, 2020 at 12:33 AM Eric Blake <eblake@redhat.com> wrote:
> >
> > On 8/20/20 4:29 PM, Eric Blake wrote:
> > > On 8/20/20 4:19 PM, Nir Soffer wrote:
> > >> If os.remove() fails to remove one of the paths, for example if the file
> > >> was removed by the test, the cleanup loop would exit silently, without
> > >> removing the rest of the files.
> > >>
> > >> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> > >> ---
> > >>   dtc                           | 2 +-
> > >>   tests/qemu-iotests/iotests.py | 8 ++++----
> > >>   2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > >
> > > Reviewed-by: Eric Blake <eblake@redhat.com>
> >
> > By the way, what test did you hit this on? If possible, I'd like to add
> > a Fixes: tag pointing to a commit that includes the problem.

I'll send a v2 with a Fixes tag, and few other related fixes.

>
> I did not hit this issue, found it while reviewing another patch,
> while trying to
> understand what FilePath is doing.
>
> The error was introduced in:
>
> commit de263986b5dc7571d12a95305ffc7ddd2f349431
> Author: John Snow <jsnow@redhat.com>
> Date:   Mon Jul 29 16:35:54 2019 -0400
>
>     iotests: teach FilePath to produce multiple paths
>
>     Use "FilePaths" instead of "FilePath" to request multiple files be
>     cleaned up after we leave that object's scope.
>
>     This is not crucial; but it saves a little typing.
>
>     Signed-off-by: John Snow <jsnow@redhat.com>
>     Reviewed-by: Max Reitz <mreitz@redhat.com>
>     Message-id: 20190709232550.10724-16-jsnow@redhat.com
>     Signed-off-by: John Snow <jsnow@redhat.com>


