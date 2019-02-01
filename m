Received: from eggs.gnu.org ([209.51.188.92]:44325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpePk-0003nl-Kd
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:23:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpePj-00060A-Ii
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:23:48 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
	<87pnsbxsi7.fsf@dusky.pond.sub.org>
	<3ed70b8e-f778-f942-2841-905223d3af8d@redhat.com>
Date: Fri, 01 Feb 2019 20:23:40 +0100
In-Reply-To: <3ed70b8e-f778-f942-2841-905223d3af8d@redhat.com> (Eric Blake's
	message of "Fri, 1 Feb 2019 13:04:12 -0600")
Message-ID: <87womjwbwj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 2/3] qemu-img info lists bitmap
 directory entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 2/1/19 12:39 PM, Markus Armbruster wrote:
>> Andrey Shinkevich <andrey.shinkevich@virtuozzo.com> writes:
>> 
>
>>>  
>>>  ##
>>> +# @Qcow2BitmapInfoFlags:
>>> +#
>>> +# An enumeration of flags that a bitmap can report to the user.
>>> +#
>>> +# @in-use: The bitmap was not saved correctly and may be inconsistent.
>> 
>> I doubt the casual reader could guess the meaning from the name.  What
>> about @dirty?
>
> I like it.  The existing name was chosen to match
> docs/interop/qcow2.txt, which uses in_use, but I don't see a problem in
> making the UI nicer than the specs (and/or rewording the specs, as the
> field name doesn't matter there, only the layout).
>
>
>>> +# @unknown-flags: any remaining flags not recognized by the current qemu version
>> 
>> Intended use cases for @unknown-flags?
>
> The qcow2 spec defines bit 2 extra_data_compatible; and also leaves the
> door open for future extensions that may define other bits. If a new
> version of qemu (or some non-qemu qcow2 creation app) creates an image
> with additional feature bits set, THIS version of qemu doesn't know what
> name to give those bits, but can still inform the user that those bits
> are set via this field. It will be omitted for all images created by
> this version of qemu.

What would QMP clients do with this information?
