Received: from eggs.gnu.org ([2001:4830:134:3::10]:56424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmJ-0003R3-9h
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmC-00056h-Il
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:03 -0400
Received: from ozlabs.ru ([107.173.13.209]:59724)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmC-00056D-7l
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:14:56 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 20 Sep 2017 21:46:33 +1000
Message-Id: <20170920114637.42004-15-aik@ozlabs.ru>
In-Reply-To: <20170920114637.42004-1-aik@ozlabs.ru>
References: <20170920114637.42004-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v4 14/18] memory: Add flat views to HMP
 "info mtree"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>

This adds a new "-d" switch to "info mtree" to print dispatch tree
internals.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v3:
* reimplemented as there is no more global FlatView list

---

Example:

QEMU 2.10.50 monitor - type 'help' for more information
(qemu) info mtree -f -d
FlatView #0
 AS "memory", root: system
 AS "cpu-memory", root: system
 AS "cpu-memory", root: system
 AS "cpu-memory", root: system
 AS "cpu-memory", root: system
 AS "cpu-memory", root: system
 AS "cpu-memory", root: system
 AS "cpu-memory", root: system
 AS "cpu-memory", root: system
 Root memory region: system
  0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
  Dispatch
    Physical sections
      #0 @0000000000000000..ffffffffffffffff (noname) [unassigned]
      #1 @0000000000000000..ffffffffffffffff (noname) [not dirty]
      #2 @0000000000000000..ffffffffffffffff (noname) [ROM]
      #3 @0000000000000000..ffffffffffffffff (noname) [watch]
      #4 @0000000000000000..000000007fffffff ppc_spapr.ram [MRU]
    Nodes (9 bits per level, 6 levels) ptr=[3] skip=4
      [0]
	  0       skip=3  ptr=[3]
	  1..511  skip=1  ptr=NIL
      [1]
	  0       skip=2  ptr=[3]
	  1..511  skip=1  ptr=NIL
      [2]
	  0       skip=1  ptr=[3]
	  1..511  skip=1  ptr=NIL
      [3]
	  0..1    skip=0  ptr=#4
	  2..511  skip=1  ptr=NIL

FlatView #1
 AS "I/O", root: io
 Root memory region: io
  0000000000000000-000000000000ffff (prio 0, i/o): io
  Dispatch
    Physical sections
      #0 @0000000000000000..ffffffffffffffff (noname) [unassigned]
      #1 @0000000000000000..ffffffffffffffff (noname) [not dirty]
      #2 @0000000000000000..ffffffffffffffff (noname) [ROM]
      #3 @0000000000000000..ffffffffffffffff (noname) [watch]
      #4 @0000000000000000..000000000000ffff io [ROOT]
    Nodes (9 bits per level, 6 levels) ptr=[5] skip=6
      [0]
	  0       skip=5  ptr=[5]
	  1..511  skip=1  ptr=NIL
      [1]
	  0       skip=4  ptr=[5]
	  1..511  skip=1  ptr=NIL
      [2]
	  0       skip=3  ptr=[5]
	  1..511  skip=1  ptr=NIL
      [3]
	  0       skip=2  ptr=[5]
	  1..511  skip=1  ptr=NIL
      [4]
	  0       skip=1  ptr=[5]
	  1..511  skip=1  ptr=NIL
      [5]
	  0..15   skip=0  ptr=#4
	 16..511  skip=0  ptr=#0

