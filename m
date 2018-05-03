Received: from eggs.gnu.org ([2001:4830:134:3::10]:45381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEEsM-0005Vz-Sp
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEEsJ-00020Y-HC
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:06:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55482 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fEEsJ-000202-B1
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:06:23 -0400
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502074403.yh5weukbjgqsvp7n@sirius.home.kraxel.org>
	<20180502080200.GG3308@redhat.com>
	<20180503072100.GA5301@stefanha-x1.localdomain>
	<20180503090727.GC11382@redhat.com>
	<CAFEAcA8=mZf8RbQX2-swbUBkoT=RYSVx-oRA2UpzJCqvgGF+KQ@mail.gmail.com>
	<20180503134321.pp736ou25pdwvslm@sirius.home.kraxel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d9203797-be4a-3cd7-c718-56fa41f60310@redhat.com>
Date: Thu, 3 May 2018 16:06:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180503134321.pp736ou25pdwvslm@sirius.home.kraxel.org>
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
To: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 03.05.2018 15:43, Gerd Hoffmann wrote:
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
> Well, major/minor numbers don't mean anything.  So I think it makes
> sense to give them a meaning, and given we do time-based releases it
> surely makes sense to use a time-based scheme.  Major indicating the
> year is the obvious and common choice here.  Various variants are in
> use:
>=20
>   (a) major equals year, minor equals month (ubuntu style).
>   (b) major equals year, minor counts up (mesa style).
>   (c) major is bumped each year, but doesn't equal year (libvirt style)=
.
>=20
> If we don't want give them a meaning, how about:
>=20
>   (d) just drop the minor and count up major each release (systemd styl=
e)?
>=20
> My personal preference would be (a) or (b), because it is easy to see
> when a version was released.  (b) looks more like a classic version
> number, we would have 18.0, 18.1, ... instead of 18.04, 18.08, ...

I'd really would like to avoid variant (a) ... otherwise people will
confuse 18.1.1 and 18.11 (aka. 18.11.0) again...

 Thomas
