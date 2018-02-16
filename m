Received: from eggs.gnu.org ([2001:4830:134:3::10]:33767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1emeSu-0005aq-NG
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1emeSr-0006V0-FX
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:46:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57520
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1emeSr-0006Uc-Ah
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:46:05 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1GBiKCG118290
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 06:46:03 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g5t55tcjg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 06:46:03 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 16 Feb 2018 04:46:02 -0700
References: <1518703835-10361-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1518703835-10361-3-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAMxuvaxg37M-mDQgMS89Cq_RdcXfi+DmnB7WAOdb36DPf5KYEw@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 16 Feb 2018 06:45:59 -0500
MIME-Version: 1.0
In-Reply-To: <CAMxuvaxg37M-mDQgMS89Cq_RdcXfi+DmnB7WAOdb36DPf5KYEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <71987b7d-21a0-6020-25bd-a742a15e19c2@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] tests: add test for TPM TIS device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 02/16/2018 05:18 AM, Marc-Andr=C3=A9 Lureau wrote:
> On Thu, Feb 15, 2018 at 3:10 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> Move the TPM TIS related register and flag #defines into
>> include/hw/acpi/tpm.h for access by the test case.
>>
>> Write a test case that covers the TIS functionality.
>>
>> Add the tests cases to the MAINTAINERS file.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> ---
>>   MAINTAINERS            |   1 +
>>   hw/tpm/tpm_tis.c       | 101 ----------
>>   include/hw/acpi/tpm.h  | 105 +++++++++++
>>   tests/Makefile.include |   2 +
>>   tests/tpm-emu.c        |   7 +
>>   tests/tpm-tis-test.c   | 486 +++++++++++++++++++++++++++++++++++++++=
++++++++++
>>   6 files changed, 601 insertions(+), 101 deletions(-)
>>   create mode 100644 tests/tpm-tis-test.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 57358a0..60a9ae9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1633,6 +1633,7 @@ F: include/hw/acpi/tpm.h
>>   F: include/sysemu/tpm*
>>   F: qapi/tpm.json
>>   F: backends/tpm.c
>> +F: tests/tpm-*-test
> Doesnt' match tests/tpm-emu.c/.h
>
> Make it tests/*tpm* ?

Did that. Thanks.
