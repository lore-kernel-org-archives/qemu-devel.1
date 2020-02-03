Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E5CC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F8DF20658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrXgjWqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8DF20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyY1b-0005P2-CN
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:28:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iyY10-0004wI-Tf
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iyY0y-0004f4-4t
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:27:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44002
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iyY0x-0004eD-Rs
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580722051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sk8SOhbhhvaIkONZar9WfUifzwk1I4cbsoXHpjVaenE=;
 b=OrXgjWqswu7ExJ3vCe+Q0MggFGNzejEUFgaZY+pxbDTNQF8XjLmCn5+99CN9Cgzgr7pU5K
 16q5G7rP6pYAeV+iR2eOUGHYaJBiJP8QUaX8LxLYvFcNbCE7o8uJ0wto6C89Q1OkWh2wbd
 PLkSzOltyt3Y4a1kLQrOe62Z5p7tTb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-_Uym_YC7OVSVWpHRLcZUrg-1; Mon, 03 Feb 2020 04:27:29 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6247DDBBB;
 Mon,  3 Feb 2020 09:27:28 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7521019E9C;
 Mon,  3 Feb 2020 09:27:21 +0000 (UTC)
Date: Mon, 3 Feb 2020 10:27:20 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 03/80] machine: alias -mem-path and -mem-prealloc
 into memory-foo backend
Message-ID: <20200203102720.6de2374e@redhat.com>
In-Reply-To: <20200203040204-mutt-send-email-mst@kernel.org>
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
 <1580483390-131164-4-git-send-email-imammedo@redhat.com>
 <20200203040204-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: _Uym_YC7OVSVWpHRLcZUrg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: pasic@linux.ibm.com, pbonzini@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 04:04:15 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Jan 31, 2020 at 04:08:33PM +0100, Igor Mammedov wrote:
> > Allow machine to opt in for hostmem backend based initial RAM
> > even if user uses old -mem-path/prealloc options by providing
> >   MachineClass::default_ram_id
> > Follow up patches will incrementally convert machines to new API,
> > by dropping memory_region_allocate_system_memory() and setting
> > default_ram_id that board used to use before conversion to keep
> > migration stream the same.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> What about non-versioned machines though?
> Why do these need to set default_ram_id?
> Seems redundant as they don't need to support cross-version
> migration ...

They need at least some id for migration to work,
so this series reuses id that they are using today.

Basically default_ram_id is a means to optin into hostmem
based allocation with (-m).

