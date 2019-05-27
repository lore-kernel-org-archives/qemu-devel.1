Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9DCC04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 13:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8C32054F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 13:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8C32054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45822 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVFRl-0001uM-53
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 09:13:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVFQe-0001Qk-OV
	for qemu-devel@nongnu.org; Mon, 27 May 2019 09:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVFQc-0007zv-PV
	for qemu-devel@nongnu.org; Mon, 27 May 2019 09:12:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hVFQc-0007yi-IO
	for qemu-devel@nongnu.org; Mon, 27 May 2019 09:12:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CCB39C4EC4
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 13:12:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 518836F440
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 13:12:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id C74FF1138648; Mon, 27 May 2019 15:12:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
References: <87wpp4m6n1.fsf@blackfin.pond.sub.org>
Date: Mon, 27 May 2019 15:12:34 +0200
In-Reply-To: <87wpp4m6n1.fsf@blackfin.pond.sub.org> (Markus Armbruster's
	message of "Tue, 15 Mar 2016 10:29:06 +0100")
Message-ID: <877eac82il.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Mon, 27 May 2019 13:12:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Our use of #include is undisciplined,
 and what to do about it
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's been three years, let's examine how things have evolved.

I'm using commit db3d11ee3f0, which is a bit behind current master, just
so I can apply my "[PATCH 0/4] Cleanups around qemu-common.h" cleanly.

Markus Armbruster <armbru@redhat.com> writes:

[...]
> = The status quo and why I hate it =
>
> I've seen several schools of thought on use of #include.
>
> There's the "no #include in headers" school: every .c file includes
> exactly the headers it needs, and the prerequisites they need.  Cyclic
> inclusion becomes impossible.  You can't sweep cyclic dependencies under
> the rug.  Headers are read just once per compilation unit.  The amount
> of crap you include is clearly visible.  However, maintaining the
> #include directives is a drag, not least because their order matters.
> Especially when headers neglect to spell out their dependencies.  Or
> they do, but it's wrong.
>
> There's the "headers must be self-contained" school: every header
> includes everything it needs.  Headers can be included in any order.
> Sorted #include directives are tidy and easy to navigate.  Headers can
> be read multiple times, which can only hurt compilation time.

Our compilers avoid this for headers with proper header guards.

>                                                                You need
> to make an effort to avoid cyclic dependencies and excessive inclusion.
>
> And then there's the school of non-thought: when it doesn't compile,
> sprinkle #include on the mess semi-randomly until it does.
>
> We do a bit of all three, but the result looks awfully close to what the
> school of non-thought produces.
>
> Every .c file includes qemu/osdep.h first.  For me, a .c file that
> includes nothing but that comes out well over half a Megabyte in >23k
> lines preprocessed.  Where does all this crap come from?
>
>   #lines  KiBytes  #files  source
>     5233     102       5   QEMU
>     8035     159      70   system
>     7915     224      73   GLib
>     2458      89       1   # lines
>    23641     576     149   total
>
> "# lines" are lines added by the preprocessor so the rest of the
> compiler can keep track of source locations.

    #lines  KiBytes  #files  source
       375       8       5   QEMU
      9722     230     113   system
      8212     254      74   GLib
      1517      65     N/A   # lines
     19826     557     192   total

The weight QEMU lost, system + GLib put on.

> Having the compiler wade through almost half a Megabyte of system+GLib
> crap before it begins to consider the code we care about feels wasteful.
> Perhaps we should rethink our approach to including library headers.

No change.

> Of the 102K that are actually our own, just 7K come from include/.  95K
> come from qapi-types.h.

Fixed.

> Judging from the .d files in my build tree, 95% of the .c files include
> qemu-common.h.  That makes things a good deal worse.

Down to 90%.  My "[PATCH 0/4] Cleanups around qemu-common.h" shrinks it
to less than 10%.  Small enough for me not to repeat the measurements
below.

