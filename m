Received: from eggs.gnu.org ([209.51.188.92]:53144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h0ExO-0006Eo-92
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 19:26:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h0Evj-0001Rh-FX
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 19:24:36 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1h0Evj-0001Qx-5B
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 19:24:35 -0500
Received: by mail-pf1-x441.google.com with SMTP id g6so702122pfh.13
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 16:24:34 -0800 (PST)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Sun, 3 Mar 2019 03:21:29 +0300
References: <201903021421.16546.randrianasulu@gmail.com>
	<201903030050.49321.randrianasulu@gmail.com>
	<alpine.BSF.2.21.9999.1903030103490.67252@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.9999.1903030103490.67252@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201903030321.30631.randrianasulu@gmail.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] Forward-porting RTC device for eppc500 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org

=C2 =F1=EE=EE=E1=F9=E5=ED=E8=E8 =EE=F2 Sunday 03 March 2019 03:17:47 BALATO=
N Zoltan =ED=E0=EF=E8=F1=E0=EB(=E0):
> On Sun, 3 Mar 2019, Andrew Randrianasulu wrote:
> > git commit -a --author=3D"Amit Singh Tomar <amit.tomar@freescale.com>"
> > git format-patch -s 20b084c4b1401b7f8fbc385649d48c67b6f43d44
> >
> > scripts/checkpatch.pl
> > 0001-Re-applying-Freescale-PPC-E500-i2c-RTC-patch.patch
> >
> > After this I created new message in Kmail and inserted 0001 file, edited
> > it a bit more (adding patchwork link and mentioning fact I actually
> > boot-tested patch), and then send out.
>
> When sending patches to list make sure your mailer sends them as plain
> text and does not try to break up lines or alter white space because that
> breaks the patch and it won't apply with git am. You can check it in
> patchew (linked from SubmitAPatch wiki page):
>
> https://patchew.org/QEMU/201903030021.22070.randrianasulu@gmail.com/
>
> Not sure if Kmail can do this, maybe it has some settings for this but
> it's usually better to do all editing on the git commit and send patch
> mails with git send-email.

I see, it failed to apply. Will try to convince git send-mail to work (last=
 time=20
it failed for me, but it was long time ago)

>
> > Guess next time I better to add second "-s" to git format-patch, so fir=
st
> > signed-off-by-line from original will be around too?
> >
> > Or ..lets wait what actual maintainers will say.
>
> Yes, I'll let actual maintainers to comment then you can do a corrected
> version with any requested fixes or Reviewed-by tags added. I think for
> next revision you should leave original author's Signed-off-by in commit
> message and add yours with -s after that. (When sending another version of
> a patch use -v2 option of git format-patch to add v2 to the patch
> subject and so on for higher revisions if needed.)

Thanks.


>
> Regards,
> BALATON Zoltan
