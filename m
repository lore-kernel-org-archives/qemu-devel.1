Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A61CC55178
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 09:31:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F328C223BD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 09:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQgnYPlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F328C223BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZseg-0006Ps-Nv
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 04:31:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kZsdx-0005h2-Ky
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 04:30:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49046)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kZsdu-00069O-Qy
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 04:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604395816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0od/EUrbF2/BZiB3Uz0bTfFvvGcuSmLwp2lfH8xNDgw=;
 b=HQgnYPlIjjqADSDKSuMMpYy7vpwllHYr6TOL8LN6r+94mmAy7NAxg7ki69rbrp4kRfUPI5
 BawjzEevlTfuC8H0C5Ezt33WaBar8xk0O28MqXm4T/Rz9+pWD2VZRPLtyusKlzMSOfVgDq
 bSdDws2reP379sBiOoA+h91BIQ9fxB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-j8M6aCl0P9-DHafV_N_Opw-1; Tue, 03 Nov 2020 04:30:12 -0500
X-MC-Unique: j8M6aCl0P9-DHafV_N_Opw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0605D1087D7C;
 Tue,  3 Nov 2020 09:30:11 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-113-164.ams2.redhat.com [10.36.113.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3684037DD;
 Tue,  3 Nov 2020 09:30:08 +0000 (UTC)
Date: Tue, 3 Nov 2020 10:30:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: AlexChen <alex.chen@huawei.com>
Subject: Re: [PATCH] block/vvfat: Fix bad printf format specifiers
Message-ID: <20201103093007.GB5509@merkur.fritz.box>
References: <5F9FF319.7060108@huawei.com>
MIME-Version: 1.0
In-Reply-To: <5F9FF319.7060108@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, zhang.zhanghailiang@huawei.com,
 QEMU <qemu-devel@nongnu.org>, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 02.11.2020 um 12:52 hat AlexChen geschrieben:
> We should use printf format specifier "%u" instead of "%d" for
> argument of type "unsigned int".
> In addition, fix two error format problems found by checkpatch.pl:
> ERROR: space required after that ',' (ctx:VxV)
> +        fprintf(stderr,"%s attributes=0x%02x begin=%u size=%d\n",
>                        ^
> ERROR: line over 90 characters
> +        fprintf(stderr, "%d, %s (%u, %d)\n", i, commit->path ? commit->path : "(null)", commit->param.rename.cluster, commit->action);
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Alex Chen <alex.chen@huawei.com>
> ---
>  block/vvfat.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 5abb90e7c7..cc2ec9af21 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1437,7 +1437,7 @@ static void print_direntry(const direntry_t* direntry)
>          for(i=0;i<11;i++)
>              ADD_CHAR(direntry->name[i]);
>          buffer[j] = 0;
> -        fprintf(stderr,"%s attributes=0x%02x begin=%d size=%d\n",
> +        fprintf(stderr, "%s attributes=0x%02x begin=%u size=%d\n",
>                  buffer,
>                  direntry->attributes,
>                  begin_of_direntry(direntry),le32_to_cpu(direntry->size));

direntry->size is unsigned, too, so if we want to fix this, I think we
should fix both specifiers.

The rest of the patch looks good.

Kevin


