Received: from eggs.gnu.org ([2001:4830:134:3::10]:37635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fFxN0-0000dk-0y
	for qemu-devel@nongnu.org; Tue, 08 May 2018 03:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fFxMw-0006GF-3x
	for qemu-devel@nongnu.org; Tue, 08 May 2018 03:49:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33556 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fFxMv-0006G2-UJ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 03:49:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6AC22401DEA7
	for <qemu-devel@nongnu.org>; Tue,  8 May 2018 07:49:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180413120234.GF16263@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Fri, 13 Apr 2018 13:02:34 +0100")
References: <20180404112731.5922-1-quintela@redhat.com>
	<20180404112731.5922-5-quintela@redhat.com>
	<20180412130932.GG2704@work-vm> <20180413120234.GF16263@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 08 May 2018 09:51:19 +0200
Message-ID: <87r2mma8lk.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 4/8] migration: Create socket-address
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Thu, Apr 12, 2018 at 02:09:33PM +0100, Dr. David Alan Gilbert wrote:
>> * Juan Quintela (quintela@redhat.com) wrote:
>> > It will be used to store the uri parameters. We want this only for
>> > tcp, so we don't set it for other uris.  We need it to know what port
>> > is migration running.
>> >=20
>> > Signed-off-by: Juan Quintela <quintela@redhat.com>
>> >=20
>> > --
>> >=20
>> > This used to be uri parameter, but it has so many troubles to
>> > reproduce that it don't just make sense.
>> >=20
>> > This used to be a port parameter.  I was asked to move to
>> > SocketAddress, done.
>> > I also merged the setting of the migration tcp port in this one
>> > because now I need to free the address, and this makes it easier.
>> > This used to be x-socket-address with a single direction, now it is a
>> > list of addresses.
>>=20
>> Is there a reason it's a parameter rather than just an entry in
>> MigrationInfo?
>
> I imagine it is a side-effect of earlier versions of this patch
> which used the migration parameter setter method. Having it in
> the MigrationInfo does seem reasonable to me since this is not
> a tunable parameter.

Yeap, that was the reason, as said on previous email, changed.

Thanks to both, Juan.
