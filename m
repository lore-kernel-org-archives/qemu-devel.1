Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145D5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A62207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TS562ITU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A62207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtopA-0001fY-5C
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 04:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtooF-0000VS-Ip
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:55:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48769
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtooD-0008HO-PS
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594371304;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hSK3YT+bBH1LkWCzHcxv8lG9Iqnh/QyCOuQuwSwg5l4=;
 b=TS562ITUtmTx/zU0yvVEpI6I5NX8RztYCIDLc/zKxH1IWcdeKJ/TquUfK32b9AwVcffe8J
 TnLaq3kiRg5bEOL66S+o9e/J40TNt8AJ1r893cVHkwX1AAyLU3KPHNc01wwdqN2iHH8iRu
 UaUECxEVfRKZ6DhXJZ9lwErRtgkVS0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-33B3PpzfMiafor5fYsyBxg-1; Fri, 10 Jul 2020 04:55:02 -0400
X-MC-Unique: 33B3PpzfMiafor5fYsyBxg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D37498014D7;
 Fri, 10 Jul 2020 08:55:01 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EA7C5C1BD;
 Fri, 10 Jul 2020 08:54:57 +0000 (UTC)
Date: Fri, 10 Jul 2020 09:54:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Liviu Ionescu <ilg@livius.net>
Subject: Re: Separate notifications from list messages?
Message-ID: <20200710085454.GD4017912@redhat.com>
References: <E646BE29-B46F-4B56-ADF5-B0DC6CCEF422@livius.net>
 <0a3689e1-001a-76ec-894d-0bb63115ecdd@redhat.com>
 <CAFEAcA-Y_e9V2UTEZoVbxOWQcs_eP96cMQ1J2BtC6Y0AAUTgSA@mail.gmail.com>
 <FF6A540C-7C16-4FFC-9A6D-FAB9EFE56B7F@livius.net>
 <CAFEAcA_c3M-NQcXMt7pnA1qn9B8AYSnFMP1zHx3i_cU2cqpnSQ@mail.gmail.com>
 <008CCEB6-D3F4-4F1A-80DE-83F47873851F@livius.net>
MIME-Version: 1.0
In-Reply-To: <008CCEB6-D3F4-4F1A-80DE-83F47873851F@livius.net>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 10, 2020 at 11:40:05AM +0300, Liviu Ionescu wrote:
> 
> 
> > On 10 Jul 2020, at 11:32, Peter Maydell <peter.maydell@linaro.org> wrote:
> > 
> > ... Do we expect any other
> > kinds to appear as we make more use of gitlab?
> 
> I have zero experience with gitlab, but on github yes, most project activity can trigger notifications.
> 
> this is not a problem in itself. the problem is that, instead of
> using a personal email address, the qemu-devel list was used
> somewhere in the project settings, and all notifications go to the list.

This wasn't a mistake - it was very delibrate, precisely so that all
involved in QEMU development will see the failures, instead of expecting
a handful of people to take all the work of dealing with failures. In
general anyone who's a regular contributor has a shared responsibility
to help keep QEMU building reliably.

Given the overall volume of mail on qemu-devel, a handful of notifications
from CI each day is not a burden IMHO.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


