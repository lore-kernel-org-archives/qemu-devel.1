Received: from eggs.gnu.org ([2001:4830:134:3::10]:39865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ewXSE-0001uJ-8P
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 14:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ewXSD-0004VZ-1l
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 14:18:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ewXSC-0004Uz-PO
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 14:18:16 -0400
Date: Thu, 15 Mar 2018 15:18:10 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180315181810.GE28578@localhost.localdomain>
References: <20180312223455.18124-1-ehabkost@redhat.com>
	<CAFEAcA9W=CLdogF+gHUfQOy7Gb=UHg0oTLYhYMRh7S363ss9wQ@mail.gmail.com>
	<20180313183704.GA3417@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313183704.GA3417@localhost.localdomain>
Subject: Re: [Qemu-devel] [PULL 0/7] Machine queue, 2018-03-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Marcel Apfelbaum <marcel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Mar 13, 2018 at 03:37:04PM -0300, Eduardo Habkost wrote:
> On Tue, Mar 13, 2018 at 06:29:10PM +0000, Peter Maydell wrote:
> > On 12 March 2018 at 22:34, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > The following changes since commit 6ceb1b51f05f9e1892d082960ed602dca7b6696e:
> > >
> > >   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20180312-pull-request' into staging (2018-03-12 16:14:37 +0000)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
> > >
> > > for you to fetch changes up to a82664f2f8b1ce2db90e644df01d7ca7845881a6:
> > >
> > >   cpu: drop unnecessary NULL check and cpu_common_class_by_name() (2018-03-12 19:33:32 -0300)
> > >
> > > ----------------------------------------------------------------
> > > Machine queue, 2018-03-12
> > >
> > 
> > Hi. It looks like this breaks bsd-user compilation:
> > 
> > /root/qemu/bsd-user/main.c: In function 'main':
> > /root/qemu/bsd-user/main.c:905:5: warning: implicit declaration of
> > function 'create' [-Wimplicit-function-declaration]
> >      cpu = create(cpu_type);
> >      ^
> > /root/qemu/bsd-user/main.c:905:5: warning: nested extern declaration
> > of 'create' [-Wnested-externs]
> > /root/qemu/bsd-user/main.c:905:9: warning: assignment makes pointer
> > from integer without a cast [enabled by default]
> >      cpu = create(cpu_type);
> >          ^
> > 
> > and then later it fails to link with
> > /root/qemu/bsd-user/main.c:905: undefined reference to `create'
> 
> Oops, sorry.  I don't have a BSD host handy right now, are you able to confirm
> if the new tag I pushed fixes it?

I didn't get test results on BSD, but as the fix was obvious I sent a
new pull request today ("[PULL v2 0/7] Machine queue, 2018-03-15").


> 
> The following changes since commit 026aaf47c02b79036feb830206cfebb2a726510d:
> 
>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2018-03-13 16:26:44 +0000)
> 
> are available in the Git repository at:
> 
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
> 
> for you to fetch changes up to e291aefcd38ca3d048e45f644e9321d02fc253cc:
> 
>   cpu: drop unnecessary NULL check and cpu_common_class_by_name() (2018-03-13 15:33:26 -0300)
> 
> ----------------------------------------------------------------
> machine queue, 2018-03-13
> 
> ----------------------------------------------------------------
> 
> Igor Mammedov (6):
>   nios2: 10m50_devboard: replace cpu_model with cpu_type
>   tests: add machine 'none' with -cpu test
>   cpu: add CPU_RESOLVING_TYPE macro
>   Use cpu_create(type) instead of cpu_init(cpu_model)
>   cpu: get rid of unused cpu_init() defines
>   cpu: drop unnecessary NULL check and cpu_common_class_by_name()
> 
> Wang Xin (1):
>   pc: correct misspelled CPU model-id for pc 2.2
> 
> -- 
> Eduardo
> 

-- 
Eduardo
