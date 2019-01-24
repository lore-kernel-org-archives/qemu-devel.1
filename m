Received: from eggs.gnu.org ([209.51.188.92]:53607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gmbIr-0004O8-Dc
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gmb82-0001dg-Ut
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:16:55 -0500
Date: Thu, 24 Jan 2019 10:16:49 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20190124091649.GF23279@paraplu>
References: <CAMAMwPB1GJNxsgcvZLHwHuLp-AjuWtnYCGOm6+U4DwdLsNrU8A@mail.gmail.com>
	<e169e116-1ab3-692c-5320-eb4da9abb623@redhat.com>
	<CAMAMwPBiy7MsZzmkOPZoh+KNHfpsfA+WcRA7ZfQa0457+au99w@mail.gmail.com>
	<9aef3157-e49e-4b53-f0de-75593df06da9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9aef3157-e49e-4b53-f0de-75593df06da9@redhat.com>
Subject: Re: [Qemu-devel] Incremental drive-backup with dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Bharadwaj Rayala <bharadwaj.rayala@rubrik.com>, qemu-devel@nongnu.org, Kashyap Chamarthy <kashyap.cv@gmail.com>, Suman Swaroop <suman.swaroop@rubrik.com>, John Snow <jsnow@redhat.com>, qemu-discuss@nongnu.org

On Wed, Jan 23, 2019 at 01:09:41PM -0600, Eric Blake wrote:
> On 1/23/19 12:08 PM, Bharadwaj Rayala wrote:

[...] # [Snip Eric's excellent exposition.]

> > What do you mean by issues? Do you mean any data/corruption bugs or lack of
> > some nice functionality that we are talking here?
> 
> Lack of functionality.  In particular, the 4.0 commands
> block-dirty-bitmap-{enable,merge,disable} (or their 3.1 counterparts
> x-block-dirty-bitmap-*) are essential to the workflow of differential
> backups (without being able to manage bitmaps yourself, you can only get
> the weaker incremental backup, and that means qemu itself is clearing
> the bitmap out of under your feet on success, and where you are having
> to worry about completion-mode=grouped).
> 
> > 
> > Thanks a lot Eric for spending your time in answering my queries. I dont
> > know if you work with Kashyap Chamarthy, but your help and his blogs are
> > lifesavers.
> 
> Yes, Kashyap is trying to build solutions on top of the building blocks
> that I am working on, so we have collaborated several times on these
> types of issues (he does a lot better at blog posts extracted from my
> mailing list brain dumps).

I haven't kept up with incremental backups lately, as I've been swamped
with other work.  But two other documents that I can point to are these
[1][2] in the QEMU tree.  And their HTML-rendered versions are
here[3][4].  They're generated for 3.0.0; but these docs haven't changed
much since then.

Along with Eric's last year talk, also check out presentations from
previous KVM Forums from other Block Layer maintainers.


[1] https://git.qemu.org/?p=qemu.git;a=blob;f=docs/interop/live-block-operations.rst
[2] https://git.qemu.org/?p=qemu.git;a=blob;f=docs/interop/bitmaps.rst
[3] https://kashyapc.fedorapeople.org/QEMU-Docs-v3.0.0/_build/html/docs/interop/live-block-operations.html
[4] https://kashyapc.fedorapeople.org/QEMU-Docs-v3.0.0/_build/html/docs/interop/bitmaps.html


-- 
/kashyap
