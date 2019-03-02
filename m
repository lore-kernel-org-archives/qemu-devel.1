Received: from eggs.gnu.org ([209.51.188.92]:60799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h0CgT-0005KO-HB
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 17:00:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h0CZr-0001ei-AE
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 16:53:52 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1h0CZr-0001dM-0U
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 16:53:51 -0500
Received: by mail-pg1-x543.google.com with SMTP id i130so686711pgd.1
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 13:53:50 -0800 (PST)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Sun, 3 Mar 2019 00:50:48 +0300
References: <201903021421.16546.randrianasulu@gmail.com>
	<201903022144.45897.randrianasulu@gmail.com>
	<alpine.BSF.2.21.9999.1903022116110.13215@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.9999.1903022116110.13215@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201903030050.49321.randrianasulu@gmail.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] Forward-porting RTC device for eppc500 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org

=C2 =F1=EE=EE=E1=F9=E5=ED=E8=E8 =EE=F2 Saturday 02 March 2019 23:40:47 BALA=
TON Zoltan =ED=E0=EF=E8=F1=E0=EB(=E0):

[snip]


>
> On Sat, 2 Mar 2019, Andrew Randrianasulu wrote:
> > Should I fix those?
>
> [...]
>
> > total: 14 errors, 2 warnings, 462 lines checked
> >
> > 0001-Re-applying-of-Freescale-PPC500-i2c-RTC-patch-writte.patch has sty=
le
> > problems, please review.  If any of these errors
> > are false positives report them to the maintainer, see
> > CHECKPATCH in MAINTAINERS.
>
> Yes, patches submitted to the list should pass checkpatch otherwise they
> will be rejected by automated build tests. These are simple to fix, just
> add spaces as checkpatch suggests: (1 << 0) and so on.
>
> (It's better to keep the list cc-d on reply so others can also answer your
> questions or correct my answers if I missed something which is not
> possible if you reply to me off list.)


Posted to list, arrived as=20
https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg00413.html

I used (in specifically created branch)

git reset origin
git reset --hard
git apply \
/home/guest/botva/src/src/qemu/0001-Re-applying-Freescale-PPC500-i2c-RTC-pa=
tch-written-b.patch
rm hw/i2c/mpc_i2c.c (leftover from my previous attempt at commiting)
again

git apply \
/home/guest/botva/src/src/qemu/0001-Re-applying-Freescale-PPC500-i2c-RTC-pa=
tch-written-b.patch
{now it applies cleanly)

git add hw/i2c/mpc_i2c.c

make

ppc64-softmmu/qemu-system-ppc64 -M ppce500 -cpu=20
e5500 -kernel /mnt/sdb1/PPC-img/linux-image-4.20.12-X1000_X5000/X5000_and_Q=
EMU_e5500/uImage-4.20 -nographic

git commit -a --author=3D"Amit Singh Tomar <amit.tomar@freescale.com>" =20
git format-patch -s 20b084c4b1401b7f8fbc385649d48c67b6f43d44
scripts/checkpatch.pl 0001-Re-applying-Freescale-PPC-E500-i2c-RTC-patch.pat=
ch

After this I created new message in Kmail and inserted 0001 file, edited it=
 a=20
bit more (adding patchwork link and mentioning fact I actually boot-tested=
=20
patch), and then send out.

Guess next time I better to add second "-s" to git format-patch, so first=20
signed-off-by-line from original will be around too?

Or ..lets wait what actual maintainers will say.=20
>
> Regards,
> BALATON Zoltan
