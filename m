Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A623C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 18:02:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D5B2084A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 18:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D5B2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51974 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he1OD-0000Wq-BL
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 14:02:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34839)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1he19b-0007Gv-CO
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 13:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1he0yM-00036c-9i
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 13:35:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51018)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1he0yJ-0002XK-H7
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 13:35:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9F892308FC5F
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 17:35:06 +0000 (UTC)
Received: from work-vm (ovpn-117-203.ams2.redhat.com [10.36.117.203])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F47219C5B;
 Thu, 20 Jun 2019 17:35:01 +0000 (UTC)
Date: Thu, 20 Jun 2019 18:34:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Message-ID: <20190620173458.GN2907@work-vm>
References: <20190613095924.21908-1-dgilbert@redhat.com>
 <7768e0c1-0e85-5cb7-7fe1-e27429762c16@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7768e0c1-0e85-5cb7-7fe1-e27429762c16@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 20 Jun 2019 17:35:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 0/5] network announce;
 interface selection & IDs
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
Cc: qemu-devel@nongnu.org, laine@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jason Wang (jasowang@redhat.com) wrote:
>=20
> On 2019/6/13 =E4=B8=8B=E5=8D=885:59, Dr. David Alan Gilbert (git) wrote=
:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Laine asked for some extra features on the network announce support;
>=20
>=20
> It's better to explain why this feature is needed.

Yes, I'll reword.

> Is this because libvirt
> can change the host network topology on the fly?

It's because something can change the network topology on the fly - not
necessarily just libvirt.  Where as previously we were using the
announce mechanism for mainly migration reasons, now we also want
to use it to announce topology changes; those include potentially things
that libvirt gets told by a higher management layer - such as the
failure or one network path.

Dave

>=20
> Thanks
>=20
>=20
> >=20
> > The first allows the announce timer to announce on a subset of the
> > interfaces.
> >=20
> > The second allows there to be multiple timers, each with their own
> > parameters (including the interface list).
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >=20
> > v4
> >    Minor typo fixes
> >    Expanded the test to check we can stop a running announce
> >=20
> > Dr. David Alan Gilbert (5):
> >    net/announce: Allow optional list of interfaces
> >    net/announce: Add HMP optional interface list
> >    net/announce: Add optional ID
> >    net/announce: Add HMP optional ID
> >    net/announce: Expand test for stopping self announce
> >=20
> >   hmp-commands.hx         |  7 +++-
> >   hmp.c                   | 41 +++++++++++++++++++-
> >   hw/net/virtio-net.c     |  4 +-
> >   include/net/announce.h  |  8 +++-
> >   net/announce.c          | 83 ++++++++++++++++++++++++++++++++++----=
---
> >   net/trace-events        |  3 +-
> >   qapi/net.json           | 16 ++++++--
> >   tests/virtio-net-test.c | 57 ++++++++++++++++++++++++++--
> >   8 files changed, 192 insertions(+), 27 deletions(-)
> >=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