FlatView #2
 AS "pci@800000020000000", root: pci@800000020000000.iommu-root
 Root memory region: pci@800000020000000.iommu-root
  0000000000000000-000000003fffffff (prio 0, i/o): tce-iommu-80000000
  0000040000000000-000004000000ffff (prio 0, i/o): msi
  Dispatch
    Physical sections
      #0 @0000000000000000..ffffffffffffffff (noname) [unassigned]
      #1 @0000000000000000..ffffffffffffffff (noname) [not dirty]
      #2 @0000000000000000..ffffffffffffffff (noname) [ROM]
      #3 @0000000000000000..ffffffffffffffff (noname) [watch]
      #4 @0000000000000000..000000003fffffff tce-iommu-80000000 [iommu]
      #5 @0000040000000000..000004000000ffff msi
    Nodes (9 bits per level, 6 levels) ptr=[2] skip=3
      [0]
	  0       skip=2  ptr=[2]
	  1..511  skip=1  ptr=NIL
      [1]
	  0       skip=1  ptr=[2]
	  1..511  skip=1  ptr=NIL
      [2]
	  0       skip=0  ptr=#4
	  1..7    skip=1  ptr=NIL
	  8       skip=3  ptr=[6]
	  9..511  skip=1  ptr=NIL
      [3]
	  0       skip=0  ptr=#4
	  1..511  skip=1  ptr=NIL
      [4]
	  0       skip=2  ptr=[6]
	  1..511  skip=1  ptr=NIL
      [5]
	  0       skip=1  ptr=[6]
	  1..511  skip=1  ptr=NIL
      [6]
	  0..15   skip=0  ptr=#5
	 16..511  skip=0  ptr=#0

FlatView #3
 AS "e1000", root: bus master container
 AS "e1000", root: bus master container
 AS "e1000", root: bus master container
 AS "e1000", root: bus master container
 AS "e1000", root: bus master container
 AS "e1000", root: bus master container
 AS "e1000", root: bus master container
 AS "e1000", root: bus master container
 AS "e1000", root: bus master container
 AS "e1000", root: bus master container
 Root memory region: (none)
  No rendered FlatView
---
 include/exec/memory-internal.h |  4 ++
 include/exec/memory.h          |  3 +-
 exec.c                         | 84 +++++++++++++++++++++++++++++++++++++++
 memory.c                       | 90 +++++++++++++++++++++++++++++++++++++-----
 monitor.c                      |  3 +-
 hmp-commands-info.hx           |  7 ++--
 6 files changed, 176 insertions(+), 15 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index d4a35c6e96..647e9bd5c4 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -35,5 +35,9 @@ AddressSpaceDispatch *address_space_to_dispatch(AddressSpace *as);
 AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv);
 void address_space_dispatch_free(AddressSpaceDispatch *d);
 
+void mtree_print_dispatch(fprintf_function mon, void *f,
+                          struct AddressSpaceDispatch *d,
+                          MemoryRegion *root);
+
 #endif
 #endif
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 7816e5d655..2f4f56cf40 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1515,7 +1515,8 @@ void memory_global_dirty_log_start(void);
  */
 void memory_global_dirty_log_stop(void);
 
