Received: from eggs.gnu.org ([2001:4830:134:3::10]:44144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpdWI-0006yk-OU
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpdW3-0004FM-Mv
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:54:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49300 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpdW3-0004F0-Hj
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:53:59 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1526916378.git.simon@ruderich.org>
	<20180809144340.GA29237@ruderich.org>
	<878t5evjqk.fsf@dusky.pond.sub.org>
	<20180814141605.GA26651@ruderich.org>
Date: Tue, 14 Aug 2018 17:27:52 +0200
In-Reply-To: <20180814141605.GA26651@ruderich.org> (Simon Ruderich's message
	of "Tue, 14 Aug 2018 16:16:05 +0200")
Message-ID: <87bma5t1c7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 0/5] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Ruderich <simon@ruderich.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, David Alan Gilbert <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Simon Ruderich <simon@ruderich.org> writes:

> On Fri, Aug 10, 2018 at 08:06:11AM +0200, Markus Armbruster wrote:
>> You neglected to cc: maintainers.  I spotted this cry for help only by
>> chance.
>>
>> To find maintainers to cc:, you can use get_maintainer.pl like this:
>>
>>     $ scripts/get_maintainer.pl *patch
>>     scripts/get_maintainer.pl: file '0000-cover-letter.patch' doesn't appear to be a patch.  Add -f to options?
>>     Paolo Bonzini <pbonzini@redhat.com> (maintainer:Overall)
>>     Peter Crosthwaite <crosthwaite.peter@gmail.com> (maintainer:Overall)
>>     Richard Henderson <rth@twiddle.net> (maintainer:Overall)
>>     "Dr. David Alan Gilbert" <dgilbert@redhat.com> (maintainer:Human Monitor (HMP))
>>     Eric Blake <eblake@redhat.com> (supporter:QAPI Schema)
>>     Markus Armbruster <armbru@redhat.com> (supporter:QAPI Schema)
>>     qemu-devel@nongnu.org (open list:Overall)
>>
>> It's output is advice, not gospel.  Use your judgement.
>>
>> I'm copying maintainers for you now.  This should get you some review.
>
> Hello,
>
> Thank you for your help. I missed that part when looking through
> the patch submission instructions.

Don't worry, we don't expect people to get it 100% right every time,
especially not the first time.
