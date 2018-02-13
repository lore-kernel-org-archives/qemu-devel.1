Received: from eggs.gnu.org ([2001:4830:134:3::10]:40568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elegr-0005Wm-Pz
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:48:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elego-0003Q3-LU
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:48:25 -0500
Date: Tue, 13 Feb 2018 18:47:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180213184759.4225abbe.cohuck@redhat.com>
In-Reply-To: <151853948001.582.10146832003778705101@bdbb90650ae5>
References: <20180213161240.19891-1-david@redhat.com>
	<151853948001.582.10146832003778705101@bdbb90650ae5>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/tcg: fix disabling/enabling DAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: no-reply@patchew.org
Cc: qemu-devel@nongnu.org, david@redhat.com, famz@redhat.com, qemu-s390x@nongnu.org, agraf@suse.de, rth@twiddle.net

On Tue, 13 Feb 2018 08:31:21 -0800 (PST)
no-reply@patchew.org wrote:

> Checking PATCH 1/1: s390x/tcg: fix disabling/enabling DAT...
> WARNING: line over 80 characters
> #32: FILE: target/s390x/cpu.h:320:
> +#define FLAG_MASK_PSW		(FLAG_MASK_PER | FLAG_MASK_DAT | FLAG_MASK_PSTATE \

I'll ignore this...

> 
> ERROR: code indent should never use tabs
> #32: FILE: target/s390x/cpu.h:320:
> +#define FLAG_MASK_PSW^I^I(FLAG_MASK_PER | FLAG_MASK_DAT | FLAG_MASK_PSTATE \$

...and just get rid of the pre-existing tabs here while merging, no
need to resend.

> 
> total: 1 errors, 1 warnings, 51 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
