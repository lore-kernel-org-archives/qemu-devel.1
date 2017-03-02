Received: from eggs.gnu.org ([2001:4830:134:3::10]:35944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjSp7-0003kE-TE
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 10:39:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjSp3-0006Jl-Ts
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 10:39:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cjSp3-0006Ip-OX
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 10:39:17 -0500
Date: Thu, 2 Mar 2017 12:39:13 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170302153913.GQ2778@thinpad.lan.raisama.net>
References: <20170227162501.29280-1-ehabkost@redhat.com>
	<CAFEAcA8b_tdQAP6YVDRaZKzHLed5xKbfABtJUV0U43HpkTiBdg@mail.gmail.com>
	<20170227194134.GH2778@thinpad.lan.raisama.net>
	<20170227205753.60b8a225@bahia.lan>
	<20170228191226.GI2778@thinpad.lan.raisama.net>
	<CAFEAcA8iZG8yB=4an9O2Mroej8bWNHBcANxsJkCOVbKHcxaGRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8iZG8yB=4an9O2Mroej8bWNHBcANxsJkCOVbKHcxaGRg@mail.gmail.com>
Subject: Re: [Qemu-devel] travis-ci 'make check' timeouts (was Re: [PULL
 00/11] x86 queue, 2017-02-27)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, Feb 28, 2017 at 07:17:39PM +0000, Peter Maydell wrote:
> On 28 February 2017 at 19:12, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > I saw a failure on x86-pull-request that seemed to be because of
> > vhost-user-test[1]. However, after restarting the job, it
> > passed[2].
> 
> I'm currently processing a patch which (hopefully) fixes
> vhost-user-test's intermittent failures:
> http://patchwork.ozlabs.org/patch/732747/

I'm not sure it will solve the issues on hosts without KVM. As
far as I can see, if vhost-user-test is working without KVM, it
is working by accident.

See the thread at:
http://www.mail-archive.com/qemu-devel@nongnu.org/msg394258.html

-- 
Eduardo
