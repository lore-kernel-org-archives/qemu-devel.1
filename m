Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91864C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1046C20721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IomIiQXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1046C20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbby-0002zc-3g
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 09:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jVbat-0001pz-Lr
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:57:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42657
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jVbas-0000Ij-0u
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588600633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=32ff6uuadat7qkHrcdy2QiK3weXFQ2A3ApLJMqTm8+Q=;
 b=IomIiQXNnSQiP8UF5SRP51wkrz8sfTDbAoNYMH8Y5SAwz30jZwQuQi8UUycUiKeUYd9pCB
 RIYgLsPWj+B2P2Xxe68EqlrAhonpvHrdguheyMco4YVDg7N0UrIisO7Z7xNpTKvwA5WAtf
 DSvMFnEZ8vEeNK67yLwPDGvo7r8RUzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-N3SEvFbXNt226bFdbqrSlw-1; Mon, 04 May 2020 09:57:10 -0400
X-MC-Unique: N3SEvFbXNt226bFdbqrSlw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 337D618A073C;
 Mon,  4 May 2020 13:56:55 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B968E5C1B2;
 Mon,  4 May 2020 13:56:53 +0000 (UTC)
Message-ID: <af236d53d949c8ebf25386332011f7a67f716d26.camel@redhat.com>
Subject: Re: [PATCH v2] Fix iotest 153
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Mon, 04 May 2020 16:56:52 +0300
In-Reply-To: <a849ecdd-00d4-e5de-223b-f93aff4af7f8@redhat.com>
References: <20200504131959.9533-1-mlevitsk@redhat.com>
 <a849ecdd-00d4-e5de-223b-f93aff4af7f8@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-05-04 at 15:55 +0200, Max Reitz wrote:
> On 04.05.20 15:19, Maxim Levitsky wrote:
> > Commit f62514b3def5fb2acbef64d0e053c0c31fa45aff made qemu-img reject -o "" but this test uses it.
> > Since this test only tries to do a dry-run run of qemu-img amend,
> > replace the -o "" with dummy -o "size=$size".
> > 
> > Fixes: f62514b3def5fb2acbef64d0e053c0c31fa45aff
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  tests/qemu-iotests/153     |  2 +-
> >  tests/qemu-iotests/153.out | 12 ++++++------
> >  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> Thanks, applied to my block branch:
> 
> https://git.xanclic.moe/XanClic/qemu/commits/branch/block
> 
> Max
> 
Thanks!
Best regards,
	Maxim Levitsky


