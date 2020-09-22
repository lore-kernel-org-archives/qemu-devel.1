Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A92C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 04:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CFEB23A1E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 04:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhkbCqqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFEB23A1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKZz8-0006RW-9N
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 00:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKZy8-0005dJ-6b
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 00:31:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27786)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKZy5-0003nz-6L
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 00:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600749111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=edQj0lCGptIa5Z4/Tl9Apneinjgp80n4XNxGtVbWj1w=;
 b=dhkbCqqVEKZyS0fnN2eJU+q2OesMyB3AtoOL6PQtI5Znq3oxDZLiQuEP4vifm32QsLy2wi
 DGa1ywlSc7QWUdkOyxh36J04llogkKKCZm3YYw31Ox8c66mlTDR+dcOhhZSKuLT+YrammK
 Q/Re1rOszTiNOPAR6aS7uZgTr8QTHyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-cat45NiYPB2dLQPuN5pg5w-1; Tue, 22 Sep 2020 00:31:49 -0400
X-MC-Unique: cat45NiYPB2dLQPuN5pg5w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75294107465D;
 Tue, 22 Sep 2020 04:31:48 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0AD755DA30;
 Tue, 22 Sep 2020 04:31:47 +0000 (UTC)
Date: Tue, 22 Sep 2020 00:31:47 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH 00/24] qom: Convert some properties to class properties
Message-ID: <20200922043147.GV57321@habkost.net>
References: <20200921221045.699690-1-ehabkost@redhat.com>
 <CAKXe6SJVwQ0iz183pnm0jvJnEyAkB_g20Vch2OEeGRZUeNc2Dw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJVwQ0iz183pnm0jvJnEyAkB_g20Vch2OEeGRZUeNc2Dw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 09:47:57AM +0800, Li Qiang wrote:
> Eduardo Habkost <ehabkost@redhat.com> 于2020年9月22日周二 上午6:11写道：
> >
> > Class properties make QOM introspection simpler and easier, as it
> > doesn't require an object to be instantiated.  This series
> > converts a few existing object_property_add*() calls to register
> > class properties instead.
> >
> 
> Hello Eduardo,
> 
> IIUC, most of the properties can be dev-spec or class-spec.
> Do we have any principle or rule to specify the property to be dev or class?
> 
> Maybe if the property which is always the same between instances can
> be a class-property?

If you are talking about having the same value, this is not the
use case for class properties.  Registering a class property just
means all instances of the object will have that property (but
each instance can have the property set to a different value),
and makes this information available for introspection before
instantiating the object.

-- 
Eduardo


