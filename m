Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF33ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B078F20663
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B078F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7Z6-0006rL-OR
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iL6af-000587-5a
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:17:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iL6ad-0003ee-CG
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:17:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31018)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iL6ad-0003dg-3a
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:17:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 78F3818CCEE9;
 Thu, 17 Oct 2019 14:17:17 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0521B60BE1;
 Thu, 17 Oct 2019 14:17:15 +0000 (UTC)
Date: Thu, 17 Oct 2019 16:17:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v12 09/11] hmat acpi: Build System Locality Latency and
 Bandwidth Information Structure(s)
Message-ID: <20191017161714.191e5d48@redhat.com>
In-Reply-To: <2e5b2843-5a82-4152-873a-27f469175c6b@intel.com>
References: <20190920074349.2616-1-tao3.xu@intel.com>
 <20190920074349.2616-10-tao3.xu@intel.com>
 <20191003164111.078fdce4@redhat.com>
 <24a4842c-4ce4-3a7f-5032-8e74458de44c@intel.com>
 <20191011160855.6d13eb69@redhat.com>
 <7f431c7c-b745-3001-d0ba-d94f7230b426@intel.com>
 <20191014110030.79fd2e18@redhat.com>
 <710e65e8-0558-5c16-1e43-c801cf704b3c@intel.com>
 <2e5b2843-5a82-4152-873a-27f469175c6b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 17 Oct 2019 14:17:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, "Williams, Dan
 J" <dan.j.williams@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Oct 2019 13:40:54 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> On 10/15/2019 8:59 AM, Tao Xu wrote:
> > On 10/14/2019 5:00 PM, Igor Mammedov wrote: =20
> >> On Sat, 12 Oct 2019 11:04:03 +0800
> >> Tao Xu <tao3.xu@intel.com> wrote:
> >> =20
> >>> On 10/11/2019 10:08 PM, Igor Mammedov wrote: =20
> >>>> On Thu, 10 Oct 2019 14:53:56 +0800
> >>>> Tao Xu <tao3.xu@intel.com> wrote: =20
> >>>>> On 10/3/2019 10:41 PM, Igor Mammedov wrote: =20
> >>>>>> On Fri, 20 Sep 2019 15:43:47 +0800
> >>>>>> Tao Xu <tao3.xu@intel.com> wrote: =20
> >>>>>>> From: Liu Jingqi <jingqi.liu@intel.com>
> >>>>>>>
> >>>>>>> This structure describes the memory access latency and bandwidth
> >>>>>>> information from various memory access initiator proximity domain=
s.
> >>>>>>> The latency and bandwidth numbers represented in this structure
> >>>>>>> correspond to rated latency and bandwidth for the platform.
> >>>>>>> The software could use this information as hint for optimization.
> >>>>>>>
> >>>>>>> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> >>>>>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> >>>>>>> ---
> >>>>>>>
> >>>>>>> Changes in v12:
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Fix a bug that if HMAT is =
enabled and without hmat-lb=20
> >>>>>>> setting,
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMU will crash.=
 (reported by Danmei Wei)
