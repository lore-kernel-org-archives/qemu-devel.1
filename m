Received: from eggs.gnu.org ([2001:4830:134:3::10]:49542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dc6AA-0002tv-FF
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dc6A5-0006fK-Nw
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:34:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dc6A5-0006ek-Hb
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:34:49 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <150127405114.4205.4905957472648540492.malonedeb@gac.canonical.com>
Date: Mon, 31 Jul 2017 10:34:46 +0200
In-Reply-To: <150127405114.4205.4905957472648540492.malonedeb@gac.canonical.com>
	(John Florian's message of "Fri, 28 Jul 2017 20:34:11 -0000")
Message-ID: <87shhd9f89.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Bug 1707297] [NEW] qemu became more picky parsing
 -m option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Florian <1707297@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org

John Florian <1707297@bugs.launchpad.net> writes:

> Public bug reported:
>
> With qemu-kvm-2.9.0-3.fc26.x86_64 I am no longer to specify the memory
> size using something like "-m 1.00000GiB" but with qemu-
> kvm-2.7.1-7.fc25.x86_64 I could without any problem.  I now get an error
> message like:
>
> qemu-system-x86_64: -m 1.00000GiB: Parameter 'size' expects a non-negative number below 2^64
> Optional suffix k, M, G, T, P or E means kilo-, mega-, giga-, tera-, peta-
> and exabytes, respectively.
>
>
> Is this expected or a regression?

We recognize suffix "G".  Before commit 75cdcd1 (v2.9.0), trailing
garbage after a recognized suffix was silently ignored.  "1.0G",
"1.0GiB", "1.0Garbage-trucks-of-RAM" were all the same to QEMU.  No
more.

All clear?
