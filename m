Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2657C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993BB21E70
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993BB21E70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvQXK-0005i9-Tv
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 14:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36651)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hvQWq-0005I7-0c
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:19:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hvQWo-0008Uy-Tz
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:19:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54978)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hvQWo-0008Sp-Om
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:19:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1A61452149
 for <qemu-devel@nongnu.org>; Wed,  7 Aug 2019 18:19:14 +0000 (UTC)
Received: from localhost (ovpn-121-66.rdu2.redhat.com [10.10.121.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99E665C557;
 Wed,  7 Aug 2019 18:19:11 +0000 (UTC)
Date: Wed, 7 Aug 2019 15:19:09 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190807181909.GH4669@habkost.net>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-23-armbru@redhat.com>
 <de7f547d-1c97-135f-654f-3856fa2eec2f@redhat.com>
 <20190807175708.GE4669@habkost.net>
 <647e2542-2042-26de-d768-cdf13afa0ec4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <647e2542-2042-26de-d768-cdf13afa0ec4@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 07 Aug 2019 18:19:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 22/29] Include hw/boards.h a bit less
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 07, 2019 at 08:05:50PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 8/7/19 7:57 PM, Eduardo Habkost wrote:
> > On Wed, Aug 07, 2019 at 07:26:56PM +0200, Philippe Mathieu-Daud=E9 wr=
ote:
> >> On 8/6/19 5:14 PM, Markus Armbruster wrote:
> >>> hw/boards.h pulls in almost 60 headers.  The less we include it int=
o
> >>> headers, the better.  As a first step, drop superfluous inclusions,
> >>> and downgrade some more to what's actually needed.  Gets rid of jus=
t
> >>> one inclusion into a header.
> >>>
> >>> Cc: Eduardo Habkost <ehabkost@redhat.com>
> >>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> >>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >>> ---
> > [...]
> >>> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> >>> index bcacdd1d8f..34a9f6f7a9 100644
> >>> --- a/target/i386/hax-all.c
> >>> +++ b/target/i386/hax-all.c
> >>> @@ -33,7 +33,6 @@
> >>>  #include "sysemu/reset.h"
> >>>  #include "sysemu/sysemu.h"
> >>>  #include "qemu/main-loop.h"
> >>> -#include "hw/boards.h"
> >>> =20
> >>>  #define DEBUG_HAX 0
> >>
> >> include/sysemu/hax.h misses to include "hw/boards.h":
> >=20
> > I don't understand.  I don't see any reason for the sysemu/hax.h
> > header to include hw/boards.h.
>=20
> Ah, you are right, the AccelClass is defined in include/sysemu/accel.h:
>=20
> typedef struct AccelClass {
>     /*< private >*/
>     ObjectClass parent_class;
>     /*< public >*/
>=20
>     const char *name;
>     int (*init_machine)(MachineState *ms);
>     ...
>=20
> So this is where "hw/boards.h" has to be included (it is where
> MachineState is defined).

As far as I can see, accel.h doesn't need the full MachineState
struct definition and doesn't need boards.h.  It just needs the
MachineState typedef, which is defined at typedefs.h.

hax-all.c, on the other hand, needs the full MachineState struct
definition and is expected to include hw/boards.h.

>=20
> >>
> >> target/i386/hax-all.c: In function 'hax_accel_init':
> >> target/i386/hax-all.c:354:26: error: dereferencing pointer to incomp=
lete
> >> type 'MachineState {aka struct MachineState}'
> >>      int ret =3D hax_init(ms->ram_size);
> >>                           ^
> >=20

--=20
Eduardo

