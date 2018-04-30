Received: from eggs.gnu.org ([2001:4830:134:3::10]:38646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDCjP-0004En-Ji
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 13:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDCjM-0003dj-FP
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 13:36:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59084 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fDCjM-0003dR-AE
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 13:36:52 -0400
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
Date: Mon, 30 Apr 2018 19:36:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180430132107.0a37704d.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 30.04.2018 13:21, Cornelia Huck wrote:
> On Mon, 30 Apr 2018 11:33:12 +0100
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
[...]
>> Given, that we have a clear deprecation process now, my view is that
>> we should formally declare that major version numbers changes are
>> meaningless. As soon as you try to assign special meaning to major
>> version changes, you open the door to endless debate about whether
>> a particular set of changes is meaningful enough to justify the
>> major version change, leading to eventually 2.42.=20
>=20
> I agree.

I agree with this, too. We've seen that in some v3.0 discussions during
the last year.

>> Two possible options
>>
>>  a) Bump major version once a year, so we'll have 3.0, 3.1, 3.3,
>>     4.0, 4.1, 4.2, 5.0, ...etc  We missed the first release this
>>     year, so we would only have 3.0 and 3.1 this year.
>>
>>  b) Bump major release when minor version gets double-digits.
>>     eg 3.0, 3.1, ...., 3.9, 3.9, 4.0, ...., 4.9, 5.0...

It's just a matter of taste, but I think I'd prefer variant b). That
will bump the major release approx. every three years which sounds like
a good time frame for me.

> If we bump the major version each year anyway, why not go the whole way
> and use 2018.1, 2018.2, ... (or even <year>.<month>)? The nice thing
> about that is that you can see at a glance when the release took place.

... or simply drop the first two digits and call them 18.1, 18.2, ...?

 Thomas
