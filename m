Received: from eggs.gnu.org ([2001:4830:134:3::10]:49538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dKeA6-0006gi-FZ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 01:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dKeA3-0002dz-8H
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 01:14:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dKeA3-0002ds-2c
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 01:14:39 -0400
References: <20170608070716.2954-1-kraxel@redhat.com>
	<CAFEAcA9+194DyFJ=grKX6o9LAUeXHAJgX92gc419+Aa64_PHig@mail.gmail.com>
	<CAFEAcA9YuwACfrciwQnHV-S60AMYZoaNzTKecEE7KzuCt2Wtyg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4a61a587-6dff-e5fd-58aa-fd168e27f876@redhat.com>
Date: Tue, 13 Jun 2017 07:14:33 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9YuwACfrciwQnHV-S60AMYZoaNzTKecEE7KzuCt2Wtyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/7] ui patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12.06.2017 20:08, Peter Maydell wrote:
> On 12 June 2017 at 19:00, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>> This causes configure to barf warnings in my build logs on half
>> my build machines:
>>
>> WARNING: Support for gtk2 will be dropped in future releases.
>> WARNING: Please consider using gtk3 instead.
>>
>> I don't think it is yet possible to drop gtk2.
>=20
> Oh, one of them was the warning about SDL1.2.

Adding the warning does not necessarily mean that we've really got to
drop support for these in the very near future, but it's a good start to
remind people that support for the old versions won't be around forever
;-) And AFAIK the old versions of these libraries are not maintained by
the upstream projects anymore, too, so at one point in time, we've
really got to deprecate support for these in QEMU, too.

So would it at least be feasible to install SDL 2 on that build
machines? (IMHO installing SDL 2 from sources is not too much of a pain,
e.g. it does not require lots of other additional libraries around)

 Thomas
