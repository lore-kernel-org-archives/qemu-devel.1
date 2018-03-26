Received: from eggs.gnu.org ([2001:4830:134:3::10]:44593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0TBk-0001Ys-0o
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0TBf-0001dc-T7
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:33:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36734 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0TBf-0001dI-Oq
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:33:27 -0400
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-3-git-send-email-imammedo@redhat.com>
	<20180323204218.GC28161@localhost.localdomain>
	<ebc23db4-34f8-5774-2486-6773af015d30@redhat.com>
	<a4855529-fc57-8313-0caa-aa635d24b626@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <75dc5dac-3afe-a3e2-633d-89088252d5da@redhat.com>
Date: Mon, 26 Mar 2018 09:33:18 -0500
MIME-Version: 1.0
In-Reply-To: <a4855529-fc57-8313-0caa-aa635d24b626@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/9] numa: split out NumaOptions parsing
 into parse_NumaOptions()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On 03/26/2018 03:38 AM, Laurent Vivier wrote:

>>>>  =C2=A0 end:
>>>> +=C2=A0=C2=A0=C2=A0 if (err) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, er=
r);
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>
>>> "if (err)" is not necessary here.=C2=A0 See
>>> scripts/coccinelle/error_propagate_null.cocci.
>>>
>>
>>>> +=C2=A0=C2=A0=C2=A0 parse_NumaOptions(ms, object, &err);
>>>> +
>>>> +end:
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qapi_free_NumaOptions(object);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report=
_err(err);
>>>
>>> We can fix this one too while at it.
>>
>> Hmm - this is the same script mentioned here:
>> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06293.html
>>
>> Except that patch didn't pick up this file.=C2=A0 Why is Coccinelle no=
t
>> seeing this?
>>
>=20
> The script only catch error_propagate(), not error_report_err(). And
> error_report_err() doesn't check if err is NULL.

Aha - chalk it up to reviewing late in the day; I saw an 'if (err)' but=20
didn't pay close attention to what was being guarded in the two=20
different conditionals.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
