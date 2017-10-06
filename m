Received: from eggs.gnu.org ([2001:4830:134:3::10]:35237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0R8i-00051W-NJ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 07:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0R8e-0004fK-Hi
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 07:50:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0R8e-0004ee-BK
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 07:49:56 -0400
Date: Fri, 6 Oct 2017 13:49:52 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171006134952.63076c08.cohuck@redhat.com>
In-Reply-To: <150728886813.8130.14646885344900219104.malone@wampee.canonical.com>
References: <150728578413.796.15373444520066064008.malonedeb@chaenomeles.canonical.com>
	<150728886813.8130.14646885344900219104.malone@wampee.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1721744] Re: Help content missing for newly
 added machine properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Bug 1721744 <1721744@bugs.launchpad.net>, qemu-devel@nongnu.org

On Fri, 06 Oct 2017 11:21:08 -0000
Greg Kurz <groug@kaod.org> wrote:

> Hmm... -h is common to all targets, ie, you should only find properties
> that can be passed to -machine for all qemu-system-* binaries (I don't
> know how s390-squash-mcss landed there but it looks wrong).

That output comes from qemu-options.hx, which contains information
added by hand. That means that some machine options end up there, some
don't. If this is only supposed to contain common options, we should
remove s390-squash-mcss (and the -key-wrap ones are s390-specific as
well).

> 
> The right way to query properties supported by a pseries machine type
> is:
> 
> $ ./ppc64-softmmu/qemu-system-ppc64 -machine pseries,help

Indeed. This contains the real set of properties and does not depend on
whether a developer added some extra help text.
