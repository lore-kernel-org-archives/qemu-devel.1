Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DDFC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 08:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE4A20863
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 08:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE4A20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48694 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSzy4-0002Go-1G
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 04:17:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hSzwy-0001oD-Og
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hSzww-0006QN-D1
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:16:44 -0400
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:33801)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hSzww-0006KR-58
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:16:42 -0400
Received: from player739.ha.ovh.net (unknown [10.109.160.54])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 24EEE102C81
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 10:16:31 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player739.ha.ovh.net (Postfix) with ESMTPSA id B64A861A4B10;
	Tue, 21 May 2019 08:16:24 +0000 (UTC)
Date: Tue, 21 May 2019 10:16:23 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Message-ID: <20190521101623.7490b611@bahia.lan>
In-Reply-To: <20190517094435.32765-1-clg@kaod.org>
References: <20190517094435.32765-1-clg@kaod.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 12961078253427333515
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddutddgtddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.72.44
Subject: Re: [Qemu-devel] [PATCH v2] docs: provide documentation on the
 POWER9 XIVE interrupt controller
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
	qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 May 2019 11:44:35 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> This documents the overall XIVE architecture and the XIVE support for
> sPAPR guest machines (pseries).
>=20
> It also provides documentation on the 'info pic' command.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

LGTM. Just found two typos, see below (I've added extra blank lines so
that you can spot them more easily).

>=20
>  Changes since v2:
>=20
>  - reorganized into different files and directories. I don't think the
>    'info pic' documentation belongs to 'interop' nor 'devel' and so
>    the ppc-spapr-xive.rst file seemed like the best place for it.
>=20
>  docs/index.rst                |   1 +
>  docs/specs/index.rst          |  13 +++
>  docs/specs/ppc-spapr-xive.rst | 174 +++++++++++++++++++++++++++++
>  docs/specs/ppc-xive.rst       | 199 ++++++++++++++++++++++++++++++++++
>  MAINTAINERS                   |   1 +
>  5 files changed, 388 insertions(+)
>  create mode 100644 docs/specs/index.rst
>  create mode 100644 docs/specs/ppc-spapr-xive.rst
>  create mode 100644 docs/specs/ppc-xive.rst
>=20
> diff --git a/docs/index.rst b/docs/index.rst
> index 3690955dd1f5..baa5791c174b 100644
> --- a/docs/index.rst
> +++ b/docs/index.rst
> @@ -12,4 +12,5 @@ Welcome to QEMU's documentation!
> =20
>     interop/index
>     devel/index
> +   specs/index
> =20
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> new file mode 100644
> index 000000000000..2e927519c2e7
> --- /dev/null
> +++ b/docs/specs/index.rst
> @@ -0,0 +1,13 @@
> +. This is the top level page for the 'specs' manual
> +
> +
> +QEMU full-system emulation guest hardware specifications
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +
> +Contents:
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   xive
> diff --git a/docs/specs/ppc-spapr-xive.rst b/docs/specs/ppc-spapr-xive.rst
> new file mode 100644
> index 000000000000..279d650737ea
> --- /dev/null
> +++ b/docs/specs/ppc-spapr-xive.rst
> @@ -0,0 +1,174 @@
> +XIVE for sPAPR (pseries machines)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The POWER9 processor comes with a new interrupt controller
> +architecture, called XIVE as "eXternal Interrupt Virtualization
> +Engine". It supports a larger number of interrupt sources and offers
> +virtualization features which enables the HW to deliver interrupts
> +directly to virtual processors without hypervisor assistance.
> +
> +A QEMU ``pseries`` machine (which is PAPR compliant) using POWER9
> +processors can run under two interrupt modes:
> +
> +- *Legacy Compatibility Mode*
> +
> +  the hypervisor provides identical interfaces and similar
> +  functionality to PAPR+ Version 2.7.  This is the default mode
> +
> +  It is also referred as *XICS* in QEMU.
> +
> +- *XIVE native exploitation mode*
> +
> +  the hypervisor provides new interfaces to manage the XIVE control
> +  structures, and provides direct control for interrupt management
> +  through MMIO pages.
> +
> +Which interrupt modes can be used by the machine is negotiated with
> +the guest O/S during the Client Architecture Support negotiation
> +sequence. The two modes are mutually exclusive.
> +
> +Both interrupt mode share the same IRQ number space. See below for the
> +layout.
> +
> +CAS Negotiation
> +---------------
> +
> +QEMU advertises the supported interrupt modes in the device tree
> +property "ibm,arch-vec-5-platform-support" in byte 23 and the OS
> +Selection for XIVE is indicated in the "ibm,architecture-vec-5"
> +property byte 23.
> +
> +The interrupt modes supported by the machine depend on the CPU type
> +(POWER9 is required for XIVE) but also on the machine property
> +``ic-mode`` which can be set on the command line. It can take the
> +following values: ``xics``, ``xive``, ``dual`` andd currently ``xics``



