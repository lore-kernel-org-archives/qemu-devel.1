Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041E9C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:12:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD63E20720
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD63E20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izR1t-0002c9-W9
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 15:12:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1izR1I-0002B0-Nq
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1izR1H-0000ma-H7
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:11:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5069
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1izR1H-0000im-CA
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:11:31 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 015K9lnP113691
 for <qemu-devel@nongnu.org>; Wed, 5 Feb 2020 15:11:29 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2xyhmhkmus-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 15:11:29 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Wed, 5 Feb 2020 20:11:28 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 5 Feb 2020 20:11:25 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 015KBOqs57409676
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Feb 2020 20:11:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D307F5204E;
 Wed,  5 Feb 2020 20:11:24 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.229])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B107052052;
 Wed,  5 Feb 2020 20:11:24 +0000 (GMT)
Date: Wed, 5 Feb 2020 21:11:23 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v4 38/80] s390x/s390-virtio-ccw: use memdev for RAM
In-Reply-To: <1580483390-131164-39-git-send-email-imammedo@redhat.com>
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
 <1580483390-131164-39-git-send-email-imammedo@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 20020520-0016-0000-0000-000002E404BD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020520-0017-0000-0000-00003346E726
Message-Id: <20200205211123.43914b0c.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-05_06:2020-02-04,
 2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002050153
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id 015K9lnP113691
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 31 Jan 2020 16:09:08 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>

Hi Igor!

I gave=20
-object memory-backend-file,id=3Dmem=20
-machine type=3Ds390-ccw-virtio,memory-backend=3Dmem
a spin on s390x. Seems to largely work a expected. So I guess it is:

Tested-by: Halil Pasic <pasic@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>

Thanks!

Halil

> ---
> CC: pasic@linux.ibm.com
> ---
>  hw/s390x/s390-virtio-ccw.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index e759eb5..a89cf4c 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -154,14 +154,12 @@ static void virtio_ccw_register_hcalls(void)
>                                     virtio_ccw_hcall_early_printk);
>  }
> =20
> -static void s390_memory_init(ram_addr_t mem_size)
> +static void s390_memory_init(MemoryRegion *ram)
>  {
>      MemoryRegion *sysmem =3D get_system_memory();
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>      Error *local_err =3D NULL;
> =20
>      /* allocate RAM for core */
> -    memory_region_allocate_system_memory(ram, NULL, "s390.ram", mem_si=
ze);
>      memory_region_add_subregion(sysmem, 0, ram);
> =20
>      /*
> @@ -245,7 +243,7 @@ static void ccw_init(MachineState *machine)
> =20
>      s390_sclp_init();
>      /* init memory + setup max page size. Required for the CPU model *=
/
> -    s390_memory_init(machine->ram_size);
> +    s390_memory_init(machine->ram);
> =20
>      /* init CPUs (incl. CPU model) early so s390_has_feature() works *=
/
>      s390_init_cpus(machine);
> @@ -471,6 +469,7 @@ static void ccw_machine_class_init(ObjectClass *oc,=
 void *data)
>      hc->plug =3D s390_machine_device_plug;
>      hc->unplug_request =3D s390_machine_device_unplug_request;
>      nc->nmi_monitor_handler =3D s390_nmi;
> +    mc->default_ram_id =3D "s390.ram";
>  }
> =20
>  static inline bool machine_get_aes_key_wrap(Object *obj, Error **errp)


