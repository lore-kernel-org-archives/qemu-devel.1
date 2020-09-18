Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDB5C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700C220872
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z51fyeDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700C220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBmX-0001uO-9o
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kJBl4-0000mY-OT
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:28:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kJBl2-0005hq-3H
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600417718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YmKdYmT7bUHRzE8/wjbOCLVQK0Fk/yHIhvxQOZ65fpE=;
 b=Z51fyeDhj0ASKB44bm94I76UilULiddGja0DYKH5IC3Pn6eRlvd/NDrmR3sQmLUYohT54P
 MRyQ2XZdb8Vi6XQuAvLDCM8C57ySOtSSgKODeXaU7kZIgJKzDCocD56beSzdRc5FsVa6lR
 1531Fq0SYVyPcqVmxpbRDcTyFhlTHh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-9wwmk7nlMAGqcQ17WYSsBQ-1; Fri, 18 Sep 2020 04:28:36 -0400
X-MC-Unique: 9wwmk7nlMAGqcQ17WYSsBQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07A4B1009454;
 Fri, 18 Sep 2020 08:28:35 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7646D1001281;
 Fri, 18 Sep 2020 08:28:26 +0000 (UTC)
Date: Fri, 18 Sep 2020 10:28:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v9 11/13] tests/acpi: update golden master DSDT binary
 table blobs for q35
Message-ID: <20200918102824.3034265e@redhat.com>
In-Reply-To: <20200918072325.9933-12-ani@anisinha.ca>
References: <20200918072325.9933-1-ani@anisinha.ca>
 <20200918072325.9933-12-ani@anisinha.ca>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Philippe =?UTF-8?B?TWF0?= =?UTF-8?B?aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Sep 2020 12:53:23 +0530
Ani Sinha <ani@anisinha.ca> wrote:

