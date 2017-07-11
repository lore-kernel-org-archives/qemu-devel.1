Received: from eggs.gnu.org ([2001:4830:134:3::10]:48391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dUtg1-00073h-T1
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 07:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dUtg1-000597-5v
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 07:50:01 -0400
Date: Tue, 11 Jul 2017 13:49:51 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170711114951.bzxzkwajvbhjs4z2@eukaryote>
References: <1499674503-21551-1-git-send-email-kchamart@redhat.com>
	<1499674503-21551-2-git-send-email-kchamart@redhat.com>
	<251c3898-8d5f-a799-318e-5ab0545220a3@redhat.com>
	<20170711075839.wgp64avrkzyo6d6t@eukaryote>
	<5215f15d-9d8b-698f-30a0-b2f569cbc59a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5215f15d-9d8b-698f-30a0-b2f569cbc59a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/2] bitmaps.md: Convert to rST;
 move it into 'interop' dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, berto@igalia.com

On Tue, Jul 11, 2017 at 06:33:22AM -0500, Eric Blake wrote:
> On 07/11/2017 02:58 AM, Kashyap Chamarthy wrote:

[...]

> >> A shame that git rename detection doesn't see these as the same rough
> >> contents, but not too bad. 
> > 
> > _Should_ it detect?
> 
> It depends on the similarities between the file, and on whether you have
> 'git config diff.renames true' set (there are some other parameters you
> can set to fine-tune how much effort git expends on detecting file
> renames, but the defaults are usually good enough).

I see, noted.

[...]

> > Indeed -- the things you point out further below were already
> > pre-existing.  
> > 
> > Asking out of curiosity: You say it is nicer split because we'll retain
> > the `git-bisect`-ability?  Or just to keep text motion and actual
> > changes separate?  (I think both.)
> 
> bisect-ability is important on code, but less so on docs. If you were
> doing code motion, I'd absolutely insist that cleanups be separate from
> the motion; but here I don't have a strong preference (separating the
> cleanups DOES make it easier to perform a backport of the cleanup
> without having to backport the rename, but backporting docs tends to be
> less of a priority than backporting code functionality).

Yep, fully agree with you, and I guessed as much.  Given this
understanding, I'll just fix your feedback in this series.

Thanks.

-- 
/kashyap