-void mtree_info(fprintf_function mon_printf, void *f, bool flatview);
+void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
+                bool dispatch_tree);
 
 /**
  * memory_region_request_mmio_ptr: request a pointer to an mmio
diff --git a/exec.c b/exec.c
index b085f82503..7a80460725 100644
--- a/exec.c
+++ b/exec.c
@@ -3616,3 +3616,87 @@ void page_size_init(void)
     }
     qemu_host_page_mask = -(intptr_t)qemu_host_page_size;
 }
+
+#if !defined(CONFIG_USER_ONLY)
+
+static void mtree_print_phys_entries(fprintf_function mon, void *f,
+                                     int start, int end, int skip, int ptr)
+{
+    if (start == end - 1) {
+        mon(f, "\t%3d      ", start);
+    } else {
+        mon(f, "\t%3d..%-3d ", start, end - 1);
+    }
+    mon(f, " skip=%d ", skip);
+    if (ptr == PHYS_MAP_NODE_NIL) {
+        mon(f, " ptr=NIL");
+    } else if (!skip) {
+        mon(f, " ptr=#%d", ptr);
+    } else {
+        mon(f, " ptr=[%d]", ptr);
+    }
+    mon(f, "\n");
+}
+
+#define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
+                           int128_sub((size), int128_one())) : 0)
+
+void mtree_print_dispatch(fprintf_function mon, void *f,
+                          AddressSpaceDispatch *d, MemoryRegion *root)
+{
+    int i;
+
+    mon(f, "  Dispatch\n");
+    mon(f, "    Physical sections\n");
+
+    for (i = 0; i < d->map.sections_nb; ++i) {
+        MemoryRegionSection *s = d->map.sections + i;
+        const char *names[] = { " [unassigned]", " [not dirty]",
+                                " [ROM]", " [watch]" };
+
+        mon(f, "      #%d @" TARGET_FMT_plx ".." TARGET_FMT_plx " %s%s%s%s%s",
+            i,
+            s->offset_within_address_space,
+            s->offset_within_address_space + MR_SIZE(s->mr->size),
+            s->mr->name ? s->mr->name : "(noname)",
+            i < ARRAY_SIZE(names) ? names[i] : "",
+            s->mr == root ? " [ROOT]" : "",
+            s == d->mru_section ? " [MRU]" : "",
+            s->mr->is_iommu ? " [iommu]" : "");
+
+        if (s->mr->alias) {
+            mon(f, " alias=%s", s->mr->alias->name ?
+                    s->mr->alias->name : "noname");
+        }
+        mon(f, "\n");
+    }
+
+    mon(f, "    Nodes (%d bits per level, %d levels) ptr=[%d] skip=%d\n",
+               P_L2_BITS, P_L2_LEVELS, d->phys_map.ptr, d->phys_map.skip);
+    for (i = 0; i < d->map.nodes_nb; ++i) {
+        int j, jprev;
+        PhysPageEntry prev;
+        Node *n = d->map.nodes + i;
+
+        mon(f, "      [%d]\n", i);
+
+        for (j = 0, jprev = 0, prev = *n[0]; j < ARRAY_SIZE(*n); ++j) {
+            PhysPageEntry *pe = *n + j;
+
+            if (pe->ptr == prev.ptr && pe->skip == prev.skip) {
+                continue;
+            }
+
+            mtree_print_phys_entries(mon, f, jprev, j, prev.skip, prev.ptr);
+
+            jprev = j;
+            prev = *pe;
+        }
+
+        if (jprev != ARRAY_SIZE(*n)) {
+            mtree_print_phys_entries(mon, f, jprev, j, prev.skip, prev.ptr);
+        }
+    }
+}
+
+#endif
diff --git a/memory.c b/memory.c
index aa8a49539d..4add0fd030 100644
--- a/memory.c
+++ b/memory.c
@@ -2903,18 +2903,44 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
     }
 }
 
-static void mtree_print_flatview(fprintf_function p, void *f,
-                                 AddressSpace *as)
+struct FlatViewInfo {
+    fprintf_function mon_printf;
+    void *f;
+    int counter;
+    bool dispatch_tree;
+};
+
+static void mtree_print_flatview(gpointer key, gpointer value,
+                                 gpointer user_data)
 {
-    FlatView *view = address_space_get_flatview(as);
+    FlatView *view = key;
+    GArray *fv_address_spaces = value;
+    struct FlatViewInfo *fvi = user_data;
+    fprintf_function p = fvi->mon_printf;
+    void *f = fvi->f;
     FlatRange *range = &view->ranges[0];
     MemoryRegion *mr;
     int n = view->nr;
+    int i;
+    AddressSpace *as;
+
+    p(f, "FlatView #%d\n", fvi->counter);
+    ++fvi->counter;
+
+    for (i = 0; i < fv_address_spaces->len; ++i) {
+        as = g_array_index(fv_address_spaces, AddressSpace*, i);
+        p(f, " AS \"%s\", root: %s", as->name, memory_region_name(as->root));
+        if (as->root->alias) {
+            p(f, ", alias %s", memory_region_name(as->root->alias));
+        }
+        p(f, "\n");
+    }
+
+    p(f, " Root memory region: %s\n",
+      view->root ? memory_region_name(view->root) : "(none)");
 
     if (n <= 0) {
-        p(f, MTREE_INDENT "No rendered FlatView for "
-          "address space '%s'\n", as->name);
-        flatview_unref(view);
+        p(f, MTREE_INDENT "No rendered FlatView\n\n");
         return;
     }
 
@@ -2941,21 +2967,65 @@ static void mtree_print_flatview(fprintf_function p, void *f,
         range++;
     }
 
+#if !defined(CONFIG_USER_ONLY)
+    if (fvi->dispatch_tree && view->root) {
+        mtree_print_dispatch(p, f, view->dispatch, view->root);
+    }
+#endif
+
+    p(f, "\n");
+}
+
+static gboolean mtree_info_flatview_free(gpointer key, gpointer value,
+                                      gpointer user_data)
+{
+    FlatView *view = key;
+    GArray *fv_address_spaces = value;
+
+    g_array_unref(fv_address_spaces);
     flatview_unref(view);
+
+    return true;
 }
 
-void mtree_info(fprintf_function mon_printf, void *f, bool flatview)
+void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
+                bool dispatch_tree)
 {
     MemoryRegionListHead ml_head;
     MemoryRegionList *ml, *ml2;
     AddressSpace *as;
 
     if (flatview) {
+        FlatView *view;
+        struct FlatViewInfo fvi = {
+            .mon_printf = mon_printf,
+            .f = f,
+            .counter = 0,
+            .dispatch_tree = dispatch_tree
+        };
+        GArray *fv_address_spaces;
+        GHashTable *views = g_hash_table_new(g_direct_hash, g_direct_equal);
+
+        /* Gather all FVs in one table */
         QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-            mon_printf(f, "address-space (flat view): %s\n", as->name);
