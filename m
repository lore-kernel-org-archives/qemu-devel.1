Received: from eggs.gnu.org ([2001:4830:134:3::10]:42731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJrf4-0000eY-VP
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:59:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJrf1-0006J2-VB
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:59:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eJrf1-0006IV-Od
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:59:39 -0500
Date: Wed, 29 Nov 2017 09:59:27 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171129015927.GA9966@lemon>
References: <151134740734.552.186654908491769740@bafd83ae6430>
	<3d7b93b2-76b1-cfc4-f87b-8983a8439bb7@redhat.com>
	<20171129012511.GA8889@lemon>
	<93609838-1bd7-6b08-ebda-538dac98f2f7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <93609838-1bd7-6b08-ebda-538dac98f2f7@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Add a blog post about HAXM acceleration on
 Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, Yu Ning <yu.ning@linux.intel.com>
Cc: Eric Blake <eblake@redhat.com>, no-reply@patchew.org, sw@weilnetz.de, qemu-devel@nongnu.org, huth@tuxfamily.org, yu.ning@intel.com, jsnow@redhat.com

On Wed, 11/29 09:30, Yu Ning wrote:
>=20
>=20
> On 11/29/2017 9:25, Fam Zheng wrote:
> > On Tue, 11/28 13:57, Eric Blake wrote:
> > > On 11/22/2017 04:43 AM, no-reply@patchew.org wrote:
> > > > Hi,
> > > >=20
> > > > This series failed automatic build test. Please find the testing =
commands and
> > > > their output below. If you have docker installed, you can probabl=
y reproduce it
> > > > locally.
> > > >=20
> > > > Subject: [Qemu-devel] [PATCH] Add a blog post about HAXM accelera=
tion on Windows
> > > > Type: series
> > > > Message-id: 1511338200-20417-1-git-send-email-yu.ning@linux.intel=
.com
> > > Just now noticing this, but it's impressive that:
> > >=20
> > > > Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> > > > Switched to a new branch 'test'
> > > > 73987e06df Add a blog post about HAXM acceleration on Windows
> > > the patch even applied, even though it wasn't against qemu.git!  Is=
 it
> > > possible to teach patchew to ignore patches against the website, as=
 that is
> > > maintained in a separate repository?
> > This patch was supposed to have "[qemu-web PATCH]" or "[PATCH web]" i=
n the
> > subject. That way it wouldn't be processed by patchew. (I think that =
is in
> > general a good way to state which repo the series is targeting at.)
>=20
> I see.=A0 Sorry I didn't know about that and used the wrong prefix.

No problem, thank you for the post!

> Is it
> documented on the wiki?

Seems not.

I'll send a patch to add this in

https://www.qemu.org/2017/02/04/the-new-qemu-website-is-up/

Fam
