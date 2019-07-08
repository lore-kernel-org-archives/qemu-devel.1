Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727B0C606CF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 22:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487E5216FD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 22:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487E5216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkcZ7-0007JN-Ii
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 18:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56358)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hkcWX-0005sV-H6
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 18:54:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hkcWW-0002GW-II
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 18:54:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hkcWV-0002Fb-0K
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 18:54:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0AE068553A
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2019 22:54:12 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F6854647E;
 Mon,  8 Jul 2019 22:54:11 +0000 (UTC)
Date: Mon, 8 Jul 2019 19:54:10 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190708225410.GA5198@habkost.net>
References: <20190619201050.19040-1-armbru@redhat.com>
 <20190619201050.19040-8-armbru@redhat.com>
 <20190620084158.GI25448@redhat.com>
 <87ef3jrzxc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87ef3jrzxc.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 08 Jul 2019 22:54:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 07/17] MAINTAINERS: Merge sections CPU,
 NUMA into Machine core
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
Cc: kwolf@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 24, 2019 at 01:22:07PM +0200, Markus Armbruster wrote:
> Daniel P. Berrang=E9 <berrange@redhat.com> writes:
>=20
> > On Wed, Jun 19, 2019 at 10:10:40PM +0200, Markus Armbruster wrote:
> >> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> >> Cc: Eduardo Habkost <ehabkost@redhat.com>
> >> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>  MAINTAINERS | 16 ++++------------
> >>  1 file changed, 4 insertions(+), 12 deletions(-)
> >
> > Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> >
> >>=20
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 1aef0afaf7..f18fddbbbb 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -1268,8 +1268,12 @@ S: Supported
> >>  F: hw/core/machine.c
> >>  F: hw/core/null-machine.c
> >>  F: hw/cpu/cluster.c
> >> +F: numa.c
> >> +F: qom/cpu.c
> >
> > Not a blocker for this patch, but as a later patch, I'd encourage you=
 to
> > move qom/cpu.c somewhere else. Pretty much anywhere else would be bet=
ter
> > than under qom/ IMHO :-)
>=20
> Eduardo, any ideas?

Sorry for the late reply.  I suggest hw/core/cpu.c.

--=20
Eduardo

