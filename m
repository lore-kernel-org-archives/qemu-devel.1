Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE83C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7669F20748
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aq8vgwvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7669F20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is49o-0008CY-2y
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 07:21:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1is48H-0006Y9-Ed
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:20:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1is48D-0005N8-FW
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:20:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29630
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1is48D-0005Mm-Bz
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579177212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PjnjFvhGqjbci+MVMojxDXv0dPM36yc5ddKbe0zc6t4=;
 b=Aq8vgwvAfnOd8U4eDb4wpqWyrKE3/iN++KCbSLdKhErL+FKFMy73F97pu8OrXl0KY4yIKN
 8Kl4858oaLIymdIrWUUefhr4VlyHdnSobYlUev5Fv62KwqN6CvS76tdSxdyJEjwEotS0j8
 z5HuAe0KDUiaAl69FqBsaas08znbJCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-5HXJXcGrPumNz8e4fDApGQ-1; Thu, 16 Jan 2020 07:20:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F20C800D4C
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 12:20:10 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4FAB060FC4;
 Thu, 16 Jan 2020 12:20:04 +0000 (UTC)
Date: Thu, 16 Jan 2020 13:20:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 03/86] machine: alias -mem-path and -mem-prealloc
 into memory-foo backend
Message-ID: <20200116132003.79e0184a@redhat.com>
In-Reply-To: <f2e2e568-d114-8b89-9605-020b5f18f597@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-4-git-send-email-imammedo@redhat.com>
 <f2e2e568-d114-8b89-9605-020b5f18f597@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 5HXJXcGrPumNz8e4fDApGQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jan 2020 19:54:18 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 1/15/20 4:06 PM, Igor Mammedov wrote:
