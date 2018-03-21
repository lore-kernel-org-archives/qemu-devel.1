Received: from eggs.gnu.org ([2001:4830:134:3::10]:48726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eycJ7-0005mH-Bj
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eycJ4-0008Eq-4j
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47404
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eycJ3-0008EW-Vk
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:26 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2LBnnKL025239
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 07:53:25 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gumn4nyvv-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 07:53:24 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 21 Mar 2018 07:53:24 -0400
References: <1521579171-26213-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CL64QaWi=9AiKbRE+NmTQ5-D3KXq0ca9uYC_0Q7zn3WQw@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 21 Mar 2018 07:53:21 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CL64QaWi=9AiKbRE+NmTQ5-D3KXq0ca9uYC_0Q7zn3WQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <6dd0a0a5-8885-838d-b2d2-cca3be1a4907@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/4] tpm: Fix initialization of a few
 flags of CRB interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

On 03/21/2018 06:35 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Tue, Mar 20, 2018 at 9:52 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> Fix the initialization of a few flags of the CRB interface. I tested t=
he changes
>> with UEFI and it works fine. SeaBIOS needs to have the latest patches =
applied.
>>
>>     Stefan
>>
>> Stefan Berger (4):
>>    tpm: CRB: Set tpmRegValidSts flag to '1' in device reset
>>    tpm: CRB: set registers to 0 by default
>>    tpm: CRB: reset locAssigned upon relinquishing locality
>>    tpm: CRB: query backend for TPM established flag
>>
>>   hw/tpm/tpm_crb.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
> Series:
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> For 2.12?

Ideally, yes.

> thanks
>
>
