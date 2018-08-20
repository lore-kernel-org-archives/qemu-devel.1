Received: from eggs.gnu.org ([2001:4830:134:3::10]:40806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1frqPv-0006pa-6n
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1frqPr-0003nK-RV
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:04:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
	id 1frqPo-0003hP-07
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:04:41 -0400
Received: from mail-oi0-f70.google.com ([209.85.218.70])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1frqPf-00083G-PK
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 20:04:31 +0000
Received: by mail-oi0-f70.google.com with SMTP id w185-v6so15314759oig.19
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 13:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
	<20180817150513.GT11124@redhat.com>
	<6bf952d9-0269-c5df-6cac-70104ec88f81@ubuntu.com>
	<20180820084329.3uhnobuy5g52zqio@sirius.home.kraxel.org>
	<b91de5ea-7719-0301-7c7a-fb06785da0dc@ubuntu.com>
	<CAATJJ0Kui418HgNBCkY6nvCQXVujvm-HAv75wsi5XBqSA_s7aw@mail.gmail.com>
	<9953aeaf-cb6c-0dba-a52c-97260728b530@ubuntu.com>
In-Reply-To: <9953aeaf-cb6c-0dba-a52c-97260728b530@ubuntu.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Mon, 20 Aug 2018 22:04:04 +0200
Message-ID: <CAATJJ0+sz+7Z6z-enmjd-QPM0djj7e_kMGCGtOm7QoZiA6k-wg@mail.gmail.com>
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

On Mon, Aug 20, 2018 at 9:51 PM Phillip Susi <psusi@ubuntu.com> wrote:

> On 8/20/2018 11:07 AM, Christian Ehrhardt wrote:
> > What exactly would you need in Ubuntu Phillp?
>
> It *looks* like this is fixed in 2.12, but Ubuntu has 2.11.
>
> > Latest qemu would atm be on 2.12 with the git available here [1].
> > Unfortunately mostly nobody cares about the git branches so I forgot to
> > push this one - shame on me :-/, it is ready now thou.
>
> What did you forget to push?  Because the debian git repo already seemd
> to have 2.12 last week.
>

I forgot to push the git branch for 2.12 when I uploaded the package itself
on 2018-07-20

Ubuntu cosmic (18.10) has qemu 2.12 as of ~4 weeks ago as well.
Once Cosmic is released there will be a 2.12 via the Ubuntu Cloud Archive
[1] available into Bionic as well.

[1]: https://wiki.ubuntu.com/OpenStack/CloudArchive


> > I couldn't follow all of the thread, do you need something else than qemu
> > code to be updated, if so which package would that be?
>
> Nope; it's just qemu 2.11 seems to have had this bug.  It seems there
> has been massive refactoring of the keyboard code since then so likely
> this bug will forever remain in 18.04 unless someone wants to go through
> the 2.11 code and figure out how to surgically fix it.  At this point I
> think the path of least resistance for me is to get the newer version in
> the debian git repo to build and install that.
>

Yeah unless one does volunteer to identify the single change or it becomes
a problem for more of the community it is unlikely to be changed in the
2.11 in Ubuntu Bionic.


> What I can't figure out is how to get the pristine-tar for
> dpkg-buildpackage.  The git repo doesn't contain the pristine-tar branch
> that was required for pristine-tar to check out the original tar.
>

I thought the salsa repo should have the pristine-tar branch which is valid
for Debian and Ubuntu.
But you are right it doesn't, any Ubuntu package in main will have a repo
per package following this scheme
  git://git.launchpad.net/~usd-import-team/ubuntu/+source/qemu
including pristine-tar branches for Debian as well as Ubuntu.

Worst case run a "pull-lp-source" and you'll get all you need (but without
git history)

-- 
Christian Ehrhardt
Software Engineer, Ubuntu Server
Canonical Ltd
