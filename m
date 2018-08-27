Received: from eggs.gnu.org ([2001:4830:134:3::10]:36672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fuIDg-0002xY-Or
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:10:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fuIDd-0002yD-Ck
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:10:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59604
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fuIDd-0002vr-4l
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:10:13 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w7RE9ea4013333
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 10:10:10 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2m4h7tme9c-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 10:10:10 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 27 Aug 2018 08:10:09 -0600
References: <20180810153223.28409-1-marcandre.lureau@redhat.com>
	<20180810153223.28409-7-marcandre.lureau@redhat.com>
	<20180813110744.3d0ee400@redhat.com>
	<CAJ+F1C+sCoJzOVGxmjKdTjPyk6EH7_vXZT7vdRPCiFrHQmtr7Q@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 27 Aug 2018 10:10:05 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+sCoJzOVGxmjKdTjPyk6EH7_vXZT7vdRPCiFrHQmtr7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <62c55924-3750-b274-7ff3-b677fd7b3ad7@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 6/6] tpm: add ACPI memory clear interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 08/14/2018 06:02 AM, Marc-Andr=C3=A9 Lureau wrote:
>
>>> --- a/docs/specs/tpm.txt
>>> +++ b/docs/specs/tpm.txt
>>> @@ -121,6 +121,8 @@ layout:
>>>    +----------+--------+--------+------------------------------------=
-------+
>>>    | next_step|   0x1  |  0x159 | Operation to execute after reboot b=
y      |
>>>    |          |        |        | firmware. Used by firmware.        =
       |
>>> + +----------+--------+--------+-------------------------------------=
------+
>>> + | movv     |   0x1  |  0x200 | Memory overwrite variable           =
      |
>>>    +----------+--------+--------+------------------------------------=
-------+
>> why 0x200 and not 0x15a ?
>>
> I thought it would be better to leave some room for PPI, but that
> probably doesn't help much. Let's move it to 0x15a.
>
>> Btw why TPM_PPI_ADDR_SIZE is 0x400 and excess bytes aren't documented =
anywhere?
> I guess for the same reason, Stefan wanted to have some room for
> future changes. Is that a problem?
>
> Stefan, can you confirm?
Yes, this was the primary reason.

 =C2=A0=C2=A0 Stefan
