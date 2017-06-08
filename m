Received: from eggs.gnu.org ([2001:4830:134:3::10]:52210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <postmaster@upsilon.org.uk>) id 1dIuSR-00007G-9p
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:14:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <postmaster@upsilon.org.uk>) id 1dIuSM-00066r-7r
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:14:27 -0400
Received: from outmx-028.london.gridhost.co.uk ([95.142.156.253]:46287)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <postmaster@upsilon.org.uk>)
	id 1dIuSM-00065z-16
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:14:22 -0400
References: <7f44106b-c67e-2581-f59b-36a9796a9a36@upsilon.org.uk>
	<20170608100208.GA4145@stefanha-x1.localdomain>
From: postmaster <postmaster@upsilon.org.uk>
Message-ID: <3cee931a-8ae1-56cd-4202-acbe91e09ca9@upsilon.org.uk>
Date: Thu, 8 Jun 2017 11:14:19 +0100
MIME-Version: 1.0
In-Reply-To: <20170608100208.GA4145@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] KVM guests fail to start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

On 08/06/17 11:02, Stefan Hajnoczi wrote:
>
> Please make sure your qemu-block-extra and qemu-system-x86 packages are
> up-to-date.  They should both have the same version number.
>
> Are you using a backports package for QEMU?
>
Thanks, something along the lines of this does seem to have been the
problem.

I am using the backports package but it seems that the update uprevved
qemu.* modulo qemu-system-x86.

After a bit of fiddling I've got it working again by updating
qemu-system-x86 and then forcing the user/group in
/etc/libvirt/qemu.conf (presumably the conf file was over-written by the
update).

David
