Received: from eggs.gnu.org ([2001:4830:134:3::10]:38386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f6KwO-0006S5-Rn
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 14:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f6KwL-00086O-FL
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 14:57:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40000 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f6KwL-00086E-4S
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 14:57:53 -0400
Date: Wed, 11 Apr 2018 19:57:42 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180411185741.GK2667@work-vm>
References: <20180329032149.44685-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180329032149.44685-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] RFC: memory/hmp: Print owners/parents
 in "info mtree"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

* Alexey Kardashevskiy (aik@ozlabs.ru) wrote:
> This adds owners/parents (which are the same, just occasionally
> owner=3D=3DNULL) printing for memory regions; a new '-o' flag
> enabled new output.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

=46rom the HMP side this looks fine to me, and if it's making it clearer
where mappings are coming from that's good.
(It's a bit long/wordy, but that's the nature of the information).



Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>=20
> Does this look anything useful?
>=20
> There are cases ("msi", "msix-table", "msix-pba" and probably more) when
> it is not clear what owns an MR while they all have an owner (always? mos=
tly?).
>=20
>=20
> "info mtree" example:
>=20
> address-space: memory
>   0000000000000000-ffffffffffffffff (prio 0, i/o): system parent:{obj}
>     0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram parent=
:{obj}
>     0000200000000000-000020000000ffff (prio 0, i/o): alias pci@8000000200=
00000.io-alias @pci@800000020000000.io 0000000000000000-000000000000ffff ow=
ner:{dev path=3D/machine/unattached/device[3]}
>     0000200080000000-00002000ffffffff (prio 0, i/o): alias pci@8000000200=
00000.mmio32-alias @pci@800000020000000.mmio 0000000080000000-00000000fffff=
fff owner:{dev path=3D/machine/unattached/device[3]}
>     0000210000000000-000021ffffffffff (prio 0, i/o): alias pci@8000000200=
00000.mmio64-alias @pci@800000020000000.mmio 0000210000000000-000021fffffff=
fff owner:{dev path=3D/machine/unattached/device[3]}
>=20
> address-space: I/O
>   0000000000000000-000000000000ffff (prio 0, i/o): io parent:{obj}
>=20
> address-space: cpu-memory-0
>   0000000000000000-ffffffffffffffff (prio 0, i/o): system parent:{obj}
>     0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram parent=
:{obj}
>     0000200000000000-000020000000ffff (prio 0, i/o): alias pci@8000000200=
00000.io-alias @pci@800000020000000.io 0000000000000000-000000000000ffff ow=
ner:{dev path=3D/machine/unattached/device[3]}
>     0000200080000000-00002000ffffffff (prio 0, i/o): alias pci@8000000200=
00000.mmio32-alias @pci@800000020000000.mmio 0000000080000000-00000000fffff=
fff owner:{dev path=3D/machine/unattached/device[3]}
>     0000210000000000-000021ffffffffff (prio 0, i/o): alias pci@8000000200=
00000.mmio64-alias @pci@800000020000000.mmio 0000210000000000-000021fffffff=
fff owner:{dev path=3D/machine/unattached/device[3]}
>=20
> address-space: pci@800000020000000
>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci@800000020000000.io=
mmu-root owner:{dev path=3D/machine/unattached/device[3]}
>     0000000000000000-ffffffffffffffff (prio 0, i/o): tce-root-80000001 ow=
ner:{dev path=3D/machine/unattached/device[3]/tce-table-80000001}
>       0800000000000000-080000007fffffff (prio 0, i/o): tce-iommu-80000001=
 owner:{dev path=3D/machine/unattached/device[3]/tce-table-80000001}
>     0000000000000000-ffffffffffffffff (prio 0, i/o): tce-root-80000000 ow=
ner:{dev path=3D/machine/unattached/device[3]/tce-table-80000000}
>       0000000000000000-000000003fffffff (prio 0, i/o): tce-iommu-80000000=
 owner:{dev path=3D/machine/unattached/device[3]/tce-table-80000000}
>     0000040000000000-000004000000ffff (prio 0, i/o): msi owner:{dev path=
=3D/machine/unattached/device[3]}
>=20
> address-space: vfio-pci
>   0000000000000000-ffffffffffffffff (prio 0, i/o): bus master container o=
wner:{dev id=3Dvfio0001_03_00_0}
>     0000000000000000-ffffffffffffffff (prio 0, i/o): alias bus master @pc=
i@800000020000000.iommu-root 0000000000000000-ffffffffffffffff owner:{dev i=
d=3Dvfio0001_03_00_0}
>=20
> memory-region: pci@800000020000000.io
>   0000000000000000-000000000000ffff (prio 0, i/o): pci@800000020000000.io=
 owner:{dev path=3D/machine/unattached/device[3]}
