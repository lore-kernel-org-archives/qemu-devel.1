Received: from eggs.gnu.org ([2001:4830:134:3::10]:47233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fbZkU-0005nY-3K
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 19:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fbZkP-0003WQ-6u
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 19:02:46 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fbZkO-0003VT-V0
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 19:02:41 -0400
Received: by mail-pf0-x243.google.com with SMTP id q7-v6so8397986pff.2
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 16:02:39 -0700 (PDT)
Date: Sat, 7 Jul 2018 08:02:36 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180706230236.GV24595@lianli.shorne-pla.net>
References: <20180702151023.24532-1-shorne@gmail.com>
	<20180702151023.24532-23-shorne@gmail.com>
	<feef2195-8fd8-f9e1-da85-f3286a9e2b1d@amsat.org>
	<CAAfxs77LqYG2gGT3Y0xs=SYMdQ9GoO0hymdwF-UGZcjXyrQUMg@mail.gmail.com>
	<43d6bc18-440a-31e9-f055-8d0b14cbc74e@linaro.org>
	<b31d8ace-fb05-0748-ba21-9daf97350af6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b31d8ace-fb05-0748-ba21-9daf97350af6@redhat.com>
Subject: Re: [Qemu-devel] [PULL v2 22/25] linux-user: Implement signals for
 openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On Fri, Jul 06, 2018 at 05:22:15PM -0500, Eric Blake wrote:
> On 07/04/2018 03:54 PM, Richard Henderson wrote:
> > On 07/03/2018 04:51 PM, Stafford Horne wrote:
> > > Richard, how do you usually remove these before your pr?  I suppose you have
> > > some kind of script?
> > 
> > No, I just edit the things by hand.
> 
> I do it by always using 'git am' to suck in patches from the mailing list,
> including my own patches, and even if I already have the patch locally.
> That is, my workflow for PR bypasses my local work tree to ensure I don't
> leave local artifacts around in the PR.

Hi Eric,

How do you carry the Change list for each patch brought in with 'git am' i.e.
v2,v3 when you have updates that need respin?  Do you just update that manually
on the .patch files after 'git format-patch'?

I found and tried `git notes` recently which seems to be meant for this.

>From 'git help notes'

   Notes can also be added to patches prepared with git format-patch by
   using the --notes option. Such notes are added as a patch commentary
   after a three dash separator line.

However, I found the notes get lots pretty easily during rebases and would not
survive a 'git am'.

I am sure many have their own methods that work.  So far I have been doing
manually just updating the .patch files after 'format-patch'.

-Stafford