>                                                       Without
> NEED_CPU_H, this adds a modest 44K of our own headers, but almost 100K
> of system headers:
>
>   #lines  KiBytes  #files  source
>     6938     146      16   QEMU
>    11426     254      74   system
>     7915     224      73   GLib
>     2658     100       1   # lines
>    28937     726     164   total
>
> NEED_CPU_H adds another 120K of our own headers:
>
>   #lines  KiBytes  #files  source
>    11534     263      43   QEMU
>    11548     256      78   system
>     7915     225      72   GLib
>     3370     138       1   # lines
>    34367     883     194   total
>
> The average size of a .c file is just over 15KiB.  To get to the actual
> C code there, the compiler has to wade through at least 550-880KiB of
> headers.  In other words, roughly 2% of the source comes from .c in the
> best case.
>
> But that's not even the worst part.  The worst part by far are our
> "touch this and recompile the world" headers.
>
> I find just short 4000 .d files in my build tree.

Some 6400 now, ignoring the .d that don't contain ".o:".

>                                                    Guess how many of our
> headers are listed as prerequisites in more than 90% of them (thus
> touching them will recompile the .c file)?  *Twenty-two*.

Down to 12 before my "[PATCH 0/4] Cleanups around qemu-common.h", and to
10 afterwards.

>                                                            Almost fifty
> recompile more half of the world.

No significant change.

> Naturally, touching osdep.h or anything it includes recompiles the
> world.  These are:
>
>     config-host.h
>     include/glib-compat.h
>     include/qapi/error.h
>     include/qemu/compiler.h
>     include/qemu/osdep.h
>     include/qemu/typedefs.h
>     include/sysemu/os-posix.h
>     qapi-types.h
>
> NEED_CPU_H adds
>
>     config-target.h
>
> Fine, except for qapi/error.h and qapi-types.h.  The latter is an itch I
> need to scratch urgently.  My first patch series will take a swing at
> it.

Both are gone.

New: include/exec/poison.h

[...]
>
> A fun exercise is to count occurences of each header in .d files and
> multiply their number by their size.  That's the number of bytes read
> from them when compiling from scratch.  Top scorers:
>
>  size * count    size   count
>     525760413  698221     753 trace/generated-tracers.h
>     298039140   93723    3180 qapi-types.h
>     197442619   55759    3541 include/qom/object.h
>     185845916   53884    3449 include/exec/memory.h
>     143750444   36878    3898 /usr/include/glib-2.0/glib/gunicode.h
>     117362690   30643    3830 include/fpu/softfloat.h
>     109783272   28164    3898 /usr/include/glib-2.0/glib/gregex.h
>     105830700   27150    3898 /usr/include/glib-2.0/glib/gvariant.h
>      92972157  123469     753 trace/generated-events.h
>      88706786   22757    3898 /usr/include/glib-2.0/glib/gtestutils.h

After my "[PATCH 0/4] Cleanups around qemu-common.h":

   size * count    size   count
      428019130   82789    5170 include/exec/memory.h
      336965209   60857    5537 include/qom/object.h
      248105382   39121    6342 /usr/include/glib-2.0/glib/gunicode.h
      187247550   29525    6342 /usr/include/glib-2.0/glib/gvariant.h
      182359220  172037    1060 trace-root.h
      178178490   28095    6342 /usr/include/glib-2.0/glib/gregex.h
      167477688   71848    2331 qapi/qapi-types-block-core.h
      166926546   36947    4518 include/qom/cpu.h
      161105826   25403    6342 /usr/include/glib-2.0/glib/gmessages.h
      153508110   24205    6342 /usr/include/glib-2.0/glib/gtestutils.h

