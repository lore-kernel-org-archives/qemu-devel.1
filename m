Received: from eggs.gnu.org ([2001:4830:134:3::10]:40520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCoho-0002tF-Fy
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCohl-0000YU-9i
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:29:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gCohk-0000V6-W5
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:29:53 -0400
Date: Wed, 17 Oct 2018 13:29:44 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181017162944.GF31060@habkost.net>
References: <20181016232201.16829-1-crosa@redhat.com>
	<CAFEAcA_KFOay7zBoYMSqqEYd0ZhTcW5wp3bs28cr=oK4W4FL3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_KFOay7zBoYMSqqEYd0ZhTcW5wp3bs28cr=oK4W4FL3A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] Acceptance tests: host arch to target arch
 name mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Cleber Rosa <crosa@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>

On Wed, Oct 17, 2018 at 01:34:41PM +0100, Peter Maydell wrote:
> On 17 October 2018 at 00:22, Cleber Rosa <crosa@redhat.com> wrote:
> > The host arch name is not always the target arch name, so it's
> > necessary to have a mapping.
> >
> > The configure scripts contains what is the authoritative and failproof
> > mapping, but, reusing it is not straightforward, so it's replicated in
> > the acceptance tests supporting code.
> 
> So, why does the test code need to care? It's not clear
> from the patch... My expectation would be that you'd
> just test all the testable target architectures,
> regardless of what the host architecture is.

I tend to agree.  Maybe the right solution is to get rid of the
os.uname().  I think the default should be testing all QEMU
binaries that were built, and the host architecture shouldn't
matter.

That said, I think the dictionary is a nice temporary workaround
until we fix that.

-- 
Eduardo