> 
> > ---
> > v3:
> >    * rename "ram-memdev" property to "memory-backend"
> >      (Paolo Bonzini <pbonzini@redhat.com>)
> > v4:
> >    * previous patch changed memory-backend property from link
> >      to string to allow for delayed backend creation, when
> >      backend comes explicitly from CLI.
> >      So s/object_property_set_link()/object_property_set_str()/
> >      to account for that.
> > 
> > CC: ehabkost@redhat.com
> > CC: pbonzini@redhat.com
> > CC: philmd@redhat.com
> > CC: pasic@linux.ibm.com
> > ---
> >  include/hw/boards.h      |  5 +++++
> >  include/sysemu/hostmem.h | 16 ++++++++++++++++
> >  backends/hostmem-file.c  |  7 -------
> >  backends/hostmem-ram.c   |  2 --
> >  vl.c                     | 25 +++++++++++++++++++++++++
> >  5 files changed, 46 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > index 7b4b6b7..106de87 100644
> > --- a/include/hw/boards.h
> > +++ b/include/hw/boards.h
> > @@ -170,6 +170,10 @@ typedef struct {
> >   *    false is returned, an error must be set to show the reason of
> >   *    the rejection.  If the hook is not provided, all hotplug will be
> >   *    allowed.
> > + * @default_ram_id:
> > + *    Specifies inital RAM MemoryRegion name to be used for default backend
> > + *    creation if user explicitly hasn't specified backend with "memory-backend"
> > + *    property.
> >   */
> >  struct MachineClass {
> >      /*< private >*/
> > @@ -226,6 +230,7 @@ struct MachineClass {
> >      bool nvdimm_supported;
> >      bool numa_mem_supported;
> >      bool auto_enable_numa;
> > +    const char *default_ram_id;
> >  
> >      HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
> >                                             DeviceState *dev);
> > diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
> > index 4dbdadd..5db0d66 100644
> > --- a/include/sysemu/hostmem.h
> > +++ b/include/sysemu/hostmem.h
> > @@ -27,6 +27,22 @@
> >  #define MEMORY_BACKEND_CLASS(klass) \
> >      OBJECT_CLASS_CHECK(HostMemoryBackendClass, (klass), TYPE_MEMORY_BACKEND)
> >  
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
> >  typedef struct HostMemoryBackendClass HostMemoryBackendClass;
> >  
> >  /**
> > diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> > index be64020..cb319a9 100644
> > --- a/backends/hostmem-file.c
> > +++ b/backends/hostmem-file.c
> > @@ -18,13 +18,6 @@
> >  #include "sysemu/sysemu.h"
> >  #include "qom/object_interfaces.h"
> >  
> > -/* hostmem-file.c */
> > -/**
> > - * @TYPE_MEMORY_BACKEND_FILE:
> > - * name of backend that uses mmap on a file descriptor
> > - */
> > -#define TYPE_MEMORY_BACKEND_FILE "memory-backend-file"
> > -
> >  #define MEMORY_BACKEND_FILE(obj) \
> >      OBJECT_CHECK(HostMemoryBackendFile, (obj), TYPE_MEMORY_BACKEND_FILE)
> >  
> > diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
> > index 6aab8d3..5cc53e7 100644
> > --- a/backends/hostmem-ram.c
> > +++ b/backends/hostmem-ram.c
> > @@ -16,8 +16,6 @@
> >  #include "qemu/module.h"
> >  #include "qom/object_interfaces.h"
> >  
> > -#define TYPE_MEMORY_BACKEND_RAM "memory-backend-ram"
> > -
> >  static void
> >  ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
> >  {
> > diff --git a/vl.c b/vl.c
> > index 24951b5..2367cb6 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -75,6 +75,7 @@ int main(int argc, char **argv)
> >  #include "ui/input.h"
> >  #include "sysemu/sysemu.h"
> >  #include "sysemu/numa.h"
> > +#include "sysemu/hostmem.h"
> >  #include "exec/gdbstub.h"
> >  #include "qemu/timer.h"
> >  #include "chardev/char.h"
> > @@ -2839,6 +2840,26 @@ static void configure_accelerators(const char *progname)
> >      }
> >  }
> >  
> > +static void create_default_memdev(MachineState *ms, const char *path,
> > +                                  bool prealloc)
> > +{
> > +    Object *obj;
> > +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> > +
> > +    obj = object_new(path ? TYPE_MEMORY_BACKEND_FILE : TYPE_MEMORY_BACKEND_RAM);
> > +    if (path) {
> > +        object_property_set_str(obj, path, "mem-path", &error_fatal);
> > +    }
> > +    object_property_set_bool(obj, prealloc, "prealloc", &error_fatal);
> > +    object_property_set_int(obj, ms->ram_size, "size", &error_fatal);
> > +    object_property_add_child(object_get_objects_root(), mc->default_ram_id,
> > +                              obj, &error_fatal);
> > +    user_creatable_complete(USER_CREATABLE(obj), &error_fatal);
> > +    object_unref(obj);
> > +    object_property_set_str(OBJECT(ms), mc->default_ram_id, "memory-backend",
> > +                            &error_fatal);
> > +}
> > +
> >  int main(int argc, char **argv, char **envp)
> >  {
> >      int i;
> > @@ -4302,6 +4323,10 @@ int main(int argc, char **argv, char **envp)
> >      }
> >      parse_numa_opts(current_machine);
> >  
> > +    if (machine_class->default_ram_id && current_machine->ram_size &&
> > +        !current_machine->ram_memdev_id) {
> > +        create_default_memdev(current_machine, mem_path, mem_prealloc);
> > +    }
> >      /* do monitor/qmp handling at preconfig state if requested */
> >      main_loop();  
> 
> So this check for default_ram_id will become redundant after the
> patchset is fully applied, this is just for bisect to work well, right?
> I couldn't find patches that drop this check though.

there was a patch to that effect in earlier versions,
but I dropped it for following reasons (from cover letter):

"
v3:
[...]
  - drop "[PATCH v2 76/86] post conversion default_ram_id cleanup"
    so that default memory-backedend won't be created for boards that do not care
    about -m. Which makes -m optin feature. We should decide  what do in  case
    board doesn't use -m (but that's out of scope of this series)
[...]
"

> 
> > -- 
> > 2.7.4
> > 
> >   
> 


