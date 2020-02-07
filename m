Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376F3C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BDDC20720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BDDC20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04EK-00052i-65
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jjherne@linux.ibm.com>) id 1j04DL-0003ak-HU
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jjherne@linux.ibm.com>) id 1j04DJ-0001Nc-VB
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:02:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35834
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
 id 1j04DJ-0001Je-OW; Fri, 07 Feb 2020 09:02:33 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 017E0PSO057891; Fri, 7 Feb 2020 09:02:32 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y0p79t87b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Feb 2020 09:02:32 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 017E0jiR059970;
 Fri, 7 Feb 2020 09:02:32 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y0p79t86p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Feb 2020 09:02:32 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 017E19eH029297;
 Fri, 7 Feb 2020 14:02:31 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma03dal.us.ibm.com with ESMTP id 2xykca33u3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Feb 2020 14:02:31 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 017E2Uof43647410
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Feb 2020 14:02:30 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 062B86A04F;
 Fri,  7 Feb 2020 14:02:30 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 632246A05A;
 Fri,  7 Feb 2020 14:02:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.177.182])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri,  7 Feb 2020 14:02:29 +0000 (GMT)
Subject: Re: [PATCH] pc-bios/s390x: Pack ResetInfo struct
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, cohuck@redhat.com
References: <20200205182126.13010-1-jjherne@linux.ibm.com>
 <e3baa1e0-e1d3-d67c-cca9-a626d42c5489@de.ibm.com>
 <896302f7-ec21-6108-6dde-f5a7439d87ab@redhat.com>
 <caefcdbf-e68c-ba05-2ec4-17f127109434@de.ibm.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Organization: IBM
Message-ID: <d9891265-2254-ee64-c009-0105f7a8b02b@linux.ibm.com>
Date: Fri, 7 Feb 2020 09:02:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <caefcdbf-e68c-ba05-2ec4-17f127109434@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-07_01:2020-02-07,
 2020-02-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002070107
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
Reply-To: jjherne@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 6:28 AM, Christian Borntraeger wrote:
> Jason,
> 
> can you run objdump -Sdr on jump2ipl.o on a broken variant?
> 
> 
To keep the volume lower, I've only pasted the output that I think you're interested in. 
If you want to see the entire thing just let me know.

static void jump_to_IPL_2(void)
{
  1d0:	eb bf f0 58 00 24 	stmg	%r11,%r15,88(%r15)
  1d6:	a7 fb ff 50       	aghi	%r15,-176
  1da:	b9 04 00 bf       	lgr	%r11,%r15
     ResetInfo *current = 0;
  1de:	a7 19 00 00       	lghi	%r1,0
  1e2:	e3 10 b0 a8 00 24 	stg	%r1,168(%r11)

     void (*ipl)(void) = (void *) (uint64_t) current->ipl_continue;
  1e8:	e3 10 b0 a8 00 04 	lg	%r1,168(%r11)
  1ee:	58 10 10 08       	l	%r1,8(%r1)
  1f2:	b9 16 00 11       	llgfr	%r1,%r1
  1f6:	e3 10 b0 a0 00 24 	stg	%r1,160(%r11)
     *current = save;
  1fc:	e3 10 b0 a8 00 04 	lg	%r1,168(%r11)
  202:	c0 20 00 00 00 00 	larl	%r2,202 <jump_to_IPL_2+0x32>
			204: R_390_PC32DBL	.bss+0x2
  208:	eb 23 20 00 00 04 	lmg	%r2,%r3,0(%r2)
  20e:	eb 23 10 00 00 24 	stmg	%r2,%r3,0(%r1)
     ipl(); /* should not return */
  214:	e3 10 b0 a0 00 04 	lg	%r1,160(%r11)
  21a:	0d e1             	basr	%r14,%r1
}
  21c:	18 00             	lr	%r0,%r0
  21e:	eb bf b1 08 00 04 	lmg	%r11,%r15,264(%r11)
  224:	07 fe             	br	%r14
  226:	07 07             	nopr	%r7

0000000000000228 <jump_to_IPL_code>:

