Received: from eggs.gnu.org ([2001:4830:134:3::10]:54317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eP5fe-0000fp-UH
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:57:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eP5fb-00076Z-0E
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:57:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46036
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eP5fa-00076K-Qu
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:57:50 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBDBtdcS056266
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 06:57:47 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eu3451qx5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 06:57:47 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 13 Dec 2017 04:57:46 -0700
References: <1510371554-29833-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510371554-29833-3-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CJA_T0DiA5B5dLpV8QD6cqCEHxLeqkuXc6dWP_TC4PCdQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 13 Dec 2017 06:57:43 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJA_T0DiA5B5dLpV8QD6cqCEHxLeqkuXc6dWP_TC4PCdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <3552aeb3-167d-d207-b7b3-b8e600d01ce6@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] tpm_tis: Return 0 for every register
 in case of failure mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, QEMU <qemu-devel@nongnu.org>

On 12/13/2017 05:26 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi Stefan
>
> On Sat, Nov 11, 2017 at 4:39 AM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> Rather than returning ~0, return 0 for every register in case of
>> failure mode. The '0' is better to indicate that there's no device
>> there.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> ---
>>   hw/tpm/tpm_tis.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
>> index eca3374..d0bdd96 100644
>> --- a/hw/tpm/tpm_tis.c
>> +++ b/hw/tpm/tpm_tis.c
>> @@ -519,7 +519,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hw=
addr addr,
>>       uint8_t v;
>>
>>       if (tpm_backend_had_startup_error(s->be_driver)) {
>> -        return val;
>> +        return 0;
>>       }
> it's not obvious to me why it's better. Could you detail a bit more the=
 reason?
>
> why not change the initialization of val instead?

http://patchwork.ozlabs.org/patch/838042/
