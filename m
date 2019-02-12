Received: from eggs.gnu.org ([209.51.188.92]:39424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gtY79-0004Lp-ED
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:28:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gtY6N-00056h-8g
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:27:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43562
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gtY6N-00051v-2t
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:27:55 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1CDPKHM027581
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 08:27:50 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qkvrfpn67-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 08:27:50 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Tue, 12 Feb 2019 13:27:49 -0000
References: <1549897385-10091-1-git-send-email-liam.merwick@oracle.com>
	<1549897385-10091-3-git-send-email-liam.merwick@oracle.com>
	<13b4d86c-0af3-12b9-fce5-92f1eb0fe95d@redhat.com>
	<0251e2fc-3dbd-937a-0649-71fcd64e2d14@linux.ibm.com>
	<0b53df4a-7065-b3b7-c419-3f8e55cffdfd@oracle.com>
	<bf1a6632-594c-cf05-e4cd-c70d9e1e2fbe@linux.ibm.com>
	<f7b55eef-68da-ef50-b060-05e86f659903@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Tue, 12 Feb 2019 08:27:44 -0500
MIME-Version: 1.0
In-Reply-To: <f7b55eef-68da-ef50-b060-05e86f659903@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <113577fd-71c8-972f-b658-635d3decd62d@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tpm_tis: fix format string
 specifier in tpm_tis_show_buffer()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Liam Merwick <liam.merwick@oracle.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

On 2/12/19 7:31 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/11/19 10:13 PM, Stefan Berger wrote:
>> On 2/11/19 3:09 PM, Liam Merwick wrote:
>>> On 11/02/2019 19:56, Stefan Berger wrote:
>>>> On 2/11/19 11:02 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> On 2/11/19 4:03 PM, Liam Merwick wrote:
> [...]
>>>>>> -    printf("tpm_tis: %s length =3D %d\n", string, len);
>>>>>> +    printf("tpm_tis: %s length =3D %u\n", string, len);
>>>>> So here the format is '%zu'.
>>>>> However in code cleanup we try go get ride of printf() calls and
>>>>> replace them with trace points.
>>>>
>>>> This code is only used for debugging if DEBUG_TIS has been #defined.
>>>> No need to add tracing here.
>>> I'd come up the attached change (but that seems like overkill).
>>
>> I don't think we need tracing for this.
> So if you think the code is mature enough, let's remove the DEBUG calls=
!
>
> Else we prefer to convert DEBUG printf to trace events because (at leas=
t):
> - no need to recompile to enable debugging
> - when compiled with debugging, you don't mess with STDIO which can be
> used as a chardev backend.
Fine. Then I withdraw my reviewed-by.
> Thanks,
>
> Phil.
>
