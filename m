Received: from eggs.gnu.org ([209.51.188.92]:51512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gqeCC-00011N-QT
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gqdx8-0006kw-1i
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:06:22 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
	<87pnsbxsi7.fsf@dusky.pond.sub.org>
	<3ed70b8e-f778-f942-2841-905223d3af8d@redhat.com>
	<87womjwbwj.fsf@dusky.pond.sub.org>
	<c017dbfe-f619-b626-211a-d3bdafb451aa@redhat.com>
Date: Mon, 04 Feb 2019 14:05:58 +0100
In-Reply-To: <c017dbfe-f619-b626-211a-d3bdafb451aa@redhat.com> (Eric Blake's
	message of "Fri, 1 Feb 2019 13:28:32 -0600")
Message-ID: <877eefsnyh.fsf@dusky.pond.sub.org>
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, jsnow@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 2/1/19 1:23 PM, Markus Armbruster wrote:
>
>>>>> +# @unknown-flags: any remaining flags not recognized by the current qemu version
>>>>
>>>> Intended use cases for @unknown-flags?
>>>
>>> The qcow2 spec defines bit 2 extra_data_compatible; and also leaves the
>>> door open for future extensions that may define other bits. If a new
>>> version of qemu (or some non-qemu qcow2 creation app) creates an image
>>> with additional feature bits set, THIS version of qemu doesn't know what
>>> name to give those bits, but can still inform the user that those bits
>>> are set via this field. It will be omitted for all images created by
>>> this version of qemu.
>> 
>> What would QMP clients do with this information?
>
> 'qemu-img info' is the intended QMP client; and it will print the
> unknown-flags along with everything else. In other words, we're trying
> to make qemu-img become useful for inspecting as much useful information
> as possible from an image with unknown origins.  Knowing that an image
> uses bitmaps with flags unknown to THIS version of qemu is a good
> indication that you should be careful about using/altering the image
> without first upgrading qemu, as it may destroy data that some other
> product desires to utilize.

Okay.  Now work that into the documentation :)
