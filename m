Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCEFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 04:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E599F2068F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 04:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOXfWNrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E599F2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvZRc-0000qZ-7X
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 00:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jvZR3-0000IT-8Y
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 00:54:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40456
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jvZQz-0003rO-UZ
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 00:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594788860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=IkXZsj5AjOINiQ3WcXtIExtpNGyoG9aaz7Ha4Ebh978=;
 b=FOXfWNrNXj/nwP9ngS82T4ul06xv3DWpv6N+iUT1TWB+9z7hW1AV6scNqA6/s2NR7lCmT+
 B8rmuzk/lhn5ub+qptxNQtnsiJukfHSgsDK3ZbU4K70wvJ2p3nwYXh1V4Tt3L+IGXwbwzr
 FKnB7qNdMrctkkVz1+n2q2YqNhcof6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-29fIy2KoOXSC0xZyUAMOdA-1; Wed, 15 Jul 2020 00:54:18 -0400
X-MC-Unique: 29fIy2KoOXSC0xZyUAMOdA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C1051800D42;
 Wed, 15 Jul 2020 04:54:17 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-26.ams2.redhat.com [10.36.112.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 416A260E1C;
 Wed, 15 Jul 2020 04:54:16 +0000 (UTC)
Subject: Re: [PATCH] util: qemu_get_thread_id for OpenBSD
To: David CARLIER <devnexen@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Brad Smith <brad@comstyle.com>
References: <CA+XhMqxD6gQDBaj8tX0CMEj3si7qYKsM8u1km47e_-U7MC37Pg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <631dad16-66cd-3f7b-90bc-969c52d29aa1@redhat.com>
Date: Wed, 15 Jul 2020 06:54:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CA+XhMqxD6gQDBaj8tX0CMEj3si7qYKsM8u1km47e_-U7MC37Pg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 00:54:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/07/2020 23.26, David CARLIER wrote:
> From 9c7f54c67d40fae0174ba795fbaad829cd59c264 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Tue, 14 Jul 2020 23:23:55 +0100
> Subject: [PATCH] util: qemu_get_thread_id implementation for OpenBSD.
> 
> ussage of getthrid syscall.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  util/oslib-posix.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 72907d4d7f..b4f7de83c8 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -100,6 +100,8 @@ int qemu_get_thread_id(void)
>      return (int)tid;
>  #elif defined(__NetBSD__)
>      return _lwp_self();
> +#elif defined(__OpenBSD__)
> +    return getthrid();
>  #else
>      return getpid();
>  #endif
> 

 Brad,

since you're listed as OpenBSD maintainer, could you please review above
patch?

 Thanks,
  Thomas


