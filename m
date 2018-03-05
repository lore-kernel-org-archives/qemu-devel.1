Received: from eggs.gnu.org ([2001:4830:134:3::10]:37632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eswnV-0004w1-AQ
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 15:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eswnS-0006g2-7C
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 15:33:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58060
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eswnS-0006fr-1k
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 15:33:22 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w25KTg7N113805
	for <qemu-devel@nongnu.org>; Mon, 5 Mar 2018 15:33:21 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ghav5d4us-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 15:33:20 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 5 Mar 2018 13:33:19 -0700
References: <1519934373-3629-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1519934373-3629-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CLUyeroa3wDDnC2tgAbvo+GChT4aADQUWF5y7Zn6_3KsQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 5 Mar 2018 15:33:16 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLUyeroa3wDDnC2tgAbvo+GChT4aADQUWF5y7Zn6_3KsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d6b055ef-4222-c3bb-22ea-c0a7999e9d56@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/2] tpm: extend TPM emulator with state
 migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 03/02/2018 04:26 AM, Marc-Andr=C3=A9 Lureau wrote:
>
>> +    return 0;
>> +}
>> +
>> +static const VMStateDescription vmstate_tpm_emulator =3D {
>> +    .name =3D "tpm-emulator",
>> +    .version_id =3D 1,
>> +    .minimum_version_id =3D 0,
> version_id =3D 1 & minimum_version_id =3D 0 ?
>
> It's the first version, let's have version_id =3D 0 (and you could
> remove minimum_version).

It doesn't work...  I cannot use version_id 0 in tpm_tis or in=20
tpm_emulator. For tpm_tis I get the error 'Missing section footer' upon=20
VM resume and for some weird reason it doesn't allocate the blob buffers=20
when reading them in tpm_emulator. I get a NULL pointer instead. So, we=20
are better off with version_id 1 here... The CRB seems to work as is.

    Stefan
