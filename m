Received: from eggs.gnu.org ([2001:4830:134:3::10]:53286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSMka-0007oK-Ly
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSMkZ-0008Vj-V7
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:16:16 -0400
Date: Tue, 4 Jul 2017 14:16:06 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170704121606.GE4253@noname.str.redhat.com>
References: <20170704103427.22791-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170704103427.22791-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: delete the -e and -6 options
 from the 'create' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 04.07.2017 um 12:34 hat Daniel P. Berrange geschrieben:
> The '-e' and '-6' options to the 'create' command were "deprecated"
> in favour of the more generic '-o' option many years ago:
> 
>   commit eec77d9e712bd4157a4e1c0b5a9249d168add738
>   Author: Jes Sorensen <Jes.Sorensen@redhat.com>
>   Date:   Tue Dec 7 17:44:34 2010 +0100
> 
>     qemu-img: Deprecate obsolete -6 and -e options
> 
> Except this was never actually a deprecation, which would imply giving
> the user a warning while the functionality continues to work for a
> number of releases before eventual removal. Instead the options were
> immediately turned into an error + exit. Given that the functionality
> is already broken, there's no point in keeping these psuedo-deprecation
> messages around any longer.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Thanks, applied to the block branch.

Do you want to send another patch to do the same in qemu-img convert?

Kevin
