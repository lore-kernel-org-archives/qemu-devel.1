Received: from eggs.gnu.org ([2001:4830:134:3::10]:38141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSHnD-0005we-9X
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 03:35:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSHn8-0007kS-R8
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 03:35:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gSHn5-0007Sl-JE
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 03:35:20 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181128103308.26755-1-fli@suse.com>
	<20181128103308.26755-2-fli@suse.com>
	<87sgzle527.fsf@dusky.pond.sub.org>
	<13916895-daeb-15ad-5540-be15d1dd7e73@suse.com>
Date: Thu, 29 Nov 2018 09:35:11 +0100
In-Reply-To: <13916895-daeb-15ad-5540-be15d1dd7e73@suse.com> (Fei Li's message
	of "Thu, 29 Nov 2018 14:16:53 +0800")
Message-ID: <87ftvkcmdc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 1/5] Fix segmentation fault when
 qemu_signal_init fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org

Fei Li <fli@suse.com> writes:

> On 11/28/2018 08:53 PM, Markus Armbruster wrote:
>> Fei Li <fli@suse.com> writes:
>>
>>> When qemu_signal_init() fails in qemu_init_main_loop(), we return
>>> without setting an error.  Its callers crash then when they try to
>>> report the error with error_report_err().
>> Yes, that's a bug.  Broken in 2f78e491d7b, v2.2.0.  Has escaped notice
>> since qemu_signalfd() is quite unlikely to fail.  Could go into 3.1 as a
>> bug fix, but I think punting it to the next release is just fine.
> Thanks. :) BTW, should I send the next version only includes patch 1/5
> and 2/5 separately so that you can merge? (I guess Dave will help to
> merge the other three migration related patches)

I can pick patches out of a series for merging, and I trust Dave can,
too.  But keeping unrelated fixes separate is a good idea.  I can see
three groups: PATCH 1 (main loop), PATCH 2 (thread abstraction), PATCH
3-5 (migration).

[...]