> In the change d7f82561fe ("piix4: don't reserve hw resources when
> hotplug is off globally"), we make changes to the ACPI DSDT tables
> such that some ACPI code are not generated when bsel is absent. Since
> as of this point in time, in q35 machines, we do not use bsel for pci
> buses, we need to update the DSDT table blobs.
> This patch updates the DSDT golden master tables for q35 machines.
> At the same time, we clear bios-tables-test-allowed-diff.h for future
> changes which update tables.
> 
> Following is a typical diff between the q35 acpi DSDT table blobs:
> 
> @@ -1,30 +1,30 @@
>  /*
>   * Intel ACPI Component Architecture
>   * AML/ASL+ Disassembler version 20180105 (64-bit version)
>   * Copyright (c) 2000 - 2018 Intel Corporation
>   *
>   * Disassembling to symbolic ASL+ operators
>   *
> - * Disassembly of tests/data/acpi/q35/DSDT, Tue Sep 15 18:52:47 2020
> + * Disassembly of /tmp/aml-3O0DR0, Tue Sep 15 18:52:47 2020
>   *
>   * Original Table Header:
>   *     Signature        "DSDT"
> - *     Length           0x00001DFE (7678)
> + *     Length           0x00001DF6 (7670)
>   *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
> - *     Checksum         0xAC
> + *     Checksum         0x17
>   *     OEM ID           "BOCHS "
>   *     OEM Table ID     "BXPCDSDT"
>   *     OEM Revision     0x00000001 (1)
>   *     Compiler ID      "BXPC"
>   *     Compiler Version 0x00000001 (1)
>   */
>  DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT", 0x00000001)
>  {
>      Scope (\)
>      {
>          OperationRegion (DBG, SystemIO, 0x0402, One)
>          Field (DBG, ByteAcc, NoLock, Preserve)
>          {
>              DBGB,   8
>          }
> 
> @@ -3113,24 +3113,20 @@
>                  Name (_ADR, 0x00010000)  // _ADR: Address
>                  Method (_S1D, 0, NotSerialized)  // _S1D: S1 Device State
>                  {
>                      Return (Zero)
>                  }
> 
>                  Method (_S2D, 0, NotSerialized)  // _S2D: S2 Device State
>                  {
>                      Return (Zero)
>                  }
> 
>                  Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
>                  {
>                      Return (Zero)
>                  }
>              }
> -
> -            Method (PCNT, 0, NotSerialized)
> -            {
> -            }
>          }
>      }
>  }
> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/data/acpi/q35/DSDT                    | Bin 7678 -> 7670 bytes
>  tests/data/acpi/q35/DSDT.acpihmat           | Bin 9002 -> 8994 bytes
>  tests/data/acpi/q35/DSDT.bridge             | Bin 7695 -> 7688 bytes
>  tests/data/acpi/q35/DSDT.cphp               | Bin 8141 -> 8133 bytes
>  tests/data/acpi/q35/DSDT.dimmpxm            | Bin 9331 -> 9323 bytes
>  tests/data/acpi/q35/DSDT.ipmibt             | Bin 7753 -> 7745 bytes
>  tests/data/acpi/q35/DSDT.memhp              | Bin 9037 -> 9029 bytes
>  tests/data/acpi/q35/DSDT.mmio64             | Bin 8808 -> 8801 bytes
>  tests/data/acpi/q35/DSDT.numamem            | Bin 7684 -> 7676 bytes
>  tests/data/acpi/q35/DSDT.tis                | Bin 8283 -> 8276 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |  10 ----------
>  11 files changed, 10 deletions(-)
> 
> diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
> index bba8884073a27427b88ac0d733c9c87330a59366..4fad91b72e279b744b0528fd687c862d3a3d5cfa 100644
> GIT binary patch
> delta 33
> pcmexo{mq)oCD<k8n=AtZqxeRyWwM-ZEHUxHPVoYElXuD50sy=Q3Pb<^
> 
> delta 42
> ycmexn{m+`qCD<k8pDY6d<C=|J%VfFySYqOXo#F-DSSIh3wPhD!3vl)eVE_Owj0{Tv
> 
> diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/q35/DSDT.acpihmat
> index 9cac92418b5fcc2767dc74603d599642b59623fe..e4df7d1ca89578dd81be3539c8f83f073bb8db25 100644
> GIT binary patch
> delta 33
> pcmZ4Gw#bdkCD<iINtuCx@ySN6OG=z>EHUxHPVoYElb<Qs0syHh3KIYT
> 
> delta 42
> xcmZ4Fw#tpmCD<iIOPPUzv2r8VB_%FDmYDcpr+5K3mdQ_*Y}rNF0-XIq7y$jZ3mO0b
> 
> diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bridge
> index f08b7245f59aad491fcaa60e2bab1085c369ea1c..065399174575442201cc09ffa4939ddf90ac81b4 100644
> GIT binary patch
> delta 33
> ocmeCT>9FB)33dtLkYiwAT)&ZPnJlLVYfOBwQ@nt~<ejqq0G06xDgXcg  
> 
> delta 41
> wcmeCM>9^r>33dtLmt$aH^xnv|OqSE1H6}jTDPF*R@=jTQb`iD!XTJ~z0NaZSF#rGn  
> 
> diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
> index 57d859cef9fa16a8f125c4b338611c8472699f38..8d2395e3cb4383b30e3840caed0d09ccad0c7323 100644
> GIT binary patch
> delta 33
> ocmX?Wf7G7KCD<k8s5}D$<AjY|rShC^EHUxHPVoYElRM>Y0kO^r)&Kwi
> 
> delta 42
> xcmX?Vf7YJMCD<k8tULn)qv}SkQh6>vmYDcpr+5K3mdPFRw(KHo0nUCQ3;+bB3f%wz
> 
> diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.dimmpxm
> index 9d5bd5744e2ba2e0f6126c3aba0bb36af865e499..df7422051c6feadeaa3b6733ad7efa67c339b49d 100644
> GIT binary patch
> delta 33
> ocmezD@!EsSCD<h-TZMsvF>)i9v<jyiOH6#QQ@nuPWPKG|0ILxQ{r~^~
> 
> delta 42
> xcmaFu@!5mRCD<jTScQRs@!du)X%#L%mYDcpr+5K3mdSc5w(KHo0nUCQ3;+_P3k3iG
> 
> diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
> index 5cd11de6a8fe47324e5f922823a22746882f19f5..c4ce5cc0ede822ea82656d078d7a8b7eee4a7516 100644
> GIT binary patch
> delta 33
> ocmX?UbI^v%CD<jzQI3Iu(Q6~uM_EocmYDcpr+5Lo$*gj=0Hl8i@&Et;
> 
> delta 42
> xcmX?TbJB*(CD<jzQ;vaw@%~1xkFs2TEHUxHPVoY6ER$K}Y}rNF0-XIq7yt{`3i$v4
> 
> diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memhp
> index 05a7a73ec43130d5c3018bb462fd84981bfb151c..84614ffc1452358053b4c2be4b2edcb4d56a9ae6 100644
> GIT binary patch
> delta 33
> ocmX@>cGQi_CD<jzRhfZ-kz*s*S0zq2mYDcpr+5Lo$(+iz0Hk>c=Kufz  
> 
> delta 42
> xcmX@=cGiu{CD<jzSDAr<aqdR0uS#5gEHUxHPVoY6ER#8uZP`WG0-XIq7yt`p3hn>^
> 
> diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
> index efd3f1188f2b55da1514212d4be081a61c2a96e9..d8dd702b69cc24a6b58b8eaa79ea02439a2a7dd9 100644
> GIT binary patch
> delta 33
> ocmaFi^3a9LCD<h-QHg<paqmX1|B9R*tTFMyPVoW`lZBN00lUBo5&!@I
> 
> delta 41
> wcmaFp^1_A7CD<h-Ly3WbF>)i<e??Az)|mKUr+5MP$wEs0>>_Ld&VC^b00^lI82|tP
> 
> diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.numamem
> index 1978b55f1255402bf9bade0b91150b5cb49789a4..f36d22063a6eed4fb107ffd0e10477a2d6d7a983 100644
> GIT binary patch
> delta 33
> pcmZp%`D4xH66_N4N0xzs@!&?THL{#;EHUxHPVoYElMl$+0sy+k3XK2&
> 
> delta 42
> xcmexk-D1P#66_MfBFDhM7`l;bjVzZROH6#QQ@ns1%jEsCw(KHo0nUCQ3;^@W3X}i<
> 
> diff --git a/tests/data/acpi/q35/DSDT.tis b/tests/data/acpi/q35/DSDT.tis
> index 638de3872673d17b1958497d0e62c83653de1602..203030a61a92c204bb93c43fe79e546471ae2985 100644
> GIT binary patch
> delta 38
> ucmccZaK(YkCD<h-M1g^U@x?~2O|qOGnlbUgPVoW`laI>UZRU~-WC8&31`DbH
> 
> delta 45
> zcmccOaNB{)CD<h-T7iLqv1KFICRt8@&6xOLr+5MP$wy`F*hJU@oc%&JGsy)p0RTF+
> B45<JB
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 631703142c..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,11 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/q35/DSDT",
> -"tests/data/acpi/q35/DSDT.acpihmat",
> -"tests/data/acpi/q35/DSDT.bridge",
> -"tests/data/acpi/q35/DSDT.cphp",
> -"tests/data/acpi/q35/DSDT.dimmpxm",
> -"tests/data/acpi/q35/DSDT.ipmibt",
> -"tests/data/acpi/q35/DSDT.memhp",
> -"tests/data/acpi/q35/DSDT.mmio64",
> -"tests/data/acpi/q35/DSDT.numamem",
> -"tests/data/acpi/q35/DSDT.tis",


