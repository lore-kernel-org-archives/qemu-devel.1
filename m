Received: from eggs.gnu.org ([209.51.188.92]:53140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h0ExX-0006En-OF
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 19:26:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h0EpD-0004oa-9v
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 19:17:52 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:60520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h0EpD-0004jw-2s
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 19:17:51 -0500
Date: Sun, 3 Mar 2019 01:17:47 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <201903030050.49321.randrianasulu@gmail.com>
Message-ID: <alpine.BSF.2.21.9999.1903030103490.67252@zero.eik.bme.hu>
References: <201903021421.16546.randrianasulu@gmail.com>
	<201903022144.45897.randrianasulu@gmail.com>
	<alpine.BSF.2.21.9999.1903022116110.13215@zero.eik.bme.hu>
	<201903030050.49321.randrianasulu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] Forward-porting RTC device for eppc500 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
Cc: qemu-devel@nongnu.org

On Sun, 3 Mar 2019, Andrew Randrianasulu wrote:
> git commit -a --author="Amit Singh Tomar <amit.tomar@freescale.com>"
> git format-patch -s 20b084c4b1401b7f8fbc385649d48c67b6f43d44
>
> scripts/checkpatch.pl 0001-Re-applying-Freescale-PPC-E500-i2c-RTC-patch.patch
>
> After this I created new message in Kmail and inserted 0001 file, edited it a
> bit more (adding patchwork link and mentioning fact I actually boot-tested
> patch), and then send out.

When sending patches to list make sure your mailer sends them as plain 
text and does not try to break up lines or alter white space because that 
breaks the patch and it won't apply with git am. You can check it in 
patchew (linked from SubmitAPatch wiki page):

https://patchew.org/QEMU/201903030021.22070.randrianasulu@gmail.com/

Not sure if Kmail can do this, maybe it has some settings for this but 
it's usually better to do all editing on the git commit and send patch 
mails with git send-email.

> Guess next time I better to add second "-s" to git format-patch, so first
> signed-off-by-line from original will be around too?
>
> Or ..lets wait what actual maintainers will say.

Yes, I'll let actual maintainers to comment then you can do a corrected 
version with any requested fixes or Reviewed-by tags added. I think for 
next revision you should leave original author's Signed-off-by in commit 
message and add yours with -s after that. (When sending another version of 
a patch use -v2 option of git format-patch to add v2 to the patch 
subject and so on for higher revisions if needed.)

Regards,
BALATON Zoltan
