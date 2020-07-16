Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DADDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42ADE206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 06:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ld3lDgdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42ADE206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvxp6-0004tY-HQ
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 02:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jvxoJ-00046R-H4
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 02:56:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20318
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jvxoF-00028x-TG
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 02:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594882558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d7E4qbeOMlWNHpAcFq/JBdJPEPzIw87GwflYUJuUQCM=;
 b=Ld3lDgdldLUFj6zZQfBmm1VR9lWaMBO2VfF43VbELY5jyCFCU6tqusosW9WRUEIOWJavfi
 N2myV6jb/A7fhYOO8NcVQ+gBFji/QWvPC7zp5QCv88Hk9+6WyYVqo77XsAjuCCFD70rYbh
 rn2Yi41nfJLGNOZAtep9TGOAjKmubCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-AdzPX465M2yQm6E3bTJdMQ-1; Thu, 16 Jul 2020 02:55:57 -0400
X-MC-Unique: AdzPX465M2yQm6E3bTJdMQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3342800597;
 Thu, 16 Jul 2020 06:55:55 +0000 (UTC)
Received: from gondolin (ovpn-113-57.ams2.redhat.com [10.36.113.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CAE660C47;
 Thu, 16 Jul 2020 06:55:46 +0000 (UTC)
Date: Thu, 16 Jul 2020 08:55:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: introduce cve or security quotient field
Message-ID: <20200716085543.7082f047.cohuck@redhat.com>
In-Reply-To: <nycvar.YSQ.7.78.906.2007141723140.6870@xnncv>
References: <20200714083631.888605-1-ppandit@redhat.com>
 <20200714083631.888605-2-ppandit@redhat.com>
 <CAFEAcA9QWLmi1fGuPW93GXFKV2KCwNs6Xp3U9MU2r4wtendzhg@mail.gmail.com>
 <20200714095233.GC25187@redhat.com>
 <20200714060916-mutt-send-email-mst@kernel.org>
 <CAFEAcA_ca4JN655GW=eGyjrjDmiv0EktaZZ7RMghO5rBwm9tGQ@mail.gmail.com>
 <20200714064921-mutt-send-email-mst@kernel.org>
 <nycvar.YSQ.7.78.906.2007141723140.6870@xnncv>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 01:59:11
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jul 2020 18:40:11 +0530 (IST)
P J P <ppandit@redhat.com> wrote:

<just commenting on this one>

>  * QEMU would abort(3), if a user attempts to start QEMU with insecure options 
>    like say -virtfs OR -fda fat:floopy OR -netdev user OR -device tulip ?  
> 
>  * One way could be to abort(3) at options parsing stage, if 'security' flag 
>    is set to high(1) and continue further if it is low(0).

Failing to start (with a message that explains why) if one of the
command line options is not covered by a specified security policy is
not unreasonable (after all, we fail to start for other cases of
incompatible command line options as well.) However, we also need to
cover dynamically-added devices. Aborting seems very bad there, just
failing to add the device seems like what we'd want.


