Received: from eggs.gnu.org ([2001:4830:134:3::10]:50492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnJ59-0003kv-Om
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnJ56-0001iA-Ge
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:36:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnJ56-0001f0-9j
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:36:00 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <87r2w6eq5n.fsf@gmail.com> <87h8x1yox3.fsf@dusky.pond.sub.org>
	<20170830170941.GB24565@stefanha-x1.localdomain>
Date: Thu, 31 Aug 2017 08:35:57 +0200
In-Reply-To: <20170830170941.GB24565@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Wed, 30 Aug 2017 18:09:41 +0100")
Message-ID: <87bmmwi6r6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] scripts: Support building with Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: David Michael <fedora.dm0@gmail.com>, qemu-devel@nongnu.org

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Mon, Aug 21, 2017 at 04:29:44PM +0200, Markus Armbruster wrote:
>> What is our Python 2 -> 3 migration strategy?
>> 
>> Don't support Python 3 until a flag day, then flip and don't support
>> Python 2?
>
> Add support for Python 3 so that both Python 2.6+ and Python 3 are
> supported.

Python 2.7 is the end of the Python 2 line of development (PEP 404).
It'll be maintained until 2020.  Downstream support for Python 2 may or
may not last longer.

> When Python 2 is EOL it will need to be dropped and the code becomes
> Python 3-only.
>
>> Keep the source in Python 2 and support 3 via conversion with 2to3?
>> 
>> Port the source to Python 3 and support 2 via conversion with 3to2?
>> 
>> Port to Python 3, but keep it working with Python 2 with help of the six
>> module?
>> 
>> Support both with ad hoc hackery (like this patch does)?
>
> Yes, please see for details:
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01758.html

So, first we'll invest in work-arounds to make both 2 and 3 work.  Once
2 is gone, we can invest some more to clean them up.  Which probably
won't happen, so we'll continue to carry work-arounds that no longer
make sense.

I maintain roughly one fourth of all Python code in qemu, and I'm not
looking forward to this hoop-jumping at all.

Are we really, really sure we want to go this way?  What exactly are we
hoping to accomplish by it?
