Received: from eggs.gnu.org ([2001:4830:134:3::10]:32785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fkUUO-0003YE-6x
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 09:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fkUUN-0004WT-D1
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 09:15:00 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20180731123540.GB5197@localhost.localdomain>
Date: Tue, 31 Jul 2018 09:14:47 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD650F16-14BA-4EC8-B14F-66931C5DC956@gmail.com>
References: <20180731025231.17482-1-programmingkidx@gmail.com>
	<cdfa1c40-b618-52e8-41b8-a58a67acef66@redhat.com>
	<20180731123540.GB5197@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] qemu-img-cmds.hx: Add example usage for
 create command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org


> On Jul 31, 2018, at 8:35 AM, Kevin Wolf <kwolf@redhat.com> wrote:
>=20
> Am 31.07.2018 um 13:57 hat Eric Blake geschrieben:
>> On 07/30/2018 09:52 PM, John Arbuckle wrote:
>>> Add an example on how to use the create command. I believe this will =
make qemu-img easier to use.
>>>=20
>>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>>> ---
>>>  qemu-img-cmds.hx | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
>>> index 69758fb6e8..92f7437944 100644
>>> --- a/qemu-img-cmds.hx
>>> +++ b/qemu-img-cmds.hx
>>> @@ -50,7 +50,7 @@ STEXI
>>>  ETEXI
>>>  DEF("create", img_create,
>>> -    "create [--object objectdef] [-q] [-f fmt] [-b backing_file] =
[-F backing_fmt] [-u] [-o options] filename [size]")
>>> +    "create [--object objectdef] [-q] [-f fmt] [-b backing_file] =
[-F backing_fmt] [-u] [-o options] filename [size]\nExample: qemu-img =
create -f qcow2 WindowsXP.qcow2 10G")
>>=20
>> Making a long line longer. It would be worth using C string =
concatenation
>> and splitting this over two lines, at the \n.
>>=20
>> Using the name WindowsXP.qcow2 as the guest is somewhat misleading =
(that OS
>> is proprietary, and quickly reaching the point of obsolescence from =
its
>> vendor - furthermore, qemu-img doesn't actually install an OS, but =
rather
>> creates a blank image for a later install process to utilize); better =
would
>> be a generic name that won't go out of date, such 'image.qcow2'.
>=20
> Also, while I like the idea of adding examples to the man page, I =
don't
> think adding it here would give the right result. The example would
> appear in the middle of the subcommand syntax lines.

As it reads now I don't feel its easy for the user to decipher. Having =
an
example near by would help the user understand how to use it.

> I'd rather add a whole new section "EXAMPLES" in the man page.

That is a good idea. I would like to have examples in both documents.=20
