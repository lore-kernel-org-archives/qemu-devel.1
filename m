Received: from eggs.gnu.org ([2001:4830:134:3::10]:55706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dyu2Z-0002Kn-Cp
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 02:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dyu2W-0007Y0-5W
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 02:17:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dyu2V-0007XX-VD
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 02:17:16 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <87r2w6eq5n.fsf@gmail.com>
	<20170918153644.GA12759@stefanha-x1.localdomain>
Date: Mon, 02 Oct 2017 08:17:12 +0200
In-Reply-To: <20170918153644.GA12759@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Mon, 18 Sep 2017 16:36:44 +0100")
Message-ID: <87h8virs47.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] scripts: Support building with Python 3
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: David Michael <fedora.dm0@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Sat, Aug 19, 2017 at 10:58:44PM -0700, David Michael wrote:
>> This allows building with "./configure --python=python3", where
>> the python3 program is at least version 3.6.  It preserves
>> compatibility with Python 2.  The changes include:
>> 
>>   - Avoiding "print" usage
>>   - Using bytes with files opened in binary mode
>>   - Switching .iteritems() to .items()
>>   - Adding fallback imports for functions moved to other modules
>> 
>> Signed-off-by: David Michael <fedora.dm0@gmail.com>
>> ---
>> 
>> Hi,
>> 
>> I've been applying these changes when building on Fedora 26, which does
>> not include any Python 2 packages by default.  It was tested with Python
>> 2.7 and 3.6.
>> 
>> I just saw the list of scripts that need updating on the mailing list,
>> and this doesn't cover all of them, but it is enough to build a binary
>> for running virtual machines with KVM.  Maybe it is still useful as a
>> starting point.
>> 
>> Thanks.
>
>
> Markus,
> You wanted to discuss the general direction of Python version support
> before applying this.

Dan has since posted competing patches.

> Has consensus been reached?

I need to decide how much I hate supporting both Python 2 and Python 3,
and that involves looking at both patch sets in more detail.

QAPI is a rather busy subsystem, and right now my review queue is in a
state where I have to decide whom to annoy and disappoint with overly
long delays.

Given the choice between addressing a problem that doesn't really exist,
yet (Python 2 going away) and addressing problems that are hurting us
*now* (such as QAPI's inability to express compile-time conditionals), I
have to prioritize the latter.  I wish I wouldn't have to make such
choices, and I apologize for the inconvenience.
