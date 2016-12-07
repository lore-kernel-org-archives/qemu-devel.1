Received: from eggs.gnu.org ([2001:4830:134:3::10]:45874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEQZ0-0005NU-5T
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 19:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEQYx-0003Ye-3a
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 19:58:26 -0500
Received: from [45.249.212.187] (port=2490 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEQYw-0003Nl-CZ
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 19:58:23 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 7 Dec 2016 00:57:57 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA15595D@DGGEMA505-MBX.china.huawei.com>
References: <1481016553-69252-1-git-send-email-arei.gonglei@huawei.com>
	<20161206153945-mutt-send-email-mst@kernel.org>
	<20161206173337.GB30363@stefanha-x1.localdomain>
	<20161206211034-mutt-send-email-mst@kernel.org>
	<66ab8815-b9bb-7068-1809-0a31367534ff@redhat.com>
	<20161206201811.GC2521@stefanha-x1.localdomain>
In-Reply-To: <20161206201811.GC2521@stefanha-x1.localdomain>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-2.8] virtio-crypto: zeroize the key
 material before free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>

>
> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> Sent: Wednesday, December 07, 2016 4:18 AM
> To: Eric Blake
> Cc: Michael S. Tsirkin; Gonglei (Arei); qemu-devel@nongnu.org; Daniel P.
> Berrange
> Subject: Re: [Qemu-devel] [PATCH for-2.8] virtio-crypto: zeroize the key
> material before free
>=20
> On Tue, Dec 06, 2016 at 01:30:12PM -0600, Eric Blake wrote:
> > On 12/06/2016 01:22 PM, Michael S. Tsirkin wrote:
> > > On Tue, Dec 06, 2016 at 05:33:37PM +0000, Stefan Hajnoczi wrote:
> > >> On Tue, Dec 06, 2016 at 03:40:49PM +0200, Michael S. Tsirkin wrote:
> > >>> On Tue, Dec 06, 2016 at 05:29:13PM +0800, Gonglei wrote:
> > >>>> Zeroize the memory of CryptoDevBackendSymOpInfo structure pointed
> > >>>> for key material security.
> > >>>>
> >
> > >>>> +            /* Zeroize and free request data structure */
> > >>>> +            memset(op_info, 0, sizeof(*op_info) + max_len);
> > >>>> +            g_free(op_info);
> > >>>
> > >>> Write into memory, then free it?  This looks rather strange. Why ar=
e we
> > >>> doing this?
> > >>
> > >> Common practice with sensitive information (key material, passwords,
> > >> etc).
> > >
> > > Some kind of explanation about what makes this one
> > > more sensitive than others would be nice.
> >
> > Even mentioning existing practice would go a long way; see commit
> 8813800b.
> >
> > >
> > > Also, what makes it 2.8 material? Considering the pointer math
> > > involved, it's not risk-free.
> > >
> > >> coredumps, memory disclosure bugs when heap memory is reused, etc.
> > >>
> > >> Sensitive information is sometimes also held in mlocked pages to pre=
vent
> > >> it being swapped to disk but that's not being done here.
> >
> > And existing practice is that we aren't going to be that paranoid at
> > this time (and yes, I asked Dan that same question on his commit
> > mentioned above).
>=20
> Okay.  I am not merging this for QEMU 2.8.0-rc3, it should go through
> Michael Tsirkin's tree.
>=20
It's fair, let me send V2 for 2.9 with clearer commit message.

Thank you, guys~

Regards,
-Gonglei
