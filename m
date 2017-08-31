Received: from eggs.gnu.org ([2001:4830:134:3::10]:47152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnOvq-0000Tx-JY
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnOvp-0006EC-T6
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:50:50 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:36955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dnOvp-0006Cb-Ml
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:50:49 -0400
Received: by mail-wr0-x230.google.com with SMTP id k9so1800987wre.4
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 05:50:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170831110222.GH17315@redhat.com>
References: <87r2w6eq5n.fsf@gmail.com> <87h8x1yox3.fsf@dusky.pond.sub.org>
	<20170830170941.GB24565@stefanha-x1.localdomain>
	<87bmmwi6r6.fsf@dusky.pond.sub.org>
	<CAFEAcA8r-EqOjZDvP=0mYG7QQ83MU-54RL9Bu8Eb_wPzQo1M7Q@mail.gmail.com>
	<20170831104710.GG17315@redhat.com>
	<CAFEAcA9pk5n7z5PkLDeuLdvknPmzHqcGtG6in1E9-+BwjVOqTg@mail.gmail.com>
	<20170831110222.GH17315@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Aug 2017 13:50:27 +0100
Message-ID: <CAFEAcA8tNXShUHB1L2g9u02CKmmJ+mX9nytSsi-HZ6Dmu0zxYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] scripts: Support building with Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, David Michael <fedora.dm0@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 31 August 2017 at 12:02, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Thu, Aug 31, 2017 at 11:55:18AM +0100, Peter Maydell wrote:
>> On 31 August 2017 at 11:47, Daniel P. Berrange <berrange@redhat.com> wrote:
>> > If we can update to python 2.7 as our minimum, then supporting py2
>> > and py3 gets simpler, avoiding some of the nastier hacks, even
>> > without that though it isn't too hard.
>>
>> Unfortunately RHEL6 is what's holding us to retaining 2.6
>> support, and googling suggests that doesn't go EOL until 2020...
>
> Who is actually requiring that we support RHEL6 until EOL though ?

OK, if we don't need to retain RHEL6 support that would help
(we should in that case not bother pulling in that big lump
of argument parsing code that just went past in a patchset
purely for the benefit of 2.6 support). How are the other
LTS distros for Python versions?

thanks
-- PMM
