Received: from eggs.gnu.org ([2001:4830:134:3::10]:52082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ceqIF-0005SE-7D
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ceqIE-0008LV-3W
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:42:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1ceqID-0008Kl-Tx
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:42:18 -0500
Date: Fri, 17 Feb 2017 16:42:15 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170217214215.GK19045@localhost.localdomain>
References: <CAAo6VWOAnGQeDwc_bJ4M=FQsu7rOhAv=1Qk6PdzG+0pcVnku=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAo6VWOAnGQeDwc_bJ4M=FQsu7rOhAv=1Qk6PdzG+0pcVnku=A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v8 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ashish mittal <ashmit602@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <ashish.mittal@veritas.com>, Stefan Hajnoczi <stefanha@gmail.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

On Thu, Feb 16, 2017 at 02:24:19PM -0800, ashish mittal wrote:
> Hi,
> 
> I am getting the following error with checkpatch.pl
> 
> ERROR: externs should be avoided in .c files
> #78: FILE: block/vxhs.c:28:
> +QemuUUID qemu_uuid __attribute__ ((weak));
> 
> Is there any way to get around this, or does it mean that I would have
> to add a vxhs.h just for this one entry?
>

I remain skeptical on the use of the qemu_uuid as a way to select the TLS
cert.

But that aside, and looking at it strictly from a checkpatch.pl point of
view, I think one could make a case that if there is no header file, the
error could be ignored.
