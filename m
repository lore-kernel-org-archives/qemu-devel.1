Received: from eggs.gnu.org ([2001:4830:134:3::10]:46759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eYnKt-00083S-KT
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 01:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eYnKs-0006sD-Td
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 01:24:35 -0500
Date: Tue, 9 Jan 2018 14:24:25 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180109062425.GA18346@lemon.usersys.redhat.com>
References: <20180105065538.13375-1-famz@redhat.com>
	<20180108144136.GF8052@localhost.localdomain>
	<CAMr-obsaegU2HDaH3EFoD+2EYUnPKuqsvQPk4GZ7hTdqXmpoWA@mail.gmail.com>
	<20180108175729.GI8052@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180108175729.GI8052@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] qemu-img: Let "info" warn
 and go ahead without -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Ala Hino <ahino@redhat.com>

On Mon, 01/08 18:57, Kevin Wolf wrote:
> I'm not sure if going back to the old behaviour for a while now would be
> helpful, you'd just end up with an even more confusing set of qemu
> versions, for example:
> 
>     <= 2.9          - works without a warning
>     2.10 and 2.11   - errors out
>     2.12            - prints a warning, but works
>     >= 2.13         - errors out again

What I had in mind is settle on warning for good. QEMU (including qemu-img) is a
low level tool that can be used in many ways that it isn't supposed to, this one
is not more harmful than others (e.g. "qemu-img snapshot ..." on iscsi:// qcow2
image) we allow siliently.

I know this is debatable but I think the #1 purpose of image locking is to
prevent data corruption; #2 IMO is to reduce confusion and misinformation.
While inconsistent output of "qemu-img info" is misinformation, it not working
as before is actually confusion. Though the current behavior is indeed ideal,
the proposed patch is a bit more pragmatical.

Fam
