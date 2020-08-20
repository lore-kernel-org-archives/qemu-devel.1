Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7C5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B422076E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dP5BwvEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B422076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8ll0-0004a1-DA
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 10:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k8lkL-0003uA-Br
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:40:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39221
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k8lkJ-0002ZW-DZ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597934450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ubmh6JJeG9ZHNklT5zqcj/VSz0pM2xSLjwj2JQNHoMY=;
 b=dP5BwvEF23zw+8ozBw5Oxuz47jNQdzQvfZYKSZ4Zd3QgxcSaNkwvyThGvY84r3q0PtlYSd
 lrBOie4FyrP6Uuaf9Zttui47fOY3q5JAqTEr9Q9EluxpCyxJn1Sayk4n2iQpIaP/HLC169
 zODcGQDHb0y09ruWYQKg+jdLVe/v0BQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-zOafsm9YPS67rawurpGWQw-1; Thu, 20 Aug 2020 10:40:46 -0400
X-MC-Unique: zOafsm9YPS67rawurpGWQw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E74A193F572;
 Thu, 20 Aug 2020 14:40:44 +0000 (UTC)
Received: from gondolin (ovpn-112-251.ams2.redhat.com [10.36.112.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB45E60C87;
 Thu, 20 Aug 2020 14:40:34 +0000 (UTC)
Date: Thu, 20 Aug 2020 16:40:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PULL 3/3] hw: add compat machines for 5.2
Message-ID: <20200820164032.5a443e3a.cohuck@redhat.com>
In-Reply-To: <20200820163508.5c2fce23@redhat.com>
References: <20200819152258.703874-1-ehabkost@redhat.com>
 <20200819152258.703874-4-ehabkost@redhat.com>
 <20200820163508.5c2fce23@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jones <drjones@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kurz <groug@kaod.org>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Aug 2020 16:35:08 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Wed, 19 Aug 2020 11:22:58 -0400
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > From: Cornelia Huck <cohuck@redhat.com>
> > 
> > Add 5.2 machine types for arm/i440fx/q35/s390x/spapr.
> > 
> > Reviewed-by: Andrew Jones <drjones@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> > Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> > Acked-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > Message-Id: <20200819144016.281156-1-cohuck@redhat.com>
                 ^^^^^^^^^^^^^^

> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>  
> 
> Is this the latest version of the patch?
> It doesn't apply cleanly on top of the current master.

Again? I re-spun it yesterday against then-current master.


