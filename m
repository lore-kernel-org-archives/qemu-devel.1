Received: from eggs.gnu.org ([2001:4830:134:3::10]:34221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eXPhC-0000AW-5D
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 05:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eXPh9-0004Dy-0a
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 05:57:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eXPh8-0004D9-QG
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 05:57:50 -0500
References: <6d95cc4b-155c-44cb-1fc0-18ba848741ac@profihost.ag>
	<446087972.818501.1515050674109.JavaMail.zimbra@oxygem.tv>
	<1548618960.818551.1515050828217.JavaMail.zimbra@oxygem.tv>
	<cb656289-97ee-d45e-cfcc-51e86b9a11ce@profihost.ag>
	<130240891.820052.1515054901352.JavaMail.zimbra@oxygem.tv>
	<671681eb-5d03-1797-4b0e-70b6e8b7b257@redhat.com>
	<b3231ee0-a232-057b-dbfe-bd31e0d4bf02@profihost.ag>
	<24204049-c489-df35-3775-ee5121e13f0f@redhat.com>
	<27133122-E470-4CDB-8732-FD83A1ADF2AF@profihost.ag>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a72871a4-c3bd-5872-4891-92b98035dd85@redhat.com>
Date: Fri, 5 Jan 2018 11:57:47 +0100
MIME-Version: 1.0
In-Reply-To: <27133122-E470-4CDB-8732-FD83A1ADF2AF@profihost.ag>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] CVE-2017-5715: relevant qemu patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, qemu-devel <qemu-devel@nongnu.org>

On 05/01/2018 11:40, Stefan Priebe - Profihost AG wrote:
> Thanks! But it=E2=80=98s very difficult to get all opinions all togethe=
r.
>=20
> SuSE Enterprise told me to update:
> - kernel
> - qemu
> - Intel microcode
>=20
> And the released already updates for all of them.

Yes, but live migrate an updated guest from updated to non-updated host
and you'll have a bad surprise.

Paolo

> Stefan
>=20
> Excuse my typo sent from my mobile phone.
>=20
> Am 05.01.2018 um 09:33 schrieb Paolo Bonzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>>:
>=20
>> On 04/01/2018 21:15, Stefan Priebe - Profihost AG wrote:
>>> attached the relevant patch for everybody who needs it.
>>
>> This is the original patch from Intel, which doesn't work unless you
>> have a patched kernel (which you almost certainly don't have) and
>> doesn't even warn you about that.
>>
>> In other words, it's rubbish. =C2=A0Please read
>> https://www.qemu.org/2018/01/04/spectre/ several times, until you
>> understand why there is no urgent need to update QEMU.
>>
>> Days are 24 hours for QEMU developers just like for you (and believe m=
e,
>> we wished several times that they weren't during the last two months).
>> We are prioritizing the fixes according to their effect in mitigating
>> the vulnerability, their applicability and the availability of patches
>> to the lower levels of the stack. =C2=A0Right now, the most urgent par=
t is
>> the simple mitigations that can go in Linux 4.15 and stable kernels.
>>
>> Paolo
