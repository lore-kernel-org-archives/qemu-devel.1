Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3162CC2BB85
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 09:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF6C2078B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 09:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUjwLeuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF6C2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP1FG-0001ae-5V
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 05:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jP1EJ-0000sS-P2
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 05:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jP1EI-0000GV-NU
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 05:54:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41109
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jP1EI-0000Fy-JJ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 05:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587030881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CYsssH8zgzf3zU4HEe6FgiJurX+k57EYOATAAJozBv0=;
 b=RUjwLeujcw6ZdSHioxYqAuej8B1AAgOYbkBgHvQTVYstm3trcbQd0bWA+vtfllxXq+UwzR
 w7p+hEhNGcXIjVu7/33UApIVbpVjVRk1ANYLjpLEbm9WU05kmW2ajFDbaPrSZ1fHmyqzn1
 yZR4WuxUZsKFVNlCTgRovf/9KCuNQwg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-c2JFxmFxPMGSZOLCyEHg2g-1; Thu, 16 Apr 2020 05:54:40 -0400
X-MC-Unique: c2JFxmFxPMGSZOLCyEHg2g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 447CA107ACCA;
 Thu, 16 Apr 2020 09:54:39 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0237B277A4;
 Thu, 16 Apr 2020 09:54:37 +0000 (UTC)
Message-ID: <8c829b4b24cb765aa8ccf81f3bb80f3337c21638.camel@redhat.com>
Subject: Re: [PATCH 0/1] LUKS: Fix error message when underlying fs don't
 support large enough files
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 16 Apr 2020 12:54:36 +0300
In-Reply-To: <20200416095019.4406-1-mlevitsk@redhat.com>
References: <20200416095019.4406-1-mlevitsk@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-04-16 at 12:50 +0300, Maxim Levitsky wrote:
> This is a repost of the same trivial patch I already, which fell through the cracks.
> Could someone queue it up so I close the bugzilla I have for this?

I a word - need more coffee :-)
I mean I already posted this patch few months ago but it was forgotten,
due to merge window/etc.

Best regards,
	Maxim Levitsky

> 
> Best regards,
> 	Maxim Levitsky
> 
> Maxim Levitsky (1):
>   block/crypto: better error message when creating too large files
> 
>  block/crypto.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 



