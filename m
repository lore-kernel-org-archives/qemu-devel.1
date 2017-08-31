Received: from eggs.gnu.org ([2001:4830:134:3::10]:47113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnN8P-0007ge-Df
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnN8O-0004Od-JZ
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:55:41 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:35814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dnN8O-0004O1-CM
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:55:40 -0400
Received: by mail-wm0-x234.google.com with SMTP id v2so2254031wmf.0
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 03:55:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170831104710.GG17315@redhat.com>
References: <87r2w6eq5n.fsf@gmail.com> <87h8x1yox3.fsf@dusky.pond.sub.org>
	<20170830170941.GB24565@stefanha-x1.localdomain>
	<87bmmwi6r6.fsf@dusky.pond.sub.org>
	<CAFEAcA8r-EqOjZDvP=0mYG7QQ83MU-54RL9Bu8Eb_wPzQo1M7Q@mail.gmail.com>
	<20170831104710.GG17315@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Aug 2017 11:55:18 +0100
Message-ID: <CAFEAcA9pk5n7z5PkLDeuLdvknPmzHqcGtG6in1E9-+BwjVOqTg@mail.gmail.com>
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

On 31 August 2017 at 11:47, Daniel P. Berrange <berrange@redhat.com> wrote:
> If we can update to python 2.7 as our minimum, then supporting py2
> and py3 gets simpler, avoiding some of the nastier hacks, even
> without that though it isn't too hard.

Unfortunately RHEL6 is what's holding us to retaining 2.6
support, and googling suggests that doesn't go EOL until 2020...

thanks
-- PMM
