Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FCFC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 16:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D12206A2
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 16:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D12206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55155 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs8pJ-0002EB-Gu
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 12:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33839)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hs8mn-0007gq-CL
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:46:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hs8ml-0000n2-Dn
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:46:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41696)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hs8mj-0000lX-J4
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:46:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD4D13DE22;
 Mon, 29 Jul 2019 16:46:04 +0000 (UTC)
Received: from redhat.com (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E418B5D6A5;
 Mon, 29 Jul 2019 16:45:58 +0000 (UTC)
Date: Mon, 29 Jul 2019 17:45:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190729164556.GV32718@redhat.com>
References: <20190729162903.4489-1-dgilbert@redhat.com>
 <20190729183232.22bcbb26.cohuck@redhat.com>
 <20190729163541.GJ2756@work-vm>
 <CAFEAcA-LG+z7=4P488Rg3=p73+kNYVy6abaZRBE97=Q==esFaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-LG+z7=4P488Rg3=p73+kNYVy6abaZRBE97=Q==esFaQ@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 29 Jul 2019 16:46:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [For 4.1 PATCH v2 0/2] Reversions to fix PCIe in
 virtio
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
Cc: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 29, 2019 at 05:43:17PM +0100, Peter Maydell wrote:
> On Mon, 29 Jul 2019 at 17:36, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * Cornelia Huck (cohuck@redhat.com) wrote:
> > > On Mon, 29 Jul 2019 17:29:01 +0100
> > > "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> > >
> > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > >
> > > > Revert a couple of patches that break PCIe capabilities in virtio
> > > > devices. The 'optional' revert is just reverted to make the main
> > > > reversion trivial.
> > >
> > > Don't want to spoil the party here; but wasn't the optional stuff
> > > removed because it was deemed to be a bad idea?
> >
> > I'm perfectly happy to go either way with this; it maybe a bad idea
> > but it's harmless I think.
> 
> It seems like the original commits were:
>  * patch that does something
>  * patch that removes no-longer used functionality (optional globals)
> 
> so it makes sense to me that if we want to revert the 'patch that
> does something' we should first revert the patch that cleaned
> up unused-functionality (because now we need it again). Is
> that right?
> 
> If optional-globals are a bad idea then we should take another
> run at this for 4.2, but as a "revert stuff for 4.1" strategy
> it seems fine to me.

Functionally both approaches are supposed to be identical, but given
that we already found one last minute problem with the 2nd patch, the
full revert of both feels ever so slightly safer.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

