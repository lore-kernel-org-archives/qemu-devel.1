Received: from eggs.gnu.org ([2001:4830:134:3::10]:37844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfkcF-0005Al-AS
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfkcB-000436-JV
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:50:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cfkcB-00042t-2i
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:50:39 -0500
Date: Mon, 20 Feb 2017 09:50:28 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170220095028.GC15874@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAAo6VWOAnGQeDwc_bJ4M=FQsu7rOhAv=1Qk6PdzG+0pcVnku=A@mail.gmail.com>
	<20170217214215.GK19045@localhost.localdomain>
	<F23F188C-DAF9-49EA-9C0E-54F57945267A@veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F23F188C-DAF9-49EA-9C0E-54F57945267A@veritas.com>
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
To: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>
Cc: Jeff Cody <jcody@redhat.com>, ashish mittal <ashmit602@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, Stefan Hajnoczi <stefanha@gmail.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

On Sat, Feb 18, 2017 at 12:30:31AM +0000, Ketan Nilangekar wrote:
> On 2/17/17, 1:42 PM, "Jeff Cody" <jcody@redhat.com> wrote:
> 
>     On Thu, Feb 16, 2017 at 02:24:19PM -0800, ashish mittal wrote:
>     > Hi,
>     > 
>     > I am getting the following error with checkpatch.pl
>     > 
>     > ERROR: externs should be avoided in .c files
>     > #78: FILE: block/vxhs.c:28:
>     > +QemuUUID qemu_uuid __attribute__ ((weak));
>     > 
>     > Is there any way to get around this, or does it mean that I would have
>     > to add a vxhs.h just for this one entry?
>     >
>     
>     I remain skeptical on the use of the qemu_uuid as a way to select the TLS
>     cert.
> 
> [ketan]
> Is there another identity that can be used for uniquely identifying instances?
> The requirement was to enforce vdisk access to owner instances.

The UUID is a bad way to do any kind of access control as QEMU could simply
lie about its UUID.

If the server needs to identify the client to do access control you need
something non-spoofable. In the absence of having an authentication protocol
built into the libqnio protocol, the best you could do would be to use the
TLS client certificate distinguished name. QEMU can't lie about that without
having access to the other certificate file - which would be blocked by
SELinux

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
