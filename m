Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BC7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9CD221FC
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+Y3yhap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9CD221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUSa6-0004Zh-Nv
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 06:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUSZP-0003b6-D0
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:39:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUSZM-000062-OK
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603103951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9bcrF9mXFxutfIuG5FuFoFAkKSa4whHFpq4ECUFX1VA=;
 b=P+Y3yhaptB7aR1Evqi0MgHESD7ANUcFIly7eh/few4IEuayG8ncrL/i5B9UP+UZyNcNjb2
 4F+1eznYT7i6i+3uIJBAlwTOkBsbDlXS7BZwto+xZ2fzbn1PAuSOXihkcyOXxPrKazzJCo
 lqi08/ce2pW1EUpRYzwMp6qx5OMo5oo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-6fPeAPCCM7WJ8bVTTv4zyQ-1; Mon, 19 Oct 2020 06:39:09 -0400
X-MC-Unique: 6fPeAPCCM7WJ8bVTTv4zyQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B22087950B;
 Mon, 19 Oct 2020 10:39:08 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-6.ams2.redhat.com [10.36.114.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04A367513B;
 Mon, 19 Oct 2020 10:39:05 +0000 (UTC)
Subject: Re: [PATCH 7/30] non-virt: Fix Lesser GPL version number
To: Chetan Pant <chetan4windows@gmail.com>, qemu-trivial@nongnu.org
References: <20201016144243.26817-1-chetan4windows@gmail.com>
 <20201016145346.27167-1-chetan4windows@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4105debd-5624-4b45-4c95-1a678b764b57@redhat.com>
Date: Mon, 19 Oct 2020 12:39:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201016145346.27167-1-chetan4windows@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org,
 clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/10/2020 16.53, Chetan Pant wrote:
> There is no "version 2" of the "Lesser" General Public License.
> It is either "GPL version 2.0" or "Lesser GPL version 2.1".
> This patch replaces all occurrences of "Lesser GPL version 2" with
> "Lesser GPL version 2.1" in comment section.
> 
> Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
> ---
>  hw/intc/xics_pnv.c         | 2 +-
>  hw/ppc/pnv.c               | 2 +-
>  hw/ppc/pnv_core.c          | 2 +-
>  hw/ppc/pnv_lpc.c           | 2 +-
>  hw/ppc/pnv_psi.c           | 2 +-
>  hw/ppc/pnv_xscom.c         | 2 +-
>  include/hw/ppc/pnv.h       | 2 +-
>  include/hw/ppc/pnv_core.h  | 2 +-
>  include/hw/ppc/pnv_homer.h | 2 +-
>  include/hw/ppc/pnv_lpc.h   | 2 +-
>  include/hw/ppc/pnv_occ.h   | 2 +-
>  include/hw/ppc/pnv_psi.h   | 2 +-
>  include/hw/ppc/pnv_xscom.h | 2 +-
>  13 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/intc/xics_pnv.c b/hw/intc/xics_pnv.c
> index 35f3811..753c067 100644
> --- a/hw/intc/xics_pnv.c
> +++ b/hw/intc/xics_pnv.c
> @@ -5,7 +5,7 @@
>   *
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public License
> - * as published by the Free Software Foundation; either version 2 of
> + * as published by the Free Software Foundation; either version 2.1 of
>   * the License, or (at your option) any later version.
[...]

Reviewed-by: Thomas Huth <thuth@redhat.com>


