Received: from eggs.gnu.org ([2001:4830:134:3::10]:42884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@intel.com>) id 1fcO1J-0003U3-Lq
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 00:43:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@intel.com>) id 1fcO1G-0002Bq-F2
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 00:43:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:40606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@intel.com>) id 1fcO1G-0002AW-3b
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 00:43:26 -0400
From: "He, Junyan" <junyan.he@intel.com>
Date: Mon, 9 Jul 2018 04:43:08 +0000
Message-ID: <EC8A4E314CF1574AB62C80421BD98339340A8EF5@SHSMSX104.ccr.corp.intel.com>
References: <1529378899-24086-1-git-send-email-junyan.he@gmx.com>
	<20180621152011.5f3778e9@redhat.com>
In-Reply-To: <20180621152011.5f3778e9@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/7 V7 RESEND] hostmem-file: add the 'pmem'
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, "junyan.he@gmx.com" <junyan.he@gmx.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lai, Paul C" <paul.c.lai@intel.com>, "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>, "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>, "mst@redhat.com" <mst@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "Zhang, Yu C" <yu.c.zhang@intel.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>

Hi:

Do I still need to do something before it can be merged?

Thanks
Junyan


-----Original Message-----
From: Igor Mammedov [mailto:imammedo@redhat.com]=20
Sent: Thursday, June 21, 2018 9:20 PM
To: junyan.he@gmx.com
Cc: qemu-devel@nongnu.org; Haozhong Zhang <haozhong.zhang@intel.com>; xiaog=
uangrong.eric@gmail.com; crosthwaite.peter@gmail.com; mst@redhat.com; dgilb=
ert@redhat.com; ehabkost@redhat.com; quintela@redhat.com; He, Junyan <junya=
n.he@intel.com>; stefanha@redhat.com; pbonzini@redhat.com; rth@twiddle.net
Subject: Re: [Qemu-devel] [PATCH 3/7 V7 RESEND] hostmem-file: add the 'pmem=
' option

On Tue, 19 Jun 2018 11:28:19 +0800
junyan.he@gmx.com wrote:

> From: Junyan He <junyan.he@intel.com>
>=20
> When QEMU emulates vNVDIMM labels and migrates vNVDIMM devices, it=20
> needs to know whether the backend storage is a real persistent memory,=20
> in order to decide whether special operations should be performed to=20
> ensure the data persistence.
>=20
> This boolean option 'pmem' allows users to specify whether the backend=20
> storage of memory-backend-file is a real persistent memory. If=20
> 'pmem=3Don', QEMU will set the flag RAM_PMEM in the RAM block of the=20
> corresponding memory region.
>=20
> Signed-off-by: Junyan He <junyan.he@intel.com>
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
a couple suggestion wrt patch submission.

1.
do not sent next version of a patch from series on its own, you should rath=
er send it as reply to the patch it replaces or resend whole series. to sen=
d as reply one can use  git send-email --in-reply-to=3D"Message-Id value we=
 are replying to" ...

2. it would be nice if you add changelog here after signatures like:

---
vX:
  * the thing that changed wrt X-1

