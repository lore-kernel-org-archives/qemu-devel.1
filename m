Received: from eggs.gnu.org ([2001:4830:134:3::10]:54177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dONYZ-0000Jv-6x
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dONYY-0000wN-6F
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:19:23 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:32872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dONYX-0000vw-VL
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:19:22 -0400
Received: by mail-wr0-x230.google.com with SMTP id r103so63524454wrb.0
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 05:19:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <874lv6gc19.fsf@dusky.pond.sub.org>
References: <20170606110556.12922-1-berrange@redhat.com>
	<20170606110556.12922-3-berrange@redhat.com>
	<874lv6gc19.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2017 13:19:00 +0100
Message-ID: <CAFEAcA_HSAaxFUcWA=Uc1wY61=tPZMSsFD=ZKCYcsiy-9Wc7xQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] docs: document support lifetime for
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 23 June 2017 at 12:48, Markus Armbruster <armbru@redhat.com> wrote:
> "Daniel P. Berrange" <berrange@redhat.com> writes:
>> +The supported lifetime for machine types is 12 releases, which is
>> +equivalent to 4 years worth of previous QEMU releases.
>> +
>
> Do we have consensus on this?  Peter?

I don't have an opinion personally because I don't care
about backcompat for what I use QEMU for. From a pure
upstream perspective, given that we don't support anything
beyond the previous stable branch for security fixes we
already don't really expect people to be doing production
work on old upstream releases. So this is a distro
question really and we need input from the people who
package QEMU. Given that for instance Ubuntu LTSes get
5 years of support I would guess that 4 years might be
a little low, but really we should ask the people with
a more informed opinion.

thanks
-- PMM
