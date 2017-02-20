Received: from eggs.gnu.org ([2001:4830:134:3::10]:50578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfowT-0004mv-SU
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:27:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfowQ-0000Sf-5B
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:27:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cfowP-0000SJ-VU
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:27:50 -0500
Date: Mon, 20 Feb 2017 14:27:39 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170220142739.GS15874@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1487543454-20373-1-git-send-email-Ashish.Mittal@veritas.com>
	<20170220142143.GI21255@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170220142143.GI21255@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v9 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Ashish Mittal <ashmit602@gmail.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, jcody@redhat.com, famz@redhat.com, ashish.mittal@veritas.com, jferlan@redhat.com, Buddhi.Madhav@veritas.com, Suraj.Singh@veritas.com, Nitin.Jerath@veritas.com, peter.maydell@linaro.org, rakesh.ranjan@veritas.com, venkatesha.mg@veritas.com, Ketan.Nilangekar@veritas.com, Abhijit.Dey@veritas.com

On Mon, Feb 20, 2017 at 02:21:43PM +0000, Stefan Hajnoczi wrote:
> On Sun, Feb 19, 2017 at 02:30:53PM -0800, Ashish Mittal wrote:
> > v9 changelog:
> > (1) Fixes for all the review comments from v8. I have left the definition
> >     of VXHS_UUID_DEF unchanged pending a better suggestion.
> 
> If I understand correctly libvxhs has a global instance ID for choosing
> the SSL client certificate.

That's a bad idea as it forces a cert usage policy onto people deploying
QEMU. Admins should be free to use the same certificate for multiple VMs,
and a single VM should be able to use different certs for connecting to
different storage servers. 

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