> ---
>  backends/hostmem-file.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  docs/nvdimm.txt         | 18 ++++++++++++++++++
>  exec.c                  |  9 +++++++++
>  include/exec/memory.h   |  4 ++++
>  include/exec/ram_addr.h |  3 +++
>  qemu-options.hx         |  7 +++++++
>  6 files changed, 79 insertions(+), 1 deletion(-)
>=20
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c index=20
> 34c68bb..4607651 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -12,6 +12,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
> +#include "qemu/error-report.h"
>  #include "sysemu/hostmem.h"
>  #include "sysemu/sysemu.h"
>  #include "qom/object_interfaces.h"
> @@ -34,6 +35,7 @@ struct HostMemoryBackendFile {
>      bool discard_data;
>      char *mem_path;
>      uint64_t align;
> +    bool is_pmem;
>  };
> =20
>  static void
> @@ -59,7 +61,8 @@ file_backend_memory_alloc(HostMemoryBackend *backend, E=
rror **errp)
>          memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
>                                   path,
>                                   backend->size, fb->align,
> -                                 backend->share ? RAM_SHARED : 0,
> +                                 (backend->share ? RAM_SHARED : 0) |
> +                                 (fb->is_pmem ? RAM_PMEM : 0),
>                                   fb->mem_path, errp);
>          g_free(path);
>      }
> @@ -131,6 +134,37 @@ static void file_memory_backend_set_align(Object *o,=
 Visitor *v,
>      error_propagate(errp, local_err);  }
> =20
> +static bool file_memory_backend_get_pmem(Object *o, Error **errp) {
> +    return MEMORY_BACKEND_FILE(o)->is_pmem; }
> +
> +static void file_memory_backend_set_pmem(Object *o, bool value, Error=20
> +**errp) {
> +    HostMemoryBackend *backend =3D MEMORY_BACKEND(o);
> +    HostMemoryBackendFile *fb =3D MEMORY_BACKEND_FILE(o);
> +
> +    if (host_memory_backend_mr_inited(backend)) {
> +        error_setg(errp, "cannot change property 'pmem' of %s '%s'",
> +                   object_get_typename(o),
> +                   object_get_canonical_path_component(o));
> +        return;
> +    }
> +
> +#ifndef CONFIG_LIBPMEM
> +    if (value) {
> +        error_report("Lack of libpmem support while setting the 'pmem=3D=
on'"
> +                     " of %s '%s'. We can not ensure the persistence of =
it"
> +                     " without libpmem support, this may cause serious"
> +                     " problems." , object_get_typename(o),
> +                     object_get_canonical_path_component(o));
> +        exit(1);
> +    }
> +#endif
> +
> +    fb->is_pmem =3D value;
> +}
> +
>  static void file_backend_unparent(Object *obj)  {
>      HostMemoryBackend *backend =3D MEMORY_BACKEND(obj); @@ -162,6=20
> +196,9 @@ file_backend_class_init(ObjectClass *oc, void *data)
>          file_memory_backend_get_align,
>          file_memory_backend_set_align,
>          NULL, NULL, &error_abort);
> +    object_class_property_add_bool(oc, "pmem",
> +        file_memory_backend_get_pmem, file_memory_backend_set_pmem,
> +        &error_abort);
>  }
> =20
>  static void file_backend_instance_finalize(Object *o) diff --git=20
> a/docs/nvdimm.txt b/docs/nvdimm.txt index 8b48fb4..2f7d348 100644
> --- a/docs/nvdimm.txt
> +++ b/docs/nvdimm.txt
> @@ -180,3 +180,21 @@ supports CPU Cache Flush and Memory Controller Flush=
 on Power Loss, etc.
> =20
>  For a complete list of the flags available and for more detailed=20
> descriptions,  please consult the ACPI spec.
> +
> +guest software that this vNVDIMM device contains a region that cannot=20
> +accept persistent writes. In result, for example, the guest Linux=20
> +NVDIMM driver, marks such vNVDIMM device as read-only.
> +
> +If the vNVDIMM backend is on the host persistent memory that can be=20
> +accessed in SNIA NVM Programming Model [1] (e.g., Intel NVDIMM), it's=20
> +suggested to set the 'pmem' option of memory-backend-file to 'on'.=20
> +When 'pmem=3Don' and QEMU is built with libpmem [2] support (configured=
=20
> +with --enable-libpmem), QEMU will take necessary operations to=20
> +guarantee the persistence of its own writes to the vNVDIMM backend=20
> +(e.g., in vNVDIMM label emulation and live migration).
will libpmem guarantee data persistence even if backend's file is not on pe=
rsistent memory?


