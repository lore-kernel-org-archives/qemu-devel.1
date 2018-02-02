Received: from eggs.gnu.org ([2001:4830:134:3::10]:54466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehe4t-0001UN-7l
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:21:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehe3o-0003dc-B6
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:20:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ehe3n-0003cU-UA
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:19:32 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02B9381DE5
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 06:49:46 +0000 (UTC)
Date: Fri, 2 Feb 2018 07:49:44 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180202064944.phcqthgentgii6at@sirius.home.kraxel.org>
References: <20180201155841.27509-1-berrange@redhat.com>
	<bedde7ad-4174-a608-ea43-c3b6535f7280@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <bedde7ad-4174-a608-ea43-c3b6535f7280@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] ui: correctly advance output buffer
 when writing SASL data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>

On Thu, Feb 01, 2018 at 10:03:23AM -0600, Eric Blake wrote:
> On 02/01/2018 09:58 AM, Daniel P. Berrang=E9 wrote:
> > In this previous commit:
> >=20
> >   commit 8f61f1c5a6bc06438a1172efa80bc7606594fa07
> >   Author: Daniel P. Berrange <berrange@redhat.com>
> >   Date:   Mon Dec 18 19:12:20 2017 +0000
> >=20
> >     ui: track how much decoded data we consumed when doing SASL encod=
ing
> >=20
> > I attempted to fix a flaw with tracking how much data had actually be=
en
> > processed when encoding with SASL. With that flaw, the VNC server cou=
ld
> > mistakenly discard queued data that had not been sent.
> >=20
> > The fix was not quite right though, because it merely decremented the
> > vs->output.offset value. This is effectively to discarding data from =
the
>=20
> s/to //

Patch queued, fix applied.

thanks,
  Gerd
