Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957DEC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61BFF20658
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUERzJiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BFF20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJDAM-0002wQ-Dx
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 05:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jJD9g-0002TY-75
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jJD9f-0004vh-8T
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:25:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21103
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jJD9f-0004vK-5I
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585646754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vqY4Mr0VWfU3ucNkSC2VSLErgYwJwr8CQYmGPDvvZmg=;
 b=QUERzJiKJ53T4SjtEgroVnZ7o5Cg+mXRjQ7zS9pLu8yPWz9QwKSm5KSpepwqhnyvgcE8fB
 KyDWFbB6CnhvLVje8PMT1O3QDRX4tnycZZ8IztC5XU1Q1dYqi4qcYyfy9+/DAVHZMVDF2G
 3pqvi0RPTQXaHCtTT37QoFDNTKps/SY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-Jzr0m6nFMTyZYXY3YaRUBQ-1; Tue, 31 Mar 2020 05:25:52 -0400
X-MC-Unique: Jzr0m6nFMTyZYXY3YaRUBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 462ED8010F3;
 Tue, 31 Mar 2020 09:25:51 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20AA9953D6;
 Tue, 31 Mar 2020 09:25:48 +0000 (UTC)
Message-ID: <58e70eadbae304751255e6f65c6b3c5cde2bed8b.camel@redhat.com>
Subject: Re: [PATCH v6 24/42] nvme: remove redundant has_sg member
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Birkelund Jensen <its@irrelevant.dk>
Date: Tue, 31 Mar 2020 12:25:48 +0300
In-Reply-To: <20200331054443.pua4yej3mmj5amqd@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-25-its@irrelevant.dk>
 <8001a1b07bce413961ff6e3569988ab118542f5d.camel@redhat.com>
 <20200331054443.pua4yej3mmj5amqd@apples.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-03-31 at 07:44 +0200, Klaus Birkelund Jensen wrote:
> On Mar 25 12:45, Maxim Levitsky wrote:
> > On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> > > From: Klaus Jensen <k.jensen@samsung.com>
> > > 
> > > Remove the has_sg member from NvmeRequest since it's redundant.
> > 
> > To be honest this patch also replaces the dma_acct_start with block_acct_start
> > which looks right to me, and IMHO its OK to have both in the same patch,
> > but that should be mentioned in the commit message
> > 
> 
> I pulled it to a separate patch :)

Cool. Thanks

> 
> > With this fixed,
> > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > 
> 
> 

Best regards,
	Maxim Levitsky



