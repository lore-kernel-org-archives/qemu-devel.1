Received: from eggs.gnu.org ([2001:4830:134:3::10]:37204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coY0j-0005KS-W0
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coY0e-0004F0-Bq
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:12:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1coY0e-0004EZ-4u
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:12:16 -0400
Date: Thu, 16 Mar 2017 16:12:11 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170316161211.GY15193@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<20170316154643.GT15193@redhat.com>
	<CAFEAcA9WdjkAr0eWNApWQGZAw4_67sci3LtY8=9pzYDcDXiLmg@mail.gmail.com>
	<20170316160012.GX15193@redhat.com>
	<CAFEAcA8Mo2PAE2QE8bd0mNTkjRHjpS9BcRj1kk1wwDXYJ2-4nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8Mo2PAE2QE8bd0mNTkjRHjpS9BcRj1kk1wwDXYJ2-4nQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, Mar 16, 2017 at 04:06:35PM +0000, Peter Maydell wrote:
> On 16 March 2017 at 16:00, Daniel P. Berrange <berrange@redhat.com> wrote:
> > I'm just pretty wary of gratuitously deleting stuff that still
> > has a reasonable chance of being functional, simply because
> > we lack CI testing.
> 
> Well, me too, but I think that if nobody turns up to help us
> or donate a test machine despite configure yelling at them
> for a release cycle or two then it's not all that gratuitous.
> 
> (Just for instance there's some grotty code in configure that
> looks at 'uname -m' to guess what host OS it is, which is
> really not the right way to do it. But I've never been able
> to clean that up because maybe it might break something
> semi obscure in the process.)

I'd just go ahead and clean it up regardless & let people report bugs, if
any.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