-            mtree_print_flatview(mon_printf, f, as);
-            mon_printf(f, "\n");
+            view = address_space_get_flatview(as);
+
+            fv_address_spaces = g_hash_table_lookup(views, view);
+            if (!fv_address_spaces) {
+                fv_address_spaces = g_array_new(false, false, sizeof(as));
+                g_hash_table_insert(views, view, fv_address_spaces);
+            }
+
+            g_array_append_val(fv_address_spaces, as);
         }
+
+        /* Print */
+        g_hash_table_foreach(views, mtree_print_flatview, &fvi);
+
+        /* Free */
+        g_hash_table_foreach_remove(views, mtree_info_flatview_free, 0);
+        g_hash_table_unref(views);
+
         return;
     }
 
diff --git a/monitor.c b/monitor.c
index 058045b3cb..f4856b9268 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1703,8 +1703,9 @@ static void hmp_boot_set(Monitor *mon, const QDict *qdict)
 static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
 {
     bool flatview = qdict_get_try_bool(qdict, "flatview", false);
+    bool dispatch_tree = qdict_get_try_bool(qdict, "dispatch_tree", false);
 
-    mtree_info((fprintf_function)monitor_printf, mon, flatview);
+    mtree_info((fprintf_function)monitor_printf, mon, flatview, dispatch_tree);
 }
 
 static void hmp_info_numa(Monitor *mon, const QDict *qdict)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 1c6772597d..4f1ece93e5 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -250,9 +250,10 @@ ETEXI
 
     {
         .name       = "mtree",
-        .args_type  = "flatview:-f",
-        .params     = "[-f]",
-        .help       = "show memory tree (-f: dump flat view for address spaces)",
+        .args_type  = "flatview:-f,dispatch_tree:-d",
+        .params     = "[-f][-d]",
+        .help       = "show memory tree (-f: dump flat view for address spaces;"
+                      "-d: dump dispatch tree, valid with -f only)",
         .cmd        = hmp_info_mtree,
     },
 
-- 
2.11.0
