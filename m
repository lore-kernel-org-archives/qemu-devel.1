Received: from eggs.gnu.org ([2001:4830:134:3::10]:47298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSgoq-0004LC-VN
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSgon-0000Lv-T6
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:46:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49470 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fSgon-0000Li-NO
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:46:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 24FA58314C
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 10:46:29 +0000 (UTC)
References: <1525843212-31922-1-git-send-email-thuth@redhat.com>
	<87bmch48w6.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a16c729a-8856-1141-5a6f-e647624bab44@redhat.com>
Date: Tue, 12 Jun 2018 12:46:26 +0200
MIME-Version: 1.0
In-Reply-To: <87bmch48w6.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add an entry for
 qemu-options* files in main directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

On 11.06.2018 17:53, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> The file "qemu-options.h", "qemu-options.hx" and "qemu-options-wrapper=
.h"
>> in the main directory are currently without maintainer according to ou=
r
>> get_maintainers.pl script. Considering that the command line options a=
re
>> a public interface and thus quite important, this is quite a bad state=
.
>> So I'd like to suggest to add these files to the "Command line option
>> argument parsing" section now.
>>
>> And since I'm interested in the command line interface of QEMU, add
>> myself as reviewer here.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  MAINTAINERS | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e187b1f..6aa19dc 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1413,7 +1413,9 @@ F: chardev/baum.c
>> =20
>>  Command line option argument parsing
>>  M: Markus Armbruster <armbru@redhat.com>
>> +R: Thomas Huth <thuth@redhat.com>
>>  S: Supported
>> +F: qemu-options*
>>  F: include/qemu/option.h
>>  F: tests/test-keyval.c
>>  F: tests/test-qemu-opts.c
>=20
> CLI is like QMP in that there's infrastructure, interface and
> implementation.
>=20
> QMP infrastructure is MAINTAINERS sections QMP and QAPI.  These are
> proper subsystems, with clear boundaries.  Its maintainers get copied o=
n
> relatively few patches.
>=20
> QMP infrastructure doesn't own the actual commands[1], subsystems do.
> For instance, the block subsystem owns commands dealing with block
> devices.
>=20
> The QMP interface is specified in the QAPI schema.  Again, QMP
> infrastructure doesn't own it, subsystems do.  However, to maintain som=
e
> measure of cohesion, we co-maintain the interface: MAINTAINERS section
> QAPI schema covers the complete schema, and subsystems cover individual
> modules of the schema[2].
>=20
> I think a similar arrangement make sense for CLI.  We'll get it for fre=
e
> with CLI QAPIfication, but that'll take time.
>=20
> Your patch does what is possible with a monolithic interface definition=
:
> it dumps it all on one maintainer: me.  I'm struggling to keep up with
> the QAPI schema, I'm not sure I can take more.
>=20
> Note that "Command line option argument parsing" is phrased carefully:
> it's not "CLI", not even "CLI parsing".  qemu-options* does not fit
> there.  Two solutions: widen the section so it fits better, create a ne=
w
> section.  The latter would be closer to how we do QMP.
>=20
> What do you think?

Both ideas sound fine to me. What about adding a new section called
"Generic command line options"? I hope that the word "generic" then
makes it clear that this entry is primarily thought for generic options
- subsystem specific options can and should still go through the
subsystem trees instead.

Do you think you could still be available as (co-)maintainer of that new
section? If not, who are going to be the maintainers of that new
section? Paolo? Eric? Daniel? ...?

 Thomas
