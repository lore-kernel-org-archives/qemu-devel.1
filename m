Received: from eggs.gnu.org ([2001:4830:134:3::10]:42569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dtxjI-0008Fk-CP
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dtxjF-0008Gu-N4
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:13:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dtxjF-0008Gc-Gu
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:12:57 -0400
Message-ID: <1505747575.4959.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 18 Sep 2017 17:12:55 +0200
In-Reply-To: <20170914124059.GD15518@redhat.com>
References: <20170912123744.14730-1-berrange@redhat.com>
	<1505223994.31639.20.camel@redhat.com>
	<20170912141910.GJ17633@redhat.com>
	<CAFEAcA-tdbzXBkyxXW_e15hVcbcfqSfKqke0PX6y-Cg6A62DzQ@mail.gmail.com>
	<20170912143007.GK17633@redhat.com>
	<1505390103.31557.11.camel@redhat.com>
	<CAFEAcA9JEGbiwKeSMyvnLrdE+2WrkRbYLcVJ+UpFnU1RymC1vQ@mail.gmail.com>
	<20170914124059.GD15518@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 2017-09-14 at 13:40 +0100, Daniel P. Berrange wrote:
> On Thu, Sep 14, 2017 at 12:58:26PM +0100, Peter Maydell wrote:
> > On 14 September 2017 at 12:55, Gerd Hoffmann <kraxel@redhat.com>
> > wrote:
> > > =C2=A0 Hi,
> > >=20
> > > > I think a better approach is to have something in rules.mak
> > > > that ensures the submodule is checked out correctly (only
> > > > when building from GIT, not dist), and then have the rules
> > > > which generate the keymap files depend on this.
> > >=20
> > > Care sending a patch doing that for dtc?
> >=20
> > It sounds awfully fiddly. Maybe it is the best we can do
> > given the mess that is git submodules, but is it really
> > the common approach?
>=20
> I'll do a prototype so we can see something concrete working and
> evaluate how pleasant (or not) it is

Tried to brew something:

https://www.kraxel.org/cgit/qemu/log/?h=3Dwork/submodule

dtc was pretty simple due to the recursive make call.

Hooking the submodule update into a non-recursive make looks
complicated, especially because the submodule update might change the
timestamps and therefore the target set which needs a rebuild ...

So I did the keymaps build with a recursive make call too, which
doesn't look that pretty ...

cheers,
  Gerd
