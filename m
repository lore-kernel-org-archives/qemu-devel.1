Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5513C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 12:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D9BF22258
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 12:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3F7L4Q0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9BF22258
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT2eI-0002fP-RS
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 08:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kT2dP-0001wj-Jc
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 08:45:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kT2dN-0001ex-H0
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 08:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602765928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ChTchp8+SkWyVexFLXALXfgmfCaFAzluBLaYDJ4kvCQ=;
 b=A3F7L4Q0BPfKQcFd1IBKb5fLuexbrvvpoLzIrq5J5Xj50yuZjKW+zt8Ox+zGPLQX3pJaxN
 T+cYW5ceeWiz506mVu0en/gqAc/XGVSer7XEORb/GfIiP5hKmV48OqG2zN9+Ixxb/mlhqM
 KCuj/mwOgdSLKiECBseHL1yyqrFQF0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-kszUkNxlMMepKXNJExwm7A-1; Thu, 15 Oct 2020 08:45:26 -0400
X-MC-Unique: kszUkNxlMMepKXNJExwm7A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B3E9803646;
 Thu, 15 Oct 2020 12:45:25 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-114-163.ams2.redhat.com [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A71460E1C;
 Thu, 15 Oct 2020 12:45:24 +0000 (UTC)
Date: Thu, 15 Oct 2020 14:45:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Elena Afanasova <eafanasova@gmail.com>
Subject: Re: [PATCH] block/qcow2-cluster: remove dead code
Message-ID: <20201015124522.GJ4610@merkur.fritz.box>
References: <e04b538ddbf6b6612c0c94602740ff78a98812d7.camel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <e04b538ddbf6b6612c0c94602740ff78a98812d7.camel@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 15.10.2020 um 14:13 hat Elena Afanasova geschrieben:
> Since handle_dependencies() returns 0 or -EAGAIN the following case can be removed.
> Spotted by PVS-Studio.
> 
> Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
> ---
>  block/qcow2-cluster.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index aa87d3e99b..e2e0db0cc9 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1806,8 +1806,6 @@ again:
>               * structs before starting over. */
>              assert(*m == NULL);
>              goto again;
> -        } else if (ret < 0) {
> -            return ret;
>          } else if (cur_bytes == 0) {
>              break;
>          } else {

Technically correct, but let's keep it for anyone who will return a
different error code in the future. I think we should always check for
any error even if it is currently not produced.

Kevin


