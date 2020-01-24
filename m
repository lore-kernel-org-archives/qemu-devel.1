Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70033C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 08:11:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E0920709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 08:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="So+XnWZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E0920709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuu47-0002oP-Dl
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 03:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuu3S-0002IN-0X
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 03:11:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuu3Q-000844-Bm
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 03:11:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51217
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuu3Q-00083B-9D
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 03:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579853459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Hx2u7UNLH2pgiFS6pXQKRZudiTLlIYjal3qOzorjd8=;
 b=So+XnWZG70IHWV7lpbsKOOies89qdAc5ZWIpET0HY5yXlZGdqeyeEcnWaXwP11O/jq8AIQ
 MF++QgtnpAqzpCDvfcpal0J0ZfFmYLmtVpjXiwnQyfoW6jescgKwF0LDSz3LZB00nTnBU5
 YilTwYbYNNPUvW0dYOJah+Z57OHPgI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-meIjkUDwMravl6EhFMqRog-1; Fri, 24 Jan 2020 03:10:56 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05A1318A6EC2;
 Fri, 24 Jan 2020 08:10:55 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4DB010016EB;
 Fri, 24 Jan 2020 08:10:53 +0000 (UTC)
Date: Fri, 24 Jan 2020 09:10:51 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au>
Subject: Re: [PATCH REPOST v3 16/80] arm/kzm: drop RAM size fixup
Message-ID: <20200124091051.566db9b5@redhat.com>
In-Reply-To: <84zhedx161.wl-Peter.Chubb@data61.csiro.au>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-17-git-send-email-imammedo@redhat.com>
 <84zhedx161.wl-Peter.Chubb@data61.csiro.au>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: meIjkUDwMravl6EhFMqRog-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.chubb@nicta.com.au" <peter.chubb@nicta.com.au>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 22:23:20 +0000
"Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au> wrote:

> Igor> If the user provided too large a RAM size, the code used to
> Igor> complain and trim it to the max size.  Now tht RAM is allocated by
> Igor> generic code, that's no longer possible, so generate an error and
> Igor> exit instead.  
> 
> You can add my 'reviewed-by' to this. There's one really minor typo in
> the comment (tht->that) that you may wish to fix before the final
> commit.

Thanks,
will do it in v4

(considering that there are already fixes to
the current version, I'll rebase and repost)
> 
> Reviewed-by: Peter Chubb <peter.chubb@data61.csiro.au>
> 


