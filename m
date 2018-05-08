Received: from eggs.gnu.org ([2001:4830:134:3::10]:38614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fG3Qn-0008BQ-MP
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fG3Qj-0001h2-EA
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:17:29 -0400
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-5-git-send-email-mst@redhat.com>
	<b3620ea6-0805-ccec-3bd5-11dc30bc2569@redhat.com>
	<20180508152349.15ad26d0.cohuck@redhat.com>
	<bc3f13f6-56fd-058d-d717-508b7034d437@redhat.com>
	<20180508154538.1b55f721.cohuck@redhat.com>
	<b335f5ae-a99e-310c-edb2-65755a2ca51a@redhat.com>
	<e05f0ed0-43cc-dc80-a5a5-7782bc77faff@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <02f0e79e-251e-5b51-6e52-d741f14a1fcd@redhat.com>
Date: Tue, 8 May 2018 16:17:09 +0200
MIME-Version: 1.0
In-Reply-To: <e05f0ed0-43cc-dc80-a5a5-7782bc77faff@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/67] s390x: drop an unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Cornelia Huck <cohuck@redhat.com>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org

On 08.05.2018 16:06, Philippe Mathieu-Daud=C3=A9 wrote:
> On 05/08/2018 10:50 AM, Thomas Huth wrote:
>> On 08.05.2018 15:45, Cornelia Huck wrote:
>>> On Tue, 8 May 2018 15:38:03 +0200
>>> Thomas Huth <thuth@redhat.com> wrote:
>>>
>>>> On 08.05.2018 15:23, Cornelia Huck wrote:
[...]
>>>>> Hm, I'm wondering why we do the typedef in cpu-qom.h, while other
>>>>> architectures do it in their cpu.h. =20
>>>>
>>>> See:
>>>>
>>>> commit ef2974cc270d51959ce90df6b4d4d41635d7a603
>>>> Author: David Hildenbrand <david@redhat.com>
>>>> Date:   Wed Sep 13 15:24:02 2017 +0200
>>>>
>>>>     target/s390x: move some s390x typedefs to cpu-qom.h
>>>>    =20
>>>>     This allows us to drop inclusion of cpu_models.h in cpu-qom.h, a=
nd
>>>>     prepares for using cpu-qom.h as a s390 specific version of typed=
efs.h
>>>>    =20
>>>>     Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>     Message-Id: <20170913132417.24384-8-david@redhat.com>
>>>>     Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>>     Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>>>
>>>>  Thomas
>>>
>>> Gargh, this is all very confusing...
>>
>> If you'd ask me, I'd say we should get rid of the typedefs and do it t=
he
>> Linux kernel way and enforce using "struct xyz" everywhere, then you
>> also do not have this problem with typedefs.h anymore ... but well, so
>> far it seems as I'm still part of a minority with this opinion here.
>=20
> Maybe not getting rid of the typedefs, but I agree with removing typede=
fs.h.

But you need a way to do forward declarations ... thus you need
something like typedefs.h as long as you use typedefs. Otherwise older
versions of GCC will choke on multiple "typedef struct XyZ XyZ" statement=
s.

 Thomas
