Received: from eggs.gnu.org ([2001:4830:134:3::10]:44804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@us.ibm.com>) id 1d0Y9Q-0008Kw-Q3
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 14:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@us.ibm.com>) id 1d0Y9N-0000Fc-M5
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 14:46:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34290
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@us.ibm.com>) id 1d0Y9N-0000FS-F0
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 14:46:53 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3IIdW2Y103685
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 14:46:51 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29wqpt1t71-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 14:46:51 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@us.ibm.com>;
	Tue, 18 Apr 2017 12:46:50 -0600
Received: from b03ledav006.gho.boulder.ibm.com
	(b03ledav006.gho.boulder.ibm.com [9.17.130.237])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id v3IIklY92425274
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 11:46:48 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05F75C6047
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 12:46:48 -0600 (MDT)
Received: from d50lp31.co.us.ibm.com (unknown [9.17.249.32])
	by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS id ED70DC6042
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 12:46:47 -0600 (MDT)
Received: from localhost
	by d50lp31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@us.ibm.com>;
	Tue, 18 Apr 2017 12:46:47 -0600
Received: from localhost
	by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
	for <qemu-devel@nongnu.org> from <stefanb@us.ibm.com>;
	Tue, 18 Apr 2017 18:46:44 -0000
In-Reply-To: <152817b5-89cf-14fe-d83a-bb5c8d748c90@citrix.com>
From: "Stefan Berger" <stefanb@us.ibm.com>
Date: Tue, 18 Apr 2017 18:46:42 +0000
References: <152817b5-89cf-14fe-d83a-bb5c8d748c90@citrix.com>
Message-Id: <OF3C1CFB9D.4BFF82AD-ON00258106.00671A8D-00258106.00672723@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] CUSE-TPM : Win 10 reports TPM device doesn't have
 sufficient resources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: anshul.makkar@citrix.com
Cc: qemu-devel@nongnu.org

   You may want to try it from this version:[1]
   https://github.com/stefanberger/qemu-tpm/tree/v2.8.0+tpm


     ----- Original message -----
     From: anshul makkar <anshul.makkar@citrix.com>
     To: <qemu-devel@nongnu.org>
     Cc: Stefan Berger/Watson/IBM@IBMUS
     Subject: CUSE-TPM : Win 10 reports TPM device doesn't have
     sufficient resources
     Date: Tue, Apr 18, 2017 1:42 PM

     Hi,


     I am using CUSE-TPM based on

     [2]https://github.com/stefanberger/qemu-tpm branch: 2.4.1+tpm


     [3]https://github.com/stefanberger/swtpm


     [4]https://github.com/ts468/seabios-tpm


     I am facing an issue where WIndows 10 guest device manager reports
     TPM status as @

   The device status is "The device cannot find enough free resources it
   can use (Code 12)"#

     On browsing I found this page
     @[5]https://bugzilla.redhat.com/show_bug.cgi?id=1281413" that
     reports exactly the same problem and the resolution patch
     @ [6]https://bugzilla.redhat.com/attachment.cgi?id=1137166â€‹ .


     I applied the patch on the code and verified with debug trace that
     the patch code does executes.


     But, I am still observing the same issue on Win 10 guest and on
     using ACPIdump utility in Windows guest I can still see "IRQ 5 and
     IRQNoFlags" in the ssdt.dsl code.
      Device (ISA.TPM)
                 {
                     Name (_HID, EisaId ("PNP0C31"))  // _HID: Hardware
     ID
                     Name (_STA, 0x0F)  // _STA: Status
                     Name (_CRS, ResourceTemplate ()  // _CRS: Current
     Resource Settings
                     {
                         Memory32Fixed (ReadWrite,
                             0xFED40000,         // Address Base
                             0x00005000,         // Address Length
                             )
                         IRQNoFlags ()
                             {5}
                     })



     I am bit confused, from my understanding, its the QEMU that builds
     the SSDT table and I can also verify it from the logs. But somehow
     guest is getting the old ACPI values for TPM which is not acceptable
     to Windows.

     Just to be sure, I also verified the SeaBIOS code and couldn't find
     any link to this table.


     Here is the patch that I applied based on the link above:


   if (misc->tpm_version != TPM_VERSION_UNSPEC) {

                ACPI_BUILD_DPRINTF("TPM: add MMIO\n");


                dev = aml_device("TPM");


                aml_append(dev, aml_name_decl("_HID",
   aml_eisaid("PNP0C31")));

                aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));


                crs = aml_resource_template();


                aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,




                           TPM_TIS_ADDR_SIZE, AML_READ_WRITE));


                aml_append(dev, aml_name_decl("_CRS", crs));


                aml_append(sb_scope, dev);


            }


   aml_append(ssdt, sb_scope);

     logs once I start qemu:
     CPI_BUILD: init ACPI tables
     ACPI_BUILD: TPM: add MMIO
     ACPI_BUILD: init ACPI tables
     ACPI_BUILD: TPM: add MMIO

     tpm_tis:  read.4(00000f00) = 00011014
     tpm_tis: write.1(00000008) = 00000000
     tpm_tis:  read.1(00000000) = 00000081
     Commands to start vTPM:
     swtpm_cuse -M 260 -m 1 -n vtpm0
     qemu-system-x86_64 -enable-kvm -m 1024 -boot d -bios bios.bin -boot
     menu=on -tpmdev cuse-tpm,id=tpm0,path=/dev/vtpm0 -device
     tpm-tis,tpmdev=tpm0 win.img
     Please suggest if I am missing anything .
     Thanks
     Anshul Makkar

References

   1. https://github.com/stefanberger/qemu-tpm/tree/v2.8.0+tpm
   2. https://github.com/stefanberger/qemu-tpm
   3. https://github.com/stefanberger/swtpm
   4. https://github.com/ts468/seabios-tpm
   5. https://bugzilla.redhat.com/show_bug.cgi?id=1281413
   6. https://bugzilla.redhat.com/attachment.cgi?id=1137166
