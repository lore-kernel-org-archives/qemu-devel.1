Received: from eggs.gnu.org ([2001:4830:134:3::10]:36395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUn8u-0001Cs-Rt
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 01:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUn8o-0006KM-8M
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 01:55:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41882 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fUn8o-0006J6-3u
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 01:55:50 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <152916202234.7686.15264921741576357687.malonedeb@wampee.canonical.com>
	<152917734027.26681.6190895101387091472.malone@gac.canonical.com>
Date: Mon, 18 Jun 2018 07:55:47 +0200
In-Reply-To: <152917734027.26681.6190895101387091472.malone@gac.canonical.com>
	(Thomas Huth's message of "Sat, 16 Jun 2018 19:29:00 -0000")
Message-ID: <87h8m0sknw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Bug 1777252] Re: tests/Makefile.include trying to
 add linking library '-lutil' that break the build on Solaris
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <1777252@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org

Thomas Huth <1777252@bugs.launchpad.net> writes:

> I'm sorry, but Solaris is currently unsupported and might get removed in
> a future release, see:
>
>  https://wiki.qemu.org/ChangeLog/2.12#Warning:_unsupported_host_systems

Quote configure:

if test "$supported_os" = "no"; then
    echo
    echo "WARNING: SUPPORT FOR THIS HOST OS WILL GO AWAY IN FUTURE RELEASES!"
    echo
    echo "Host OS $targetos support is not currently maintained."
    echo "The QEMU project intends to remove support for this host OS in"
    echo "a future release if nobody volunteers to maintain it and to"
    echo "provide a build host for our continuous integration setup."
    echo "configure has succeeded and you can continue to build, but"
    echo "if you care about QEMU on this platform you should contact"
    echo "us upstream at qemu-devel@nongnu.org."
fi

> So it would be great if you could contribute patches, or find someone
> who's willing to maintain QEMU on Solaris.

The key phrase here is "provide a build host for our continuous
integration setup".  Once that's in place, continuing maintenance
shouldn't be hard.
