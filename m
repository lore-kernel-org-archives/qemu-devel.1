Received: from eggs.gnu.org ([2001:4830:134:3::10]:48893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLByM-0005z6-LF
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:20:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLByI-00014h-JB
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:20:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dLByI-00014M-9y
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:20:46 -0400
References: <1497369290-20401-1-git-send-email-peter.maydell@linaro.org>
	<1497369290-20401-2-git-send-email-peter.maydell@linaro.org>
	<f279fd6d-d32f-79e8-66e3-62edc0e425a8@amsat.org>
	<937b2871-7380-4bfc-9a3b-997e496633ff@redhat.com>
	<7b7e4b38-923d-b928-ab09-716b2140273b@amsat.org>
	<7de47a0f-baad-d849-eebd-87c86dae16c1@redhat.com>
	<CAFEAcA8y1GaZ7f-zf5BZQaJkCXNz+t5mD4hkJAB2eCVx7eYr4g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <574e33c9-eb8f-71cb-8d7d-383b618d2f21@redhat.com>
Date: Wed, 14 Jun 2017 19:20:41 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8y1GaZ7f-zf5BZQaJkCXNz+t5mD4hkJAB2eCVx7eYr4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] travis: install more library
 dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, "patches@linaro.org" <patches@linaro.org>, Fam Zheng <famz@redhat.com>



On 14/06/2017 19:04, Peter Maydell wrote:
> On 14 June 2017 at 17:49, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> Well, trusty is 3 years old by now... I wouldn't call that bleeding
>> edge, and it seems like Travis is suggesting using Docker images for
>> those who want to use a newer distro.  This patch and patch 2 are
>> useful, but I think I'd rather get full coverage, either with Shippabl=
e
>> or by keeping on doing manual builds, than to rush things and switch t=
o
>> CI when it's not ready.
>=20
> Yes, I overall agree that we maybe don't want to use Travis
> for this, but I would like us to automate it somehow.
> (I was about 50/50 on whether to tag the patchset as RFC.)
>=20
>> First, I don't think it's accurate to say that scans have been often
>> weeks or months apart:
>>
>>                         #days   #commits
>>         2017-06-05      4       123
>>         2017-06-01      14      214
>>         2017-05-18      3       108
>>         2017-05-15      8       262
>>         2017-05-07      12      149
>>         2017-04-25      24      317
>=20
> Yes, but this one (I think) only happened because I got fed
> up enough of the build being out of date to go and find out
> how to rebuild it and do an upload. I think I also did the
> 1st June one by hand, maybe?

Yes, that one I was super-busy (and travelling until April 16).  On June
1 and June 12 we crossed, you did one at the same time as me but you
must have faster internet uplink (not hard :)).

> I'm more likely to look at coverity during freeze periods
> than less, because bugs coverity notices are more likely
> than not to be candidates for being worth fixing before
> releases, and I don't have my plate full with feature work.
> So I'd rather have the build be as up to date as possible
> during a release so we can catch any bugs that snuck in
> before we hit the last release candidate.

Understood, on the other hand during freeze periods it's easier to look
at what went in and see how safe it is.

> Conversely, if we don't do scans very frequently then the
> "outstanding defects" view gets hard to use because it's
> still showing things we've already fixed and isn't showing
> new things we've introduced but not scanned yet.
The beauty of doing manual scans is that you can do them when that pull
request with lots of Coverity fixes has just gone in. :)  Seriously, I
didn't think frequency was a problem and we must have different
workflows.  I rely more on "all newly detected"/"all newly fixed" than
on the "new" state, because that can more easily show problems in the
build environment, though admittedly a more reproducible scan recipe
makes that less relevant.

Paolo
