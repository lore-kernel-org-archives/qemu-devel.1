Received: from eggs.gnu.org ([2001:4830:134:3::10]:36119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gK6X2-0002hg-Qf
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:56:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gK6Wu-0002um-Gy
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:56:54 -0500
References: <20181021175858.25886-1-ppandit@redhat.com>
	<nycvar.YSQ.7.76.1810270118190.7551@xnncv>
	<nycvar.YSQ.7.76.1811021434001.17929@xnncv>
	<1055bb12-6b57-1240-790c-930f2405ebee@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d68a8ce9-7be0-9f10-23a1-eed362ee7f18@redhat.com>
Date: Tue, 6 Nov 2018 19:56:11 +0100
MIME-Version: 1.0
In-Reply-To: <1055bb12-6b57-1240-790c-930f2405ebee@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] bt: use size_t type for length
 parameters instead of int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Arash TC <tohidi.arash@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On 06/11/2018 15:52, Thomas Huth wrote:
> The bluetooth subsystem is completely unmaintained, so if Paolo does not
> want to pick it up through his "misc" tree, maybe Peter could apply this
> patch directly? Or maybe it could go through the trivial tree since it
> does not look very complicated?

I wanted to check that there were no possible underflows, but that takes
time.

> FWIW, the patch looks OK to me at a first glance, so:
> 
> Acked-by: Thomas Huth <thuth@redhat.com>
> 
> PS: I still think we should deprecate the bt subsystem, since nobody
> really touched it within years...

Well, apparently there _are_ people using it, and it worked for them.
Or at least they were using it in 2014.  I'm sure that if people
starting poking at it, some holes would appear, but it appears to work
decently.

Paolo
