Received: from eggs.gnu.org ([2001:4830:134:3::10]:58745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diCoI-00041E-Ai
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 00:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diCoH-0000In-Eh
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 00:53:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1500537221-20556-1-git-send-email-armbru@redhat.com>
	<a7a4e4dd-8c2f-8014-6486-13f9a90a0341@redhat.com>
Date: Thu, 17 Aug 2017 06:53:24 +0200
In-Reply-To: <a7a4e4dd-8c2f-8014-6486-13f9a90a0341@redhat.com> (John Snow's
	message of "Wed, 16 Aug 2017 17:34:29 -0400")
Message-ID: <87r2wassl7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 00/10] Correct two minor
 QMP interface design flaws
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com

John Snow <jsnow@redhat.com> writes:

[...]
> On 07/20/2017 03:53 AM, Markus Armbruster wrote:
>> blockdev-add and migrate-set-parameters overload empty strings to mean
>> something entirely different.  See my memo "qapi: Stop abusing
>> "special" values for something entirely different" for details.
>> 
>>     Message-ID: <87379zhrhn.fsf@dusky.pond.sub.org>
>>     https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04526.html
>> 
>> This series deprecates these usages of "" in favour of JSON null.
>> Because we're so close to the 2.10 freeze, the implementation is
>> intentionally stupid: rewrite null to "" at first opportunity.  The
>> proper way to do it would be rewriting "" to null, but that requires
>> fixing up code to work with null.  There are TODO comments for that.
>> I'm willing to take care of them in the next development cycle.
>> 
>
> Did this get dropped in favor of a more comprehensive 2.11 fix?

This is the stupid solution for 2.10.  TODO comments in PATCH 05+08-10
mark the spots that could use cleanup.  I hope to get to them in 2.11.

[...]
