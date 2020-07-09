Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF45FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 806C1206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcb+tzar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806C1206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtTuB-0008JN-Pi
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 06:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jtTtb-0007om-P9
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:35:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50255
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jtTtZ-0000ax-JK
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594290912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9WeI0oWWXs+bVldmZqo1XuZ6eysdSrWI8zjv+SUUAjI=;
 b=bcb+tzar5b0xludVMHu5/yN6q1HzEPXd1eyzGeizOSfok9HditYjYaDVn2xvD1+iyIDZCk
 sHODjUJtp9bptve8PsHij3qvWN/l8G3Mia0h0Ek91ls7GywPMvdFLLYSHsYY/IGvQ9VcDw
 4JnQHXynWfQIlKuiRGWneYDORoK7Ug4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-lXg3-gqJNIGcg8Bre6ejYQ-1; Thu, 09 Jul 2020 06:35:11 -0400
X-MC-Unique: lXg3-gqJNIGcg8Bre6ejYQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D16B88C7A0;
 Thu,  9 Jul 2020 10:35:10 +0000 (UTC)
Received: from starship (unknown [10.35.206.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A12BB7F8BF;
 Thu,  9 Jul 2020 10:35:05 +0000 (UTC)
Message-ID: <ee35f0e3c00300bc84137bc0f82ee58cc3bbe0ca.camel@redhat.com>
Subject: Re: [PATCH v2 6/7] scsi: Add scsi_device_get
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 09 Jul 2020 13:35:04 +0300
In-Reply-To: <20200527152749.GL29137@stefanha-x1.localdomain>
References: <20200511160951.8733-1-mlevitsk@redhat.com>
 <20200511160951.8733-7-mlevitsk@redhat.com>
 <20200527152749.GL29137@stefanha-x1.localdomain>
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:20:09
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
Cc: Fam Zheng <fam@euphon.net>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-05-27 at 16:27 +0100, Stefan Hajnoczi wrote:
> On Mon, May 11, 2020 at 07:09:50PM +0300, Maxim Levitsky wrote:
> > +/*
> > + * This function works like scsi_device_get but doesn't take a refernce
> 
> s/refernce/reference/
> 
> > + * to the returned object. Intended for legacy code
> 
> The following explains this in more detail. It's not necessarily legacy
> code but rather whether it runs under the QEMU global mutex or not:
> 
> Devices that run under the QEMU global mutex can use this function.
> Devices that run outside the QEMU global mutex must use
> scsi_device_get() instead.
Done.

Best regards,
	Maxim Levitsky


