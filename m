Received: from eggs.gnu.org ([209.51.188.92]:55772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1goAZi-00029t-M7
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:19:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1goAZg-0007d3-E2
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:19:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1goAZe-0007YT-HT
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:19:54 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0SHEa46063311
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 12:19:51 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qa5phh6ub-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 12:19:50 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Mon, 28 Jan 2019 17:19:49 -0000
From: Stefan Berger <stefanb@linux.ibm.com>
References: <20190125210058.1092551-1-stefanb@linux.ibm.com>
	<20190128154553.583f79a3@redhat.com>
	<f7fc884b-0a7f-17d5-ada4-fc44c08bfba1@linux.ibm.com>
Date: Mon, 28 Jan 2019 12:19:37 -0500
MIME-Version: 1.0
In-Reply-To: <f7fc884b-0a7f-17d5-ada4-fc44c08bfba1@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <f93f5ab2-8b51-ca05-c4c3-902743e4b13e@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] acpi: Make TPM 2.0 with TIS available as
 MSFT0101
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mst@redhat.com

On 1/28/19 11:14 AM, Stefan Berger wrote:
> On 1/28/19 9:45 AM, Igor Mammedov wrote:
>> On Fri, 25 Jan 2019 16:00:58 -0500
>> Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>> This patch makes the a TPM 2.0 with TIS interface available under the
>>> HID 'MSF0101'. This is supported by Linux and also Windows now
>> MSF0101 is relatively recent addition to Linux,
>> are there in wild (old) kernels that worked with PNP0C31 but won't wor=
k
>> with MSF0101?
>
>
> Linux 4.3.4 and later references this HID here:=20
> https://elixir.bootlin.com/linux/v4.3.4/source/drivers/char/tpm/tpm_tis=
.c=20
> . I don't see it before that. A 3.10 kernel works with this patch as=20
> well.


... that 3.10 kernel from el7 has been patched, though.

 =C2=A0=C2=A0 Stefan
