Received: from eggs.gnu.org ([2001:4830:134:3::10]:45237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dGK7m-0001Bw-69
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 03:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dGK7h-0002iN-A0
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 03:02:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dGK7h-0002iD-3N
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 03:02:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF8B71A6729
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 07:02:19 +0000 (UTC)
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-2-git-send-email-vyasevic@redhat.com>
	<b7f9de2d-e09c-bcf1-24c8-0d961989cd9c@redhat.com>
	<2687d5d9-9771-97dc-5a32-ac78006472f1@redhat.com>
	<20170530185713.GT2120@work-vm>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1b1b49c5-f949-9d29-bc36-1c482b4644f3@redhat.com>
Date: Thu, 1 Jun 2017 15:02:08 +0800
MIME-Version: 1.0
In-Reply-To: <20170530185713.GT2120@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Vlad Yasevich <vyasevic@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, germano@redhat.com, lvivier@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com



On 2017=E5=B9=B405=E6=9C=8831=E6=97=A5 02:57, Dr. David Alan Gilbert wrot=
e:
> * Vlad Yasevich (vyasevic@redhat.com) wrote:
>> On 05/26/2017 12:03 AM, Jason Wang wrote:
>>> On 2017=C3=A5=C2=B9=C2=B405=C3=A6=C5=93=CB=8625=C3=A6=E2=80=94=C2=A5 =
02:05, Vladislav Yasevich wrote:
>>>> Add parameters that control RARP/GARP announcement timeouts.
>>>> The parameters structure is added to the QAPI and a qmp command
>>>> is added to set/get the parameter data.
>>>>
>>>> Based on work by "Dr. David Alan Gilbert"<dgilbert@redhat.com>
>>>>
>>>> Signed-off-by: Vladislav Yasevich<vyasevic@redhat.com>
>>> I think it's better to explain e.g under which condition do we need t=
o tweak such parameters.
>>>
>>> Thanks
>>>
>> OK.  I'll rip off what dgilbert wrote in his original series for the d=
escription.
>>
>> Dave, if you have any text to add as to why migration might need to tw=
eak this, I'd
>> appreciate it.
> Pretty much what I originally said;  that the existing values
> are arbitrary and fixed, and for systems with complex/sluggish
> network reconfiguration systems they can be too slow.
>
> Dave
>

I agree, but I'm not sure how much it can help in fact unless management=20
can set configuration specific parameters. And what we did here is best=20
effort, there's no guarantee that G(R)ARP packet can reach the destinatio=
n.

Thanks
