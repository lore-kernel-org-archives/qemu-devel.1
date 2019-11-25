Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9F0C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A4DE20679
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTLtsVxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4DE20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45755 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGi0-0007Po-Gr
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 10:55:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iZGYl-0005zI-7M
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:45:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iZGYj-0000an-DY
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:45:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43225
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iZGYj-0000ad-9o
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574696752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WadP2MjNyRDE98mOoDvVW/giDJaPSGQtNH/OE+hqgmI=;
 b=FTLtsVxwHHHFzu3Jsd6u+Pw/bkYtHaPfNXWEU1DF8u9vmIxYe6qNWCk5DHqLtyVk6D6TAe
 kRQAkMLiERFnHseE41H/cQNe/rbQtBC1rLVaf2vUSAin373IusHX/ZNdUW1SxBCWmQo/+0
 syAeGrIQMCgcp063adHUMFaJttH3vrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-TipN8w9jPQeqvG6Dvmqr-w-1; Mon, 25 Nov 2019 10:45:49 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB0B0A1F53;
 Mon, 25 Nov 2019 15:45:47 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5EAC15D6A0;
 Mon, 25 Nov 2019 15:45:43 +0000 (UTC)
Date: Mon, 25 Nov 2019 16:45:41 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 0/5] ARM virt: Add NVDIMM support
Message-ID: <20191125164541.3f0a593f@redhat.com>
In-Reply-To: <441c818f24084b4191315cf2a6267cef@huawei.com>
References: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
 <a133d4c4-3f60-2bb1-a7d7-35cdb06af265@redhat.com>
 <441c818f24084b4191315cf2a6267cef@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: TipN8w9jPQeqvG6Dvmqr-w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>, Auger Eric <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 25 Nov 2019 13:20:02 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> Hi Eric/Igor,
> 
> > -----Original Message-----
> > From: Shameerali Kolothum Thodi
> > Sent: 22 October 2019 15:05
> > To: 'Auger Eric' <eric.auger@redhat.com>; qemu-devel@nongnu.org;
> > qemu-arm@nongnu.org; imammedo@redhat.com
> > Cc: peter.maydell@linaro.org; shannon.zhaosl@gmail.com; xuwei (O)
> > <xuwei5@huawei.com>; lersek@redhat.com; Linuxarm
> > <linuxarm@huawei.com>
> > Subject: RE: [PATCH 0/5] ARM virt: Add NVDIMM support

not related to problem discussed in this patch but you probably
need to update docs/specs/acpi_nvdimm.txt to account for your changes

> >   
> 
> [..]
> 
> > > one question: I noticed that when a NVDIMM slot is hotplugged one get
> > > the following trace on guest:
> > >
> > > nfit ACPI0012:00: found a zero length table '0' parsing nfit
> > > pmem0: detected capacity change from 0 to 1073741824
> > >
> > > Have you experienced the 0 length trace?  
> > 
> > I double checked and yes that trace is there. And I did a quick check with
> > x86 and it is not there.
> > 
> > The reason looks like, ARM64 kernel receives an additional 8 bytes size when
> > the kernel evaluates the "_FIT" object.
> > 
> > For the same test scenario, Qemu reports a FIT buffer size of 0xb8 and
> > 
> > X86 Guest kernel,
> > [    1.601077] acpi_nfit_init: data 0xffff8a273dc12b18 sz 0xb8
> > 
> > ARM64 Guest,
> > [    0.933133] acpi_nfit_init: data 0xffff00003cbe6018 sz 0xc0
> > 
> > I am not sure how that size gets changed for ARM which results in
> > the above mentioned 0 length trace. I need to debug this further.
> > 
> > Please let me know if you have any pointers...  
> 
> I spend some time debugging this further and it looks like the AML code
> behaves differently on x86 and ARM64.
FIT table is built dynamically and you are the first to debug
such issue.
(apart from the author the NVDIMM code.
 btw: why NVDIMM author is not on CC list???)


