Received: from eggs.gnu.org ([2001:4830:134:3::10]:52611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gK2LQ-0006ne-GZ
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:28:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gK2LM-00023W-1v
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:28:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42744
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gK2LK-0001zU-5W
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:28:34 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wA6ELAjO002193
	for <qemu-devel@nongnu.org>; Tue, 6 Nov 2018 09:28:32 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nkbudav3f-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 09:28:32 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Tue, 6 Nov 2018 14:28:31 -0000
References: <20181106052144.31841-1-ppandit@redhat.com>
	<20181106052144.31841-2-ppandit@redhat.com>
	<CAJ+F1C+EdebPX5jo0k7hh4nw1vL2hT9TOec3_b6AvizNQyfZ0g@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Tue, 6 Nov 2018 09:28:27 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+EdebPX5jo0k7hh4nw1vL2hT9TOec3_b6AvizNQyfZ0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <2c3e5be5-c01e-5c04-b978-069eb55ca83c@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] tpm: use loop iterator to set sts data
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, P J P <ppandit@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>

On 11/6/18 3:13 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Tue, Nov 6, 2018 at 9:24 AM P J P <ppandit@redhat.com> wrote:
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> When TIS request is done, set 'sts' data field across all localities.
> The code certainly meant to set the field across all localities.
> However I don't see in the "TCG PC Client Specific TPM Interface
> Specification (TIS)" where it states that the field should be set
> across all localities. Could you quote the relevant part?

I don't see it explicitly mentioned but would interpret it as being a=20
flag across all localities.


 =C2=A0=C2=A0=C2=A0 Stefan


>
> thanks
>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>> ---
>>   hw/tpm/tpm_tis.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
>> index 20126dd838..58d90645bc 100644
>> --- a/hw/tpm/tpm_tis.c
>> +++ b/hw/tpm/tpm_tis.c
>> @@ -299,7 +299,7 @@ static void tpm_tis_request_completed(TPMIf *ti, i=
nt ret)
>>
>>       if (s->cmd.selftest_done) {
>>           for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
>> -            s->loc[locty].sts |=3D TPM_TIS_STS_SELFTEST_DONE;
>> +            s->loc[l].sts |=3D TPM_TIS_STS_SELFTEST_DONE;
>>           }
>>       }
>>
>> --
>> 2.17.2
>>
>>
>
