Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A9AC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 11:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7C34205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 11:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C34205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyaYw-00055b-UM
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 07:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1hyaYD-0004Vk-71
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 07:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hyaYB-00042T-S1
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 07:37:45 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.79]:23919)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hyaXx-0003IB-Ir; Fri, 16 Aug 2019 07:37:29 -0400
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 BWP09926084.bt.com (10.36.82.115) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Fri, 16
 Aug 2019 12:37:05 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18e.domain1.systemhost.net (10.9.212.18) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Fri, 16 Aug 2019 12:37:26 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Fri, 16 Aug
 2019 12:37:26 +0100
From: <tony.nguyen@bt.com>
To: <philmd@redhat.com>, <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v7 00/42] Invert Endian bit in SPARCv9 MMU
 TTE
Thread-Index: AQHVU/vc8DdfhK3ulkmWv148s0Uozqb9eXeAgAAr/BQ=
Date: Fri, 16 Aug 2019 11:37:26 +0000
Message-ID: <1565955445398.83897@bt.com>
References: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>,
 <a7d6eede-b152-4c06-8945-9607c663b99c@redhat.com>
In-Reply-To: <a7d6eede-b152-4c06-8945-9607c663b99c@redhat.com>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.40]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.79
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v7 00/42] Invert Endian bit in SPARCv9 MMU
 TTE
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
Cc: frederic.konrad@adacore.com, berto@igalia.com, qemu-block@nongnu.org,
 arikalo@wavecomp.com, pasic@linux.ibm.com, hpoussin@reactos.org,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org, jasowang@redhat.com,
 jiri@resnulli.us, ehabkost@redhat.com, b.galvani@gmail.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, stefanha@redhat.com,
 jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com, andrew@aj.id.au,
 claudio.fontana@suse.com, crwulff@gmail.com, laurent@vivier.eu,
 sundeep.lkml@gmail.com, michael@walle.cc, qemu-ppc@nongnu.org,
 kbastian@mail.uni-paderborn.de, imammedo@redhat.com, fam@euphon.net,
 peter.maydell@linaro.org, david@redhat.com, palmer@sifive.com,
 keith.busch@intel.com, jcmvbkbc@gmail.com, hare@suse.com,
 sstabellini@kernel.org, andrew.smirnov@gmail.com, deller@gmx.de,
 magnus.damm@gmail.com, atar4qemu@gmail.com, minyard@acm.org, sw@weilnetz.de,
 yuval.shaia@oracle.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 jan.kiszka@web.de, clg@kaod.org, shorne@gmail.com, qemu-riscv@nongnu.org,
 i.mitsyanko@gmail.com, cohuck@redhat.com, amarkovic@wavecomp.com,
 peter.chubb@nicta.com.au, aurelien@aurel32.net, pburton@wavecomp.com,
 sagark@eecs.berkeley.edu, green@moxielogic.com, kraxel@redhat.com,
 edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn, robh@kernel.org,
 borntraeger@de.ibm.com, joel@jms.id.au, antonynpavlov@gmail.com,
 chouteau@adacore.com, lersek@redhat.com, Andrew.Baumann@microsoft.com,
 mreitz@redhat.com, walling@linux.ibm.com, dmitry.fleytman@gmail.com,
 mst@redhat.com, mark.cave-ayland@ilande.co.uk, jslaby@suse.cz, marex@denx.de,
 proljc@gmail.com, marcandre.lureau@redhat.com, alistair@alistair23.me,
 paul.durrant@citrix.com, david@gibson.dropbear.id.au,
 xiaoguangrong.eric@gmail.com, huth@tuxfamily.org, jcd@tribudubois.net,
 pbonzini@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Phillippe,

On 8/16/19 7:58 PM, Philippe Mathieu-Daud=E9 wrote:
>On 8/16/19 8:28 AM, tony.nguyen@bt.com wrote:
>> This patchset implements the IE (Invert Endian) bit in SPARCv9 MMU TTE.
>>
>> v7:
>[...]
>> - Re-declared many native endian devices as little or big endian. This i=
s why
>>   v7 has +16 patches.
>
>Why are you doing that? What is the rational?

While collapsing the byte swaps, it was suggested in patch #11 of v5 that
consistent use of MemOp simplified endian comparisons. This lead to the
deprecation of enum device_endian by MemOp.

As MO_TE is conditional upon NEED_CPU_H, the s/DEVICE_NATIVE_ENDIAN/MO_TE/
required changing some device object files from common-obj-* to obj-*. In p=
atch
#15 of v6 Paolo noted that most devices should not of been DEVICE_NATIVE_EN=
DIAN
and hinted at a clean up.

The +16 patches in v7 is the clean up effort.

>Anyhow if this not required by your series, you should split it out of
>it, and send it on your principal changes are merged.
>I'm worried because this these new patches involve many subsystems (thus
>maintainers) and reviewing them will now take a fair amount of time.

Yes, lets split these patches out. They are very much a tangent to the seri=
es
purpose.

>> For each device declared with DEVICE_NATIVE_ENDIAN, find the set of
>> targets from the set of target/hw/*/device.o.
>>
>> If the set of targets are all little or all big endian, re-declare
>> the device endianness as DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN
>> respectively.
>
>If only little endian targets use a device, that doesn't mean the device
>is designed in little endian...
>
>Then if a big endian target plan to use this device, it will require
>more work and you might have introduced regressions...
>
>I'm not sure this is a safe move.
>
>> This *naive* deduction may result in genuinely native endian devices
>> being incorrectly declared as little or big endian, but should not
>> introduce regressions for current targets.
>

Roger. Evidently too naive. TBH, most devices I've never heard of...

Regards,
Tony