>=20
> memory-region: pci@800000020000000.mmio
>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci@800000020000000.mm=
io owner:{dev path=3D/machine/unattached/device[3]}
>     0000210000000000-000021000000ffff (prio 1, i/o): 0001:03:00.0 base BA=
R 1 owner:{dev id=3Dvfio0001_03_00_0}
>       0000210000000000-000021000000ffff (prio 0, i/o): 0001:03:00.0 BAR 1=
 owner:{dev id=3Dvfio0001_03_00_0}
>       000021000000e000-000021000000e5ff (prio 0, i/o): msix-table owner:{=
dev id=3Dvfio0001_03_00_0}
>       000021000000f000-000021000000f00f (prio 0, i/o): msix-pba [disabled=
] owner:{dev id=3Dvfio0001_03_00_0}
>     0000210000040000-000021000007ffff (prio 1, i/o): 0001:03:00.0 base BA=
R 3 owner:{dev id=3Dvfio0001_03_00_0}
>       0000210000040000-000021000007ffff (prio 0, i/o): 0001:03:00.0 BAR 3=
 owner:{dev id=3Dvfio0001_03_00_0}
>         0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BA=
R 3 mmaps[0] owner:{dev id=3Dvfio0001_03_00_0}
>=20
> memory-region: pci@800000020000000.iommu-root
>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci@800000020000000.io=
mmu-root owner:{dev path=3D/machine/unattached/device[3]}
>     0000000000000000-ffffffffffffffff (prio 0, i/o): tce-root-80000001 ow=
ner:{dev path=3D/machine/unattached/device[3]/tce-table-80000001}
>       0800000000000000-080000007fffffff (prio 0, i/o): tce-iommu-80000001=
 owner:{dev path=3D/machine/unattached/device[3]/tce-table-80000001}
>     0000000000000000-ffffffffffffffff (prio 0, i/o): tce-root-80000000 ow=
ner:{dev path=3D/machine/unattached/device[3]/tce-table-80000000}
>       0000000000000000-000000003fffffff (prio 0, i/o): tce-iommu-80000000=
 owner:{dev path=3D/machine/unattached/device[3]/tce-table-80000000}
