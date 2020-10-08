Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196F5C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 09:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56229215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 09:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jT0qGkS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56229215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQRsY-0001ZQ-B7
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 05:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kQRr4-0000At-NC
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 05:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36187)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kQRr1-0002DB-5l
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 05:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602147889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ky5VS87OH8gvRQQL31cWGs5SPWRULpMDDIbxxP8/qSs=;
 b=jT0qGkS+T6Z/1xx0bfz/FIsEq/DqDYMTokJFLU6MCcj8slvdUs0YwCK2wtt/zBY6BN9ibD
 DpIrVDrnztjZHC0Soab8naU1aISJvJpUODkZ2EriChq5aEyDwsuv9GHZz8mXEXofH8loVP
 fA+uSgntCiGhYjL9jOo3Oz87NURzQsk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-SQGCGln0NVSjDl_WWWf6eA-1; Thu, 08 Oct 2020 05:04:48 -0400
X-MC-Unique: SQGCGln0NVSjDl_WWWf6eA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B5F9803F4D;
 Thu,  8 Oct 2020 09:04:47 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-40.ams2.redhat.com [10.36.113.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A0FB5D9D5;
 Thu,  8 Oct 2020 09:04:45 +0000 (UTC)
Subject: Re: [PATCH] Fixing LGPL version number
To: Chetan Pant <chetan4windows@gmail.com>, qemu-trivial@nongnu.org
References: <20201008060528.68579-1-chetan4windows@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1c24b564-9870-10f9-ac37-c4ebfacc74f0@redhat.com>
Date: Thu, 8 Oct 2020 11:04:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201008060528.68579-1-chetan4windows@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/10/2020 08.05, Chetan Pant wrote:
> There is no "version 2" of the "Lesser" General Public License. It is
> either "GPL version 2.0" or "LGPL version 2.1". This patch replaces all
> occurrences of "LGPL version 2" with "LGPL version 2.1" in comment section.
> 
> Signed-off-by: Chetan Pant <chetan4windows@gmail.com>

Phew, that's a pretty huge patch, could you maybe split it by subsystem /
folder so that it is easier to review?

[...]
> diff --git a/net/hub.h b/net/hub.h
> index ce45f7b..83e33e4 100644
> --- a/net/hub.h
> +++ b/net/hub.h
> @@ -7,7 +7,7 @@
>   *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
>   *  Zhi Yong Wu       <wuzhy@linux.vnet.ibm.com>
>   *
> - * This work is licensed under the terms of the GNU LGPL, version 2 or later.
> + * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
>   * See the COPYING.LIB file in the top-level directory.
>   *
>   */

I'm not sure whether we should update the version in the files that just say
"LGPL" (and do not mention "Lesser") ... they could also refer to the GNU
*Library* GPL instead, which was available as version 2 (in the sense of 2.0).
Could you please drop the hunks for the files that only mention LGPL for now?

> diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
> index d3e289e..da570e3 100644
> --- a/target/i386/hvf/x86_emu.c
> +++ b/target/i386/hvf/x86_emu.c
> @@ -5,7 +5,7 @@
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This program is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> @@ -23,7 +23,7 @@
>  //  This library is free software; you can redistribute it and/or
>  //  modify it under the terms of the GNU Lesser General Public
>  //  License as published by the Free Software Foundation; either
> -//  version 2 of the License, or (at your option) any later version.
> +//  version 2.1 of the License, or (at your option) any later version.
>  //
>  //  This library is distributed in the hope that it will be useful,
>  //  but WITHOUT ANY WARRANTY; without even the implied warranty of

That's an interesting file - the license text shows up twice here... I
wonder whether we could scratch one of the two... but that's also something
for a separate patch, I think.

 Thomas


