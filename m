Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23309ECE58D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 21:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80D02084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 21:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80D02084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ2nj-0000cp-Se
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 17:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iJ2Z4-0001zk-Vk
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 17:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iJ2Z3-0003g8-05
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 17:35:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49086)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iJ2Yy-0003f3-NT; Fri, 11 Oct 2019 17:35:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9C19718C4289;
 Fri, 11 Oct 2019 21:35:03 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23E895C1B2;
 Fri, 11 Oct 2019 21:35:03 +0000 (UTC)
Subject: Re: [PATCH 1/4] vl: Split off user_creatable_print_help()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191011205551.32149-1-kwolf@redhat.com>
 <20191011205551.32149-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f1b7efeb-6ce5-2943-76fc-12b6d0f09215@redhat.com>
Date: Fri, 11 Oct 2019 16:35:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011205551.32149-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Fri, 11 Oct 2019 21:35:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/19 3:55 PM, Kevin Wolf wrote:
> Printing help for --object is something that we don't only want in the

s/don't/not/

> system emulator, but also in tools that support --object. Move it into a
> separate function in qom/object_interfaces.c to make the code accessible
> for tools.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   include/qom/object_interfaces.h | 12 +++++++
>   qom/object_interfaces.c         | 61 +++++++++++++++++++++++++++++++++
>   vl.c                            | 52 +---------------------------
>   3 files changed, 74 insertions(+), 51 deletions(-)
> 
> diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
> index 682ba1d9b0..3e4e1d928b 100644
> --- a/include/qom/object_interfaces.h

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

