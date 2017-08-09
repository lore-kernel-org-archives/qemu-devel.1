Received: from eggs.gnu.org ([2001:4830:134:3::10]:33103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfKCx-0002vV-Qt
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 02:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfKCw-0003tY-PI
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 02:11:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-33-git-send-email-armbru@redhat.com>
	<20170808153429.GN2081@work-vm>
Date: Wed, 09 Aug 2017 08:10:50 +0200
In-Reply-To: <20170808153429.GN2081@work-vm> (David Alan Gilbert's message of
	"Tue, 8 Aug 2017 16:34:30 +0100")
Message-ID: <87k22dz2xh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 32/56] hmp: Make
 block_set_io_throttle's arguments unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, jsnow@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> The previous commit made them unsigned in QMP.  Switch HMP's args_type
>> from 'l' to 'o'.  Loses support for expressions (QEMU pocket
>> calculator), gains support for unit suffixes.  Negative values are no
>> longer accepted and interpreted modulo 2^64.  Instead, values between
>> 2^63 and 2^64-1 are now accepted.
>
> But that also means all these values are assumed to be in MB by default?

Yes.

We could debate whether that's acceptable, as HMP is not a stable
interface, but as a matter of fact, I'm no friend of defaulting the unit
to anything but one.  Looks like we have a customer for your proposed
args_type '6'.
