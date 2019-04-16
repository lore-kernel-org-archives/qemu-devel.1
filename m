Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48F5C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 11:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AAE32073F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 11:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AAE32073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34777 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGLrN-0006b8-Is
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 07:02:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hGLpz-0005wp-Rs
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 07:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hGLpy-00052k-GN
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 07:01:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hGLpy-00051q-5Y
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 07:01:14 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3GB087U030908
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 07:01:10 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rwcb53thq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 07:01:09 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 16 Apr 2019 12:01:06 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 16 Apr 2019 12:01:03 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
	(b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3GB12Wm55115872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Tue, 16 Apr 2019 11:01:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A2FAA406E;
	Tue, 16 Apr 2019 11:01:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0D07A4065;
	Tue, 16 Apr 2019 11:01:01 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.131])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 16 Apr 2019 11:01:01 +0000 (GMT)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
	<1555334842-195718-6-git-send-email-imammedo@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
	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
	syiRa+UVlsKmx1hsEg==
Date: Tue, 16 Apr 2019 13:01:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555334842-195718-6-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041611-0020-0000-0000-0000033060A7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041611-0021-0000-0000-00002182A452
Message-Id: <43f77950-019d-f06f-bfbc-4daa831430e3@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-16_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	suspectscore=2 malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904160074
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH v1 5/5] s390: do not call
 memory_region_allocate_system_memory() multiple times
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
Cc: qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
	Helge Deller <deller@gmx.de>, Cornelia Huck <cohuck@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
	=?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416110101.SzimnSLDiP97D87OgjsMGxDLeSPNGKqnHwUo-EB39sU@z>

This crashes

a simple -kernel -initrd example on s390x.

#0  0x000003ff94e3e47c in __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
#1  0x000003ff94e23d18 in __GI_abort () at abort.c:79
#2  0x000003ff94e365e6 in __assert_fail_base
    (fmt=0x3ff94f60ca6 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=assertion@entry=0x14aac70 "new_block", file=file@entry=0x13b1168 "/home/cborntra/REPOS/qemu/exec.c", line=line@entry=2041, function=function@entry=0x13b0c8a <__PRETTY_FUNCTION__.34656> "qemu_ram_set_idstr") at assert.c:92
#3  0x000003ff94e36664 in __GI___assert_fail
    (assertion=assertion@entry=0x14aac70 "new_block", file=file@entry=0x13b1168 "/home/cborntra/REPOS/qemu/exec.c", line=line@entry=2041, function=function@entry=0x13b0c8a <__PRETTY_FUNCTION__.34656> "qemu_ram_set_idstr") at assert.c:101
#4  0x000000000102e062 in qemu_ram_set_idstr (new_block=new_block@entry=0x0, name=<optimized out>, dev=dev@entry=0x0) at /home/cborntra/REPOS/qemu/exec.c:2041
#5  0x00000000011f5b0a in vmstate_register_ram (mr=0x2cd2dd0, mr@entry=<error reading variable: value has been optimized out>, dev=dev@entry=0x0) at /home/cborntra/REPOS/qemu/migration/savevm.c:2828
#6  0x00000000011f5b5a in vmstate_register_ram_global (mr=<error reading variable: value has been optimized out>) at /home/cborntra/REPOS/qemu/migration/savevm.c:2841
#7  0x000000000110d2ce in s390_memory_init (mem_size=<optimized out>) at /home/cborntra/REPOS/qemu/hw/s390x/s390-virtio-ccw.c:186
#8  0x000000000110d2ce in ccw_init (machine=0x2a96770) at /home/cborntra/REPOS/qemu/hw/s390x/s390-virtio-ccw.c:266
#9  0x00000000011b342c in machine_run_board_init (machine=0x2a96770) at /home/cborntra/REPOS/qemu/hw/core/machine.c:1030
#10 0x0000000001026fee in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at /home/cborntra/REPOS/qemu/vl.c:4479



On 15.04.19 15:27, Igor Mammedov wrote:
> s390 was trying to solve limited memslot size issue by abusing
> memory_region_allocate_system_memory(), which breaks API contract
> where the function might be called only once.
> 
> s390 should have used memory aliases to fragment inital memory into
> smaller chunks to satisfy KVM's memslot limitation. But its a bit
> late now, since allocated pieces are transfered in migration stream
> separately, so it's not possible to just replace broken layout with
> correct one. Previous patch made MemoryRegion alases migratable and
> this patch switches to use them to split big initial RAM chunk into
> smaller pieces up to KVM_SLOT_MAX_BYTES each and registers aliases
> for migration.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> A don't have access to a suitable system to test it, so I've simulated
> it with smaller chunks on x84 host. Ping-pong migration between old
> and new QEMU worked fine.  KVM part should be fine as memslots
> using mapped MemoryRegions (in this case it would be aliases) as
> far as I know but is someone could test it on big enough host it
> would be nice.
> ---
>  hw/s390x/s390-virtio-ccw.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index d11069b..12ca3a9 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -161,20 +161,30 @@ static void virtio_ccw_register_hcalls(void)
>  static void s390_memory_init(ram_addr_t mem_size)
>  {
>      MemoryRegion *sysmem = get_system_memory();
> +    MemoryRegion *ram = g_new(MemoryRegion, 1);
>      ram_addr_t chunk, offset = 0;
>      unsigned int number = 0;
>      gchar *name;
>  
>      /* allocate RAM for core */
> +    memory_region_allocate_system_memory(ram, NULL, "s390.whole.ram", mem_size);
> +    /*
> +     * memory_region_allocate_system_memory() registers allocated RAM for
> +     * migration, however for compat reasons the RAM should be passed over
> +     * as RAMBlocks of the size upto KVM_SLOT_MAX_BYTES. So unregister just
> +     * allocated RAM so it won't be migrated directly. Aliases will take
> +     * of segmenting RAM into legacy chunks.
> +     */
> +    vmstate_unregister_ram(ram, NULL);
>      name = g_strdup_printf("s390.ram");
>      while (mem_size) {
> -        MemoryRegion *ram = g_new(MemoryRegion, 1);
> -        uint64_t size = mem_size;
> +        MemoryRegion *alias = g_new(MemoryRegion, 1);
>  
>          /* KVM does not allow memslots >= 8 TB */
> -        chunk = MIN(size, KVM_SLOT_MAX_BYTES);
> -        memory_region_allocate_system_memory(ram, NULL, name, chunk);
> -        memory_region_add_subregion(sysmem, offset, ram);
> +        chunk = MIN(mem_size, KVM_SLOT_MAX_BYTES);
> +        memory_region_init_alias(alias, NULL, name, ram, offset, chunk);
> +        vmstate_register_ram_global(alias);
> +        memory_region_add_subregion(sysmem, offset, alias);
>          mem_size -= chunk;
>          offset += chunk;
>          g_free(name);
> 


