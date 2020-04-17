Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE4DC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555FF221E9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2vHhY84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555FF221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPZKS-0000Cg-Ft
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 18:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jPZI1-0006nv-Va
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jPZI0-0001Sl-S4
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:16:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35069
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jPZI0-0001QX-OD
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587161808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=syBgCS5Esla0lu5vZPZZKzGs0qRBljvfPIltt3id39A=;
 b=R2vHhY84OXHTBeL7K0l4eqoinRll0RFScbnLXUiVQDwdlfFS8KfM0Gw0wZ5rhYnAOWkyWn
 AEv8DgmqfD4qWfjI+wg7nGFndMkSoMjWnCqoMUcuhjJjyHa8FlIgAJodstbySOXk9kdGxc
 6VXwx90rNnGCD+uIb2hzCHcBnL7kizY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-oT_2r349P4W5eJFhCeYNKw-1; Fri, 17 Apr 2020 18:16:41 -0400
X-MC-Unique: oT_2r349P4W5eJFhCeYNKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C05A0800D53;
 Fri, 17 Apr 2020 22:16:40 +0000 (UTC)
Received: from [10.3.115.59] (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 123F29E0D4;
 Fri, 17 Apr 2020 22:16:40 +0000 (UTC)
Subject: Re: [PATCH] qemu-img: Fix stale doc comment
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <20200417221258.900117-1-eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c3c49393-eedd-3aa0-6156-86cc1e732762@redhat.com>
Date: Fri, 17 Apr 2020 17:16:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417221258.900117-1-eblake@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org,
 Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/17/20 5:12 PM, Eric Blake wrote:
> Missed in commit e13c59fa.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   qemu-img-cmds.hx | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

and I should have grepped for other instances; this needs to be squashed in:

diff --git i/qemu-img.c w/qemu-img.c
index d900bde89911..481103f7a10f 100644
--- i/qemu-img.c
+++ w/qemu-img.c
@@ -110,7 +110,7 @@ static void QEMU_NORETURN unrecognized_option(const 
char *option)
      error_exit("unrecognized option '%s'", option);
  }

-/* Please keep in synch with qemu-img.texi */
+/* Please keep in synch with docs/tools/qemu-img.rst */
  static void QEMU_NORETURN help(void)
  {
      const char *help_msg =


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


