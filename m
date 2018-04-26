Received: from eggs.gnu.org ([2001:4830:134:3::10]:55002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBio5-0003BK-5h
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBio4-0007OD-5i
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:27:37 -0400
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
	<87in8qf2w3.fsf@dusky.pond.sub.org>
	<62dba5cf-b497-1a98-0af5-971e169a3458@redhat.com>
	<877eou2nek.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <71e91497-42bd-eea7-636d-9e725c4d2906@redhat.com>
Date: Thu, 26 Apr 2018 17:27:20 +0200
MIME-Version: 1.0
In-Reply-To: <877eou2nek.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] tests/device-introspect: Test devices
 with all machines, not only with "none"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On 26.04.2018 13:54, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
[...]
> Actually, a worse offender in the "waste everybody's time via redunancy=
"
> department could be qom-test.

I guess we could also change the logic in qom-tester to only run with
all machines if we're in SPEED=3Dslow mode, and rather only use the "none=
"
machine by default?

>> Anyway, do you think my patch here is useful and has a chance of getti=
ng
>> included? I.e. shall I re-spin this as a non-RFC patch? Or shall we
>> rather wait for Eduardo's python-based tests to get included into the
>> repository?
>=20
> I don't mind having make check SPEED=3Dslow run more extensive tests.
> Assuming we actually run them at least once in a while, which seems
> doubtful.

If some developers (like myself) are running it at least every couple of
weeks manually, that's already much better than nothing!

>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  In case someone wants to help with creating some bug fix patches
>>>>  during the QEMU hard freeze phase: This test can now be used to
>>>>  trigger lots of introspection bugs that we were not aware of yet.
>>>>  I think most of the bugs are due to wrong handling of instance_init
>>>>  vs. realize functions.
>>>
>>> Yes, that's a common class of bugs.  There's little guidance on what
>>> kind of work belongs where, and plenty of bad examples.
>>
>> I think we urgently need a file in doc/devel/ that describes the vario=
us
>> states / functions of a device, where we should properly describe the
>> differences between instance_init and realize. ... I'll try to come up
>> with something when I've got some spare time (unless somebody else
>> volunteers to do that first).
>=20
> Please do.
>=20
> Widen the scope from just TYPE_DEVICE to all of QOM?

I don't have that much experience with QOM yet that I'd dare to write a
doc about it. Would you maybe be interested in writing something up
about QOM?

 Thomas
