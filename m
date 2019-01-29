Received: from [209.51.188.92] (port=51275 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1goUxr-0002Or-Md
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:06:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1goUxW-00051I-JX
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:06:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1goUxR-0004ap-Tu
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:05:54 -0500
References: <CAFEAcA-4r8_K0=WTaK+A_KvO93ni+3==+a5FRvGTFJ3av0GPFw@mail.gmail.com>
	<20190129021815.GA3264@stefanha-x1.localdomain>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <5ada804a-0832-e557-48b7-217e6213a9a0@redhat.com>
Date: Tue, 29 Jan 2019 09:39:20 -0500
MIME-Version: 1.0
In-Reply-To: <20190129021815.GA3264@stefanha-x1.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] building rst docs with sphinx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, pkg-qemu-devel@lists.alioth.debian.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 1/28/19 9:18 PM, Stefan Hajnoczi wrote:
> On Thu, Jan 24, 2019 at 06:56:09PM +0000, Peter Maydell wrote:
>> (1) configure: My thought is that we should just make
>> sphinx-build a requirement for the existing --enable-docs
>> switch (as texinfo and pod2man are currently). The
>> disadvantage is that we won't support a "build the half
>> of the docs you have the tools for and leave the others"
>> setup. The advantage, which I think is significant, is that
>> distros will naturally be directed to the missing build
>> dependency (either they're building with --enable-docs
>> and will get the configure message, or they aren't and
>> then their build will fail later because of missing docs
>> files when they try to put the built files into the package).
> 
> I'm CCing Cole (Fedora) and the Debian QEMU team so they can give their
> input on this point and your next point.
>

Peter's assessment sounds correct to me. And sphinx is so widely 
available that adding it as a build dep is no problem at all IMO

>> (2) What do we actually want to ship?
>> That is, what do we want 'make install-doc' to copy into
>> the installation directory?
>> https://wiki.qemu.org/Features/Documentation
>> has a good suggested breakdown of docs for where we
>> eventually want to be. I think we probably don't want
>> to install the "developer's guide" (docs/devel) on
>> end-user systems. The others are presumably OK.
>> Currently, we seem to only install manpages and a
>> few other things in the 'install-doc' makefile target
>> (we don't install a bunch of plain-text user-facing
>> docs) so this would be a significant expansion.
> 
> I agree, developer documentation is not relevant to end-users.
> 

Agreed as well. On my Fedora system I see that some packages install 
HACKING/CONTRIBUTING files but even that seems a little weird. If qemu 
cared about installing developer docs it could be a separate makefile 
target so it's easy to control whether it's handled during package build

Thanks,
Cole
