Received: from eggs.gnu.org ([2001:4830:134:3::10]:55208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dGQPu-0001KQ-Hy
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dGQPp-0000L1-Lo
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:45:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1dGQPp-0000Ka-Cs
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:45:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42A351A673A
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 13:45:27 +0000 (UTC)
Reply-To: vyasevic@redhat.com
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-2-git-send-email-vyasevic@redhat.com>
	<b7f9de2d-e09c-bcf1-24c8-0d961989cd9c@redhat.com>
	<2687d5d9-9771-97dc-5a32-ac78006472f1@redhat.com>
	<20170530185713.GT2120@work-vm>
	<1b1b49c5-f949-9d29-bc36-1c482b4644f3@redhat.com>
From: Vlad Yasevich <vyasevic@redhat.com>
Message-ID: <4566aebb-4e6b-158a-4227-7bb6e35f737a@redhat.com>
Date: Thu, 1 Jun 2017 09:45:18 -0400
MIME-Version: 1.0
In-Reply-To: <1b1b49c5-f949-9d29-bc36-1c482b4644f3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/12] migration: Introduce announce
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, germano@redhat.com, lvivier@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com

On 06/01/2017 03:02 AM, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B405=E6=9C=8831=E6=97=A5 02:57, Dr. David Alan Gilbert wr=
ote:
>> * Vlad Yasevich (vyasevic@redhat.com) wrote:
>>> On 05/26/2017 12:03 AM, Jason Wang wrote:
>>>> On 2017=C3=A5=C2=B9=C2=B405=C3=A6=C5=93=CB=8625=C3=A6=E2=80=94=C2=A5=
 02:05, Vladislav Yasevich wrote:
>>>>> Add parameters that control RARP/GARP announcement timeouts.
>>>>> The parameters structure is added to the QAPI and a qmp command
>>>>> is added to set/get the parameter data.
>>>>>
>>>>> Based on work by "Dr. David Alan Gilbert"<dgilbert@redhat.com>
>>>>>
>>>>> Signed-off-by: Vladislav Yasevich<vyasevic@redhat.com>
>>>> I think it's better to explain e.g under which condition do we need =
to tweak such
>>>> parameters.
>>>>
>>>> Thanks
>>>>
>>> OK.  I'll rip off what dgilbert wrote in his original series for the =
description.
>>>
>>> Dave, if you have any text to add as to why migration might need to t=
weak this, I'd
>>> appreciate it.
>> Pretty much what I originally said;  that the existing values
>> are arbitrary and fixed, and for systems with complex/sluggish
>> network reconfiguration systems they can be too slow.
>>
>> Dave
>>
>=20
> I agree, but I'm not sure how much it can help in fact unless managemen=
t can set
> configuration specific parameters. And what we did here is best effort,=
 there's no
> guarantee that G(R)ARP packet can reach the destination.
>=20

So, that's what the series allows.  If management knows something new, it=
 can set
appropriate parameter values.  Additionally, the management is also free =
to trigger
additional announcements through the new commands.

I am starting to think that just for the sake of migration, exposing anno=
unce_self
interface to management might be sufficient.  Management, when it deems m=
igration
complete, may use the interface to trigger announcements in addition to w=
hatever
best effort QEMU may attempt itself.

Dave, would that be enough, or do the parameters still make sense?

Thanks
-vlad
