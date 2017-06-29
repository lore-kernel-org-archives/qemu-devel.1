Received: from eggs.gnu.org ([2001:4830:134:3::10]:52727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dQU2Z-0003Ho-0t
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:39:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dQU2V-0000gu-0D
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:39:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dQU2U-0000gb-R4
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:38:58 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1498596157.git.alistair.francis@xilinx.com>
	<4e1eded5cda7b182a8a4cb133b40b2915817b7d1.1498596157.git.alistair.francis@xilinx.com>
	<20170628090448.GE29134@redhat.com>
	<CAKmqyKNEgZPMdS5B4J09XVpDQt0LXw0YFbMdBa_fnBXmnndftA@mail.gmail.com>
	<20170628161927.GQ29134@redhat.com>
Date: Thu, 29 Jun 2017 09:38:55 +0200
In-Reply-To: <20170628161927.GQ29134@redhat.com> (Daniel P. Berrange's message
	of "Wed, 28 Jun 2017 17:19:27 +0100")
Message-ID: <87r2y31bw0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC v1 2/3] util/qemu-error: Add a
 warning_report() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

"Daniel P. Berrange" <berrange@redhat.com> writes:

> On Wed, Jun 28, 2017 at 09:16:45AM -0700, Alistair Francis wrote:
>> On Wed, Jun 28, 2017 at 2:04 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
>> > On Tue, Jun 27, 2017 at 01:45:45PM -0700, Alistair Francis wrote:
>> >> Add a functino which can be used similarly to error_report() execpt to
>> >> inform the users about warnings instead of errors.
>> >>
>> >> The warning print does not include the timestamp and instead will
>> >> preface the messages with a 'warning: '.
>> >
>> > Not including the timestamp is a bug IMHO. If I've turned on timestamps,
>> > I expect all messages to have the timestamp.
>> 
>> That's fine, I'm happy to add it back in. I just wasn't sure.
>> 
>> >
>> > I'm not particularly convinced by adding the 'warning: ' prefix either,
>> > particularly given the scenario you are using this in, is not actually
>> > a warning - its just a informative message.
>> 
>> Maybe it makes more sense to add an extra argument to error_report()
>> that can be used to specify error, warning or information. The same
>> way qemu_log_mask() works. That was Edgar's idea in reply to one of
>> the other patches.
>> 
>> Does that sound more useful?
>
> I'd suggest renaming the current 'error_report' to 'message_report' and
> making it take an extra arg that accepts a enum flag INFO | WARNING | ERROR.
> Then add macros for  error_report, warning_report, info_report that call
> message_report with the right enum.  That way you don't have to update any
> of the existing code that calls error_report.

*Functions*, please, not macros.  Macros would bloat the code for no
benefit at all.
