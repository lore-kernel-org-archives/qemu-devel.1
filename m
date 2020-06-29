Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB613C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 23:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E18206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 23:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJk/lUsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E18206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq2mE-00039c-Kh
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 19:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jq2lV-0002ZZ-Dx
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 19:00:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41170
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jq2lS-0002BF-S7
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 19:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593471637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2TQCzlz36VV8QDAl+vOjAMNELGdZ+RQL4QM3SuhZLkY=;
 b=IJk/lUsUnGmgH+mOxVxW0Qvf6WAq9lSNTZDyD157PXntNTzvTtYz/0HlMPLvrQQGmWprE4
 DSHklvn19MvGi6+8S5JrS1Im1yAAyVvyPsgcVwCGQvjA3oXZvFxWYzi/gyE5GeXkqM42tW
 v8574+L8xZ+B0EzJI1dfKHG7UB0HVEU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-UDrBEDvVNeav-MjHi_brqA-1; Mon, 29 Jun 2020 19:00:21 -0400
X-MC-Unique: UDrBEDvVNeav-MjHi_brqA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6B681005513;
 Mon, 29 Jun 2020 23:00:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-41.ams2.redhat.com
 [10.36.112.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E60A429367;
 Mon, 29 Jun 2020 23:00:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 01D5F59CC; Tue, 30 Jun 2020 01:00:09 +0200 (CEST)
Date: Tue, 30 Jun 2020 01:00:09 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH 09/10] spice: Put spice functions in a separate load module
Message-ID: <20200629230009.iojnu2gtalpgedxo@sirius.home.kraxel.org>
References: <20200626164307.3327380-1-dinechin@redhat.com>
 <20200626164307.3327380-10-dinechin@redhat.com>
 <20200626173538.GP1028934@redhat.com> <lyo8p1dc2a.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <lyo8p1dc2a.fsf@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 19:00:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > If so the more normal approach would be to have a struct defining
> > a set of callbacks, that can be registered. Or if there's a natural
> > fit with QOM, then a QOM interface that can then have a QOM object
> > impl registered as a singleton.
> 
> That was my second attempt (after the weak symbols). I cleaned it up a bit
> and put it here: https://github.com/c3d/qemu/commits/spice-vtable.

I think this is the direction we should take.

> What made me switch to the approach in this series is the following
> considerations:
> 
> - A vtable is useful if there can be multiple values for a method, e.g. to
>   implement inheritance, or if you have multiple instances. This is not the
>   case here.

Well, we'll have two.  The normal functions.  And the stubs.

The stubs are inline functions right now, in include/ui/qemu-spice.h, in
the !CONFIG_SPICE section.  We can turn them into normal functions, move
them to some C file.  Let QemuSpiceOpts function pointers point to the
stubs initially.  When spice initializes (no matter whenever modular or
not) it'll set QemuSpiceOpts to the normal implementation.

That way we'll also remove some spice #ifdefs as part of the spice
modularization effort.

Things like the "using_spice" variable which don't depend on the spice
shared libraries can also be moved to the new C file with the spice
stubs.

I don't think we need to hide QemuSpiceOpts with inline functions like
qemu_spice_migrate_info().  I would simply use ...

	struct QemuSpiceOps {
		[ ... ]
		int (*migrate_info)(...);
		[ ... ]
	} qemu_spice;

... then change the ...

	qemu_spice_migrate_info(...)

.. callsites into ...

	qemu_spice.migrate_info(...)

> - Overloading QOM for that purpose looked more confusing than anything else.
>   It looked like I was mixing unrelated concepts. Maybe that's just me.

Hmm?  Not sure what you mean.  There is no need for QOM here (and I
can't see anything like that in your spice-vtable branch either).

> - The required change with a vtable ends up being more extensive. Instead of
>   changing a single line to put an entry point in a DSO, you need to create
>   the vtable, add functions to it, add a register function, etc. I was
>   looking for an easier and more scalable way.

IMHO it isn't too much overhead, and I find the code is more readable
that way.

> - In particular, with a vtable, you cannot take advantage of the syntactic
>   trick I used here, which is that foo(x) is a shortcut for (*foo)(x).
>   So for a vtable, you need to manually write wrappers.

See above, I don't think we need wrappers.

take care,
  Gerd


