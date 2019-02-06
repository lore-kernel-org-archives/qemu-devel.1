Received: from eggs.gnu.org ([209.51.188.92]:49414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1grMn1-0004rS-IL
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 07:58:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1grMn0-0004z3-Rr
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 07:58:55 -0500
Date: Wed, 6 Feb 2019 13:58:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190206135840.60a2a49f.cohuck@redhat.com>
In-Reply-To: <1549456893-16589-1-git-send-email-thuth@redhat.com>
References: <1549456893-16589-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x: Fix the confusing
 contributions-after-2012 license statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Christian Borntraeger <borntraeger@de.ibm.com>

On Wed,  6 Feb 2019 13:41:33 +0100
Thomas Huth <thuth@redhat.com> wrote:

> The license information in these files is rather confusing. The text
> declares LGPL first, but then says that contributions after 2012 are
> licensed under the GPL instead. How should the average user who just
> downloaded the release tarball know which part is now GPL and which
> is LGPL?

FWIW, that statement was added in ccb084d3f0ec ("s390: new
contributions GPLv2 or later").

> 
> Looking at the text of the LGPL (see COPYING.LIB in the top directory),
> the license clearly states how this should be done instead:
> 
> "3. You may opt to apply the terms of the ordinary GNU General Public
>  License instead of this License to a given copy of the Library. To do
>  this, you must alter all the notices that refer to this License, so
>  that they refer to the ordinary GNU General Public License, version 2,
>  instead of to this License."

Hm. This talks about GPL v2, not GPL v2-or-later...

> 
> Thus let's clean up the confusing statements and use the proper GPL
> text only.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  linux-user/s390x/target_cpu.h | 19 ++++++++-----------
>  target/s390x/cpu.c            | 19 ++++++++-----------
>  target/s390x/cpu.h            | 19 ++++++++-----------
>  target/s390x/kvm.c            | 19 ++++++++-----------

BTW: Is the original author of the code still around?

>  4 files changed, 32 insertions(+), 44 deletions(-)
