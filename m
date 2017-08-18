Received: from eggs.gnu.org ([2001:4830:134:3::10]:60455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1digKn-0005WW-GT
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 08:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1digKj-0004zs-Hk
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 08:25:05 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:33871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asegundo@redhat.com>) id 1digKj-0004zF-D9
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 08:25:01 -0400
Received: by mail-io0-f170.google.com with SMTP id o9so32552654iod.1
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 05:24:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <878tikf34o.fsf@dusky.pond.sub.org>
References: <20170731085110.1050-1-apahim@redhat.com>
	<20170731085110.1050-4-apahim@redhat.com>
	<87zib1s13v.fsf@dusky.pond.sub.org>
	<20170815195827.GW3108@localhost.localdomain>
	<878tikf34o.fsf@dusky.pond.sub.org>
From: Amador Pahim <apahim@redhat.com>
Date: Fri, 18 Aug 2017 14:24:57 +0200
Message-ID: <CALAZnb0P3qepUHv-TPCwwZnvX=xqi4MpcjCSfG3DtzQ4ESYd3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 3/7] qemu.py: use python logging system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Wed, Aug 16, 2017 at 8:17 AM, Markus Armbruster <armbru@redhat.com> wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
>
>> On Tue, Aug 15, 2017 at 10:10:12AM +0200, Markus Armbruster wrote:
>>> Please spell "Python" with a capital "P" (it's a proper name).
>>>
>>> Amador Pahim <apahim@redhat.com> writes:
>>>
>>> > Let's provide extra control and flexibility by using python logging
>>> > system instead of print and/or sys.std*.write().
>>> >
>>> > Signed-off-by: Amador Pahim <apahim@redhat.com>
>>>
>>> How exactly does this change error messages?
>>>
>>> Is logging the right tool to report errors to the human user?  I'm
>>> asking because logging and error reporting are generally separate
>>> things.  Example: a program runs into a recoverable error.  It logs the
>>> error, but does not report it.
>>>
>>> Is reporting errors to stderr the right thing to do for library class
>>> QEMUMachine?  I doubt it.  Libraries throw exceptions and let their
>>> users decide how to handle them.
>>
>> I believe the "qemu received signal" event is supposed to be
>> logged, not necessarily reported.  Callers can then choose where
>> the log messages should go (scripts could choose to send them
>> directly to stderr if verbose or debugging mode is enabled).  We
>> don't even need an exception for it: we can let callers check
>> exitcode() and decide what to do about the QEMU exit code.
>
> Makes sense.
>
>> The send_fd_scm() messages, on the other hand, could become
>> exceptions, and don't need the logging system at all.
>
> I think we all agree that printing to stderr is not a good idea for this
> library class.  Instead of a blanket conversion to logging without
> further explanation, I'd like to see cleanup with rationale such as
> yours.

Ok.