[...]
>
> = What to do about it =
>
> The immediately obvious thing to do is reduce "recompile the world"
> headers that change frequently.  I've started to do that.
>
> Another one is attacking widely included bulky files (see "Top
> scorers").  Some can simply be included less.  Others need to be split,
> in particular the generated tracers.

Some progress, notably around trace and QAPI.

> Yet another one is reviewing the way we include system and GLib headers.

Not attempted.

> But our root problem is our undisciplined use of #include.  Can we agree
> on a sane set of rules?  Here's my proposal:
>
> 1. Have a carefully curated header that's included everywhere first.  We
>    got that already thanks to Peter: osdep.h.
>
> 2. Headers should normally include everything they need beyond osdep.h.
>    If exceptions are needed for some reason, they must be documented in
>    the header.  If all that's needed from a header is typedefs, put
>    those into qemu/typedefs.h instead of including the header.
>
> 3. Cyclic inclusion is forbidden.
>
> Nice to have: "make check" checks 2. and 3.

See my "[RFC v4 0/7] Baby steps towards saner headers".

[...]

Headers that are prerequisites of more than 2000 .o:

   6312 config-host.h
   2827 include/block/aio.h
   4537 include/disas/dis-asm.h
   3634 include/exec/cpu-all.h
   5177 include/exec/cpu-common.h
   3634 include/exec/cpu-defs.h
   5401 include/exec/hwaddr.h
   5395 include/exec/memattrs.h
   5170 include/exec/memory.h
   3514 include/exec/memory_ldst.inc.h
   3514 include/exec/memory_ldst_cached.inc.h
   3514 include/exec/memory_ldst_phys.inc.h
   3517 include/exec/ramlist.h
   5699 include/fpu/softfloat-types.h
   6312 include/glib-compat.h
   5429 include/hw/hotplug.h
   2423 include/hw/hw.h
   5437 include/hw/irq.h
   5428 include/hw/qdev-core.h
   2520 include/hw/qdev-properties.h
   2297 include/hw/qdev.h
   2425 include/migration/qemu-file-types.h
   2564 include/migration/vmstate.h
   2502 include/qapi/error.h
   6063 include/qapi/util.h
   5939 include/qemu/atomic.h
   5494 include/qemu/bitmap.h
   5673 include/qemu/bitops.h
   5697 include/qemu/bswap.h
   6312 include/qemu/compiler.h
   3701 include/qemu/coroutine.h
   2838 include/qemu/event_notifier.h
   5683 include/qemu/host-utils.h
   4680 include/qemu/int128.h
   3701 include/qemu/lockable.h
   3187 include/qemu/log-for-trace.h
   2230 include/qemu/log.h
   2483 include/qemu/main-loop.h
   5568 include/qemu/module.h
   5137 include/qemu/notify.h
   6312 include/qemu/osdep.h
   5561 include/qemu/processor.h
   5560 include/qemu/qsp.h
   5863 include/qemu/queue.h
   5178 include/qemu/rcu.h
   5398 include/qemu/rcu_queue.h
   5178 include/qemu/sys_membarrier.h
   5560 include/qemu/thread-posix.h
   5560 include/qemu/thread.h
   4356 include/qemu/timer.h
   6312 include/qemu/typedefs.h
   2008 include/qemu/uuid.h
   4518 include/qom/cpu.h
   5537 include/qom/object.h
   6312 include/sysemu/os-posix.h
   2456 include/sysemu/reset.h
   2000 include/sysemu/sysemu.h
   6062 qapi/qapi-builtin-types.h
   2821 qapi/qapi-types-block-core.h
   2669 qapi/qapi-types-block.h
   3806 qapi/qapi-types-common.h
   2860 qapi/qapi-types-crypto.h
   2825 qapi/qapi-types-job.h
   3038 qapi/qapi-types-misc.h
   5249 qapi/qapi-types-run-state.h
   3148 qapi/qapi-types-sockets.h
   3634 tcg/i386/tcg-target.h
   3634 tcg/tcg-mo.h
   2369 trace/control-internal.h
   2369 trace/control.h
   2369 trace/event-internal.h
   2361 trace/ftrace.h
   5224 x86_64-softmmu/config-target.h

Bulky headers:

   size * count    size   count
       17744958   16461    1078 accel/tcg/tcg-runtime.h
       32519424   10304    6312 config-host.h
       21298950  525900      81 hw/display/trace.h
       25070220 1432584      35 hw/net/trace.h
       28700355  604218      95 hw/vfio/trace.h
       57913922   20486    2827 include/block/aio.h
       54939528   30744    1787 include/block/block.h
       15698796   53763     292 include/block/block_int.h
       12076546    6758    1787 include/block/dirty-bitmap.h
       90694630   19990    4537 include/disas/dis-asm.h
       22187844   68481     324 include/elf.h
       41198658   11337    3634 include/exec/cpu-all.h
       19118661    3693    5177 include/exec/cpu-common.h
       26052146    7169    3634 include/exec/cpu-defs.h
       10698472   11098     964 include/exec/cpu_ldst.h
       32181064   19144    1681 include/exec/exec-all.h
       14027000    2600    5395 include/exec/memattrs.h
      428019130   82789    5170 include/exec/memory.h
       12590662    3583    3514 include/exec/memory_ldst.inc.h
       13254808    3772    3514 include/exec/memory_ldst_cached.inc.h
       18258744    5196    3514 include/exec/memory_ldst_phys.inc.h
       37693186    6614    5699 include/fpu/softfloat-types.h
       40152640   41480     968 include/fpu/softfloat.h
       24408504    3867    6312 include/glib-compat.h
       16216423    2987    5429 include/hw/hotplug.h
       10178064    1872    5437 include/hw/irq.h
       27001315   27137     995 include/hw/pci/pci.h
       10509377   10541     997 include/hw/pci/pci_ids.h
       84058008   15486    5428 include/hw/qdev-core.h
       38099880   15119    2520 include/hw/qdev-properties.h
       10165600    4192    2425 include/migration/qemu-file-types.h
      140199520   54680    2564 include/migration/vmstate.h
       28062432   11216    2502 include/qapi/error.h
       14093499   21649     651 include/qapi/visitor.h
      122361217   20603    5939 include/qemu/atomic.h
       53242354    9691    5494 include/qemu/bitmap.h
       91409049   16113    5673 include/qemu/bitops.h
       82589409   14497    5697 include/qemu/bswap.h
       48009072    7606    6312 include/qemu/compiler.h
       32872282    8882    3701 include/qemu/coroutine.h
       20290224   11348    1788 include/qemu/hbitmap.h
       64189485   11295    5683 include/qemu/host-utils.h
       24059880    5141    4680 include/qemu/int128.h
       16473456    8474    1944 include/qemu/iov.h
       33191317   18553    1789 include/qemu/job.h
       11054887    2987    3701 include/qemu/lockable.h
       29294434   11798    2483 include/qemu/main-loop.h
       14081472    2529    5568 include/qemu/module.h
      120111048   19029    6312 include/qemu/osdep.h
       14389467    7383    1949 include/qemu/qht.h
      142840269   24363    5863 include/qemu/queue.h
       24735306    4777    5178 include/qemu/rcu.h
       68419650   12675    5398 include/qemu/rcu_queue.h
       59775560   10751    5560 include/qemu/thread.h
      122708520   28170    4356 include/qemu/timer.h
       26573520    4210    6312 include/qemu/typedefs.h
      166926546   36947    4518 include/qom/cpu.h
      336965209   60857    5537 include/qom/object.h
       55562856   55786     996 include/standard-headers/linux/pci_regs.h
       12834339   18361     699 include/sysemu/kvm.h
       19453584    3082    6312 include/sysemu/os-posix.h
       12720000    6360    2000 include/sysemu/sysemu.h
       16650270   26429     630 linux-user/qemu.h
       53241630   84110     633 linux-user/syscall_defs.h
       29144784 1214366      48 migration/trace.h
       16888732    5572    6062 qapi/qapi-builtin-types.h
      202683208  215544    2821 qapi/qapi-types-block-core.h
       11236490   12630    2669 qapi/qapi-types-block.h
       15791094   12447    3806 qapi/qapi-types-common.h
       21564400   22620    2860 qapi/qapi-types-crypto.h
       83229048   82188    3038 qapi/qapi-types-misc.h
       11551995   28665    1209 qapi/qapi-types-net.h
       25888068   14796    5249 qapi/qapi-types-run-state.h
       14465060   13785    3148 qapi/qapi-types-sockets.h
       18174224   62526     872 qapi/qapi-types-ui.h
       60562920  124872     485 target/arm/cpu.h
       18587552   63656     292 target/i386/cpu.h
       18575446   36139     514 target/mips/cpu.h
       44133336  109512     403 target/ppc/cpu.h
       28893934    7951    3634 tcg/i386/tcg-target.h
       24384936   51663     472 tcg/tcg-op.h
       18304270   11285    1622 tcg/tcg-opc.h
       79108184   48772    1622 tcg/tcg.h
       64600980   95352    1355 trace-dtrace-root.h
      233110135  344074    1355 trace-root.h
       22750450   33580    1355 trace-ust-root.h
       16220543    6847    2369 trace/control.h

