Received: from eggs.gnu.org ([2001:4830:134:3::10]:55052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe66p-0007Rc-QD
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 18:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe66p-0006C8-2M
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 18:00:15 -0400
Date: Fri, 13 Jul 2018 19:00:07 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180713220007.GB31657@localhost.localdomain>
References: <1531470464-21522-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531470464-21522-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/16] Fix crashes with introspection of
 ARM devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Fri, Jul 13, 2018 at 10:27:28AM +0200, Thomas Huth wrote:
> As discovered recently, you can crash QEMU with a lot of devices
> that do not get the reference counting of child objects right.
> You just have to run 'device-list-properties' and call 'info qtree'
> afterwards.
> This patch series fixes a bunch of these problems in the ARM code.
> I did not fix all problems yet, since it is quite time consuming,
> and this series is big enough already. The remaining problems can
> be fixed in an independent patch series later.
> 
> v2:
>  - Updated the first patch according to the review feedback from v1
>  - Added more patches with additional fixes

OK, I will stop replying to each individual patch and just send
a single one for the series:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
