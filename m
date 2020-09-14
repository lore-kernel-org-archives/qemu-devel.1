Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6060C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04CF20672
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KaqX4qbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04CF20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHida-0004Js-Vo
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kHicz-0003jL-Sl
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kHicx-0000xo-Nu
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600067414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWQD4mhCV1hMjL5x12a6OTrWpxb6Dhrt/x1dGasC7Mk=;
 b=KaqX4qbrAWBjVbc8GGJsiMu+0OazyS2SkNAovx7BRLDARysmJmRs4qaGLgnp3gcaOP+/66
 nnzl73KzFoSCwcOhvkh72FcybfmPxnumRkq0f38LoPG8MTBVNoFrCRHHa+fWPR2fBolPpR
 11zEKsBUgj0GcO8heDux6lLMAWrQMnc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-k8MITBPOPVee74bSmGP01g-1; Mon, 14 Sep 2020 03:10:10 -0400
X-MC-Unique: k8MITBPOPVee74bSmGP01g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A98F781F01E;
 Mon, 14 Sep 2020 07:10:08 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-134.ams2.redhat.com [10.36.112.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD3505C1BB;
 Mon, 14 Sep 2020 07:10:04 +0000 (UTC)
Subject: Re: [PATCH v8 03/27] ci: fixes msys2 build by upgrading capstone to
 4.0.2
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-4-luoyonggang@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4601317a-d110-e5f3-faf5-8b9b0278ffb9@redhat.com>
Date: Mon, 14 Sep 2020 09:10:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200912224431.1428-4-luoyonggang@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/09/2020 00.44, Yonggang Luo wrote:
> The currently random version capstone have the following compiling issue:
>   CC      /c/work/xemu/qemu/build/slirp/src/arp_table.o
> make[1]: *** No rule to make target “/c/work/xemu/qemu/build/capstone/capstone.lib”。 Stop.
> 
> Subproject commit 1d230532840a37ac032c6ab80128238fc930c6c1 are the tagged version 4.0.2
> when upgrading to this version, the folder structure of include are changed to
> qemu\capstone\include
> │  platform.h
> │
> ├─capstone
> │      arm.h
> │      arm64.h
> │      capstone.h
> │      evm.h
> │      m680x.h
> │      m68k.h
> │      mips.h
> │      platform.h
> │      ppc.h
> │      sparc.h
> │      systemz.h
> │      tms320c64x.h
> │      x86.h
> │      xcore.h
> │
> └─windowsce
>         intrin.h
>         stdint.h
> 
> in capstone. so we need add extra include path -I${source_path}/capstone/include/capstone
> for directly #include <capstone.h>, and the exist include path should preserve, because
> in capstone code there something like #include "capstone/capstone.h"
> 
> If only using
>     capstone_cflags="-I${source_path}/capstone/include/capstone"
> Then will cause the following compiling error:
> 
>   CC      cs.o
> cs.c:17:10: fatal error: 'capstone/capstone.h' file not found
> #include <capstone/capstone.h>
>          ^~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  capstone  | 2 +-
>  configure | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/capstone b/capstone
> index 22ead3e0bf..1d23053284 160000
> --- a/capstone
> +++ b/capstone
> @@ -1 +1 @@
> -Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf
> +Subproject commit 1d230532840a37ac032c6ab80128238fc930c6c1

Richard has a patch series on the list now to update and improve the
capstone submodule (see "capstone + disassembler patches") ... I think
this patch here will then not be required anymore.

 Thomas