> +
> +References
> +----------
> +
> +[1] SNIA NVM Programming Model:=20
> +https://www.snia.org/sites/default/files/technical_work/final/NVMProg
> +rammingModel_v1.2.pdf
> +[2] PMDK: http://pmem.io/pmdk/
> diff --git a/exec.c b/exec.c
> index 8e079df..c42483e 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2077,6 +2077,9 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, M=
emoryRegion *mr,
>      Error *local_err =3D NULL;
>      int64_t file_size;
> =20
> +    /* Just support these ram flags by now. */
> +    assert(ram_flags =3D=3D 0 || (ram_flags & (RAM_SHARED | RAM_PMEM)));
> +
>      if (xen_enabled()) {
>          error_setg(errp, "-mem-path not supported with Xen");
>          return NULL;
> @@ -4007,6 +4010,11 @@ err:
>      return ret;
>  }
> =20
> +bool ramblock_is_pmem(RAMBlock *rb)
> +{
> +    return rb->flags & RAM_PMEM;
> +}
> +
>  #endif
> =20
>  void page_size_init(void)
> @@ -4105,3 +4113,4 @@ void mtree_print_dispatch(fprintf_function mon,=20
> void *f,  }
> =20
>  #endif
> +
> diff --git a/include/exec/memory.h b/include/exec/memory.h index=20
> 3769c06..7dd43b0 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -122,6 +122,9 @@ typedef struct IOMMUNotifier IOMMUNotifier;
>  /* RAM can be migrated */
>  #define RAM_MIGRATABLE (1 << 4)
> =20
> +/* RAM is a persistent kind memory */ #define RAM_PMEM (1 << 5)
> +
>  static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
>                                         IOMMUNotifierFlag flags,
>                                         hwaddr start, hwaddr end) @@=20
> -613,6 +616,7 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
>   *         (getpagesize()) will be used.
>   * @ram_flags: Memory region features:
>   *             - RAM_SHARED: memory must be mmaped with the MAP_SHARED f=
lag
> + *             - RAM_PMEM: the memory is persistent memory
>   *             Other bits are ignored now.
>   * @path: the path in which to allocate the RAM.
>   * @errp: pointer to Error*, to store an error if it happens.
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h index=20
> 5545cf3..3c65643 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -70,6 +70,8 @@ static inline unsigned long int ramblock_recv_bitmap_of=
fset(void *host_addr,
>      return host_addr_offset >> TARGET_PAGE_BITS;  }
> =20
> +bool ramblock_is_pmem(RAMBlock *rb);
> +
>  long qemu_getrampagesize(void);
>  unsigned long last_ram_page(void);
> =20
> @@ -84,6 +86,7 @@ unsigned long last_ram_page(void);
>   *  @ram_flags: specify the properties of the ram block, which can be on=
e
>   *              or bit-or of following values
>   *              - RAM_SHARED: mmap the backing file or device with MAP_S=
HARED
> + *              - RAM_PMEM: the backend @mem_path or @fd is persistent m=
emory
>   *              Other bits are ignored.
>   *  @mem_path or @fd: specify the backing file or device
>   *  @errp: pointer to Error*, to store an error if it happens diff=20
> --git a/qemu-options.hx b/qemu-options.hx index c0d3951..006ca44=20
> 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4045,6 +4045,13 @@ requires an alignment different than the=20
> default one used by QEMU, eg  the device DAX /dev/dax0.0 requires 2M=20
> alignment rather than 4K. In  such cases, users can specify the required =
alignment via this option.
> =20
> +The @option{pmem} option specifies whether the backing file specified=20
> +by @option{mem-path} is on the persistent memory that can be accessed=20
> +using the SNIA NVM programming model (e.g. Intel NVDIMM).
> +If @option{pmem}, QEMU will take necessary operations to guarantee=20
> +the persistence of its own writes to @option{mem-path} (e.g. in=20
> +vNVDIMM label emulation and live migration).
> +
>  @item -object=20
> memory-backend-ram,id=3D@var{id},merge=3D@var{on|off},dump=3D@var{on|off}=
,sh
> are=3D@var{on|off},prealloc=3D@var{on|off},size=3D@var{size},host-nodes=
=3D@var
> {host-nodes},policy=3D@var{default|preferred|bind|interleave}
> =20
>  Creates a memory backend object, which can be used to back the guest RAM=
.
