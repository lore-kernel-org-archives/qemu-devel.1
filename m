Received: from eggs.gnu.org ([2001:4830:134:3::10]:36475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cid5L-0001Ly-ND
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 03:24:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cid5K-0001Ga-T4
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 03:24:39 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<87poi4c4jd.fsf@dusky.pond.sub.org>
	<20170227105704.GB6356@noname.redhat.com>
	<87innvhi1j.fsf@dusky.pond.sub.org>
	<97fd5714-e51b-5786-9576-47614e7a4351@redhat.com>
Date: Tue, 28 Feb 2017 09:24:30 +0100
In-Reply-To: <97fd5714-e51b-5786-9576-47614e7a4351@redhat.com> (Eric Blake's
	message of "Mon, 27 Feb 2017 13:47:59 -0600")
Message-ID: <871sui3ept.fsf@dusky.pond.sub.org>
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
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/27/2017 07:36 AM, Markus Armbruster wrote:
>
>> 
>>>                  Maybe just 'foo.array[]' (without any =) for an empty
>>> array or something like that.
>> 
>> Yes, that should do.  Likewise foo.object{} for empty object.
>> 
>> {} doesn't even need quoting.  [] may.
>
> [contents] needs quoting, but [] does NOT need shell quoting (no shells
> treat it as a glob), for the same reason that 'if [ -e "$file" ];' needs
> no quoting around the [ or ] (the shell only requires quotes for [ if
> the rest of the shell word can look like a valid glob, but globs require
> intermediate content before the ]).

Bash shell options failglob and nullglob can still mess it up.

>>> Before we introduce anything like this, do we actually need it?
>> 
>> I don't know whether anything needs optional, present and empty.  But
>> even if the answer is "no" today, it need not remain "no".
>> 
>> Anyone running into a case of "yes", will have to fall back to the JSON
>> form of -blockdev.  Strengthens my belief that providing JSON there is a
>> good idea.
>> 
>> The insufficient generality of dotted keys bugs me a bit.  Not sure
>> whether it justifies more syntax now.  But we should document it.
>
> I agree that documenting it as a shortcoming of dotted form and pointing
> to JSON form is okay.  I also like that we are leaving the door open for
> future expansion, if needed, and think that is better than inventing the
> syntax now, especially for what we are trying to get into 2.9.

Okay, I'll work on improving the documentation.
