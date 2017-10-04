Received: from eggs.gnu.org ([2001:4830:134:3::10]:33795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dzkMQ-0005eX-LX
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 10:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dzkMN-00072U-Dn
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 10:09:18 -0400
Received: from mail-it0-x236.google.com ([2607:f8b0:4001:c0b::236]:49473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dzkMN-00071r-8v
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 10:09:15 -0400
Received: by mail-it0-x236.google.com with SMTP id c195so16326798itb.4
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 07:09:15 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20171004054817.GD24018@lemon>
Date: Wed, 4 Oct 2017 10:09:12 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <60AAE052-6D54-42B7-824F-8CDD0A64AF17@gmail.com>
References: <mailman.5237.1506939080.14747.qemu-devel@gnu.org>
	<13D44E07-31FB-4DCB-AAA7-6EF24670BF14@gmail.com>
	<20171004054817.GD24018@lemon>
Subject: Re: [Qemu-devel] [PATCH v8 0/6] Initial support for keycodemapdb
 GIT submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>


> On Oct 4, 2017, at 1:48 AM, Fam Zheng <famz@redhat.com> wrote:
>=20
> On Mon, 10/02 11:52, Programmingkid wrote:
>>=20
>>> On Oct 2, 2017, at 6:11 AM, qemu-devel-request@gnu.org wrote:
>>>=20
>>> Message: 21
>>> Date: Mon, 2 Oct 2017 10:56:27 +0100
>>> From: "Daniel P. Berrange" <berrange@redhat.com>
>>> To: qemu-devel@nongnu.org
>>> Cc: Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
>>> 	Peter Maydell <peter.maydell@linaro.org>,	Paolo Bonzini
>>> 	<pbonzini@redhat.com>
>>> Subject: Re: [Qemu-devel] [PATCH v8 0/6] Initial support for
>>> 	keycodemapdb GIT submodule
>>> Message-ID: <20171002095627.GD27086@redhat.com>
>>> Content-Type: text/plain; charset=3Dutf-8
>>>=20
>>> FYI, in case people were wondering, patchew successfully passed all
>>> tests. So it looks like 8th time lucky for getting submodules =
working
>>> correctly unless someone can break it again.....
>>>=20
>>> http://patchew.org/QEMU/20170929101201.21039-1-berrange@redhat.com/
>>=20
>> Using the above link I was able to copy and paste your patches to my =
computer. The problem was 'git am' kept saying "Patch format detection =
failed". Using 'git apply' was what I used instead. After running 'make' =
I saw this error:=20
>=20
> Since you've noticed the link: in the beginning of that page there is =
also an
> easy way to get the patches by one command:
>=20
>> git fetch https://github.com/patchew-project/qemu =
patchew/20170929101201.21039-1-berrange@redhat.com
>=20
> Fam

Thank you very much for the info. I was able to finally 'make' QEMU with =
this patch set. Didn't notice any problems with qemu-system-ppc or =
qemu-system-i386.=20=
