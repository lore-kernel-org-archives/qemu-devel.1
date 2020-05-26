Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B778C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:18:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB3B2073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/hlIUv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB3B2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdVjL-0006zW-Bq
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 05:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jdVin-0006Xh-RI
 for qemu-devel@nongnu.org; Tue, 26 May 2020 05:18:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33309
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jdVim-0000jm-Rn
 for qemu-devel@nongnu.org; Tue, 26 May 2020 05:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590484683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWEMU+zPKWD3gjVxq80RXiia6amuoPqgu3MNcttfqdw=;
 b=f/hlIUv+LhLVLk6eV0ndqa/ZT8C87bLZ5cVTAUpsv160fvx827m4eBDhBOUE7Y0oh0ypNo
 yEdMy1+dYqsScp9p/F7FO9kzHKv6KxdWNKUE2RujANGdkcs5vi262hsMcRnul+OoF4z3Qh
 9ybRsbOPYk4UNjtBbTGU28W2RsoRgME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-v-Isnhx0NlyU1fbMQshBDA-1; Tue, 26 May 2020 05:18:01 -0400
X-MC-Unique: v-Isnhx0NlyU1fbMQshBDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07060461;
 Tue, 26 May 2020 09:18:01 +0000 (UTC)
Received: from gondolin (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 251888ECE1;
 Tue, 26 May 2020 09:17:59 +0000 (UTC)
Date: Tue, 26 May 2020 11:17:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: add Thomas as additional s390x maintainer
Message-ID: <20200526111757.592e761d.cohuck@redhat.com>
In-Reply-To: <2d8a8cb4-f6bc-acac-6425-83eea297e8e3@redhat.com>
References: <20200525155855.225564-1-cohuck@redhat.com>
 <2d8a8cb4-f6bc-acac-6425-83eea297e8e3@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 25 May 2020 20:15:50 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 25/05/2020 17.58, Cornelia Huck wrote:
> > ...because two people are better than one.
> > 
> > Cc: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3690f313c3b6..b3c729688649 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -85,6 +85,7 @@ Architecture support
> >  --------------------
> >  S390 general architecture support
> >  M: Cornelia Huck <cohuck@redhat.com>
> > +M: Thomas Huth <thuth@redhat.com>
> >  S: Supported
> >  F: default-configs/s390x-softmmu.mak
> >  F: gdb-xml/s390*.xml  
> 
> Glad to help!

Thanks! :)

> 
> Acked-by: Thomas Huth <thuth@redhat.com>

Queued to s390-next.


