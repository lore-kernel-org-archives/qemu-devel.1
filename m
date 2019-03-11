Received: from eggs.gnu.org ([209.51.188.92]:55705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h3Uwx-0003eX-5s
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h3UoT-0003Gg-PU
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 19:58:34 -0400
Date: Mon, 11 Mar 2019 19:58:22 -0400
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190311235822.zavteezbiewr4eoq@localhost.localdomain>
References: <20190221005753.27955-1-crosa@redhat.com>
	<20190221005753.27955-10-crosa@redhat.com>
	<20190301114144.23351a68.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301114144.23351a68.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 09/20] Boot Linux Console Test: update
 the x86_64 kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>

On Fri, Mar 01, 2019 at 11:41:44AM +0100, Cornelia Huck wrote:
> On Wed, 20 Feb 2019 19:57:42 -0500
> Cleber Rosa <crosa@redhat.com> wrote:
> 
> > To the stock Fedora 29 kernel, from the Fedora 28.  New tests will be
> > added using the 29 kernel, so for consistency, let's also update it
> > here.
> > 
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > Reviewed-by: Caio Carrara <ccarrara@redhat.com>
> > ---
> >  tests/acceptance/boot_linux_console.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> > index 89df7f6e4f..35b31162d4 100644
> > --- a/tests/acceptance/boot_linux_console.py
> > +++ b/tests/acceptance/boot_linux_console.py
> > @@ -28,9 +28,9 @@ class BootLinuxConsole(Test):
> >          :avocado: tags=arch:x86_64
> >          :avocado: tags=machine:pc
> >          """
> > -        kernel_url = ('https://mirrors.kernel.org/fedora/releases/28/'
> > +        kernel_url = ('https://mirrors.kernel.org/fedora/releases/29/'
> >                        'Everything/x86_64/os/images/pxeboot/vmlinuz')
> > -        kernel_hash = '238e083e114c48200f80d889f7e32eeb2793e02a'
> > +        kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
> >          kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> >  
> >          self.vm.set_machine('pc')
> 
> This looks reasonable; but an obvious follow-up question is how we
> handle updates to new distro levels in general.
> 
> I don't think we'll need to run acceptance tests on old qemus, though.

No, I don't think we have to bother with that.  Backport(er)s would be
expected to handle this (if they ever come to existence).

You do have a point about consistenly updating those images, though.
I won't pretend to have an answer for that just yet... but it's
possible that these "kernel_urls" can be turned into parameters
that will eventually be expand based on the user's selected distro
and version (similar to the Avocado vmimage library[1]).

- Cleber.

[1] https://avocado-framework.readthedocs.io/en/69.0/api/utils/avocado.utils.html#avocado.utils.vmimage.get
