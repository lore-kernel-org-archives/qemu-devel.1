Received: from eggs.gnu.org ([209.51.188.92]:60764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glsYC-0000fH-BV
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glsY8-00039m-9e
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:40:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1glsY7-00036D-4W
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:40:52 -0500
References: <20190116191950.94110-1-emaste@freefall.freebsd.org>
	<20190118144724.66914-1-emaste@freebsd.org>
	<8def73c9-23e5-9f87-81d1-dda0c7e6f7d9@redhat.com>
	<242e057a-0c35-93b1-1249-93799cdf1196@redhat.com>
	<CAPyFy2BLuGCYx0-GUdy5w8HD0u3hkvH3DGmCV+9OKYjtkr6rew@mail.gmail.com>
	<CAPyFy2DNJvE4GbXxtzFJe8bPiXQm+bOmp+D_zVSCtaJML18vzw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6272e5b7-477c-6a38-97cd-a16b94c209d5@redhat.com>
Date: Tue, 22 Jan 2019 10:40:14 +0100
MIME-Version: 1.0
In-Reply-To: <CAPyFy2DNJvE4GbXxtzFJe8bPiXQm+bOmp+D_zVSCtaJML18vzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Maste <emaste@freebsd.org>
Cc: Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 2019-01-21 17:30, Ed Maste wrote:
> On Mon, 21 Jan 2019 at 10:16, Ed Maste <emaste@freebsd.org> wrote:
>>
>> To confirm, I have another build running now with
>> echo "Running with hw.ncpu=3D$(sysctl -n hw.ncpu)"
>> added.
>=20
> Confirmed - https://cirrus-ci.com/build/5768962257190912:
> Running with hw.ncpu=3D8
>=20
> If there is some sort of hanging test issue I could try wrapping it in
> timeout and outputting ps and other info upon failure.

Ok, I did some more tests today. First two runs were simply killed:

 https://cirrus-ci.com/build/5478092878381056
 https://cirrus-ci.com/build/5754149284085760

Then I tried to decrease the amount of resources to 4 CPUs and 8G of
RAM, but that timed out:

 https://cirrus-ci.com/build/6003268728651776

Then I finally increased the CPUs back to 8 again, but stick with 8G of
RAM, and that indeed finished in time successfully:

 https://cirrus-ci.com/build/6218565876187136

So yes, looks like 8 CPUs should work indeed, but I think you should
decrease the amount of memory of the VM, to make sure that it does not
get killed so easily. 8 GB of RAM should also be enough to compile QEMU,
as far as I can tell.

 Thomas


PS: I also removed the V=3D1 in my tests since otherwise the log was way
to verbose for my taste ... but that's likely really just a matter of tas=
te.
