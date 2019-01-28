Received: from eggs.gnu.org ([209.51.188.92]:38880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1goEqH-00082Y-NV
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 16:53:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1goEqG-000218-PO
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 16:53:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59914
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1goEqG-0001zy-JU
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 16:53:20 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0SLmckM110212
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 16:53:18 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qa9gkhgjq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 16:53:17 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Mon, 28 Jan 2019 21:53:16 -0000
References: <20190125210058.1092551-1-stefanb@linux.ibm.com>
	<20190128154553.583f79a3@redhat.com>
	<f7fc884b-0a7f-17d5-ada4-fc44c08bfba1@linux.ibm.com>
	<f93f5ab2-8b51-ca05-c4c3-902743e4b13e@linux.ibm.com>
	<20190128124924-mutt-send-email-mst@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Mon, 28 Jan 2019 16:53:12 -0500
MIME-Version: 1.0
In-Reply-To: <20190128124924-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <5df42727-a6e7-e47f-15f4-d647d2c02525@linux.ibm.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com

On 1/28/19 12:49 PM, Michael S. Tsirkin wrote:
> On Mon, Jan 28, 2019 at 12:19:37PM -0500, Stefan Berger wrote:
>> On 1/28/19 11:14 AM, Stefan Berger wrote:
>>> On 1/28/19 9:45 AM, Igor Mammedov wrote:
>>>> On Fri, 25 Jan 2019 16:00:58 -0500
>>>> Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>>
>>>>> This patch makes the a TPM 2.0 with TIS interface available under t=
he
>>>>> HID 'MSF0101'. This is supported by Linux and also Windows now
>>>> MSF0101 is relatively recent addition to Linux,
>>>> are there in wild (old) kernels that worked with PNP0C31 but won't w=
ork
>>>> with MSF0101?
>>>
>>> Linux 4.3.4 and later references this HID here:
>>> https://elixir.bootlin.com/linux/v4.3.4/source/drivers/char/tpm/tpm_t=
is.c
>>> . I don't see it before that. A 3.10 kernel works with this patch as
>>> well.
>>
>> ... that 3.10 kernel from el7 has been patched, though.
>>
>>  =C2=A0=C2=A0 Stefan
> .. and supports the new HID.
>
And this spec here also speaks for it:=20
https://trustedcomputinggroup.org/wp-content/uploads/PC-ClientSpecific_Pl=
atform_Profile_for_TPM_2p0_Systems_v51.pdf

See chapter 8.
