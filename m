Received: from eggs.gnu.org ([2001:4830:134:3::10]:47961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ew3Uc-0005YX-C2
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 06:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ew3UZ-00010j-63
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 06:18:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34962 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ew3UZ-00010N-19
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 06:18:43 -0400
Date: Wed, 14 Mar 2018 11:18:22 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180314111822.5caaa243@igors-macbook-pro.local>
In-Reply-To: <CAFEAcA9W=CLdogF+gHUfQOy7Gb=UHg0oTLYhYMRh7S363ss9wQ@mail.gmail.com>
References: <20180312223455.18124-1-ehabkost@redhat.com>
	<CAFEAcA9W=CLdogF+gHUfQOy7Gb=UHg0oTLYhYMRh7S363ss9wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 13 Mar 2018 18:29:10 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 12 March 2018 at 22:34, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > The following changes since commit 6ceb1b51f05f9e1892d082960ed602dca7b6696e:
> >
> >   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20180312-pull-request' into staging (2018-03-12 16:14:37 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
> >
> > for you to fetch changes up to a82664f2f8b1ce2db90e644df01d7ca7845881a6:
> >
> >   cpu: drop unnecessary NULL check and cpu_common_class_by_name() (2018-03-12 19:33:32 -0300)
> >
> > ----------------------------------------------------------------
> > Machine queue, 2018-03-12
> >
> 
> Hi. It looks like this breaks bsd-user compilation:
> 
> /root/qemu/bsd-user/main.c: In function 'main':
> /root/qemu/bsd-user/main.c:905:5: warning: implicit declaration of
> function 'create' [-Wimplicit-function-declaration]
>      cpu = create(cpu_type);
>      ^
> /root/qemu/bsd-user/main.c:905:5: warning: nested extern declaration
> of 'create' [-Wnested-externs]
> /root/qemu/bsd-user/main.c:905:9: warning: assignment makes pointer
> from integer without a cast [enabled by default]
>      cpu = create(cpu_type);
>          ^
> 
> and then later it fails to link with
> /root/qemu/bsd-user/main.c:905: undefined reference to `create'
Sorry, it was my mistake not testing series on BSD after the last rewriting
fix should be s/create/create_cpu/.

Eduardo fixed it up in his updated pull req.


> 
> thanks
> -- PMM
> 