void jump_to_IPL_code(uint64_t address)
{
  228:	eb bf f0 58 00 24 	stmg	%r11,%r15,88(%r15)
  22e:	c0 d0 00 00 00 00 	larl	%r13,22e <jump_to_IPL_code+0x6>
			230: R_390_PC32DBL	.rodata+0x2a
  234:	a7 fb ff 50       	aghi	%r15,-176
  238:	b9 04 00 bf       	lgr	%r11,%r15
  23c:	e3 20 b0 a0 00 24 	stg	%r2,160(%r11)
     /* store the subsystem information _after_ the bootmap was loaded */
     write_subsystem_identification();
  242:	c0 e5 00 00 00 00 	brasl	%r14,242 <jump_to_IPL_code+0x1a>
			244: R_390_PLT32DBL	write_subsystem_identification+0x2

     /* prevent unknown IPL types in the guest */
     if (iplb.pbt == S390_IPL_TYPE_QEMU_SCSI) {
  248:	c0 10 00 00 00 00 	larl	%r1,248 <jump_to_IPL_code+0x20>
			24a: R_390_GOTENT	iplb+0x2
  24e:	e3 10 10 00 00 04 	lg	%r1,0(%r1)
  254:	43 10 10 0c       	ic	%r1,12(%r1)
  258:	a7 28 00 ff       	lhi	%r2,255
  25c:	14 12             	nr	%r1,%r2
  25e:	a7 1e 00 ff       	chi	%r1,255
  262:	a7 74 00 15       	jne	28c <jump_to_IPL_code+0x64>
         iplb.pbt = S390_IPL_TYPE_CCW;
  266:	c0 10 00 00 00 00 	larl	%r1,266 <jump_to_IPL_code+0x3e>
			268: R_390_GOTENT	iplb+0x2
  26c:	e3 10 10 00 00 04 	lg	%r1,0(%r1)
  272:	92 02 10 0c       	mvi	12(%r1),2
         set_iplb(&iplb);
  276:	c0 10 00 00 00 00 	larl	%r1,276 <jump_to_IPL_code+0x4e>
			278: R_390_GOTENT	iplb+0x2
  27c:	e3 10 10 00 00 04 	lg	%r1,0(%r1)
  282:	b9 04 00 21       	lgr	%r2,%r1
  286:	c0 e5 ff ff ff 75 	brasl	%r14,170 <set_iplb>
     /*
      * The IPL PSW is at address 0. We also must not overwrite the
      * content of non-BIOS memory after we loaded the guest, so we
      * save the original content and restore it in jump_to_IPL_2.
      */
     ResetInfo *current = 0;
  28c:	a7 19 00 00       	lghi	%r1,0
  290:	e3 10 b0 a8 00 24 	stg	%r1,168(%r11)

     save = *current;
  296:	c0 10 00 00 00 00 	larl	%r1,296 <jump_to_IPL_code+0x6e>
			298: R_390_PC32DBL	.bss+0x2
  29c:	e3 20 b0 a8 00 04 	lg	%r2,168(%r11)
  2a2:	eb 23 20 00 00 04 	lmg	%r2,%r3,0(%r2)
  2a8:	eb 23 10 00 00 24 	stmg	%r2,%r3,0(%r1)

     current->ipl_psw = (uint64_t) &jump_to_IPL_2;
  2ae:	c0 20 ff ff ff 91 	larl	%r2,1d0 <jump_to_IPL_2>
  2b4:	e3 10 b0 a8 00 04 	lg	%r1,168(%r11)
  2ba:	e3 20 10 00 00 24 	stg	%r2,0(%r1)
     current->ipl_psw |= RESET_PSW_MASK;
  2c0:	e3 10 b0 a8 00 04 	lg	%r1,168(%r11)
  2c6:	e3 10 10 00 00 04 	lg	%r1,0(%r1)
  2cc:	e3 20 d0 00 00 04 	lg	%r2,0(%r13)
  2d2:	b9 81 00 21       	ogr	%r2,%r1
  2d6:	e3 10 b0 a8 00 04 	lg	%r1,168(%r11)
  2dc:	e3 20 10 00 00 24 	stg	%r2,0(%r1)
     current->ipl_continue = address & 0x7fffffff;
  2e2:	e3 10 b0 a0 00 04 	lg	%r1,160(%r11)
  2e8:	b9 17 00 21       	llgtr	%r2,%r1
  2ec:	e3 10 b0 a8 00 04 	lg	%r1,168(%r11)
  2f2:	50 20 10 08       	st	%r2,8(%r1)

     debug_print_int("set IPL addr to", current->ipl_continue);
  2f6:	e3 10 b0 a8 00 04 	lg	%r1,168(%r11)
  2fc:	58 10 10 08       	l	%r1,8(%r1)
  300:	b9 16 00 11       	llgfr	%r1,%r1
  304:	b9 04 00 31       	lgr	%r3,%r1
  308:	c0 20 00 00 00 00 	larl	%r2,308 <jump_to_IPL_code+0xe0>
			30a: R_390_PC32DBL	.rodata+0x2
  30e:	c0 e5 ff ff ff 4d 	brasl	%r14,1a8 <debug_print_int>

     /* Ensure the guest output starts fresh */
     sclp_print("\n");
  314:	c0 20 00 00 00 00 	larl	%r2,314 <jump_to_IPL_code+0xec>
			316: R_390_PC32DBL	.rodata+0x12
  31a:	c0 e5 00 00 00 00 	brasl	%r14,31a <jump_to_IPL_code+0xf2>
			31c: R_390_PLT32DBL	sclp_print+0x2
     /*
      * HACK ALERT.
      * We use the load normal reset to keep r15 unchanged. jump_to_IPL_2
      * can then use r15 as its stack pointer.
      */
     asm volatile("lghi 1,1\n\t"
  320:	a7 19 00 01       	lghi	%r1,1
  324:	83 11 03 08       	diag	%r1,%r1,776
                  "diag 1,1,0x308\n\t"
                  : : : "1", "memory");
     panic("\n! IPL returns !\n");
  328:	c0 20 00 00 00 00 	larl	%r2,328 <jump_to_IPL_code+0x100>
			32a: R_390_PC32DBL	.rodata+0x14
  32e:	c0 e5 00 00 00 00 	brasl	%r14,32e <jump_to_IPL_code+0x106>
			330: R_390_PLT32DBL	panic+0x2
}
  334:	18 00             	lr	%r0,%r0
  336:	eb bf b1 08 00 04 	lmg	%r11,%r15,264(%r11)
  33c:	07 fe             	br	%r14
  33e:	07 07             	nopr	%r7



-- 
-- Jason J. Herne (jjherne@linux.ibm.com)

