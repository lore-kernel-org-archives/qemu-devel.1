Received: from eggs.gnu.org ([2001:4830:134:3::10]:56540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZyBh-0002Ph-OV
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:11:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZyBf-0001bd-3Q
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:11:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZyBe-0001an-Up
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:11:55 -0500
References: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
	<ecc919de-5193-a83c-0e29-4b8d9bc8d7d7@redhat.com>
	<e0cbd675-7872-05c3-8c3e-214ef93e4552@redhat.com>
	<002201d38b9d$f0a248d0$d1e6da70$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <357a23a7-2cac-a14d-f4b9-7f883b101ea7@redhat.com>
Date: Fri, 12 Jan 2018 13:11:40 +0100
MIME-Version: 1.0
In-Reply-To: <002201d38b9d$f0a248d0$d1e6da70$@ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v3 00/30] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org

On 12/01/2018 13:07, Pavel Dovgalyuk wrote:
>=20
>=20
>> -----Original Message-----
>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>> Sent: Friday, January 12, 2018 12:33 PM
>> To: Pavel Dovgalyuk; qemu-devel@nongnu.org
>> Cc: kwolf@redhat.com; peter.maydell@linaro.org; mst@redhat.com; jasowa=
ng@redhat.com;
>> quintela@redhat.com; zuban32s@gmail.com; maria.klimushenkova@ispras.ru=
; dovgaluk@ispras.ru;
>> kraxel@redhat.com; boost.lists@gmail.com; alex.bennee@linaro.org
>> Subject: Re: [Qemu-devel] [RFC PATCH v3 00/30] replay additions
>>
>> On 11/01/2018 13:56, Paolo Bonzini wrote:
>>> On 11/01/2018 09:24, Pavel Dovgalyuk wrote:
>>>> Accidentally sent draft version of patches to the mailing list.
>>>> Please consider this one as the correct one.
>>>>
>>>> This set of patches includex fixes from Alex Benn=C3=A9e for fixing
>>>> BQL and replay locks after inventing the MTTCG. It also includes som=
e
>>>> additional replay patches that makes this set of fixes working.
>>>> It is also fixes some vmstate creation (and loading) issues
>>>> in record/replay modes:
>>>>  - VM start/stop fixes in replay mode
>>>>  - overlay creation for blkreplay filter
>>>>  - fixes for vmstate save/load in record/replay mode
>>>>  - fixes for host clock vmstate
>>>>  - fixes for icount timers vmstate
>>>>
>>>> There is also a set of helper scripts written by Alex Benn=C3=A9e
>>>> for debugging the record/replay code.
>>>
>>> For now, I'm applying patches 13, 24-26 and 28.
>>
>> Which don't compile on Windows.
>=20
> I can't build current version of qemu on Windows.
> For the first time this happened when capstone was included into the bu=
ild.

I've fixed it now.  But please do not submit patches that obviously need
a Windows version without testing them (on Linux you can use "make
docker-test-mingw@fedora" for example if you have a Docker setup).

Paolo
