Received: from eggs.gnu.org ([2001:4830:134:3::10]:38332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSJ1w-00057F-8U
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSJ1s-0007V4-GD
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:22:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54438 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fSJ1s-0007Ur-AG
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:22:24 -0400
Date: Mon, 11 Jun 2018 10:22:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180611092221.GE11636@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180608170231.27912-1-armbru@redhat.com>
	<20180608171209.GE18233@redhat.com>
	<b0870ff7-fb75-09a9-40cc-4d73f188a95c@amsat.org>
	<87po0xn9fq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87po0xn9fq.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Purge uses of banned g_assert_FOO()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On Mon, Jun 11, 2018 at 08:06:49AM +0200, Markus Armbruster wrote:
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>=20
> > On 06/08/2018 02:12 PM, Daniel P. Berrang=C3=A9 wrote:
> >> On Fri, Jun 08, 2018 at 07:02:31PM +0200, Markus Armbruster wrote:
> >>> We banned use of certain g_assert_FOO() functions outside tests, an=
d
> >>> made checkpatch.pl flag them (commit 6e9389563e5).  We neglected to
> >>> purge existing uses.  Do that now.
> >>>
> >>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >>> ---
> >>>  hw/ide/ahci.c                 |  2 +-
> >>>  hw/ppc/spapr_ovec.c           | 12 ++++++------
> >>>  hw/usb/dev-smartcard-reader.c |  2 +-
> >>>  qom/object.c                  | 10 +++++-----
> >>>  util/qht.c                    |  2 +-
> >>>  5 files changed, 14 insertions(+), 14 deletions(-)
> >>>
> >>> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> >>=20
> >>> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-r=
eader.c
> >>> index 2131e33d27..13d0befd9c 100644
> >>> --- a/hw/usb/dev-smartcard-reader.c
> >>> +++ b/hw/usb/dev-smartcard-reader.c
> >>> @@ -786,7 +786,7 @@ static void ccid_write_data_block(USBCCIDState =
*s, uint8_t slot, uint8_t seq,
> >>>          DPRINTF(s, D_VERBOSE, "error %d\n", p->b.bError);
> >>>      }
> >>>      if (len) {
> >>> -        g_assert_nonnull(data);
> >>> +        assert(data);
> >>=20
> >> nitpick - all the other conversions used  g_assert()
>=20
> The other conversions are in files that predominantly or exclusively us=
e
> g_assert().  This one is in a file that exclusively uses assert().

Ah ok, makes sense then.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
