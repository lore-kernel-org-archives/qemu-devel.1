Received: from eggs.gnu.org ([209.51.188.92]:58103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghU7Q-0000uj-SU
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 01:47:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghU7P-0004me-DK
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 01:47:08 -0500
References: <1547051976-13982-1-git-send-email-thuth@redhat.com>
	<1547051976-13982-2-git-send-email-thuth@redhat.com>
	<3316bf08-36c0-c3ce-4e4f-8244276c58d3@kaod.org>
	<20190109172801.GB3998@redhat.com>
	<ab4e0a6a-3a9f-8f27-a86e-e283bb737cf7@kaod.org>
	<20190109184745.1e61b5bf@bahia.lan>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b2b594e2-0b4f-4e7e-f1f2-022b0a4ea8b1@redhat.com>
Date: Thu, 10 Jan 2019 07:47:02 +0100
MIME-Version: 1.0
In-Reply-To: <20190109184745.1e61b5bf@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/2] include/hw/ppc: Fix
 compilation with clang -std=gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>

On 2019-01-09 18:47, Greg Kurz wrote:
> On Wed, 9 Jan 2019 18:40:48 +0100
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> On 1/9/19 6:28 PM, Daniel P. Berrang=C3=A9 wrote:
>>> On Wed, Jan 09, 2019 at 06:13:01PM +0100, C=C3=A9dric Le Goater wrote=
: =20
>>>> On 1/9/19 5:39 PM, Thomas Huth wrote: =20
>>>>> When compiling with Clang and -std=3Dgnu99, I get the following err=
ors:
>>>>>
>>>>>   CC      ppc64-softmmu/hw/intc/xics_spapr.o
>>>>> In file included from hw/intc/xics_spapr.c:34:
>>>>> include/hw/ppc/xics.h:46:25: error: redefinition of typedef 'ICSSta=
te' is a C11 feature
>>>>>       [-Werror,-Wtypedef-redefinition]
>>>>> typedef struct ICSState ICSState;
>>>>>                         ^
>>>>> include/hw/ppc/spapr.h:18:25: note: previous definition is here
>>>>> typedef struct ICSState ICSState;
>>>>>                         ^
>>>>> In file included from hw/intc/xics_spapr.c:34:
>>>>> include/hw/ppc/xics.h:203:34: error: redefinition of typedef 'sPAPR=
MachineState' is a C11 feature
>>>>>       [-Werror,-Wtypedef-redefinition]
>>>>> typedef struct sPAPRMachineState sPAPRMachineState;
>>>>>                                  ^
>>>>> include/hw/ppc/spapr_irq.h:25:34: note: previous definition is here
>>>>> typedef struct sPAPRMachineState sPAPRMachineState;
>>>>>                                  ^
>>>>>   CC      ppc64-softmmu/hw/intc/spapr_xive.o
>>>>> In file included from hw/intc/spapr_xive.c:19:
>>>>> include/hw/ppc/spapr_xive.h:38:3: error: redefinition of typedef 's=
PAPRXive' is a C11 feature
>>>>>       [-Werror,-Wtypedef-redefinition]
>>>>> } sPAPRXive;
>>>>>   ^
>>>>> include/hw/ppc/spapr.h:20:26: note: previous definition is here
>>>>> typedef struct sPAPRXive sPAPRXive;
>>>>>                          ^
>>>>> In file included from hw/intc/spapr_xive.c:19:
>>>>> include/hw/ppc/spapr_xive.h:45:34: error: redefinition of typedef '=
sPAPRMachineState' is a C11 feature
>>>>>       [-Werror,-Wtypedef-redefinition]
>>>>> typedef struct sPAPRMachineState sPAPRMachineState;
>>>>>                                  ^
>>>>> include/hw/ppc/spapr_irq.h:25:34: note: previous definition is here
>>>>> typedef struct sPAPRMachineState sPAPRMachineState;
>>>>>                                  ^
>>>>>   CC      ppc64-softmmu/hw/char/spapr_vty.o
>>>>> In file included from hw/char/spapr_vty.c:8:
>>>>> In file included from include/hw/ppc/spapr.h:12:
>>>>> include/hw/ppc/spapr_xive.h:45:34: error: redefinition of typedef '=
sPAPRMachineState' is a C11 feature
>>>>>       [-Werror,-Wtypedef-redefinition]
>>>>> typedef struct sPAPRMachineState sPAPRMachineState;
>>>>>                                  ^
>>>>> include/hw/ppc/spapr_irq.h:25:34: note: previous definition is here
>>>>> typedef struct sPAPRMachineState sPAPRMachineState;
>>>>>                                  ^
>>>>>
>>>>> Since we're going to make -std=3Dgnu99 mandatory, fix these issues
>>>>> by including the right header files indead of typedeffing stuff twi=
ce.
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>  include/hw/ppc/spapr.h      | 4 ++--
>>>>>  include/hw/ppc/spapr_xive.h | 2 +-
>>>>>  include/hw/ppc/xics.h       | 4 ++--
>>>>>  3 files changed, 5 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>>>>> index 2c77a8b..6a5ae4f 100644
>>>>> --- a/include/hw/ppc/spapr.h
>>>>> +++ b/include/hw/ppc/spapr.h
>>>>> @@ -8,6 +8,8 @@
>>>>>  #include "hw/mem/pc-dimm.h"
>>>>>  #include "hw/ppc/spapr_ovec.h"
>>>>>  #include "hw/ppc/spapr_irq.h"
>>>>> +#include "hw/ppc/xics.h"
>>>>> +#include "hw/ppc/spapr_xive.h"
>>>>> =20
>>>>>  struct VIOsPAPRBus;
>>>>>  struct sPAPRPHBState;
>>>>> @@ -15,8 +17,6 @@ struct sPAPRNVRAM;
>>>>>  typedef struct sPAPREventLogEntry sPAPREventLogEntry;
>>>>>  typedef struct sPAPREventSource sPAPREventSource;
>>>>>  typedef struct sPAPRPendingHPT sPAPRPendingHPT;
>>>>> -typedef struct ICSState ICSState;
>>>>> -typedef struct sPAPRXive sPAPRXive;
>>>>> =20
>>>>>  #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
>>>>>  #define SPAPR_ENTRY_POINT       0x100
>>>>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xiv=
e.h
>>>>> index 728735d..aff4366 100644
>>>>> --- a/include/hw/ppc/spapr_xive.h
>>>>> +++ b/include/hw/ppc/spapr_xive.h
>>>>> @@ -42,7 +42,7 @@ bool spapr_xive_irq_free(sPAPRXive *xive, uint32_=
t lisn);
>>>>>  void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
>>>>>  qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t lisn);
>>>>> =20
>>>>> -typedef struct sPAPRMachineState sPAPRMachineState;
>>>>> +#include "hw/ppc/spapr.h"  /* for sPAPRMachineState */ =20
>>>>
>>>> so both files include each other, how nice ... =20
>>>
>>> If the header files are mutually dependent it makes me wonder what th=
e
>>> point of having them split up is ? =20
>>
>> The XICS interrupt controller models are used in two different machine=
s,
>> sPAPR and PowerNV.
>>
>>> Feels like either they need to be merged, or they need to be split up
>>> and refactored even more to remove the mutual dependancy. =20
>>
>> yes or that some spapr_* definitions do not belong to the common xics.=
h
>> file.
>=20
> Yeah,
>=20
> These should move to a new xics_spapr.h or maybe even spapr.h for simpl=
icity:
>=20
> void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void =
*fdt,
>                    uint32_t phandle);
> int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
> void xics_spapr_init(sPAPRMachineState *spapr);

Ok, I'll move them to xics_spapr.h.

 Thomas