>     0000040000000000-000004000000ffff (prio 0, i/o): msi owner:{dev path=
=3D/machine/unattached/device[3]}
>=20
>=20
>=20
> Flatviews:
>=20
>=20
> FlatView #0
>  AS "pci@800000020000000", root: pci@800000020000000.iommu-root
>  AS "vfio-pci", root: bus master container
>  Root memory region: pci@800000020000000.iommu-root
>   0000000000000000-000000003fffffff (prio 0, i/o): tce-iommu-80000000 own=
er:{dev path=3D/machine/unattached/device[3]/tce-table-80000000}
>   0000040000000000-000004000000ffff (prio 0, i/o): msi owner:{dev path=3D=
/machine/unattached/device[3]}
>   0800000000000000-080000007fffffff (prio 0, i/o): tce-iommu-80000001 own=
er:{dev path=3D/machine/unattached/device[3]/tce-table-80000001}
>=20
> FlatView #1
>  AS "memory", root: system
>  AS "cpu-memory-0", root: system
>  Root memory region: system
>   0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram parent:{=
obj}
>   0000210000000000-000021000000dfff (prio 0, i/o): 0001:03:00.0 BAR 1 own=
er:{dev id=3Dvfio0001_03_00_0}
>   000021000000e000-000021000000e5ff (prio 0, i/o): msix-table owner:{dev =
id=3Dvfio0001_03_00_0}
>   000021000000e600-000021000000ffff (prio 0, i/o): 0001:03:00.0 BAR 1 @00=
0000000000e600 owner:{dev id=3Dvfio0001_03_00_0}
>   0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mm=
aps[0] owner:{dev id=3Dvfio0001_03_00_0}
>=20
> FlatView #2
>  AS "I/O", root: io
>  Root memory region: io
>   0000000000000000-000000000000ffff (prio 0, i/o): io parent:{obj}
> ---
>  include/exec/memory.h |  2 +-
>  memory.c              | 80 ++++++++++++++++++++++++++++++++++++++++++++-=
------
>  monitor.c             |  4 ++-
>  hmp-commands-info.hx  |  7 +++--
>  4 files changed, 78 insertions(+), 15 deletions(-)
>=20
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 31eae0a..3e9d67c 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1541,7 +1541,7 @@ void memory_global_dirty_log_start(void);
>  void memory_global_dirty_log_stop(void);
> =20
>  void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
> -                bool dispatch_tree);
> +                bool dispatch_tree, bool owner);
> =20
>  /**
>   * memory_region_request_mmio_ptr: request a pointer to an mmio
> diff --git a/memory.c b/memory.c
> index e70b64b..538a57c 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2830,10 +2830,57 @@ typedef QTAILQ_HEAD(mrqueue, MemoryRegionList) Me=
moryRegionListHead;
>                             int128_sub((size), int128_one())) : 0)
>  #define MTREE_INDENT "  "
> =20
> +static void mtree_expand_owner(fprintf_function mon_printf, void *f,
> +                               const char *label, Object *obj)
> +{
> +    DeviceState *dev =3D (DeviceState *) object_dynamic_cast(obj, TYPE_D=
EVICE);
> +    const char *id =3D object_property_print(obj, "id", true, NULL);
> +    const char *name =3D object_property_print(obj, "name", true, NULL);
> +
> +    mon_printf(f, " %s:{", label);
> +    if (dev) {
> +        mon_printf(f, "dev");
> +        if (dev->id) {
> +            mon_printf(f, " id=3D%s", dev->id);
> +        }
> +    } else {
> +        mon_printf(f, "obj");
> +    }
> +    if (name) {
> +        mon_printf(f, " name=3D%s ", name);
> +    }
> +    if (id) {
> +        mon_printf(f, " id=3D%s ", id);
> +    }
> +    if (dev && (!name && !id && !dev->id)) {
> +        mon_printf(f, " path=3D%s", dev->canonical_path);
> +    }
> +    mon_printf(f, "}");
> +}
> +
> +static void mtree_print_mr_owner(fprintf_function mon_printf, void *f,
> +                                 const MemoryRegion *mr)
> +{
> +    Object *owner =3D mr->owner;
> +    Object *parent =3D memory_region_owner((MemoryRegion *)mr);
> +
> +    if (!owner && !parent) {
> +        mon_printf(f, " orphan");
> +        return;
> +    }
> +    if (owner) {
> +        mtree_expand_owner(mon_printf, f, "owner", owner);
> +    }
> +    if (parent && parent !=3D owner) {
> +        mtree_expand_owner(mon_printf, f, "parent", parent);
> +    }
> +}
> +
>  static void mtree_print_mr(fprintf_function mon_printf, void *f,
>                             const MemoryRegion *mr, unsigned int level,
>                             hwaddr base,
> -                           MemoryRegionListHead *alias_print_queue)
> +                           MemoryRegionListHead *alias_print_queue,
> +                           bool owner)
>  {
>      MemoryRegionList *new_ml, *ml, *next_ml;
>      MemoryRegionListHead submr_print_queue;
> @@ -2879,7 +2926,7 @@ static void mtree_print_mr(fprintf_function mon_pri=
ntf, void *f,
>          }
>          mon_printf(f, TARGET_FMT_plx "-" TARGET_FMT_plx
>                     " (prio %d, %s): alias %s @%s " TARGET_FMT_plx
> -                   "-" TARGET_FMT_plx "%s\n",
> +                   "-" TARGET_FMT_plx "%s",
>                     cur_start, cur_end,
>                     mr->priority,
>                     memory_region_type((MemoryRegion *)mr),
> @@ -2888,15 +2935,22 @@ static void mtree_print_mr(fprintf_function mon_p=
rintf, void *f,
>                     mr->alias_offset,
>                     mr->alias_offset + MR_SIZE(mr->size),
>                     mr->enabled ? "" : " [disabled]");
> +        if (owner) {
> +            mtree_print_mr_owner(mon_printf, f, mr);
> +        }
>      } else {
>          mon_printf(f,
> -                   TARGET_FMT_plx "-" TARGET_FMT_plx " (prio %d, %s): %s=
%s\n",
> +                   TARGET_FMT_plx "-" TARGET_FMT_plx " (prio %d, %s): %s=
%s",
>                     cur_start, cur_end,
>                     mr->priority,
>                     memory_region_type((MemoryRegion *)mr),
>                     memory_region_name(mr),
>                     mr->enabled ? "" : " [disabled]");
> +        if (owner) {
> +            mtree_print_mr_owner(mon_printf, f, mr);
> +        }
>      }
> +    mon_printf(f, "\n");
> =20
>      QTAILQ_INIT(&submr_print_queue);
> =20
> @@ -2919,7 +2973,7 @@ static void mtree_print_mr(fprintf_function mon_pri=
ntf, void *f,
> =20
>      QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
>          mtree_print_mr(mon_printf, f, ml->mr, level + 1, cur_start,
> -                       alias_print_queue);
> +                       alias_print_queue, owner);
>      }
> =20
>      QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, mrqueue, next_ml) {
> @@ -2932,6 +2986,7 @@ struct FlatViewInfo {
>      void *f;
>      int counter;
>      bool dispatch_tree;
> +    bool owner;
>  };
> =20
>  static void mtree_print_flatview(gpointer key, gpointer value,
> @@ -2972,7 +3027,7 @@ static void mtree_print_flatview(gpointer key, gpoi=
nter value,
>          mr =3D range->mr;
>          if (range->offset_in_region) {
>              p(f, MTREE_INDENT TARGET_FMT_plx "-"
> -              TARGET_FMT_plx " (prio %d, %s): %s @" TARGET_FMT_plx "\n",
> +              TARGET_FMT_plx " (prio %d, %s): %s @" TARGET_FMT_plx,
>                int128_get64(range->addr.start),
>                int128_get64(range->addr.start) + MR_SIZE(range->addr.size=
),
>                mr->priority,
> @@ -2981,13 +3036,17 @@ static void mtree_print_flatview(gpointer key, gp=
ointer value,
>                range->offset_in_region);
>          } else {
>              p(f, MTREE_INDENT TARGET_FMT_plx "-"
> -              TARGET_FMT_plx " (prio %d, %s): %s\n",
> +              TARGET_FMT_plx " (prio %d, %s): %s",
>                int128_get64(range->addr.start),
>                int128_get64(range->addr.start) + MR_SIZE(range->addr.size=
),
>                mr->priority,
>                range->readonly ? "rom" : memory_region_type(mr),
>                memory_region_name(mr));
>          }
> +        if (fvi->owner) {
> +            mtree_print_mr_owner(p, f, mr);
> +        }
> +        p(f, "\n");
>          range++;
>      }
> =20
> @@ -3013,7 +3072,7 @@ static gboolean mtree_info_flatview_free(gpointer k=
ey, gpointer value,
>  }
> =20
>  void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
> -                bool dispatch_tree)
> +                bool dispatch_tree, bool owner)
>  {
>      MemoryRegionListHead ml_head;
>      MemoryRegionList *ml, *ml2;
> @@ -3025,7 +3084,8 @@ void mtree_info(fprintf_function mon_printf, void *=
f, bool flatview,
>              .mon_printf =3D mon_printf,
>              .f =3D f,
>              .counter =3D 0,
> -            .dispatch_tree =3D dispatch_tree
> +            .dispatch_tree =3D dispatch_tree,
> +            .owner =3D owner,
>          };
>          GArray *fv_address_spaces;
>          GHashTable *views =3D g_hash_table_new(g_direct_hash, g_direct_e=
qual);
> @@ -3057,14 +3117,14 @@ void mtree_info(fprintf_function mon_printf, void=
 *f, bool flatview,
> =20
>      QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
>          mon_printf(f, "address-space: %s\n", as->name);
> -        mtree_print_mr(mon_printf, f, as->root, 1, 0, &ml_head);
> +        mtree_print_mr(mon_printf, f, as->root, 1, 0, &ml_head, owner);
>          mon_printf(f, "\n");
>      }
> =20
>      /* print aliased regions */
>      QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
>          mon_printf(f, "memory-region: %s\n", memory_region_name(ml->mr));
> -        mtree_print_mr(mon_printf, f, ml->mr, 1, 0, &ml_head);
> +        mtree_print_mr(mon_printf, f, ml->mr, 1, 0, &ml_head, owner);
>          mon_printf(f, "\n");
>      }
> =20
> diff --git a/monitor.c b/monitor.c
> index 51f4cf4..9d304a5 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1969,8 +1969,10 @@ static void hmp_info_mtree(Monitor *mon, const QDi=
ct *qdict)
>  {
>      bool flatview =3D qdict_get_try_bool(qdict, "flatview", false);
>      bool dispatch_tree =3D qdict_get_try_bool(qdict, "dispatch_tree", fa=
lse);
> +    bool owner =3D qdict_get_try_bool(qdict, "owner", false);
> =20
> -    mtree_info((fprintf_function)monitor_printf, mon, flatview, dispatch=
_tree);
> +    mtree_info((fprintf_function)monitor_printf, mon, flatview, dispatch=
_tree,
> +               owner);
>  }
> =20
>  static void hmp_info_numa(Monitor *mon, const QDict *qdict)
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index ddfcd5a..5956495 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -250,10 +250,11 @@ ETEXI
> =20
>      {
>          .name       =3D "mtree",
> -        .args_type  =3D "flatview:-f,dispatch_tree:-d",
> -        .params     =3D "[-f][-d]",
> +        .args_type  =3D "flatview:-f,dispatch_tree:-d,owner:-o",
> +        .params     =3D "[-f][-d][-o]",
>          .help       =3D "show memory tree (-f: dump flat view for addres=
s spaces;"
> -                      "-d: dump dispatch tree, valid with -f only)",
> +                      "-d: dump dispatch tree, valid with -f only);"
> +                      "-o: dump region owners/parents",
>          .cmd        =3D hmp_info_mtree,
>      },
> =20
> --=20
> 2.11.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