> Booted guest with nvdimm mem, and used SSDT override with dbg prints
> added,
> 
> -object memory-backend-ram,id=mem1,size=1G \
> -device nvdimm,id=dimm1,memdev=mem1 \
> 
> On X86,
> -----------
> 
> [Qemu]NVDIMM:nvdimm_dsm_func_read_fit: Read FIT: offset 0 FIT size 0xb8 Dirty Yes.
> [Qemu]NVDIMM:nvdimm_dsm_func_read_fit: read_fit_out buf size 0xc0 func_ret_status 0
> 
> [AML]"NVDIMM-NCAL: Rcvd RLEN 000000C0"
> [AML]"NVDIMM-NCAL: Creating OBUF with 000005E0 bits"
> [AML]"NVDIMM-NCAL: Created  BUF(Local7) size 000000BC"
> [AML]"NVDIMM-RFIT Rcvd buf size 000000BC"
> [AML]"NVDIMM-RFIT Created NVDR.RFIT.BUFF size 000000B8"
> [AML]"NVDIMM-FIT: Rcvd buf size 000000B8"
> 
> [Qemu]NVDIMM:nvdimm_dsm_func_read_fit: Read FIT: offset 0xb8 FIT size 0xb8 Dirty No.
> [Qemu]NVDIMM:nvdimm_dsm_func_read_fit: read_fit_out buf size 0x8 func_ret_status 0 
> 
> [AML]"NVDIMM-NCAL: Rcvd RLEN 00000008"
> [AML]"NVDIMM-NCAL: Creating OBUF with 00000020 bits"
> [AML]"NVDIMM-NCAL: Created  BUF(Local7) size 00000004"
> [AML]"NVDIMM-RFIT Rcvd buf size 00000004"
> [AML]"NVDIMM-FIT: Rcvd buf size 00000000"
> [AML]"NVDIMM-FIT: _FIT returned size 000000B8"
> 
> [ KERNEL] acpi_nfit_init: NVDIMM: data 0xffff9855bb9a7518 sz 0xb8  --> Guest receives correct size(0xb8) here 
> 
> On ARM64,
> ---------------
> 
> [Qemu]NVDIMM:nvdimm_dsm_func_read_fit: Read FIT: offset 0 FIT size 0xb8 Dirty Yes.
> [Qemu]VDIMM:nvdimm_dsm_func_read_fit: read_fit_out buf size 0xc0 func_ret_status 0 
> 
> [AML]"NVDIMM-NCAL: Rcvd RLEN 00000000000000C0"
> [AML]"NVDIMM-NCAL: Creating OBUF with 00000000000005E0 bits"
> [AML]"NVDIMM-NCAL: Created  BUF(Local7) size 00000000000000BC"
> [AML]"NVDIMM-RFIT Rcvd buf size 00000000000000BC"
> [AML]"NVDIMM-RFIT Created NVDR.RFIT.BUFF size 00000000000000B8"
> [AML]"NVDIMM-FIT: Rcvd buf size 00000000000000B8"
> 
> [Qemu]NVDIMM:nvdimm_dsm_func_read_fit: Read FIT: offset 0xb8 FIT size 0xb8 Dirty No.
> [Qemu]NVDIMM:nvdimm_dsm_func_read_fit: read_fit_out buf size 0x8 func_ret_status 0 
> 
> [AML]"NVDIMM-NCAL: Rcvd RLEN 0000000000000008"
> [AML]"NVDIMM-NCAL: Creating OBUF with 0000000000000020 bits"  --> All looks same as x86 up to here.
> [AML]"NVDIMM-NCAL: Created  BUF(Local7) size 0000000000000008"  ---> The size goes wrong. 8 bytes instead of 4!.

> [AML]"NVDIMM-RFIT Rcvd buf size 0000000000000008"
> [AML]"NVDIMM-RFIT Created NVDR.RFIT.BUFF size 0000000000000004"
> [AML]"NVDIMM-FIT: Rcvd buf size 0000000000000008"  --> Again size goes wrong. 8 bytes instead of 4!.

                Local1 = SizeOf (Local0)
                printf("NVDIMM-RFIT Rcvd buf size %o", Local1)

                Local1 -= 0x04
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ here you get -4 so sizes you see are consistent

                If ((Local1 == Zero))
                {
                    Return (Buffer (Zero){})
                }

                CreateField (Local0, 0x20, (Local1 << 0x03), BUFF)
                printf("NVDIMM-RFIT Created NVDR.RFIT.BUFF size %o", Local1)

 
