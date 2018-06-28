Received: from eggs.gnu.org ([2001:4830:134:3::10]:39341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fYZEz-0005QN-KQ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fYZEw-000656-HY
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:53:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fYZEw-00062l-68
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:53:46 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5SFn2FB006605
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 11:53:44 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jw1c6mj0w-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 11:53:44 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 28 Jun 2018 11:53:43 -0400
References: <20180626122343.13473-1-marcandre.lureau@redhat.com>
	<20180626122343.13473-5-marcandre.lureau@redhat.com>
	<20180627151948.5779e60b@redhat.com>
	<CAJ+F1CKKaw0GyD_94bvpC97NheYqstUF6NLDbeGaRj0BUw_H7g@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 28 Jun 2018 11:53:39 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKKaw0GyD_94bvpC97NheYqstUF6NLDbeGaRj0BUw_H7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <2191e826-c5c0-dcce-e336-cc4d3572f74a@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 4/4] acpi: build TPM Physical Presence
 interface
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

On 06/28/2018 11:24 AM, Marc-Andr=C3=A9 Lureau wrote:
>
>>> +            ifctx2 =3D aml_if(aml_equal(func_idx, aml_int(3)));
>>> +            {
>>> +                /* revision to integer */
>>> +                aml_append(ifctx2,
>>> +                           aml_store(
>>> +                               aml_to_integer(aml_arg(1)),
>> same do you need cast here, by spec it's 'int' already?
>>
> Yeah, looks like it's unnecessary. Stefan?

Iirc some things were not working at the beginning when I wrote this=20
ACPI thing and one problem went away by doing this cast, though it may=20
have overlapped with other issues. I cannot say for sure.
