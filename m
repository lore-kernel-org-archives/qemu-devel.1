Received: from eggs.gnu.org ([2001:4830:134:3::10]:38660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1f0NeV-0003Sb-R3
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 04:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1f0NeS-0000R5-Pz
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 04:38:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36404 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1f0NeS-0000Qc-Lp
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 04:38:48 -0400
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-3-git-send-email-imammedo@redhat.com>
	<20180323204218.GC28161@localhost.localdomain>
	<ebc23db4-34f8-5774-2486-6773af015d30@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <a4855529-fc57-8313-0caa-aa635d24b626@redhat.com>
Date: Mon, 26 Mar 2018 10:38:43 +0200
MIME-Version: 1.0
In-Reply-To: <ebc23db4-34f8-5774-2486-6773af015d30@redhat.com>
Content-Type: text/plain; charset=utf-8
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
To: Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On 23/03/2018 21:49, Eric Blake wrote:
> On 03/23/2018 03:42 PM, Eduardo Habkost wrote:
>> On Mon, Mar 12, 2018 at 02:11:08PM +0100, Igor Mammedov wrote:
>>> it will allow to reuse parse_NumaOptions() for parsing
>>> configuration commands received via QMP interface
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>=20
>>> =C2=A0 end:
>>> +=C2=A0=C2=A0=C2=A0 if (err) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, err=
);
>>> +=C2=A0=C2=A0=C2=A0 }
>>
>> "if (err)" is not necessary here.=C2=A0 See
>> scripts/coccinelle/error_propagate_null.cocci.
>>
>=20
>>> +=C2=A0=C2=A0=C2=A0 parse_NumaOptions(ms, object, &err);
>>> +
>>> +end:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qapi_free_NumaOptions(object);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report_e=
rr(err);
>>
>> We can fix this one too while at it.
>=20
> Hmm - this is the same script mentioned here:
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06293.html
>=20
> Except that patch didn't pick up this file.=C2=A0 Why is Coccinelle not
> seeing this?
>=20

The script only catch error_propagate(), not error_report_err(). And
error_report_err() doesn't check if err is NULL.

Thanks,
Laurent
