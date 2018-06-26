Received: from eggs.gnu.org ([2001:4830:134:3::10]:55675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fXpnR-0001v0-5a
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fXpnM-0005AU-4S
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:22:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fXpnL-0005AA-RI
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:22:16 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5QFJi63040748
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 11:22:13 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2juqcpjdcp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 11:22:12 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 26 Jun 2018 11:22:11 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
	[9.57.199.110])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	w5QFM9RA6291934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 15:22:09 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28396AE05F
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 11:22:01 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17ADDAE05C
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 11:22:01 -0400 (EDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 11:22:01 -0400 (EDT)
References: <20180515121433.6112-1-marcandre.lureau@redhat.com>
	<20180515121433.6112-5-marcandre.lureau@redhat.com>
	<20180621150203.2c985ed2@redhat.com>
	<CAJ+F1CJHraqeM2q5G-ooVfp771r_K4g=osJG=J6PTH4aV0BprQ@mail.gmail.com>
	<20180621163335.19010217@redhat.com>
	<CAJ+F1C+pYQ-7e-8KqNNwRb4Jtq_HmZUowtiGPjFWV7AE3JL_TA@mail.gmail.com>
	<20180626143404.2ee79c69@redhat.com>
	<03a9b99d-6824-ae36-d8d0-4c0434974b6c@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 26 Jun 2018 11:22:09 -0400
MIME-Version: 1.0
In-Reply-To: <03a9b99d-6824-ae36-d8d0-4c0434974b6c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <de237f87-6cbf-afcf-2702-4ce5dbb31311@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/4] tpm: add a fake ACPI memory clear
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 06/26/2018 08:47 AM, Laszlo Ersek wrote:
> On 06/26/18 14:34, Igor Mammedov wrote:
>> On Tue, 26 Jun 2018 11:22:26 +0200
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
>>
>>> On Thu, Jun 21, 2018 at 4:33 PM, Igor Mammedov <imammedo@redhat.com> =
wrote:
>>>> On Thu, 21 Jun 2018 15:24:44 +0200
>>>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
>>>>  =20
>>>>> Hi
>>>>>
>>>>> On Thu, Jun 21, 2018 at 3:02 PM, Igor Mammedov <imammedo@redhat.com=
> wrote:
>>>>>> On Tue, 15 May 2018 14:14:33 +0200
>>>>>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>>>>>>  =20
>>>>>>> This allows to pass the last failing test from the Windows HLK TP=
M 2.0
>>>>>>> TCG PPI 1.3 tests.
>>>>>>>
>>>>>>> The interface is described in the "TCG Platform Reset Attack
>>>>>>> Mitigation Specification", chapter 6 "ACPI _DSM Function". Whethe=
r or
>>>>>>> not we should have a real implementation remains an open question=
 to me.
>>>>>> might it cause security issues?
>>>>> Good question. If the guest assumes success of this operation perha=
ps.
>>>>> I'll check the spec.
>>>>>  =20
>>>>>> What are implications of faking it and how hard it's to implement =
thing
>>>>>> per spec?
>>>>> Laszlo answerd that in "[Qemu-devel] investigating TPM for
>>>>> OVMF-on-QEMU"  2f2b) TCG Memory Clear Interface
>>>> I get that it's optional, but we probably shouldn't advertise/fake
>>>> feature if it's not supported.
>>> As said in the commit message, the objective was to pass the Windows
>>> HLK test. If we don't want to advertize a fake interface, I am fine
>>> droping this patch. We'll have to revisit with Laszlo the work needed
>>> in the firmware to support it.
>> I think it would be safer to drop this patch.
> This is BTW a feature that's very difficult for OVMF to implement, but
> (I think) near trivial for QEMU to implement. The feature is about
> clearing all of the guest RAM to zero at reboot.
>
> For the firmware, it's difficult to solve, because in the 32-bit PEI
> phase, we don't map DRAM beyond 4GB, so we can't re-set memory to zero
> via normal addressing. (For physical platforms, this is different,
> because their PEI phases have PEI modules that initialize the memory
> controller(s), so they have platform-specific means to clear RAM.) For
> QEMU, on the other hand, the feature "shouldn't be hard (TM)", just
> implement a reset handler that clears all RAMBlocks on the host side (o=
r
> some such :) ).

Except don't clear that PPI memory device where the user/ACPI posted the=20
command for the firmware to act upon.