s/andd/and




> +is the default but it may change in the future.
> +
> +The choosen interrupt mode is activated after a reconfiguration done
> +in a machine reset.
> +
> +XIVE Device tree properties
> +---------------------------
> +
> +The properties for the PAPR interrupt controller node when the *XIVE
> +native exploitation mode* is selected shoud contain:
> +
> +- ``device_type``
> +
> +  value should be "power-ivpe".
> +
> +- ``compatible``
> +
> +  value should be "ibm,power-ivpe".
> +
> +- ``reg``
> +
> +  contains the base address and size of the thread interrupt
> +  managnement areas (TIMA), for the User level and for the Guest OS
> +  level. Only the Guest OS level is taken into account today.
> +
> +- ``ibm,xive-eq-sizes``
> +
> +  the size of the event queues. One cell per size supported, contains
> +  log2 of size, in ascending order.
> +
> +- ``ibm,xive-lisn-ranges``
> +
> +  the IRQ interrupt number ranges assigned to the guest for the IPIs.
> +
> +The root node also exports :
> +
> +- ``ibm,plat-res-int-priorities``
> +
> +  contains a list of priorities that the hypervisor has reserved for
> +  its own use.
> +
> +IRQ number space
> +----------------
> +
> +IRQ Number space of the ``pseries`` machine is 8K wide and is the same
> +for both interrupt mode. The different ranges are defined as follow :
> +
> +- ``0x0000 .. 0x0FFF`` 4K CPU IPIs (only used under XIVE)
> +- ``0x1000 .. 0x1000`` 1 EPOW
> +- ``0x1001 .. 0x1001`` 1 HOTPLUG
> +- ``0x1100 .. 0x11FF`` 256 VIO devices
> +- ``0x1200 .. 0x127F`` 32 PHBs devices
> +- ``0x1280 .. 0x12FF`` unused
> +- ``0x1300 .. 0x1FFF`` PHB MSIs
> +
> +Monitoring XIVE
> +---------------
> +
> +The state of the XIVE interrupt controller can be queried through the
> +monitor commands ``info pic``. The output comes in two parts.
> +
> +First, the state of the thread interrupt context registers is dumped
> +for each CPU :
> +
> +::
> +
> +   (qemu) info pic
> +   CPU[0000]:   QW   NSR CPPR IPB LSMFB ACK# INC AGE PIPR  W2
> +   CPU[0000]: USER    00   00  00    00   00  00  00   00  00000000
> +   CPU[0000]:   OS    00   ff  00    00   ff  00  ff   ff  80000400
> +   CPU[0000]: POOL    00   00  00    00   00  00  00   00  00000000
> +   CPU[0000]: PHYS    00   00  00    00   00  00  00   ff  00000000
> +   ...
> +
> +In the case of a ``pseries`` machine, QEMU acts as the hypervisor and on=
ly
> +the O/S and USER register rings make sense. ``W2`` contains the vCPU CAM
> +line which is set to the VP identifier.
> +
> +Then comes the routing information which aggregates the EAS and the
> +END configuration:
> +
> +::
> +
> +   ...
> +   LISN         PQ    EISN     CPU/PRIO EQ
> +   00000000 MSI --    00000010   0/6    380/16384 @1fe3e0000 ^1 [ 800000=
10 ... ]
> +   00000001 MSI --    00000010   1/6    305/16384 @1fc230000 ^1 [ 800000=
10 ... ]
> +   00000002 MSI --    00000010   2/6    220/16384 @1fc2f0000 ^1 [ 800000=
10 ... ]
> +   00000003 MSI --    00000010   3/6    201/16384 @1fc390000 ^1 [ 800000=
10 ... ]
> +   00000004 MSI -Q  M 00000000
> +   00000005 MSI -Q  M 00000000
> +   00000006 MSI -Q  M 00000000
> +   00000007 MSI -Q  M 00000000
> +   00001000 MSI --    00000012   0/6    380/16384 @1fe3e0000 ^1 [ 800000=
10 ... ]
> +   00001001 MSI --    00000013   0/6    380/16384 @1fe3e0000 ^1 [ 800000=
10 ... ]
> +   00001100 MSI --    00000100   1/6    305/16384 @1fc230000 ^1 [ 800000=
10 ... ]
> +   00001101 MSI -Q  M 00000000
> +   00001200 LSI -Q  M 00000000
> +   00001201 LSI -Q  M 00000000
> +   00001202 LSI -Q  M 00000000
> +   00001203 LSI -Q  M 00000000
> +   00001300 MSI --    00000102   1/6    305/16384 @1fc230000 ^1 [ 800000=
10 ... ]
> +   00001301 MSI --    00000103   2/6    220/16384 @1fc2f0000 ^1 [ 800000=
10 ... ]
> +   00001302 MSI --    00000104   3/6    201/16384 @1fc390000 ^1 [ 800000=
10 ... ]
> +
> +The source information and configuration:
> +
> +- The ``LISN`` column outputs the interrupt number of the source in
> +  range ``[ 0x0 ... 0x1FFF ]`` and its type : ``MSI`` or ``LSI``
> +- The ``PQ`` column reflects the state of the PQ bits of the source :
> +
> +  - ``--`` source is ready to take events
> +  - ``P-`` an event was sent and an EOI is PENDING
> +  - ``PQ`` an event was QUEUED
> +  - ``-Q`` source is OFF
> +
> +  a ``M`` indicates that source is *MASKED* at the EAS level,
> +
> +The targeting configuration :
> +
> +- The ``EISN`` column is the event data what will be queued in the event



