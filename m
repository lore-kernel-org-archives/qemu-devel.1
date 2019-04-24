Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9AFC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 18:32:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 859D221773
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 18:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859D221773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45522 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJMgw-0004Fv-Jy
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 14:32:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJMfY-0003OP-IL
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJMe8-0006QC-UK
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:29:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48313)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>)
	id 1hJMe8-0006P0-Ky; Wed, 24 Apr 2019 14:29:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B37B5308B44C;
	Wed, 24 Apr 2019 18:29:27 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E8C3D5DC1B;
	Wed, 24 Apr 2019 18:29:23 +0000 (UTC)
Date: Wed, 24 Apr 2019 15:29:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190424182922.GJ18406@habkost.net>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<20190423212246.3542-3-ehabkost@redhat.com>
	<20190424082309.GB28615@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190424082309.GB28615@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 24 Apr 2019 18:29:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] machine: Use SupportStatusInfo for
 deprecation info
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, mprivozn@redhat.com,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	qemu-ppc@nongnu.org,
	=?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424182922.yrd8QDv6yjjbdsLYsaybgOrtDcGkpz7giJHYjEn8pkE@z>

On Wed, Apr 24, 2019 at 09:23:09AM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Apr 23, 2019 at 06:22:45PM -0300, Eduardo Habkost wrote:
> > Use SupportStatusInfo to represent deprecation information of
> > machine types.
> >=20
> > Instead of using a generic "use XXX instead" message for humans,
> > encode the suggested alternative in a machine-friendly way at the
> > 'suggested_alternatives' field.
> >=20
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  include/hw/boards.h |  7 ++++---
> >  hw/i386/pc_piix.c   |  4 +++-
> >  hw/ppc/prep.c       |  4 +++-
> >  vl.c                | 13 +++++++++----
> >  4 files changed, 19 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > index e231860666..243bf3c7ce 100644
> > --- a/include/hw/boards.h
> > +++ b/include/hw/boards.h
> > @@ -8,6 +8,8 @@
> >  #include "hw/qdev.h"
> >  #include "qom/object.h"
> >  #include "qom/cpu.h"
> > +#include "qapi/qapi-types-common.h"
> > +
> > =20
> >  /**
> >   * memory_region_allocate_system_memory - Allocate a board's main me=
mory
> > @@ -105,8 +107,7 @@ typedef struct {
> > =20
> >  /**
> >   * MachineClass:
> > - * @deprecation_reason: If set, the machine is marked as deprecated.=
 The
> > - *    string should provide some clear information about what to use=
 instead.
> > + * @support_status: Support and deprecation status of machine type.
> >   * @max_cpus: maximum number of CPUs supported. Default: 1
> >   * @min_cpus: minimum number of CPUs supported. Default: 1
> >   * @default_cpus: number of CPUs instantiated if none are specified.=
 Default: 1
> > @@ -169,7 +170,7 @@ struct MachineClass {
> >      char *name;
> >      const char *alias;
> >      const char *desc;
> > -    const char *deprecation_reason;
> > +    SupportStatusInfo support_status;
> > =20
> >      void (*init)(MachineState *state);
> >      void (*reset)(void);
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index 8ad8e885c6..97bd401618 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -781,7 +781,9 @@ static void pc_i440fx_0_15_machine_options(Machin=
eClass *m)
> > =20
> >      pc_i440fx_1_0_machine_options(m);
> >      m->hw_version =3D "0.15";
> > -    m->deprecation_reason =3D "use a newer machine type instead";
> > +    m->support_status.deprecated =3D true;
> > +    m->support_status.has_suggested_alternative =3D true;
> > +    m->support_status.suggested_alternative =3D g_strdup("pc");
> >      compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
> >  }
> > =20
> > diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> > index 847d320465..9a02b0eec4 100644
> > --- a/hw/ppc/prep.c
> > +++ b/hw/ppc/prep.c
> > @@ -587,7 +587,9 @@ static void ppc_prep_init(MachineState *machine)
> > =20
> >  static void prep_machine_init(MachineClass *mc)
> >  {
> > -    mc->deprecation_reason =3D "use 40p machine type instead";
> > +    mc->support_status.deprecated =3D true;
> > +    mc->support_status.has_suggested_alternative =3D true;
> > +    mc->support_status.suggested_alternative =3D g_strdup("40p");
> >      mc->desc =3D "PowerPC PREP platform";
> >      mc->init =3D ppc_prep_init;
> >      mc->block_default_type =3D IF_IDE;
> > diff --git a/vl.c b/vl.c
> > index c696ad2a13..99b857ed2a 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -2610,7 +2610,7 @@ static gint machine_class_cmp(gconstpointer a, =
gconstpointer b)
> >              }
> >              printf("%-20s %s%s%s\n", mc->name, mc->desc,
> >                     mc->is_default ? " (default)" : "",
> > -                   mc->deprecation_reason ? " (deprecated)" : "");
> > +                   mc->support_status.deprecated ? " (deprecated)" :=
 "");
> >          }
> >      }
> > =20
> > @@ -4308,9 +4308,14 @@ int main(int argc, char **argv, char **envp)
> >       * called from configure_accelerator().
> >       */
> > =20
> > -    if (!qtest_enabled() && machine_class->deprecation_reason) {
> > -        error_report("Machine type '%s' is deprecated: %s",
> > -                     machine_class->name, machine_class->deprecation=
_reason);
> > +    if (!qtest_enabled() && machine_class->support_status.deprecated=
) {
> > +        error_report("Machine type '%s' is deprecated%s%s", machine_=
class->name,
> > +                     machine_class->support_status.status_message ? =
": " : "",
> > +                     machine_class->support_status.status_message ?:=
 "");
> > +        if (machine_class->support_status.suggested_alternative) {
> > +            error_report("Suggested solution: use '%s' machine type =
instead",
> > +                         machine_class->support_status.suggested_alt=
ernative);
>=20
> I'd just drop the word "Suggested solution: " as I think it is fine to =
just
> say "Use foobar machine type instead".

I'm not sure.  Can we reword this, but in a way that it still
sounds like a suggestion, not as a definitive solution?

Sometimes the provided alternative won't work for everybody.
e.g. if one day we deprecate pc-i440fx, we can't be sure that
everybody will be able to use q35 instead.

--=20
Eduardo

