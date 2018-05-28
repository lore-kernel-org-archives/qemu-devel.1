Received: from eggs.gnu.org ([2001:4830:134:3::10]:57463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fNEOW-0002XK-Hl
	for qemu-devel@nongnu.org; Mon, 28 May 2018 05:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fNEOR-0001th-H0
	for qemu-devel@nongnu.org; Mon, 28 May 2018 05:24:48 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fNEOR-0001t6-AL
	for qemu-devel@nongnu.org; Mon, 28 May 2018 05:24:43 -0400
Received: by mail-wr0-f195.google.com with SMTP id u12-v6so19118025wrn.8
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 02:24:43 -0700 (PDT)
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502093326.2fbec55f.cohuck@redhat.com>
	<CAG7hfcKo62hpq-qkVE8_+pR1R6uQKcG_FuNuNo1yGqGV-6oazQ@mail.gmail.com>
	<20180502075904.GF3308@redhat.com>
	<CAG7hfcKEiNfLR0xW6b2FPFAN1L4xs81ozPXZAZAs=+Wzs6Q2Vw@mail.gmail.com>
	<de11d2a4-3bd0-42e3-5bff-79c160e9c5df@redhat.com>
	<CAG7hfc+rXFSHE7P4dA-2YhSnW1fXmsaK4zT6n9yCf+a_ALxm1A@mail.gmail.com>
	<20180502091039.GK3308@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <17473814-91c4-6816-621c-1762473dc88e@redhat.com>
Date: Mon, 28 May 2018 11:24:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180502091039.GK3308@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Liviu Ionescu <ilg@livius.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 02/05/2018 11:10, Daniel P. Berrangé wrote:
>> it would allow to postpone incompatible removals to relatively seldom
>> major releases, add new features during more often minor releases, and
>> fix bugs during regular patch releases.
>>
>> major releases can be scheduled every 1-2 years, for example, minor
>> releases every 3-6 months, and patch releases when needed.
> No, we do not want to extend the deprecation period further just so that
> we can adopt semver.  We explicitly chose "2 releases", so that every
> deprecation warning has the same lifetime - we don't want some deprecations
> to be 4 months long, while other deprecation warnings are 1+1/2 years long.

In practice it's already "at least" 2 releases, if only because
sometimes 1) people forget, or 2) they are busy with more important
things, or 3) we want to provide a good replacement and it turns out to
be harder than 2 releases.

Paolo
