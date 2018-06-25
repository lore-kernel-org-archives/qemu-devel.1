Received: from eggs.gnu.org ([2001:4830:134:3::10]:51797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fXTr2-0002l9-HP
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fXTqy-0003CE-Lp
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:56:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fXTqy-0003Bm-DN
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:56:32 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5PFsc5k047581
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 11:56:31 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ju00qathu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 11:56:30 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 25 Jun 2018 09:56:30 -0600
References: <aa9ce054-f58c-097d-aee3-8fae769d0840@linux.vnet.ibm.com>
	<20180625152513.GI18580@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 25 Jun 2018 11:56:24 -0400
MIME-Version: 1.0
In-Reply-To: <20180625152513.GI18580@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <6adb28e6-85eb-38dc-ad24-99a5daa0f972@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Choosing PCR banks for swtpm's TPM 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: tpm2@lists.01.org, Kenneth Goldman <kgoldman@us.ibm.com>, Chris Friesen <chris.friesen@windriver.com>, "Qi, Yadong" <yadong.qi@intel.com>, qemu-devel <qemu-devel@nongnu.org>, "Xu, Quan" <quan.xu@intel.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 06/25/2018 11:25 AM, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Jun 25, 2018 at 11:05:55AM -0400, Stefan Berger wrote:
>> Hi!
>>
>>  =C2=A0I am sending this email to solicit input on the choice of the P=
CR banks to
>> enable for swtpm's TPM 2. I have currently enabled 4 PCR banks for
>> SHA{1,256,384,512}. The downside of this is that running the TPM 2 wit=
h so
>> many PCR banks has a performance impact when the Linux integrity measu=
rement
>> architecture is used and has to extend measurements into all PCR banks=
,
>> which Linux does already.
>>
>> TPM 2 has the PCR_Allocate() command for a user to select the PCR bank=
s to
>> use. This command allows to make some PCR banks invisible. The change =
has to
>> be done through the firmware and has the downside that the TPM2 does n=
ot
>> support TPM2_Shutdown(SU_STATE) after this command was used. This prev=
ents
>> suspend/resume from working properly. So, it seems that one shouldn't =
have
>> to use this command, which in turn means the number of PCR banks shoul=
d be
>> small.
>>
>> Another complication with the swtpm is the upgrade path. Suspended VMs=
 will
>> expect that the PCR banks that were available before the suspend will =
be
>> available after the resume and a possible swtpm upgrade. This in turn =
means
>> that the PCR banks should be chosen now and we'll have to stick with t=
hem.
> Anything that has a risk of needing to change between versions would ne=
ed
> to be tied into the machine type in some way.

You mean a machine type like q35? I am not sure how it would be tied=20
into QEMU since the swtpm command line options are chosen more or less=20
independently of the ones from QEMU.

 =C2=A0=C2=A0=C2=A0 Stefan
