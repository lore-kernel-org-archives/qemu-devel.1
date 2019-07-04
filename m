Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893F1C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 21:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C4A121852
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 21:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4A121852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj9FH-0006jh-Lx
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 17:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55639)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hj9En-0006Is-Gs
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 17:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hj9El-0001QH-Lw
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 17:25:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hj9El-0001PM-Gl
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 17:25:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C3DF286677
 for <qemu-devel@nongnu.org>; Thu,  4 Jul 2019 21:25:50 +0000 (UTC)
Received: from redhat.com (ovpn-120-165.rdu2.redhat.com [10.10.120.165])
 by smtp.corp.redhat.com (Postfix) with SMTP id D156D19C79;
 Thu,  4 Jul 2019 21:25:49 +0000 (UTC)
Date: Thu, 4 Jul 2019 17:25:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190704172519-mutt-send-email-mst@kernel.org>
References: <20190704082736.25258-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704082736.25258-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 04 Jul 2019 21:25:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] tests: acpi: improve tests
 reproducability
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

On Thu, Jul 04, 2019 at 04:27:34AM -0400, Igor Mammedov wrote:
> 
> series should help to make tests more reproducable and not depend
> on IASL being installed. IASL will be required only is user needs
> to get textual diff of mismatching files.


I like this very much but pls send v3 with both patches so
I can apply it easily.

> Igor Mammedov (2):
>   tests: acpi: do not require IASL for dumping AML blobs
>   tests: acpi: do not skip tests when IASL is not installed
> 
>  tests/bios-tables-test.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> -- 
> 2.18.1

