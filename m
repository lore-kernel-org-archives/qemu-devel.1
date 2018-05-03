Received: from eggs.gnu.org ([2001:4830:134:3::10]:36768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEApb-0007dr-0q
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEApW-0007xC-0k
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:47:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37400 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fEApV-0007x5-R9
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:47:13 -0400
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502074403.yh5weukbjgqsvp7n@sirius.home.kraxel.org>
	<20180502080200.GG3308@redhat.com>
	<20180503072100.GA5301@stefanha-x1.localdomain>
	<20180503090727.GC11382@redhat.com>
	<CAFEAcA8=mZf8RbQX2-swbUBkoT=RYSVx-oRA2UpzJCqvgGF+KQ@mail.gmail.com>
	<20180503093103.GE11382@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8296fe4e-aa5b-6678-b634-8e2b62c30ef9@redhat.com>
Date: Thu, 3 May 2018 11:47:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180503093103.GE11382@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 03.05.2018 11:31, Daniel P. Berrang=C3=A9 wrote:
> On Thu, May 03, 2018 at 10:26:40AM +0100, Peter Maydell wrote:
>> On 3 May 2018 at 10:07, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>>> On Thu, May 03, 2018 at 08:21:00AM +0100, Stefan Hajnoczi wrote:
>>>> I don't see an issue with time-based numbering schemes.  Ubuntu made=
 it
>>>> popular and other projects (like DPDK) are doing the same thing now.
>>>>
>>>> The convention is YY.MM though, not YYMM.
>>>
>>> It feels like we've got quite a strong backing for time based version=
ing
>>> amongst people replying here. I'd be happy with YY.MM
>>
>> I'm not hugely in favour mostly because I don't much like
>> changing version numbering formats -- does it really gain
>> us anything? But I guess it's a bit of a bikeshed-colour question.
>=20
> You mean the change from 3 to 2 digits ?   We would presumably need to
> stick a zero on the end of it anyway. eg  18.04.0 indicates 2018, May
> initial release. Then 18.04.1 indicates the first stable branch release=
,
> etc.
>=20
> Or if you mean you don't like the jump from 2.x to 18.x, we could just
> follow a time based version scheme, but just bumping major digit once
> a year as I first suggested in this thread ?
>=20
> Both are effectively saying the same thing - we're changing versions
> based on time, not features. So it is largely a matter of whether you
> want the actual date visible or not.

If we're going to a year-based numbering, I think we should do it the
"libvirt" way and simply increment the current number by one each year,
instead of jumping directly to 18. So in case this numbering scheme does
not work out as we expected, we can easier revert back to another
numbering scheme, without looking completely stupid due to the big
number gap and without having to explain later why QEMU version 19 is
*not* released in the year 2019.

 Thomas
