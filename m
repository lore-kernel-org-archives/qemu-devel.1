Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFF1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 12:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1597221E2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 12:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PklumEyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1597221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k41OC-0008MA-60
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 08:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k41Mv-0007H6-Uc
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 08:21:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41593
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k41Mt-00077r-6Q
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 08:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596802862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QlML8WqfC9apmvopRcZC0hO5nK1ZlgWBf7Z3XkLN9lc=;
 b=PklumEyOyZjWZp2zfab1TaR2RQx0NSogofHQ4MgfVPxXqhOwEZEl7TPXwIJY11Kd+pb64n
 7/rVMRe3vIuV3zGo/tOyQ1SzX12c3pou2AMs02/bGXxm0sgwoyKShkzNVoJQVAnwkqytwu
 Ji3m8brOXRJA1Nlp/IBH5+cyGpyTI3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-N8R4CN29ODaJmRWjZVtUBw-1; Fri, 07 Aug 2020 08:21:00 -0400
X-MC-Unique: N8R4CN29ODaJmRWjZVtUBw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D9929127C;
 Fri,  7 Aug 2020 12:20:58 +0000 (UTC)
Received: from gondolin (ovpn-112-214.ams2.redhat.com [10.36.112.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94203709E1;
 Fri,  7 Aug 2020 12:20:46 +0000 (UTC)
Date: Fri, 7 Aug 2020 14:20:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
Message-ID: <20200807142021.53967299.cohuck@redhat.com>
In-Reply-To: <20200807113557.178825af.cohuck@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <20200807085302.7d7616df.cohuck@redhat.com>
 <499b18ae-b15d-abbb-faf5-d9bdd5262fa4@redhat.com>
 <20200807113557.178825af.cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:53:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, alex.bennee@linaro.org,
 stefanha@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Aug 2020 11:35:57 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 7 Aug 2020 09:59:57 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:

> - on an s390x system, it mostly builds, but I end up with a bunch of
>   link errors for libblock.fa, where it fails to find various ZSTD_
>   symbols

Still happening after switching to the latest version of your branch.

> 
> > 
> > If you want to test on s390, just testing the boot ROM would be great
> > (patch 3).  That one does not need Meson at all; the purpose of the
> > patch is just to decouple the boot ROM makefile from rules.mak, which
> > allows to drop some of the contents of rules.mak.  
> 
> I gave it a try; no errors, but then I realized that the image does not
> seem to get rebuilt? I'll double check later.

I re-tried with a pristine build directory (on a different system), and
it does not look good:

  BUILD   pc-bios/s390-ccw/s390-ccw.elf
cc: error: start.o: No such file or directory
cc: error: main.o: No such file or directory
cc: error: bootmap.o: No such file or directory
cc: error: jump2ipl.o: No such file or directory
cc: error: sclp.o: No such file or directory
cc: error: menu.o: No such file or directory
cc: error: virtio.o: No such file or directory
cc: error: virtio-scsi.o: No such file or directory
cc: error: virtio-blkdev.o: No such file or directory
cc: error: libc.o: No such file or directory
cc: error: cio.o: No such file or directory
cc: error: dasd-ipl.o: No such file or directory
make[1]: *** [Makefile:85: s390-ccw.elf] Error 1
make: *** [Makefile:576: pc-bios/s390-ccw/all] Error 2


