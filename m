Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CE6C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 17:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D50B220640
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 17:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JzvNLTYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50B220640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibp9c-0005Oz-3a
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 12:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ibp4a-0007dv-TR
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 12:01:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ibp4Z-0005v2-A8
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 12:01:20 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57636
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ibp4Z-0005ug-5b
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 12:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575306078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MlVGm+nwJ2DRW3voY/u1leMX+aSkE8UAnkk0cuI05Ao=;
 b=JzvNLTYkeoro24W+uknjtnOICEEgNlNAoTSRAcV1hWIpMa8TwpeN4eHbcrkKiI6DPDFg9G
 +SN3LDLH9ZJ/KJwyEsS84W0NNkZ93vvfR0MToLtTGwuQMZ8csfPESK/Gu9yKNFZfkiUekr
 U3cwCfYY7HE0nAJiI24NUQ8UjDagHRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-_-LyD3GyN9-X9L9TcRFo_g-1; Mon, 02 Dec 2019 12:01:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41EF5107ACC4
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2019 17:01:16 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA19719C6A;
 Mon,  2 Dec 2019 17:01:04 +0000 (UTC)
Date: Mon, 2 Dec 2019 17:01:02 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: virtiofsd: Where should it live?
Message-ID: <20191202170102.GF2904@work-vm>
References: <20191125185021.GB3767@work-vm>
 <20191202043040-mutt-send-email-mst@kernel.org>
 <20191202164423.GE2904@work-vm>
 <20191202114724-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191202114724-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: _-LyD3GyN9-X9L9TcRFo_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
> On Mon, Dec 02, 2019 at 04:44:23PM +0000, Dr. David Alan Gilbert wrote:
> > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > On Mon, Nov 25, 2019 at 06:50:21PM +0000, Dr. David Alan Gilbert wrot=
e:
> > > > Hi,
> > > >   There's been quite a bit of discussion about where virtiofsd, our
> > > > implemenation of a virtiofs daemon, should live.  I'd like to get
> > > > this settled now, because I'd like to tidy it up for the next
> > > > qemu cycle.
> > > >=20
> > > > For reference it's based on qemu's livhost-user+chunks of libfuse.
> > > > It can't live in libfuse because we change enough of the library
> > > > to break their ABI.
> > >=20
> > > Generally there could be some ifdefs that allow one to
> > > build libfuse-host or whatever from the same source.
> > > I am guessing the big reason this doesn't fly is that
> > > libfuse is not actively developed anymore.
> >=20
> > libfuse is certainly taking patches; so it's not dead.
> > However, the changes for the transport are quite invasive,
> > and it doesn't feel right to impose them on it.
> > We've pushed up small fixes/changes etc - but not things
> > that are big intrusive lumps for our use.
>=20
> Maybe they will want these patches then ....  The big question would be
> around security, e.g.  what if you rebase, how do you know they didn't
> introduce what is a security hole for virtiofsd ...  But then, that
> question remains even if you keep a separate tree.

It's active but slow moving; ~10 patches/month - so not too bad to
inspect.

> > > Given that, the main remaining part is libvhost-user,
> > > and it's less work to use than to duplicate that.
> > > That kind of dictates being in qemu.
> > >=20
> > > >  It's C, and we've got ~100 patches - which
> > > > we can split into about 3 chunks.
> > > >=20
> > > > Some suggestions so far:
> > > >   a) In contrib
> > > >      This is my current working assumption; the main objection is i=
t's
> > > >      a bit big and pulls in a chunk of libfuse.
> > > >   b) In a submodule
> > > >=20
> > > >   c) Just separate
> > > >=20
> > > > Your suggestions/ideas please.  My preference is (a).
> > > >=20
> > > > Dave
> > >=20
> > >=20
> > > My preference is close to a, and maybe to avoid confusion we should h=
ave
> > > a new top-level directory for "separate daemons qemu invokes, and nee=
d
> > > to be built together with qemu". libvhost-user would have to move the=
re,
> > > too. "modules"?
> >=20
> > "modules" feels too close to "plugins" to my mind.
> >=20
> > Dave
>=20
> daemons?

I'm OK with that.

Dave

> > >=20
> > > >=20
> > > > --
> > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > >=20
> > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


