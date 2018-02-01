Received: from eggs.gnu.org ([2001:4830:134:3::10]:37048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ehA3v-0001VB-3k
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 03:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ehA3q-0006SB-5g
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 03:17:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ehA3q-0006Ro-02
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 03:17:34 -0500
References: <20180131144846.31697-1-armbru@redhat.com>
	<20180131144846.31697-2-armbru@redhat.com>
	<1fed5cb6-e8c7-e289-ef56-08abca0913c9@redhat.com>
	<87mv0trycw.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e7fbb8b7-f8b0-0310-feda-e2853747808b@redhat.com>
Date: Thu, 1 Feb 2018 09:17:29 +0100
MIME-Version: 1.0
In-Reply-To: <87mv0trycw.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/19] Use #include "..." for our own
 headers, <...> for others
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org

On 01.02.2018 07:57, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 31.01.2018 15:48, Markus Armbruster wrote:
>>> System headers should be included with <...>, our own headers with
>>> "...". Offenders tracked down with an ugly, brittle and probably
>>> buggy Perl script.  Previous iteration was commit a9c94277f0.
>>>
>>> Put the cleaned up system header includes first, except for the ones
>>> the next commit will delete.
>>
>> That's a little bit of code churn ... why not delete them here
>> immediately, or simply ignore these headers here and just delete them in
>> the next patch?
> 
> Ignore won't do, as scripts/clean-includes won't find them then.
> 
> Delete is possible, but requires still more explanation in the commit
> message.  Worthwhile?

I'd prefer to do it. Otherwise, if you look at the commit log of such a
file later, it just looks weird (first change the quotes, then
immediately delete it afterwards again). But if it's too cumbersome to
rework your patch this way right now, I'm also fine if you keep it as it
currently is.

 Thomas
