Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,WEIRD_QUOTING autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47F3C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:44:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1344D2064E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6y1lXrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1344D2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ7ry-00028X-2A
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 07:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQ7nX-00080y-H2
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:39:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQ7nU-0007ts-KU
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602070791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=std3IddxnHM5DjsjC83rndjtdwGlILxl+SzzXUq42fU=;
 b=M6y1lXrna1yObkCAdjCxumDvZE1TpeJJfMbZWby7b++B7VDI0AFqXVPryOd7tK3o8TunuK
 lfWlyAVba1Jr4CTdNK7bE70Z1NYzOxIFzyaMeWy8xjlPMDCrYjuZFSClirPBr/mV/j+lrV
 rzsyxPupiIAvFLpT/siC+4MXhGIvt0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-WeO8_TtBNcKwyHwyDMPfTA-1; Wed, 07 Oct 2020 07:39:50 -0400
X-MC-Unique: WeO8_TtBNcKwyHwyDMPfTA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D59B804018
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 11:39:49 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D494819C4F;
 Wed,  7 Oct 2020 11:39:48 +0000 (UTC)
Date: Wed, 7 Oct 2020 07:39:47 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/3] docs/devel/qtest: Include protocol spec in document
Message-ID: <20201007113947.GS7303@habkost.net>
References: <20201005205228.697463-1-ehabkost@redhat.com>
 <20201005205228.697463-3-ehabkost@redhat.com>
 <27b0312b-cef9-9aea-3196-871eeca6760d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <27b0312b-cef9-9aea-3196-871eeca6760d@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 07, 2020 at 01:03:21PM +0200, Paolo Bonzini wrote:
> On 05/10/20 22:52, Eduardo Habkost wrote:
> > + * DOC: QTest Protocol
> > + *
> > + * .. highlight:: none
> >   *
> >   * Line based protocol, request/response based.  Server can send async messages
> >   * so clients should always handle many async messages before the response
> >   * comes in.
> >   *
> >   * Valid requests
> > + * ^^^^^^^^^^^^^^
> >   *
> >   * Clock management:
> > + * """""""""""""""""
> >   *
> >   * The qtest client is completely in charge of the QEMU_CLOCK_VIRTUAL.  qtest commands
> >   * let you adjust the value of the clock (monotonically).  All the commands
> >   * return the current value of the clock in nanoseconds.
> >   *
> > + * .. code-block::
> 
> What version of Sphinx do you have?  I need to have ".. code-block::
> none" here, so presumably the "highlight" directive is newer than my
> version (1.7.6, pretty old I admit)?

I have 2.2.2.

It looks like we should really add code to print a warning if not
running Sphinx 2.x.

-- 
Eduardo


