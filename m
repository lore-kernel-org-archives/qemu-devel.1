Received: from eggs.gnu.org ([2001:4830:134:3::10]:50751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fScO4-0004Ua-Fw
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:02:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fScNy-0006xx-IA
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:02:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50852 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fScNy-0006xX-Bt
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:02:30 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180601153922.11590-1-ricardo.perez_blanco@nokia.com>
	<a51fbf8b-9839-ebc1-cde5-5ae95656f918@suse.de>
	<20180608094101.GG2671@work-vm>
	<0cc71e01-7015-8f8b-6988-d3b411d3b28c@suse.de>
Date: Tue, 12 Jun 2018 08:02:26 +0200
In-Reply-To: <0cc71e01-7015-8f8b-6988-d3b411d3b28c@suse.de> ("Andreas
	=?utf-8?Q?F=C3=A4rber=22's?= message of "Fri,
	8 Jun 2018 18:19:45 +0200")
Message-ID: <87y3fky231.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Show values and description when using
 "qom-list"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

Andreas F=C3=A4rber <afaerber@suse.de> writes:

> Am 08.06.2018 um 11:41 schrieb Dr. David Alan Gilbert:
>> * Andreas F=C3=A4rber (afaerber@suse.de) wrote:
>>> Am 01.06.2018 um 17:39 schrieb Ricardo Perez Blanco:
>>>> For debugging purposes it is very useful to:
>>>>  - See the description of the field. This information is already filled
>>>>    in but not shown in "qom-list" command.
>>>
>>> No objection on this part.
>>>
>>>>  - Display value of the field.
>>>
>>> That is by definition the qom-get operation, not qom-list. Just like the
>>> ls command does not show file contents, there's cat etc. for that. For
>>> debugging purposes we had a qom-tree (?) command that would combine
>>> both.
>>
>> I'm not too bothered about distinguishing between the two commands;
>> but it would be nice

When an HMP and QMP both have a command with the same name, they should
do the same.

HMP may add convenience features that aren't wanted in QMP, but I feel
extending an operation to list objects to also show their contents goes
beyond that.  If we want an HMP command that does both, it should be
named differently.  Perhaps that might even be more appropriate for HMP
than low-level commands qom-list and qom-get, but I leave that to the
HMP maintainer to decide.

>>                      - one reason I'm not too bothered is because we've
>> failed to get a qom-get in multiple years of trying.

We clearly haven't tried hard enough.

If we can figure out how to show values in qom-list, surely we can
figure out how to show them in qom-get.

>>>       There might be unmerged patches on qemu-devel related to display
>>> of certain data types.
>>=20
>> Which ones?
>
> My original qom-info series needed StringOutputVisitor changes for enums
> (test case: rtc) that did not get accepted immediately and thus some
> part of HMP qom-info/qom-get got stuck due to risking assertions for
> qom-info / otherwise; QMP was not affected IIRC.

Here's the last try I can find:
[PATCH v2] qom: Implement qom-get HMP command
Message-Id: <1473157086-12062-1-git-send-email-dgilbert@redhat.com>
https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg01041.html

Its v1 tries a different approach:
[PATCH 0/2] qom-get [for 2.8]
Message-Id: <1472117833-10236-1-git-send-email-dgilbert@redhat.com>
Unfortunately the mailing list archive doesn't show the full thread, so
you get to follow three links:
https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg03815.html
https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg04261.html
https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg04267.html
