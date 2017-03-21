Received: from eggs.gnu.org ([2001:4830:134:3::10]:50062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cqEh8-0004NI-7J
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cqEh7-00011q-21
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:59:06 -0400
References: <1490014548-15083-1-git-send-email-armbru@redhat.com>
	<1490014548-15083-6-git-send-email-armbru@redhat.com>
	<c2110a8d-b4f8-3781-469c-59b99a062d6a@redhat.com>
	<87wpbjt7yl.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <37a42cde-538a-ed0e-e993-388c1c2b61d2@redhat.com>
Date: Tue, 21 Mar 2017 08:58:54 +0100
MIME-Version: 1.0
In-Reply-To: <87wpbjt7yl.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 5/5] MAINTAINERS: Add myself for
 files I touched recently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org

On 21.03.2017 08:17, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 03/20/2017 07:55 AM, Markus Armbruster wrote:
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  MAINTAINERS | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> By the way, where do we stand on the idea of having checkpatch.pl reje=
ct
>> patches that introduce new files without mentioning a maintainer?
>=20
> Stuck.  Thomas hasn't followed up on his RFC PATCH because he's afraid
> of false positives.  I encouraged him to rescue at least "[RFC PATCH
> 4/5] checkpatch: emit a reminder about MAINTAINERS on file
> add/move/delete", and I'm now encouraging him again.

Well, the patch series is out there, and there haven't been any (valid)
requests to rework it, so if you like, feel free to merge it:

https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05740.html

But as mentioned here:

 https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05753.html

there will be quite a bunch of false-positives. So we'd either have to
live with those or we have to come up with a smarter approach to handle
this issue (e.g. by running get_maintainers.pl on the affected files).

 Thomas