s/what/that



> +  queue of the O/S.
> +- The ``CPU/PRIO`` column is the tuple defining the CPU number and
> +  priority queue serving the source.
> +- The ``EQ`` column outputs :
> +
> +  - the current index of the event queue/ the max number of entries
> +  - the O/S event queue address
> +  - the toggle bit
> +  - the last entries that were pushed in the event queue.
> diff --git a/docs/specs/ppc-xive.rst b/docs/specs/ppc-xive.rst
> new file mode 100644
> index 000000000000..b997dc062910
> --- /dev/null
> +++ b/docs/specs/ppc-xive.rst
> @@ -0,0 +1,199 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +POWER9 XIVE interrupt controller
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The POWER9 processor comes with a new interrupt controller
> +architecture, called XIVE as "eXternal Interrupt Virtualization
> +Engine".
> +
> +Compared to the previous architecture, the main characteristics of
> +XIVE are to support a larger number of interrupt sources and to
> +deliver interrupts directly to virtual processors without hypervisor
> +assistance. This removes the context switches required for the
> +delivery process.
> +
> +
> +XIVE architecture
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The XIVE IC is composed of three sub-engines, each taking care of a
> +processing layer of external interrupts:
> +
> +- Interrupt Virtualization Source Engine (IVSE), or Source Controller
> +  (SC). These are found in PCI PHBs, in the PSI host bridge
> +  controller, but also inside the main controller for the core IPIs
> +  and other sub-chips (NX, CAP, NPU) of the chip/processor. They are
> +  configured to feed the IVRE with events.
> +- Interrupt Virtualization Routing Engine (IVRE) or Virtualization
> +  Controller (VC). It handles event coalescing and perform interrupt
> +  routing by matching an event source number with an Event
> +  Notification Descriptor (END).
> +- Interrupt Virtualization Presentation Engine (IVPE) or Presentation
> +  Controller (PC). It maintains the interrupt context state of each
> +  thread and handles the delivery of the external interrupt to the
> +  thread.
> +
> +::
> +
> +                XIVE Interrupt Controller
> +                +------------------------------------+      IPIs
> +                | +---------+ +---------+ +--------+ |    +-------+
> +                | |IVRE     | |Common Q | |IVPE    |----> | CORES |
> +                | |     esb | |         | |        |----> |       |
> +                | |     eas | |  Bridge | |   tctx |----> |       |
> +                | |SC   end | |         | |    nvt | |    |       |
> +    +------+    | +---------+ +----+----+ +--------+ |    +-+-+-+-+
> +    | RAM  |    +------------------|-----------------+      | | |
> +    |      |                       |                        | | |
> +    |      |                       |                        | | |
> +    |      |  +--------------------v------------------------v-v-v--+    =
other
> +    |      <--+                     Power Bus                      +--> =
chips
> +    |  esb |  +---------+-----------------------+------------------+
> +    |  eas |            |                       |
> +    |  end |         +--|------+                |
> +    |  nvt |       +----+----+ |           +----+----+
> +    +------+       |IVSE     | |           |IVSE     |
> +                   |         | |           |         |
> +                   | PQ-bits | |           | PQ-bits |
> +                   | local   |-+           |  in VC  |
> +                   +---------+             +---------+
> +                      PCIe                 NX,NPU,CAPI
> +
> +
> +    PQ-bits: 2 bits source state machine (P:pending Q:queued)
> +    esb: Event State Buffer (Array of PQ bits in an IVSE)
> +    eas: Event Assignment Structure
> +    end: Event Notification Descriptor
> +    nvt: Notification Virtual Target
> +    tctx: Thread interrupt Context registers
> +
> +
> +
> +XIVE internal tables
> +--------------------
> +
> +Each of the sub-engines uses a set of tables to redirect interrupts
> +from event sources to CPU threads.
> +
> +::
> +
> +                                            +-------+
> +    User or O/S                             |  EQ   |
> +        or                          +------>|entries|
> +    Hypervisor                      |       |  ..   |
> +      Memory                        |       +-------+
> +                                    |           ^
> +                                    |           |
> +               +-------------------------------------------------+
> +                                    |           |
> +    Hypervisor      +------+    +---+--+    +---+--+   +------+
> +      Memory        | ESB  |    | EAT  |    | ENDT |   | NVTT |
> +     (skiboot)      +----+-+    +----+-+    +----+-+   +------+
> +                      ^  |        ^  |        ^  |       ^
> +                      |  |        |  |        |  |       |
> +               +-------------------------------------------------+
> +                      |  |        |  |        |  |       |
> +                      |  |        |  |        |  |       |
> +                 +----|--|--------|--|--------|--|-+   +-|-----+    +---=
---+
> +                 |    |  |        |  |        |  | |   | | tctx|    |Thr=
ead|
> +     IPI or   ---+    +  v        +  v        +  v |---| +  .. |----->  =
   |
