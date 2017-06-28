Received: from eggs.gnu.org ([2001:4830:134:3::10]:60381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1dQD96-0002Qf-8U
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1dQD92-0006rm-Ay
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:36:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:42649 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <afaerber@suse.de>) id 1dQD92-0006rA-3w
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:36:36 -0400
References: <20170628124850.12821-1-famz@redhat.com>
	<20170628124850.12821-2-famz@redhat.com>
	<538088ce-7515-f8a0-e4d7-21ec02bd45c9@redhat.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <a9272af6-d6fa-89b0-3e30-35d85f5d3489@suse.de>
Date: Wed, 28 Jun 2017 15:36:33 +0200
MIME-Version: 1.0
In-Reply-To: <538088ce-7515-f8a0-e4d7-21ec02bd45c9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] qom: Make link property API public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Am 28.06.2017 um 15:32 schrieb Paolo Bonzini:
> On 28/06/2017 14:48, Fam Zheng wrote:
>> The get/set pair and the struct will be reused by qdev link prop, make
>> them public.
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> Maybe it's better to make it a separate header file.  No other objectio=
ns.

So you think it should be added?

The alternative would be moving info qom-tree forward and finally
deprecating info qtree. There was a patch of mine to make it list
properties with -v or so, but there were StringOutputVisitor
dependencies where it got stuck in review.

Regards,
Andreas

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=C3=BCrnberg)