> >>>>>>>
> >>>>>>> Changes in v11:
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Calculate base in build_hm=
at_lb().
> >>>>>>> ---
> >>>>>>> =C2=A0=C2=A0=C2=A0 hw/acpi/hmat.c | 126=20
> >>>>>>> ++++++++++++++++++++++++++++++++++++++++++++++++-
> >>>>>>> =C2=A0=C2=A0=C2=A0 hw/acpi/hmat.h |=C2=A0=C2=A0 2 +
> >>>>>>> =C2=A0=C2=A0=C2=A0 2 files changed, 127 insertions(+), 1 deletion=
(-)
> >>>>>>>
> >>>>>>> diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
> >>>>>>> index 1368fce7ee..e7be849581 100644
> >>>>>>> --- a/hw/acpi/hmat.c
> >>>>>>> +++ b/hw/acpi/hmat.c
> >>>>>>> @@ -27,6 +27,7 @@
> >>>>>>> =C2=A0=C2=A0=C2=A0 #include "qemu/osdep.h"
> >>>>>>> =C2=A0=C2=A0=C2=A0 #include "sysemu/numa.h"
> >>>>>>> =C2=A0=C2=A0=C2=A0 #include "hw/acpi/hmat.h"
> >>>>>>> +#include "qemu/error-report.h"
> >>>>>>> =C2=A0=C2=A0=C2=A0 /*
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 * ACPI 6.3:
> >>>>>>> @@ -67,11 +68,105 @@ static void build_hmat_mpda(GArray=20
> >>>>>>> *table_data, uint16_t flags, int initiator,
> >>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build_append_int_nopre=
fix(table_data, 0, 8);
> >>>>>>> =C2=A0=C2=A0=C2=A0 }
> >>>>>>> +static bool entry_overflow(uint64_t *lb_data, uint64_t base, int=
=20
> >>>>>>> len)
> >>>>>>> +{
> >>>>>>> +=C2=A0=C2=A0=C2=A0 int i;
> >>>>>>> +
> >>>>>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < len; i++) {
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (lb_data[i] / base=
 >=3D UINT16_MAX) {
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return true;
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>>>>> +=C2=A0=C2=A0=C2=A0 }
> >>>>>>> +
> >>>>>>> +=C2=A0=C2=A0=C2=A0 return false;
> >>>>>>> +} =20
> >>>>>> I suggest to do this check at CLI parsing time =20
> >>>>>>> +/*
> >>>>>>> + * ACPI 6.3: 5.2.27.4 System Locality Latency and Bandwidth=20
> >>>>>>> Information
> >>>>>>> + * Structure: Table 5-146
> >>>>>>> + */
> >>>>>>> +static void build_hmat_lb(GArray *table_data, HMAT_LB_Info=20
> >>>>>>> *hmat_lb,
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 uint32_t num_initiator, uint32_t=20
> >>>>>>> num_target,
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 uint32_t *initiator_list, int type)
> >>>>>>> +{
> >>>>>>> +=C2=A0=C2=A0=C2=A0 uint8_t mask =3D 0x0f;
> >>>>>>> +=C2=A0=C2=A0=C2=A0 uint32_t s =3D num_initiator;
> >>>>>>> +=C2=A0=C2=A0=C2=A0 uint32_t t =3D num_target; =20
> >>>>>> drop this locals and use arguments directly =20
> >>>>>>> +=C2=A0=C2=A0=C2=A0 uint64_t base =3D 1;
> >>>>>>> +=C2=A0=C2=A0=C2=A0 uint64_t *lb_data;
> >>>>>>> +=C2=A0=C2=A0=C2=A0 int i, unit;
> >>>>>>> +
> >>>>>>> +=C2=A0=C2=A0=C2=A0 /* Type */
> >>>>>>> +=C2=A0=C2=A0=C2=A0 build_append_int_noprefix(table_data, 1, 2);
> >>>>>>> +=C2=A0=C2=A0=C2=A0 /* Reserved */
> >>>>>>> +=C2=A0=C2=A0=C2=A0 build_append_int_noprefix(table_data, 0, 2);
> >>>>>>> +=C2=A0=C2=A0=C2=A0 /* Length */
> >>>>>>> +=C2=A0=C2=A0=C2=A0 build_append_int_noprefix(table_data, 32 + 4 =
* s + 4 * t + 2=20
> >>>>>>> * s * t, 4); =20
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^
> >>>>>> to me above looks like /dev/random output, absolutely unreadable.
> >>>>>> Suggest to use local var (like: lb_length) for expression with=20
> >>>>>> comments
> >>>>>> beside magic numbers. =20
> >>>>>>> +=C2=A0=C2=A0=C2=A0 /* Flags: Bits [3:0] Memory Hierarchy, Bits[7=
:4] Reserved */
> >>>>>>> +=C2=A0=C2=A0=C2=A0 build_append_int_noprefix(table_data, hmat_lb=
->hierarchy &=20
> >>>>>>> mask, 1); =20
> >>>>>>
> >>>>>> why do you need to use mask here? =20
> >>>>> Because Bits[7:4] Reserved, so I use mask to keep it reserved. =20
> >>>>
> >>>> these bits are not user provided and set to 0, if they get set it's
> >>>> programming error and instead of masking problem out QEMU should abo=
rt,
> >>>> I suggest replace masking with assert(!foo>>x). =20
> >>>>>>> +=C2=A0=C2=A0=C2=A0 /* Data Type */
> >>>>>>> +=C2=A0=C2=A0=C2=A0 build_append_int_noprefix(table_data, hmat_lb=
->data_type, 1); =20
> >>>>>>
> >>>>>> Isn't hmat_lb->data_type and passed argument 'type' the same? =20
> >>>>> Yes, I will drop 'type'. =20
> >>>>>>> +=C2=A0=C2=A0=C2=A0 /* Reserved */
> >>>>>>> +=C2=A0=C2=A0=C2=A0 build_append_int_noprefix(table_data, 0, 2);
> >>>>>>> +=C2=A0=C2=A0=C2=A0 /* Number of Initiator Proximity Domains (s) =
*/
> >>>>>>> +=C2=A0=C2=A0=C2=A0 build_append_int_noprefix(table_data, s, 4);
> >>>>>>> +=C2=A0=C2=A0=C2=A0 /* Number of Target Proximity Domains (t) */
> >>>>>>> +=C2=A0=C2=A0=C2=A0 build_append_int_noprefix(table_data, t, 4);
> >>>>>>> +=C2=A0=C2=A0=C2=A0 /* Reserved */
> >>>>>>> +=C2=A0=C2=A0=C2=A0 build_append_int_noprefix(table_data, 0, 4);
> >>>>>>> +
> >>>>>>> +=C2=A0=C2=A0=C2=A0 if (HMAT_IS_LATENCY(type)) {
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unit =3D 1000;
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lb_data =3D hmat_lb->=
latency;
> >>>>>>> +=C2=A0=C2=A0=C2=A0 } else {
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unit =3D 1024;
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lb_data =3D hmat_lb->=
bandwidth;
> >>>>>>> +=C2=A0=C2=A0=C2=A0 }
> >>>>>>> +
> >>>>>>> +=C2=A0=C2=A0=C2=A0 while (entry_overflow(lb_data, base, s * t)) {
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < s *=
 t; i++) {
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (!QEMU_IS_ALIGNED(lb_data[i], unit * base)) {
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Invalid latency/bandwidth input,=
=20
> >>>>>>> all "
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "latencies/bandwidths should be specified in th=
e=20
> >>>>>>> same units.");
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base *=3D unit;
> >>>>>>> +=C2=A0=C2=A0=C2=A0 } =20
> >>>>>> Can you clarify what you are trying to check here? =20
> >>>>> This part I use entry_overflow() to check if uint16 can store=20
> >>>>> entry. If
> >>>>> can't store and the entries matrix can be divisible by unit * base,=
=20
> >>>>> then
> >>>>> base will be unit * base.
> >>>>>
> >>>>> For example, if lb_data[i] are 1048576(1TB/s) and 1024(1GB/s), unit=
 is
> >>>>> 1024, so 1048576 is bigger than UINT16_MAX, and can be divisible by=
=20
> >>>>> 1024
> >>>>> * 1, so base is 1024 and entries are 1024 and 1 (see entry =3D
> >>>>> hmat_lb->latency[i] / base;). The benefit is even user input differ=
ent
> >>>>> unit(TB/s vs GB/s), we can still store the data as far as possible.=
 =20
> >>>>
> >>>> Is it possible instead of doing multiple iterations over lb_data
> >>>> until it finds valid base, just go over lb_data once to find MIN/MAX
> >>>> and then calculate base using it. Error out with max/min offending
> >>>> values if it's not possible to compress the range into uint16_t? =20
> >>>
> >>> Although we tell user input same unit data, such as use 1GB/s 3GB/s. =
If
> >>> user input data such as 1048575, 1048576(1TB/s) and 1024(1GB/s), then=
 we
> >>> will get 1024 * (1023 1024 1). I am wondering if it is appropriate
> >>> because we lose a float number(0.999020). But in our codes, it will
> >>> raise error. =20
> >> I do not understand what you are trying to say here, could you rephrase
> >> it, so the problem would be more clear, please?
> >> =20
> > Sorry, I mean how we treat the data cannot be divisible if we use=20
> > max/min as base. For another example, If user input the data(including =
3=20
> > bandwidths) : 9GB/s 5GB/s 3GB/s. Then max/min result is 3. But entries=
=20
> > should be uint16, (5GB/s)/3 we can only get 1GB/s, then we should raise=
=20
> > error(overflow).
> > But if this patch, we will get the base is 1GB/s. =20
> I understand the MIN/MAX means, in the case above, we get MAX is 9GB/s,=20
> MIN is 3GB/s, then I use code below to calculate :
>=20
>      while (max_data >=3D UINT16_MAX) {
>          if (!QEMU_IS_ALIGNED(max_data, unit * base) ||
>              !QEMU_IS_ALIGNED(min_data, unit * base) {
>                  error_report("Invalid latency/bandwidth input.");
>                  exit(1);
>          }
>          base *=3D unit;
>      }
this check won't cover, entries in between min and max.
Maybe using range bitmap the time of parsing bandwidth/latency CLI option
would work:

   parse_numa_hmat_lb(...) {
      ...
      if (bw && !ALIGNED(value, 1MB))
          error fatal("should be 1MB aligned")

      sub_table->range_bitmap |=3D value;

      last_bit =3D find_last_bit(sub_table->range_bitmap)
      first_bit =3D find_first_bit(sub_table->range_bitmap)
      if ((last_bit - first_bit) > UINT16_BITS)
          error_fatal("value (%d) should not differ from
                      previously entered values on more that UNINT16_MAX")

      sub_table->base =3D bit_2_base(first_bit)
      sub_table[x] =3D value
      ...
   }

it should
  1: error out at the first option which value deviates too
     much from previously parsed options for sub-table
  2: recalculate 'base' value for sub-table

