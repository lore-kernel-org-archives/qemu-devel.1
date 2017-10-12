Received: from eggs.gnu.org ([2001:4830:134:3::10]:35988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2cpa-00023W-4t
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2cpZ-0000Z0-3c
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:43:18 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:56966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2cpY-0000YK-SF
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:43:17 -0400
Received: by mail-wm0-x236.google.com with SMTP id l68so12987479wmd.5
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 05:43:16 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 13:42:54 +0100
Message-ID: <CAFEAcA81AZBaGu6nrLK51_6vWApMSpMDhb9OsnkdApMGebYK8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] qemu.org: new git repos to be mirrored (qemu-palcode,
 capstone, keycodemapdb)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 12 October 2017 at 11:14, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Thu, Oct 12, 2017 at 12:13:23PM +0200, Gerd Hoffmann wrote:
>> On Thu, 2017-10-12 at 11:07 +0100, Daniel P. Berrange wrote:
>> > On Thu, Oct 12, 2017 at 12:04:47PM +0200, Gerd Hoffmann wrote:
>> > > Hmm, so maybe we should mirror the thing on git.qemu.org and use
>> > > that?
>> >
>> > Can that be made 100% automated - I don't want to have to push
>> > changes to
>> > two different git repos.
>>
>> Yes, seabios works that way for example.
>
> Ok, lets do that mirror then we can use git:// and we're consistent with
> other submodules we use

We also have RTH's capstone disassembler patchset which wants to
use capstone as a more-or-less-required dependency, and we have
the one loose end in our current submodules that the qemu-palcode
rom is using a non-qemu.org URL.

So can we set up these repos to be mirrored on qemu.org:
 * git://github.com/rth7680/qemu-palcode.git
 * https://github.com/aquynh/capstone.git
 * https://gitlab.com/keycodemap/keycodemapdb.git

please?

thanks
-- PMM
