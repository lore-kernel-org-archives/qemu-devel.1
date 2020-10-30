Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0398C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F188620725
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaS+d0JH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F188620725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYTkh-0008Ae-TF
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 08:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTjk-0007hv-PI
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:42:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYTjg-0007sI-1L
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 08:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KtUb4W7qsUtOz+VocPR8ieTOCtSssjr+CeRTXxdkFM4=;
 b=VaS+d0JHRsQtletjXeXsWxxMBs0TLV4ral8hzge1t4BCxRMywuXfy194sxvRsHL16Cjvvo
 WQdizypCKALMV3Yp9HiQYD3Q2pmvzJ55PwqlpgBjchtVu2z4CFGcZLfGYEe2jk+bbNyFGM
 f7p1/qty3rliHElfvObHSkNFSog/KJc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-elIPmjuAPcmrgJN5m2LVbA-1; Fri, 30 Oct 2020 08:42:24 -0400
X-MC-Unique: elIPmjuAPcmrgJN5m2LVbA-1
Received: by mail-wr1-f72.google.com with SMTP id 11so1501982wrc.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 05:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KtUb4W7qsUtOz+VocPR8ieTOCtSssjr+CeRTXxdkFM4=;
 b=AT3nnVJbPBEjrTgK2NaAFqLLRl6zof6SVDmaHiK2n9zTh6oPsfgAfetDPO3/fAxCTI
 xL/jpHLcSbAOvuDQbPsmZjOoBPjWLVJV90maJXXwrc9uSWgOt9YEfyYUFSor5BdtYlsL
 PCOnWtdVbuTam7DGFs/FOHx9ti5xr78/tw4uKXyXKJnEJyaV98CkPVvZ9YqGyJ+u33Ih
 IX8BYOl4sxEUxK/42YtlhXJAdigmxR8cbYtBiWojI9+nPOfcap0ixgH8zU2J2+XSXfGq
 UZptOY8jNOPaneqkihuaIwzIxwJcRmtH1YlY5tVMhxgCp4TbiZ9g8X0RYqGr7a70twg+
 /X0A==
X-Gm-Message-State: AOAM533jihpstiJHfk65m3Wbj7S88PB4IrcLNTwkAMX2fOnql1lbEsqM
 quFDU6Us4dX/HRrxIBxt/2E8XH5c0+q6ytQCdrLxC0YUA38sD3+dQOJ/DHDeTPPV1AiG3adbSzw
 ezK1Zrp5IPunTlt0=
X-Received: by 2002:a1c:2d97:: with SMTP id t145mr2366445wmt.132.1604061743108; 
 Fri, 30 Oct 2020 05:42:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyn9QYN7XAQIFFAzE8sGLiEFVNgH0uHUruD1Ty66zxz9ROt0nz6n6RexUMbNHgfEZiL+qqp7Q==
X-Received: by 2002:a1c:2d97:: with SMTP id t145mr2366418wmt.132.1604061742868; 
 Fri, 30 Oct 2020 05:42:22 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id p13sm10148804wrt.73.2020.10.30.05.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 05:42:22 -0700 (PDT)
Date: Fri, 30 Oct 2020 08:42:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 00/12] block/export: vhost-user-blk server cleanups and
 tests
Message-ID: <20201030084155-mutt-send-email-mst@kernel.org>
References: <20201027173528.213464-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201027173528.213464-1-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Coiby Xu <Coiby.Xu@gmail.com>, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 27, 2020 at 05:35:16PM +0000, Stefan Hajnoczi wrote:
> This patch series solves some issues with the new vhost-user-blk-server and
> adds the qtest test case. The test case was not included in the pull request
> that introduced the vhost-user-blk server because of reliability issues that
> are fixed in this patch series.


Fails make check for me:

Running test qtest-i386/qos-test
Broken pipe
../qemu/tests/qtest/libqtest.c:161: kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
ERROR qtest-i386/qos-test - too few tests run (expected 92, got 65)
make: *** [Makefile.mtest:1857: run-test-230] Error 1


> Coiby Xu (1):
>   test: new qTest case to test the vhost-user-blk-server
> 
> Stefan Hajnoczi (11):
>   libvhost-user: follow QEMU comment style
>   configure: introduce --enable-vhost-user-blk-server
>   block/export: make vhost-user-blk config space little-endian
>   block/export: fix vhost-user-blk get_config() information leak
>   contrib/vhost-user-blk: fix get_config() information leak
>   tests/qtest: add multi-queue test case to vhost-user-blk-test
>   libqtest: add qtest_socket_server()
>   vhost-user-blk-test: rename destroy_drive() to destroy_file()
>   vhost-user-blk-test: close fork child file descriptors
>   vhost-user-blk-test: drop unused return value
>   vhost-user-blk-test: fix races by using fd passing
> 
>  configure                               |  15 +
>  contrib/libvhost-user/libvhost-user.h   |  15 +-
>  tests/qtest/libqos/libqtest.h           |  25 +
>  tests/qtest/libqos/vhost-user-blk.h     |  48 ++
>  block/export/export.c                   |   4 +-
>  block/export/vhost-user-blk-server.c    |  28 +-
>  contrib/vhost-user-blk/vhost-user-blk.c |   2 +
>  tests/qtest/libqos/vhost-user-blk.c     | 129 ++++
>  tests/qtest/libqtest.c                  |  76 ++-
>  tests/qtest/vhost-user-blk-test.c       | 843 ++++++++++++++++++++++++
>  block/export/meson.build                |   2 +-
>  tests/qtest/libqos/meson.build          |   1 +
>  tests/qtest/meson.build                 |   2 +
>  util/meson.build                        |   2 +-
>  14 files changed, 1151 insertions(+), 41 deletions(-)
>  create mode 100644 tests/qtest/libqos/vhost-user-blk.h
>  create mode 100644 tests/qtest/libqos/vhost-user-blk.c
>  create mode 100644 tests/qtest/vhost-user-blk-test.c
> 
> -- 
> 2.26.2
> 


