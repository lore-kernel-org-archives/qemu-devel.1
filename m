Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2CAC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 486A820661
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3TGU3Yz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486A820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is566-0003df-Df
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 08:22:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1is54q-0002hF-Cz
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1is54m-00064k-Pq
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:20:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20034
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1is54m-00062w-MM
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579180843;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qxb6I+r2tu+IqoEBz94iBAHq3Z+iLje3XtuOWbo6EdM=;
 b=O3TGU3YzjawDirVAU0+7tKBvwKdWZ+eQLsfMfoyLW45S4ZJem3cNFe/vocAyKovw9V4pHK
 7YC1DpfFDdBxbeRjDQMvKqx5/DartM7UxQa+9V3Z5EVCSvyD74eq32JpbKkCWL29RLXNCm
 D0VmR1uiathi5xvYmafzqjQsHojOEC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-HPtQEiHiOUK9QNbhRBlhGQ-1; Thu, 16 Jan 2020 08:20:41 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75B55B3D1E;
 Thu, 16 Jan 2020 13:20:40 +0000 (UTC)
Received: from redhat.com (ovpn-117-192.ams2.redhat.com [10.36.117.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09A6A38A;
 Thu, 16 Jan 2020 13:20:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Zhimin Feng <fengzhimin1@huawei.com>
Subject: Re: [PATCH RFC 03/12] migration: Create the multi-rdma-channels
 parameter
In-Reply-To: <20200109045922.904-4-fengzhimin1@huawei.com> (Zhimin Feng's
 message of "Thu, 9 Jan 2020 12:59:13 +0800")
References: <20200109045922.904-1-fengzhimin1@huawei.com>
 <20200109045922.904-4-fengzhimin1@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 16 Jan 2020 14:20:37 +0100
Message-ID: <87imlb8rmi.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: HPtQEiHiOUK9QNbhRBlhGQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Reply-To: quintela@redhat.com
Cc: zhang.zhanghailiang@huawei.com, armbru@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, jemmy858585@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Zhimin Feng <fengzhimin1@huawei.com> wrote:
> From: fengzhimin <fengzhimin1@huawei.com>
>
> Indicates the number of RDMA threads that we would create.
> By default we create 2 threads for RDMA migration.
>
> Signed-off-by: fengzhimin <fengzhimin1@huawei.com>

Two things:

- If you use multifd as suggested on the 1st platch, please use
  multifd-channels here.

- Once told that, why are you using a default of two?

Thanks, Juan.


