Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81428C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 10:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA2D20733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 10:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ernDkUj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA2D20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih9gD-0001r2-L1
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 05:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ih9fI-0001Bk-JT
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 05:01:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ih9fG-00032r-Rd
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 05:01:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ih9fG-0002xS-Oi
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 05:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576576874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=395DB4iT9L+1P/tSMZceOAr9KHSQ/lUxweD5xuwkJ8s=;
 b=ernDkUj8JTzY8NGWjZmwwCgXXgAmctXd1WC1t4s/pnZKzGbmEFzqPnhCiZYxlBKVmmoknf
 fdIVS2IX/Ynb8ddBsyBCvSogC0LBKcgyqrzbDftGcWREtw5YYvn5N3uDM+JuIBl02fic0k
 sHttPVD2UynexjCTzwC14RP17lAMEtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-3x47OKjlPrW3BVi73qxGtw-1; Tue, 17 Dec 2019 05:01:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91C34802C9C;
 Tue, 17 Dec 2019 10:01:09 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BF455D9E2;
 Tue, 17 Dec 2019 10:01:06 +0000 (UTC)
Date: Tue, 17 Dec 2019 11:01:04 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/2] target/s390x: Implement LOAD/STORE TO REAL ADDRESS
 inline
Message-ID: <20191217110104.2c1079f5.cohuck@redhat.com>
In-Reply-To: <20191211203614.15611-1-richard.henderson@linaro.org>
References: <20191211203614.15611-1-richard.henderson@linaro.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 3x47OKjlPrW3BVi73qxGtw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Dec 2019 12:36:12 -0800
Richard Henderson <richard.henderson@linaro.org> wrote:

> Found while working on other parts of cputlb,
> this cleanup can be split out independently.
> 
> 
> r~
> 
> 
> Richard Henderson (2):
>   target/s390x: Split out helper_per_store_real
>   target/s390x: Implement LOAD/STORE TO REAL ADDRESS inline
> 
>  target/s390x/helper.h      |  5 +----
>  target/s390x/mem_helper.c  | 38 --------------------------------------
>  target/s390x/misc_helper.c | 10 ++++++++++
>  target/s390x/translate.c   | 21 ++++++++-------------
>  target/s390x/insn-data.def |  8 ++++----
>  5 files changed, 23 insertions(+), 59 deletions(-)
> 

Thanks, applied.