> +    HW events    |                                 |   |       |    |   =
   |
> +                 |             IVRE                |   | IVPE  |    +---=
---+
> +                 +---------------------------------+   +-------+
> +
> +
> +The IVSE have a 2-bits state machine, P for pending and Q for queued,
> +for each source that allows events to be triggered. They are stored in
> +an Event State Buffer (ESB) array and can be controlled by MMIOs.
> +
> +If the event is let through, the IVRE looks up in the Event Assignment
> +Structure (EAS) table for an Event Notification Descriptor (END)
> +configured for the source. Each Event Notification Descriptor defines
> +a notification path to a CPU and an in-memory Event Queue, in which
> +will be enqueued an EQ data for the O/S to pull.
> +
> +The IVPE determines if a Notification Virtual Target (NVT) can handle
> +the event by scanning the thread contexts of the VCPUs dispatched on
> +the processor HW threads. It maintains the interrupt context state of
> +each thread in a NVT table.
> +
> +XIVE thread interrupt context
> +-----------------------------
> +
> +The XIVE presenter can generate four different exceptions to its
> +HW threads:
> +
> +- hypervisor exception
> +- O/S exception
> +- Event-Based Branch (user level)
> +- msgsnd (doorbell)
> +
> +Each exception has a state independent from the others called a Thread
> +Interrupt Management context. This context is a set of registers which
> +lets the thread handle priority management and interrupt
> +acknowledgment among other things. The most important ones being :
> +
> +- Interrupt Priority Register  (PIPR)
> +- Interrupt Pending Buffer     (IPB)
> +- Current Processor Priority   (CPPR)
> +- Notification Source Register (NSR)
> +
> +TIMA
> +~~~~
> +
> +The Thread Interrupt Management registers are accessible through a
> +specific MMIO region, called the Thread Interrupt Management Area
> +(TIMA), four aligned pages, each exposing a different view of the
> +registers. First page (page address ending in ``0b00``) gives access
> +to the entire context and is reserved for the ring 0 view for the
> +physical thread context. The second (page address ending in ``0b01``)
> +is for the hypervisor, ring 1 view. The third (page address ending in
> +``0b10``) is for the operating system, ring 2 view. The fourth (page
> +address ending in ``0b11``) is for user level, ring 3 view.
> +
> +Interrupt flow from an O/S perspective
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +After an event data has been enqueued in the O/S Event Queue, the IVPE
> +raises the bit corresponding to the priority of the pending interrupt
> +in the register IBP (Interrupt Pending Buffer) to indicate that an
> +event is pending in one of the 8 priority queues. The Pending
> +Interrupt Priority Register (PIPR) is also updated using the IPB. This
> +register represent the priority of the most favored pending
> +notification.
> +
> +The PIPR is then compared to the the Current Processor Priority
> +Register (CPPR). If it is more favored (numerically less than), the
> +CPU interrupt line is raised and the EO bit of the Notification Source
> +Register (NSR) is updated to notify the presence of an exception for
> +the O/S. The O/S acknowledges the interrupt with a special load in the
> +Thread Interrupt Management Area.
> +
> +The O/S handles the interrupt and when done, performs an EOI using a
> +MMIO operation on the ESB management page of the associate source.
> +
> +Overview of the QEMU models for XIVE
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The XiveSource models the IVSE in general, internal and external. It
> +handles the source ESBs and the MMIO interface to control them.
> +
> +The XiveNotifier is a small helper interface interconnecting the
> +XiveSource to the XiveRouter.
> +
> +The XiveRouter is an abstract model acting as a combined IVRE and
> +IVPE. It routes event notifications using the EAS and END tables to
> +the IVPE sub-engine which does a CAM scan to find a CPU to deliver the
> +exception. Storage should be provided by the inheriting classes.
> +
> +XiveEnDSource is a special source object. It exposes the END ESB MMIOs
> +of the Event Queues which are used for coalescing event notifications
> +and for escalation. Not used on the field, only to sync the EQ cache
> +in OPAL.
> +
> +Finally, the XiveTCTX contains the interrupt state context of a thread,
> +four sets of registers, one for each exception that can be delivered
> +to a CPU. These contexts are scanned by the IVPE to find a matching VP
> +when a notification is triggered. It also models the Thread Interrupt
> +Management Area (TIMA), which exposes the thread context registers to
> +the CPU for interrupt management.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a73a61a54654..44d4dd7e20b6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1707,6 +1707,7 @@ L: qemu-ppc@nongnu.org
>  S: Supported
>  F: hw/*/*xive*
>  F: include/hw/*/*xive*
> +F: docs/*/*xive*
> =20
>  Subsystems
>  ----------


