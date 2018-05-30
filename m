Received: from eggs.gnu.org ([2001:4830:134:3::10]:40135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fO5uG-0003wm-5J
	for qemu-devel@nongnu.org; Wed, 30 May 2018 14:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fO5uC-0007sj-7d
	for qemu-devel@nongnu.org; Wed, 30 May 2018 14:33:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35204 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fO5uC-0007sO-3W
	for qemu-devel@nongnu.org; Wed, 30 May 2018 14:33:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 82A84401EF10
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 18:33:03 +0000 (UTC)
References: <1527693912-32378-1-git-send-email-thuth@redhat.com>
	<af34cabc-9980-3f8c-c6c6-bb834c802235@redhat.com>
	<3171722d-aad9-39ad-7b24-6f80decf2747@redhat.com>
	<3846e12b-d2b3-a802-af9f-8a5d69b9794c@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c239bfc1-393d-6ad2-33fb-3c61a386866a@redhat.com>
Date: Wed, 30 May 2018 20:33:01 +0200
MIME-Version: 1.0
In-Reply-To: <3846e12b-d2b3-a802-af9f-8a5d69b9794c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH v2] Add a blog post about the new
 -nic parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>

On 30.05.2018 20:15, Eric Blake wrote:
> On 05/30/2018 12:27 PM, Thomas Huth wrote:
>> On 30.05.2018 17:57, Eric Blake wrote:
>>> On 05/30/2018 10:25 AM, Thomas Huth wrote:
>>>> QEMU v2.12 features a new, useful parameter called "-nic". Let's
>>>> throw some light on this new parameter with a new blog post.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>
>>>> =C2=A0=C2=A0screenshots/2018-05-30-qemu-cli-net.png=C2=A0=C2=A0=C2=A0=
 | Bin 0 -> 24020 bytes
>>>> =C2=A0=C2=A0screenshots/2018-05-30-qemu-cli-netdev.png | Bin 0 -> 13=
553 bytes
>>>
>>> While binaries are necessary for use from within the blog, do you als=
o
>>> have source files that can be opened under gimp or other software for
>>> easily tweaking the images?
>>
>> I've created them with LibreOffice for my presentation at FOSDEM 2018
>> ... I don't think we really want to check in .odp file into the
>> repository, do we? It's also just some text and boxes, you can easily
>> re-create that within minutes if it's ever necessary.
>=20
> True, but even posting the .odp to the list (even if not stored in
> qemu-web.git) or including a URL to your presentation in the commit
> message (hoping that the URL is long-lasting), might save a few minutes
> for someone down the road trying to use the image as a starting point
> for a slightly different graphic.

FWIW: https://fosdem.org/2018/schedule/event/vai_qemu_jungle/

>=C2=A0 (Or maybe I'm just spoiled by the GPL
> guaranteeing access to preferred-editing forms, whether for executables
> or for graphics - even if the blog isn't really under GPL)

You could also edit such png with gimp... Anyway, I think I'll include
the graphics as svg instead, then you can easily edit them with
Inkscape, for example.

 Thomas
