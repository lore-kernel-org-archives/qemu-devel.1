Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7829C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 12:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1FCC22DBF
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 12:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FCC22DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5qmB-00080s-Q9
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 08:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i5qlW-0007ZY-TV
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 08:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i5qlU-0003kB-UJ
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 08:21:30 -0400
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:52413)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i5qlU-0003iO-N8
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 08:21:28 -0400
Received: from player694.ha.ovh.net (unknown [10.109.160.244])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 39FBD67E2B
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 14:21:26 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player694.ha.ovh.net (Postfix) with ESMTPSA id A9F29968861E;
 Thu,  5 Sep 2019 12:21:22 +0000 (UTC)
Date: Thu, 5 Sep 2019 14:21:20 +0200
From: Greg Kurz <groug@kaod.org>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190905142120.1edb7895@bahia.lan>
In-Reply-To: <20190905111729.1197-1-thuth@redhat.com>
References: <20190905111729.1197-1-thuth@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 18286021862439164210
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejjedggeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.52.203
Subject: Re: [Qemu-devel] [PATCH] gitlab-ci.yml: Install libattr1-dev and
 libcap-dev to test virtio-9p
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
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  5 Sep 2019 13:17:29 +0200
Thomas Huth <thuth@redhat.com> wrote:

> So far the gitlab-ci was not testing virtio-9p yet, since we did not
> install libattr1-dev and libcap-dev in any of the pipelines. Do it
> now to get some more test coverage.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .gitlab-ci.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index cd4c03372b..ed8067f5cf 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -59,7 +59,7 @@ build-user:
>  
>  build-clang:
>   script:
> - - apt-get install -y -qq clang libsdl2-dev
> + - apt-get install -y -qq clang libsdl2-dev libattr1-dev libcap-dev
>        xfslibs-dev libiscsi-dev libnfs-dev libseccomp-dev gnutls-dev librbd-dev
>   - ./configure --cc=clang --cxx=clang++ --enable-werror
>        --target-list="alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu

I don't know gitlab-ci at all but shouldn't these libs be added to some
other builds as well ?

Apart from that, this change looks okay so:

Acked-by: Greg Kurz <groug@kaod.org>

