Received: from eggs.gnu.org ([2001:4830:134:3::10]:52678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dL3d6-0001h6-05
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dL3d2-00025K-00
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:26:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dL3d1-00024O-Qh
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:26:15 -0400
Date: Wed, 14 Jun 2017 09:26:10 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170614082610.GB4370@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170607175419.13558-1-berrange@redhat.com>
	<CAFEAcA8eXe2+65KTYPHDpXgK2X3k=bdvVFdWfAAzP-OeWgL1gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8eXe2+65KTYPHDpXgK2X3k=bdvVFdWfAAzP-OeWgL1gw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v1 0/5] Merge sockets 2017/06/07
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

On Mon, Jun 12, 2017 at 02:14:19PM +0100, Peter Maydell wrote:
> On 7 June 2017 at 18:54, Daniel P. Berrange <berrange@redhat.com> wrote:
> > The following changes since commit 0db1851becbefe3e50cfc03776fb1f75817376af:
> >
> >   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.10-pull-request' into staging (2017-06-07 11:56:00 +0100)
> >
> > are available in the git repository at:
> >
> >   git://github.com/berrange/qemu tags/pull-sockets-2017-06-07-1
> >
> > for you to fetch changes up to 8dd2c27927b93aa352c43e8f0b9437f85d2f5f55:
> >
> >   tests: add functional test validating ipv4/ipv6 address flag handling (2017-06-07 17:15:08 +0100)
> >
> > ----------------------------------------------------------------
> > Merge sockets 2017/06/07 v1
> >
> > ----------------------------------------------------------------
> 
> Hi; I'm afraid this ran into 'make check' problems:
> 
> On OSX and FreeBSD:
>   GTESTER check-qtest-i386
> ERROR:/Users/pm215/src/qemu-for-merges/tests/test-sockets-proto.c:825:void
> test_listen(const void *): assertion failed: (data->ipv6 != 0)
> GTester: last random seed: R02Sc21fa7784ab13d0fd3274d86c5a52367
> **
> ERROR:/Users/pm215/src/qemu-for-merges/tests/test-sockets-proto.c:825:void
> test_listen(const void *): assertion failed: (data->ipv6 != 0)
> GTester: last random seed: R02Sdf653a63e8d9a5d03bfadb49122f3e9a
> 
> 
> 
> On the clang runtime undefined-behavior sanitizer:

Was this clang on OSX/FreeBSD too, or is that on Linux ? If the latter,
what are the args to use with configure to exercise this scenario ?

>   GTESTER check-qtest-i386
> /home/petmay01/linaro/qemu-for-merges/qapi/qapi-visit-core.c:139:12:
> runtime error: load of value 254, which is not a valid value for type
> 'bool'


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
