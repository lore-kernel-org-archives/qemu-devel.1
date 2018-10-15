Received: from eggs.gnu.org ([2001:4830:134:3::10]:34039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gC7Sx-0000L4-1A
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gC7St-0002Qu-GC
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:19:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gC7Sr-0002OP-45
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:19:38 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9FIIjiZ142182
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 14:19:28 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n4w9syfhp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 14:19:28 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 15 Oct 2018 19:19:25 +0100
References: <20181013050227.17022-1-ehabkost@redhat.com>
	<20181015093243.GE6785@redhat.com>
	<CAFEAcA8MQ37JVCCPGyQa20n6AuU8Sv_pC9DoDoCKdQhqekpGnQ@mail.gmail.com>
	<20181015101309.GD10459@localhost.localdomain>
	<87woqjw4o3.fsf@dusky.pond.sub.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 15 Oct 2018 20:19:18 +0200
MIME-Version: 1.0
In-Reply-To: <87woqjw4o3.fsf@dusky.pond.sub.org>
Content-Language: en-US
Message-Id: <d1335244-1aaa-a6e6-e27f-a4de6a38a785@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] Require Python 3 for building QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>



On 10/15/2018 06:33 PM, Markus Armbruster wrote:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
>> Am 15.10.2018 um 12:02 hat Peter Maydell geschrieben:
>>> On 15 October 2018 at 10:32, Daniel P. Berrang=C3=A9 <berrange@redhat=
.com> wrote:
>>>> On Sat, Oct 13, 2018 at 02:02:27AM -0300, Eduardo Habkost wrote:
>>>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>>>> ---
>>>>> I'd like to do this in QEMU 3.1.  I think it's time to drop
>>>>> support for old systems that have only Python 2.
>>>>>
>>>>> We still have a few scripts that are not required for building
>>>>> QEMU that still work only with Python 2 (iotests being the most
>>>>> relevant set).  Requiring Python 3 for building QEMU won't
>>>>> prevent people from using those scripts with Python 2 until they
>>>>> are finally ported.
>>>>
>>>> I think it is premature & unecessary to do this. We just got QEMU bu=
ilding
>>>> with dual Python2/3 in 3.0 to give people leeway in the migration pa=
th to
>>>> a fully v3 future. The code to support building 2/3 in parallel is n=
ot
>>>> imposing a unreasonable maint burden. Dropping py2 suport would have
>>>> negligible impact on the code, as there's no v3-only features we hav=
e
>>>> used. IOW, I don't think there's a compelling reason to rush into fo=
rcing
>>>> users onto v3.
>>>>
>>>> If we want to drop py2, we should give people a warning of such a pl=
anned
>>>> change, especially since some of our targetted host OS[1] don't even
>>>> include a py3 as standard without acquiring extra add-on repos. Devs=
 in
>>>> a typical corporate env will not have the freedom to install such ex=
tra
>>>> repos on their machines.
>>>
>>> I agree. I also think that dropping python 2 support before we've
>>> even converted all our python scripts to handle python 3 is the
>>> wrong order to do things. People interested in moving forward with
>>> the transition to python-3-only should start by making sure everythin=
g
>>> we have works with python 3...
>>
>> It's easier to port stuff to Python 3 though than making them work wit=
h
>> both. I think Eduardo's RFC is in part motivated by a patch from
>> Philippe that converted something in iotests to work with Python 3,
>> passed review and then turned out to break Python 2.
>=20
> Seconded.  This is not about the cost of maintaining existing
> compatibility gunk, it's about the extra effort to first get the
> remainder to work with 2 and 3, only to throw away 2 a few months later.
>=20
> I propose we permit ourselves to port stuff that isn't essential to
> building QEMU straight to 3 instead.  This includes iotests.
>=20
>> Having to test every iotests patch twice with different Python version=
s
>> isn't something I would like to do for extended periods of time.
>=20
> It's worth doing only if the benefits of doing it outweigh the costs.  =
I
> don't think they do.

FWIW, I do not care about python 2 vs 3. I just want to emphasize that I=20
consider the qemu iotest a very valuable part of the qemu test suite as i=
t
has detected a lot of regressions over the past years. So as long as we k=
eep
that running I am fine.
>=20
