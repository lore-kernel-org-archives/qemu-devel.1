Received: from eggs.gnu.org ([2001:4830:134:3::10]:37859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1frlmk-0006BH-EF
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1frlmh-0005Wj-4N
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:08:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
	id 1frlmg-0005WF-Ty
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:07:59 -0400
Received: from mail-oi0-f69.google.com ([209.85.218.69])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1frlmf-0001Bn-OY
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:07:57 +0000
Received: by mail-oi0-f69.google.com with SMTP id u74-v6so14430670oie.16
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 08:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
	<20180817150513.GT11124@redhat.com>
	<6bf952d9-0269-c5df-6cac-70104ec88f81@ubuntu.com>
	<20180820084329.3uhnobuy5g52zqio@sirius.home.kraxel.org>
	<b91de5ea-7719-0301-7c7a-fb06785da0dc@ubuntu.com>
In-Reply-To: <b91de5ea-7719-0301-7c7a-fb06785da0dc@ubuntu.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Mon, 20 Aug 2018 17:07:30 +0200
Message-ID: <CAATJJ0Kui418HgNBCkY6nvCQXVujvm-HAv75wsi5XBqSA_s7aw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Pipe key broken on US keyboards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: psusi@ubuntu.com
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Mon, Aug 20, 2018 at 4:32 PM Phillip Susi <psusi@ubuntu.com> wrote:

> On 8/20/2018 4:43 AM, Gerd Hoffmann wrote:
> > There have been fixes for that one, specifically recent qemu will look
> > at modifier state in addition to the keysym when looking up the keycode,
> > because some keymaps can generate the same keysym with different key
> > combinations, and most of the time they have different modifier state.
>
> Yea, I saw that code, so the new version probably works if I could
> figure out how to get the package to build.  I'm not sure why Ubuntu is
> on such an old version.  I just cloned the debain git repo to start
> poking around and assumed that was what was in Ubuntu.
>

What exactly would you need in Ubuntu Phillp?
Latest qemu would atm be on 2.12 with the git available here [1].
Unfortunately mostly nobody cares about the git branches so I forgot to
push this one - shame on me :-/, it is ready now thou.

I couldn't follow all of the thread, do you need something else than qemu
code to be updated, if so which package would that be?

[1]: https://salsa.debian.org/qemu-team/qemu/commits/ubuntu-cosmic-2.12
