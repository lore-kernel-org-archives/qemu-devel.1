Received: from eggs.gnu.org ([2001:4830:134:3::10]:49345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ffoNX-0002vK-7H
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ffoNW-0001Vv-FY
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:28:35 -0400
References: <20180717234015.22700-1-f4bug@amsat.org>
	<20180718145312.GZ31657@localhost.localdomain>
	<8fbaf02a-752c-2fec-5bbd-9b31839ce19a@amsat.org>
	<20180718150510.GA31657@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <dfde19a3-a51a-7025-6d41-9910bb2d130b@redhat.com>
Date: Wed, 18 Jul 2018 11:28:29 -0400
MIME-Version: 1.0
In-Reply-To: <20180718150510.GA31657@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-3.1] qemu-iotests: Adapt
 to moved location of StringIO module in py3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>



On 07/18/2018 11:05 AM, Eduardo Habkost wrote:
> On Wed, Jul 18, 2018 at 12:02:39PM -0300, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> Hi Eduardo,
>>
>> On 07/18/2018 11:53 AM, Eduardo Habkost wrote:
>>> On Tue, Jul 17, 2018 at 08:40:15PM -0300, Philippe Mathieu-Daud=C3=A9=
 wrote:
>>> [...]
>>>> -    import StringIO
>>>> +    try:
>>>> +        from StringIO import StringIO
>>>> +    except ImportError:
>>>> +        from io import StringIO
>>>
>>> Why do we need this?  Python 2.7 has io.StringIO.
>>
>> Python 2 works fine, the problem is the Fedora Docker image uses Pytho=
n
>> 3 and the block tests started to fail...
>=20
> My question is: why use StringIO.StringIO on Python 2 and
> io.StringIO on Python 3, if io.StringIO works on both Python
> versions?
>=20

Holdover from when 2.6 was our requisite version, surely.

--js
