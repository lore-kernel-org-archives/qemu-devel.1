Received: from eggs.gnu.org ([2001:4830:134:3::10]:46088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cdTrh-0005BF-SR
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 22:33:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cdTre-0004g6-QT
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 22:33:17 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:35498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1cdTre-0004fr-LW
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 22:33:14 -0500
Received: by mail-it0-x243.google.com with SMTP id 203so2538898ith.2
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 19:33:13 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <ec491d8c-3fb0-3ce9-5558-ac4ab1455f7f@twiddle.net>
Date: Mon, 13 Feb 2017 22:33:09 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <4BE06A79-02EC-48A8-8081-F21CEACE396F@gmail.com>
References: <mailman.51026.1486615955.22738.qemu-devel@nongnu.org>
	<8C14E9D0-F376-4CDC-BF24-A0609A329977@gmail.com>
	<20170210003916.GL32144@lianli.shorne-pla.net>
	<ec491d8c-3fb0-3ce9-5558-ac4ab1455f7f@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 00/22] target/openrisc updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Stafford Horne <shorne@gmail.com>, Openrisc <openrisc@lists.librecores.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>


On Feb 13, 2017, at 10:25 PM, Richard Henderson wrote:

> On 02/10/2017 11:39 AM, Stafford Horne wrote:
>> On Thu, Feb 09, 2017 at 09:10:51AM -0500, G 3 wrote:
>>>=20
>>> On Feb 8, 2017, at 11:52 PM, qemu-devel-request@nongnu.org wrote:
>>>=20
>>>> Message: 6
>>>> Date: Wed,  8 Feb 2017 20:51:32 -0800
>>>> From: Richard Henderson <rth@twiddle.net>
>>>> To: qemu-devel@nongnu.org
>>>> Cc: shorne@gmail.com
>>>> Subject: [Qemu-devel] [PATCH 00/22] target/openrisc updates
>>>> Message-ID: <20170209045154.16868-1-rth@twiddle.net>
>>>>=20
>>>> The bulk of this patch set is 2-3 years old, and was mostly
>>>> reviewed by Bastian Koppelmann.  But it languished because
>>>> there were reports of it not booting kernel images, and I
>>>> had problems putting together a set of tools that could even
>>>> build a kernel.
>>>>=20
>>>> The OpenRISC community has picked up activity recently,
>>>> with Stafford Horne upstreaming some of the compiler tools.
>>>> He has even done some testing for me of this patch set.
>>>>=20
>>>>=20
>>>> r~
>>>=20
>>> I see you are working on OpenRISC. Would you be able to help
>>> me improve its wiki page?
>>>=20
>>> http://wiki.qemu-project.org/Documentation/Platforms/OpenRISC
>>>=20
>>> Right now there isn't much information on OpenRISC here. I'm
>>> hoping to make it a lot useful to anyone who is interesting in this
>>> platform.
>>>=20
>>> Would you know of any links to software that works in OpenRISC?
>>>=20
>>> Pictures of the OpenRISC target running anything would be great =
also.
>>>=20
>>> What is your suggested command-line for using OpenRISC?
>>>=20
>>> If you have any suggestions on how to improve the page place don't
>>> hesitate to let me know.
>>>=20
>>=20
>> Hi Richard, G 3,
>>=20
>> I am not sure if Richard has the time for this.  But I kind of got =
him
>> started back on the openrisc work, it would be my fault to burden him
>> with even more work :).  Also, I was helping to do some tests so I =
have
>> some example commands.
>=20
> :-)
>=20
>> I don't have a lot of time, but I think I can help to update the =
above.
>> Probably Richard and I could work together?
>>=20
>> I was recently working on updating the openrisc page
>>=20
>>  http://openrisc.io
>>=20
>> I think I could link between the two for toolchain compile guides and
>> software guides (i.e. debugging and linux).
>>=20
>> Richard what do you think?
>=20
> Probably the most beneficial thing that we can do is create a =
kernel+initrd that boots into a busybox root shell.  Similar to the =
other test images that we have at
>=20
>  http://wiki.qemu-project.org/Testing/System_Images
>=20
>=20
> r~
>=20

We could do both the test image and a wiki page.=
