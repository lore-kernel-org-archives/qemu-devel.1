Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A82BC432C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 16:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B9620748
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 16:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bz6gR7Ns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B9620748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibopA-0000Yn-BR
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 11:45:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ibooT-0008V0-Pd
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ibooR-0007kj-Sy
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:44:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42810
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ibooR-0007kZ-Oa
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575305078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T64rpJTHeo8rSiad/sU89XMpHXDwaTgTtBLA7bbtrfA=;
 b=Bz6gR7NsFemHTJM38nzsNvuS+fRBNsa/EmsZPddPvqoaTJHkRCegaYsKZySxYyoIs1TMDE
 MpeX7TbUrLQlpLGlGeWXUN1TewgCplDyLXFQaEsoYe7Rj5eGj2ujNkoR7dXwjS9fR2GQLl
 OIWtx/QM6iENscH8wh+kLqMoNHtFyWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-WIW5NgPKOESGBaMX3U5Sww-1; Mon, 02 Dec 2019 11:44:35 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0558A10054E3
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2019 16:44:35 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6597319C68;
 Mon,  2 Dec 2019 16:44:25 +0000 (UTC)
Date: Mon, 2 Dec 2019 16:44:23 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: virtiofsd: Where should it live?
Message-ID: <20191202164423.GE2904@work-vm>
References: <20191125185021.GB3767@work-vm>
 <20191202043040-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191202043040-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: WIW5NgPKOESGBaMX3U5Sww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: mszeredi@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Mon, Nov 25, 2019 at 06:50:21PM +0000, Dr. David Alan Gilbert wrote:
> > Hi,
> >   There's been quite a bit of discussion about where virtiofsd, our
> > implemenation of a virtiofs daemon, should live.  I'd like to get
> > this settled now, because I'd like to tidy it up for the next
> > qemu cycle.
> >=20
> > For reference it's based on qemu's livhost-user+chunks of libfuse.
> > It can't live in libfuse because we change enough of the library
> > to break their ABI.
>=20
> Generally there could be some ifdefs that allow one to
> build libfuse-host or whatever from the same source.
> I am guessing the big reason this doesn't fly is that
> libfuse is not actively developed anymore.

libfuse is certainly taking patches; so it's not dead.
However, the changes for the transport are quite invasive,
and it doesn't feel right to impose them on it.
We've pushed up small fixes/changes etc - but not things
that are big intrusive lumps for our use.

> Given that, the main remaining part is libvhost-user,
> and it's less work to use than to duplicate that.
> That kind of dictates being in qemu.
>=20
> >  It's C, and we've got ~100 patches - which
> > we can split into about 3 chunks.
> >=20
> > Some suggestions so far:
> >   a) In contrib
> >      This is my current working assumption; the main objection is it's
> >      a bit big and pulls in a chunk of libfuse.
> >   b) In a submodule
> >=20
> >   c) Just separate
> >=20
> > Your suggestions/ideas please.  My preference is (a).
> >=20
> > Dave
>=20
>=20
> My preference is close to a, and maybe to avoid confusion we should have
> a new top-level directory for "separate daemons qemu invokes, and need
> to be built together with qemu". libvhost-user would have to move there,
> too. "modules"?

"modules" feels too close to "plugins" to my mind.

Dave

>=20
> >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