> > Allow a machine to opt in for hostmem backend based initial
> > RAM even if user used old -mem-path/prealloc options by providing
> >    MachineClass::default_ram_id
> > Follow up patches will incrementally convert machines to new API,
> > by dropping memory_region_allocate_system_memory() and setting
> > default_ram_id that board used to use before conversion to keep
> > migration stream the same.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > CC: ehabkost@redhat.com
> > CC: pbonzini@redhat.com
> > ---
> >   include/hw/boards.h      |  5 +++++
> >   include/sysemu/hostmem.h | 16 ++++++++++++++++
> >   backends/hostmem-file.c  |  7 -------
> >   backends/hostmem-ram.c   |  2 --
> >   vl.c                     | 25 +++++++++++++++++++++++++
> >   5 files changed, 46 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > index 6aa01b8..e3ea8b0 100644
> > --- a/include/hw/boards.h
> > +++ b/include/hw/boards.h
> > @@ -170,6 +170,10 @@ typedef struct {
> >    *    false is returned, an error must be set to show the reason of
> >    *    the rejection.  If the hook is not provided, all hotplug will b=
e
> >    *    allowed.
> > + * @default_ram_id:
> > + *    Specifies inital RAM MemoryRegion name to be used for default ba=
ckend
> > + *    creation if user explicitly hasn't specified backend with "ram-m=
emdev"
> > + *    property.
> >    */
> >   struct MachineClass {
> >       /*< private >*/
> > @@ -226,6 +230,7 @@ struct MachineClass {
> >       bool nvdimm_supported;
> >       bool numa_mem_supported;
> >       bool auto_enable_numa;
> > +    const char *default_ram_id;
> >  =20
> >       HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
> >                                              DeviceState *dev);
> > diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
> > index 4dbdadd..5db0d66 100644
> > --- a/include/sysemu/hostmem.h
> > +++ b/include/sysemu/hostmem.h
> > @@ -27,6 +27,22 @@
> >   #define MEMORY_BACKEND_CLASS(klass) \
> >       OBJECT_CLASS_CHECK(HostMemoryBackendClass, (klass), TYPE_MEMORY_B=
ACKEND)
> >  =20
> > +/* hostmem-ram.c */
> > +/**
> > + * @TYPE_MEMORY_BACKEND_RAM:
> > + * name of backend that uses mmap on the anonymous RAM
> > + */
> > +
> > +#define TYPE_MEMORY_BACKEND_RAM "memory-backend-ram"
> > +
> > +/* hostmem-file.c */
> > +/**
> > + * @TYPE_MEMORY_BACKEND_FILE:
> > + * name of backend that uses mmap on a file descriptor
> > + */
> > +#define TYPE_MEMORY_BACKEND_FILE "memory-backend-file"
> > +
> > +typedef struct HostMemoryBackend HostMemoryBackend;
> >   typedef struct HostMemoryBackendClass HostMemoryBackendClass;
> >  =20
> >   /**
> > diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> > index be64020..cb319a9 100644
> > --- a/backends/hostmem-file.c
> > +++ b/backends/hostmem-file.c
> > @@ -18,13 +18,6 @@
> >   #include "sysemu/sysemu.h"
> >   #include "qom/object_interfaces.h"
> >  =20
> > -/* hostmem-file.c */
> > -/**
> > - * @TYPE_MEMORY_BACKEND_FILE:
> > - * name of backend that uses mmap on a file descriptor
> > - */
> > -#define TYPE_MEMORY_BACKEND_FILE "memory-backend-file"
> > -
> >   #define MEMORY_BACKEND_FILE(obj) \
> >       OBJECT_CHECK(HostMemoryBackendFile, (obj), TYPE_MEMORY_BACKEND_FI=
LE)
> >  =20
> > diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
> > index 6aab8d3..5cc53e7 100644
> > --- a/backends/hostmem-ram.c
> > +++ b/backends/hostmem-ram.c
> > @@ -16,8 +16,6 @@
> >   #include "qemu/module.h"
> >   #include "qom/object_interfaces.h"
> >  =20
> > -#define TYPE_MEMORY_BACKEND_RAM "memory-backend-ram"
> > -
> >   static void
> >   ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
> >   {
> > diff --git a/vl.c b/vl.c
> > index 7514012..d36a857 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -75,6 +75,7 @@ int main(int argc, char **argv)
> >   #include "ui/input.h"
> >   #include "sysemu/sysemu.h"
> >   #include "sysemu/numa.h"
> > +#include "sysemu/hostmem.h"
> >   #include "exec/gdbstub.h"
> >   #include "qemu/timer.h"
> >   #include "chardev/char.h"
> > @@ -2820,6 +2821,25 @@ static void configure_accelerators(const char *p=
rogname)
> >       }
> >   }
> >  =20
> > +static void create_default_memdev(MachineState *ms, const char *path,
> > +                                  bool prealloc)
> > +{
> > +    Object *obj;
> > +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> > +
> > +    obj =3D object_new(path ? TYPE_MEMORY_BACKEND_FILE : TYPE_MEMORY_B=
ACKEND_RAM);
> > +    if (path) {
> > +        object_property_set_str(obj, path, "mem-path", &error_fatal);
> > +    }
> > +    object_property_set_bool(obj, prealloc, "prealloc", &error_fatal);
> > +    object_property_set_int(obj, ms->ram_size, "size", &error_fatal);
> > +    object_property_add_child(object_get_objects_root(), mc->default_r=
am_id,
> > +                              obj, &error_fatal);
> > +    user_creatable_complete(USER_CREATABLE(obj), &error_fatal);
> > +    object_unref(obj);
> > +    object_property_set_link(OBJECT(ms), obj, "ram-memdev", &error_fat=
al);
> > +}
> > +
> >   int main(int argc, char **argv, char **envp)
> >   {
> >       int i;
> > @@ -4283,6 +4303,11 @@ int main(int argc, char **argv, char **envp)
> >       }
> >       parse_numa_opts(current_machine);
> >  =20
> > +    if (!current_machine->ram_memdev &&
> > +         machine_class->default_ram_size &&
> > +         machine_class->default_ram_id) { =20
>=20
> Do we really need for its presence?
>=20
> Can we instead set it to "ram" if NULL?
it helps with incremental conversion,
once all boards are converted, it's cleaned up (see [76/86]).

>=20
> > +        create_default_memdev(current_machine, mem_path, mem_prealloc)=
;
> > +    }
> >       /* do monitor/qmp handling at preconfig state if requested */
> >       main_loop();
> >  =20
> >  =20
>=20
>=20


