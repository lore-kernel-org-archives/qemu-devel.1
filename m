Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF1EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9D120672
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJxVvjcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9D120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIwuM-0006jC-Ee
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIwt8-0005aa-5i
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:36:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIwt6-0001jG-Bf
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600360559;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Q+cqqL+P42iWreJPV1Rb5mCPkmWvXV8M7AGpPIgCy0I=;
 b=jJxVvjcZZ/6Jwr6iF2iH6vIh0oHprxGyBxCYhP/C5XNZpjQx54T1wCehtpQezvs07hVKM2
 l8FKaWzTSGhJaaZTfKEVdbNGItrrxwiqLwarv9f0xUnFssqJhpNlgOn1slyX/Ys5jfYvG9
 MmJYcz1WzsZEZy4k6B7iklQPTFeNZOM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-8TSBY3bXMkCQpadirh7oPg-1; Thu, 17 Sep 2020 12:35:55 -0400
X-MC-Unique: 8TSBY3bXMkCQpadirh7oPg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53E9564159;
 Thu, 17 Sep 2020 16:35:54 +0000 (UTC)
Received: from redhat.com (ovpn-114-29.ams2.redhat.com [10.36.114.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0990C78803;
 Thu, 17 Sep 2020 16:35:48 +0000 (UTC)
Date: Thu, 17 Sep 2020 17:35:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Subject: Re: Python 3.5 EOL; when can require 3.6?
Message-ID: <20200917163545.GN1597829@redhat.com>
References: <875z8eupyp.fsf@dusky.pond.sub.org>
 <CAFEAcA8q8J1n2UqsNbHgNwEedA8pZ6fNA7obCR1REN-33nvmkg@mail.gmail.com>
 <d07189e2-0683-2eb9-44e0-a275688fa8b4@redhat.com>
 <9d4363e8-7bb8-8255-9914-6d9bc36cec79@redhat.com>
 <871rj0o1yk.fsf@dusky.pond.sub.org>
 <b679e646f4dd8ebea753892c0cec27e54ba8f407.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b679e646f4dd8ebea753892c0cec27e54ba8f407.camel@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 06:07:00PM +0200, Andrea Bolognani wrote:
> On Thu, 2020-09-17 at 17:30 +0200, Markus Armbruster wrote:
> > Thomas Huth <thuth@redhat.com> writes:
> > > Sorry, I forgot to check Debian. If I got that right, Debian 9 still
> > > uses Python 3.5 by default. So I guess that means we can not deprecate
> > > Python 3.5 yet?
> > 
> > Discussed before:
> > 
> >     Subject: Re: [PATCH] qapi: Fix code generation with Python 3.5
> >     Date: Sat, 18 Jan 2020 07:54:18 +0100
> >     Message-ID: <87lfq5s19h.fsf@dusky.pond.sub.org>
> >     https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg03855.html
> > 
> > Short version: Debian != Debian LTS.  We support Debian until EOL, not
> > LTS.  Debian 9 reached EOL in July.
> 
> FWIW, this is the same policy the libvirt project follows, and we
> have formalized it at
> 
>   https://libvirt.org/platforms.html
> 
> with Debian LTS being called out explicitly as not supported.
> 
> It would be *fantastic* if we could keep the platform support policy
> used by QEMU and libvirt as aligned as reasonably possible.

The current QEMU policy was a copy+paste of the same policy I wrote for
libvirt originally, just adding OpenBSD/NetBSD.

I've just posted an update for QEMU which matches the latest libvirt
policy, again just adding the extra BSDs.

https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg06371.html

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


