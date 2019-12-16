Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F6CC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD70206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpLybrgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD70206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igqLy-0001gD-A1
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 08:24:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1igqLM-0001Ei-OQ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:23:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1igqLJ-0006Qy-7J
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:23:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49713
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1igqLJ-0006Qa-3I
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:23:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576502600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i9XGtH1HIxT2Svyemp0h7H7JAFwmSw92X3ipmB9Jqok=;
 b=cpLybrgWsHMAifAOfsZjsTEdC4mVxvshNqtNbj7YcxZpT4bwBzE/q8Gi6cZoUZgdZ6n1NP
 pDFEKlTIZea6qtjgODbt33AI1Oth1KPOVXPzcS/D4GLGeEb8TUhhtPQd1vkRG1PpeC8yZ5
 GymF9ZKnbfwva4FmWtPR88yUTFo5TJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-lFrcD_WqP9ijv8k0BogYeQ-1; Mon, 16 Dec 2019 08:23:19 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F5BE8017DF
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 13:23:18 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B73895D9C5;
 Mon, 16 Dec 2019 13:23:16 +0000 (UTC)
Date: Mon, 16 Dec 2019 14:23:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 00/10] Migration Arguments cleanup
Message-ID: <20191216142314.7d4237cc.cohuck@redhat.com>
In-Reply-To: <20191212222033.1026-1-quintela@redhat.com>
References: <20191212222033.1026-1-quintela@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: lFrcD_WqP9ijv8k0BogYeQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Dec 2019 23:20:23 +0100
Juan Quintela <quintela@redhat.com> wrote:

> Hi
> 
> This series simplify test_migrate_start() in two ways:
> - simplify the command line creation, so everything that is common between
>   architectures don't have to be repeated (DRY).
>   Note that this bit remove lines of code.
> - test_migrate_start() has two bools and two strings as arguments, it is very
>   difficult to remmeber which is which and meaning.  And it is even worse to
>   add new parameters.  Just pass them through one struct.
> 
> Please, review.
> 
> Juan Quintela (10):
>   migration-test: Create cmd_soure and cmd_target
>   migration-test: Move hide_stderr to common commandline
>   migration-test: Move -machine to common commandline
>   migration-test: Move memory size to common commandline
>   migration-test: Move shmem handling to common commandline
>   migration-test: Move -name handling to common commandline
>   migration-test: Move -serial handling to common commandline
>   migration-test: Move -incomming handling to common commandline
>   migration-test: Rename cmd_src/dst to arch_source/arch_target
>   migration-test: Use a struct for test_migrate_start parameters
> 
>  tests/migration-test.c | 265 +++++++++++++++++++++++------------------
>  1 file changed, 147 insertions(+), 118 deletions(-)
> 

I gave this a go on s390x, and the migration test still seems to work
fine there. So, feel free to add

Tested-by: Cornelia Huck <cohuck@redhat.com> #s390x


