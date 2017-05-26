Received: from eggs.gnu.org ([2001:4830:134:3::10]:39446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dEEwm-0003rx-0r
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dEEwi-00040z-TO
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:06:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1dEEwi-00040c-Mz
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:06:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 937167F4B6
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 13:06:23 +0000 (UTC)
Reply-To: vyasevic@redhat.com
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-2-git-send-email-vyasevic@redhat.com>
	<b7f9de2d-e09c-bcf1-24c8-0d961989cd9c@redhat.com>
From: Vlad Yasevich <vyasevic@redhat.com>
Message-ID: <2687d5d9-9771-97dc-5a32-ac78006472f1@redhat.com>
Date: Fri, 26 May 2017 09:06:16 -0400
MIME-Version: 1.0
In-Reply-To: <b7f9de2d-e09c-bcf1-24c8-0d961989cd9c@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com

On 05/26/2017 12:03 AM, Jason Wang wrote:
>=20
> On 2017=E5=B9=B405=E6=9C=8825=E6=97=A5 02:05, Vladislav Yasevich wrote:
>> Add parameters that control RARP/GARP announcement timeouts.
>> The parameters structure is added to the QAPI and a qmp command
>> is added to set/get the parameter data.
>>
>> Based on work by "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>
>> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
>=20
> I think it's better to explain e.g under which condition do we need to =
tweak such parameters.
>=20
> Thanks
>=20

OK.  I'll rip off what dgilbert wrote in his original series for the desc=
ription.

Dave, if you have any text to add as to why migration might need to tweak=
 this, I'd
appreciate it.

Thanks
-vlad