> [Qemu]NVDIMM:nvdimm_dsm_func_read_fit: Read FIT: offset 0xc0 FIT size 0xb8 Dirty No.  -->Another read is attempted 
> [Qemu]NVDIMM:nvdimm_dsm_func_read_fit: read_fit_out buf size 0x8 func_ret_status 3  --> Error status returned

status 3 means that QEMU didn't like content of NRAM, and there is only
1 place like this in nvdimm_dsm_func_read_fit()
    if (read_fit->offset > fit->len) {                                           
        func_ret_status = NVDIMM_DSM_RET_STATUS_INVALID;                         
        goto exit;                                                               
    }

so I'd start looking from here and check that QEMU gets expected data
in nvdimm_dsm_write(). In other words I'd try to trace/compare
content of DSM buffer (from qemu side).


> [AML]"NVDIMM-NCAL: Rcvd RLEN 0000000000000008"
> [AML]"NVDIMM-NCAL: Creating OBUF with 0000000000000020 bits"
> [AML]"NVDIMM-NCAL: Created  BUF(Local7) size 0000000000000008"
> [AML]"NVDIMM-FIT: Rcvd buf size 0000000000000000"
RFIT returns 0-sized buffer in case of error

> [AML]"NVDIMM-FIT: _FIT returned size 00000000000000C0"   --> Wrong size returned.
after that it goes

                    Local0 = Buffer (Zero){}
                    Local0 = RFIT (Local3)
                    Local1 = SizeOf (Local0)
                    printf("NVDIMM-FIT: Rcvd buf size %o", Local1)
                    If ((RSTA == 0x0100))
                    {
                        Local2 = Buffer (Zero){}
                        Local3 = Zero
                    }
                    Else
                    {
                        If ((Local1 == Zero))
  --> here, probably on the second iteration of the loop taking Zero
      size as EOF sign but without checking for any error (RSTA !=0)
      and returning partial buffer only

                        {
                           printf("NVDIMM-FIT: _FIT returned size %o", SizeOf(Local2))
                           Return (Local2)
                        }

relevant code in QEMU that builds this AML is in nvdimm_build_fit()

> [ KERNEL] acpi_nfit_init: NVDIMM: data 0xffff0000fc57ce18 sz 0xc0   -->Kernel gets 0xc0 instead of 0xb8
> 
> 
> It looks like the aml, "CreateField (ODAT, Zero, Local1, OBUF)" goes wrong for
> ARM64 when the buffer is all zeroes. My knowledge on aml is very limited and not
> sure this is a 32/64bit issue or not. I am attaching the SSDT files with the above
> dbg prints added. Could you please take a look and let me know what actually is
> going on here...

diff -u SSDT-dbg-x86.dsl SSDT-dbg-arm64.dsl 
--- SSDT-dbg-x86.dsl	2019-11-25 14:50:22.024983026 +0100
+++ SSDT-dbg-arm64.dsl	2019-11-25 14:50:06.740690645 +0100
@@[...]
@@ -28,7 +28,7 @@
             Method (NCAL, 5, Serialized)
             {
                 Local6 = MEMA /* \MEMA */
-                OperationRegion (NPIO, SystemIO, 0x0A18, 0x04)
+                OperationRegion (NPIO, SystemMemory, 0x09090000, 0x04)
that's fine and matches your code

                 OperationRegion (NRAM, SystemMemory, Local6, 0x1000)
                 Field (NPIO, DWordAcc, NoLock, Preserve)
                 {
@@ -210,6 +210,6 @@
         }
     }
 
-    Name (MEMA, 0xBFBFD000)
+    Name (MEMA, 0xFFFF0000)

However value here is suspicious. If I recall right it should
point to DMS buffer allocated by firmware somewhere in the guest RAM.


 }
 
> Much appreciated,
> Shameer.
> 
> 


