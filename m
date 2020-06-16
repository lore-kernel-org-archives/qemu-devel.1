Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561ABC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B55320707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1sLT+9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B55320707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFMt-0002Qa-F8
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jlF8R-0001US-RS
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:12:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52495
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jlF8Q-0008Bm-1r
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592327549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q7rPbUNxQ/rW5U9BX3QbkTThaGfDLx5mAfAOI0uHae4=;
 b=A1sLT+9GLvaSzn4fWgABd4OIZkFX6SJWlgHK9TrVB/6QSXEw+5N4VAIvZKiy6yDxd5C+DP
 T/SCquxj94f+77hsiY0atIJnFeKsTzAhkueNd1ZQKI8vMaMgrCS1hH8ug519wsuI59LrXA
 yaUdQcTzpHKkV03Zy9/yiXzNtz/0KZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-6RkPcz41NdS7n8gDRqu_Mg-1; Tue, 16 Jun 2020 13:12:26 -0400
X-MC-Unique: 6RkPcz41NdS7n8gDRqu_Mg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2792810059B7
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 17:12:25 +0000 (UTC)
Received: from localhost (ovpn-113-23.phx2.redhat.com [10.3.113.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6176D1002388;
 Tue, 16 Jun 2020 17:12:22 +0000 (UTC)
Date: Tue, 16 Jun 2020 13:12:18 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Add an entry to review Avocado based
 acceptance tests
Message-ID: <20200616171218.GW2366737@habkost.net>
References: <20200605165656.17578-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200605165656.17578-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:46:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 05, 2020 at 06:56:56PM +0200, Philippe Mathieu-Daudé wrote:
> Add an entry for to allow reviewers to be notified when acceptance /
> integration tests are added or modified.
> The designated reviewers are not maintainers, subsystem maintainers
> are expected to merge their tests.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thank you very much for volunteering!

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e7d9cb0a5..c2ae2bf390 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2923,6 +2923,14 @@ S: Maintained
>  F: tests/tcg/Makefile
>  F: tests/tcg/Makefile.include
>  
> +Acceptance (Integration) Testing with the Avocado framework
> +W: https://trello.com/b/6Qi1pxVn/avocado-qemu
> +R: Cleber Rosa <crosa@redhat.com>
> +R: Philippe Mathieu-Daudé <philmd@redhat.com>
> +R: Wainer dos Santos Moschetta <wainersm@redhat.com>
> +S: Odd Fixes
> +F: tests/acceptance/
> +
>  Documentation
>  -------------
>  Build system architecture
> -- 
> 2.21.3
> 

-- 
Eduardo


