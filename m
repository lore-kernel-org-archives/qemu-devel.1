Received: from eggs.gnu.org ([2001:4830:134:3::10]:45926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1flZO1-0005Ca-Dg
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 08:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1flZO0-00085S-Dq
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 08:40:53 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20180803084620.GE16395@lemon.usersys.redhat.com>
Date: Fri, 3 Aug 2018 08:40:43 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <F39993DF-274E-4951-B7D1-C03594BFED30@gmail.com>
References: <20180803005015.5116-1-programmingkidx@gmail.com>
	<20180803021036.GB16395@lemon.usersys.redhat.com>
	<12064535-0CD5-4762-B437-5E640C4A13C1@gmail.com>
	<20180803084620.GE16395@lemon.usersys.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img.c: Add examples section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org


> On Aug 3, 2018, at 4:46 AM, Fam Zheng <famz@redhat.com> wrote:
>=20
> On Thu, 08/02 22:34, Programmingkid wrote:
>>=20
>>> On Aug 2, 2018, at 10:10 PM, Fam Zheng <famz@redhat.com> wrote:
>>>=20
>>> On Thu, 08/02 20:50, John Arbuckle wrote:
>>>> Add an examples section to the help output.
>>>>=20
>>>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>>>> ---
>>>> qemu-img.c | 11 +++++++++++
>>>> 1 file changed, 11 insertions(+)
>>>>=20
>>>> diff --git a/qemu-img.c b/qemu-img.c
>>>> index 1acddf693c..f77c82695d 100644
>>>> --- a/qemu-img.c
>>>> +++ b/qemu-img.c
>>>> @@ -199,6 +199,17 @@ static void QEMU_NORETURN help(void)
>>>>=20
>>>>    printf("%s\nSupported formats:", help_msg);
>>>>    bdrv_iterate_format(format_print, NULL);
>>>> +
>>>> +    printf("\n\nExamples:\n\n"
>>>> +           "Create: qemu-img create -f qcow2 image.qcow2 10G\n\n"
>>>> +           "Info: qemu-img info image.qcow2\n\n"
>>>> +           "Resize: qemu-img resize image.qcow2 20G\n\n"
>>>> +           "Convert: qemu-img convert -f raw -O qcow2 image.img =
image.qcow2\n\n"
>>>> +           "Check: qemu-img check image.qcow2\n\n"
>>>> +           "Map: qemu-img map -f qcow2 --output=3Dhuman =
image.qcow2\n\n"
>>>> +           "Rebase: qemu-img rebase -b new_backing_file.qcow2 =
image.qcow2"
>>>> +           );
>>>=20
>>> The text looks good but maybe it's better to condense the section by =
using only
>>> one \n between command lines instead of two?
>>>=20
>>> Fam
>>=20
>> It would be harder on the user's eyes if I did that.
>=20
> This is objective, but being compact is more consistent in density =
with the
> above "Command syntax" section in this function.

I want to break away from that very dense format. It was just too hard =
to read.
