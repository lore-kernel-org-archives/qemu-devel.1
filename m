Received: from eggs.gnu.org ([2001:4830:134:3::10]:36437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZx07-0005PV-EN
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 04:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZx06-0007e0-JE
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 04:51:23 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<20170203172520.GA13825@redhat.com>
Date: Sat, 04 Feb 2017 10:51:13 +0100
In-Reply-To: <20170203172520.GA13825@redhat.com> (Richard W. M. Jones's
	message of "Fri, 3 Feb 2017 17:25:20 +0000")
Message-ID: <87vasq708e.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

"Richard W.M. Jones" <rjones@redhat.com> writes:

> On Thu, Feb 02, 2017 at 08:42:33PM +0100, Markus Armbruster wrote:
>> There's also the -drive file=json:... syntax.  It's a bad fit for
>> QemuOpts, because QemuOpts and JSON fight for the comma.  I'd show you
>> if I could get it to work.
>
> I think this refers to the json: syntax for qemu URIs?

The json: pseudo-protocol, i.e. "file names" starting with a "json:"
protocol prefix.  I think we mean the same.

> Anyway we're using this in virt-v2v
> (https://github.com/libguestfs/libguestfs/blob/master/v2v/input_libvirt_xen_ssh.ml)
>
> It's very useful, please try not to break it!

We're not going to take the json: pseudo-protocol away.  Perhaps we'll
deprecate it at some point, but even then it'll stay for a sufficiently
generous grace period.
