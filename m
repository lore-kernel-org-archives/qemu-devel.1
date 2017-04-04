Received: from eggs.gnu.org ([2001:4830:134:3::10]:39854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cvQo0-0008Np-9n
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cvQnx-0004Tl-2j
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:55:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cvQnw-0004T7-TY
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:55:37 -0400
Date: Tue, 4 Apr 2017 16:55:18 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170404155518.GA25661@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1491277689-24949-1-git-send-email-Ashish.Mittal@veritas.com>
	<1491277689-24949-2-git-send-email-Ashish.Mittal@veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1491277689-24949-2-git-send-email-Ashish.Mittal@veritas.com>
Subject: Re: [Qemu-devel] [PATCH v11 1/2] block/vxhs.c: Add support for a
 new block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashish Mittal <ashmit602@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, jcody@redhat.com, famz@redhat.com, ashish.mittal@veritas.com, stefanha@gmail.com, Ketan.Nilangekar@veritas.com, jferlan@redhat.com, Buddhi.Madhav@veritas.com, Suraj.Singh@veritas.com, Nitin.Jerath@veritas.com, peter.maydell@linaro.org, venkatesha.mg@veritas.com, Rakesh.Ranjan@veritas.com, eblake@redhat.com, Abhijit.Dey@veritas.com

On Mon, Apr 03, 2017 at 08:48:08PM -0700, Ashish Mittal wrote:
> Source code for the qnio library that this code loads can be downloaded from:
> https://github.com/VeritasHyperScale/libqnio.git
> 
> Sample command line using JSON syntax:
> ./x86_64-softmmu/qemu-system-x86_64 -name instance-00000008 -S -vnc 0.0.0.0:0
> -k en-us -vga cirrus -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x5
> -msg timestamp=on
> 'json:{"driver":"vxhs","vdisk-id":"c3e9095a-a5ee-4dce-afeb-2a59fb387410",
> "server":{"host":"172.172.17.4","port":"9999"}}'
> 
> Sample command line using URI syntax:
> qemu-img convert -f raw -O raw -n
> /var/lib/nova/instances/_base/0c5eacd5ebea5ed914b6a3e7b18f1ce734c386ad
> vxhs://192.168.0.1:9999/c6718f6b-0401-441d-a8c3-1f0064d75ee0
> 
> Sample command line using TLS credentials (run in secure mode):
> ./qemu-io --object
> tls-creds-x509,id=tls0,dir=/etc/pki/qemu/vxhs,endpoint=client -c 'read
> -v 66000 2.5k' 'json:{"server.host": "127.0.0.1", "server.port": "9999",
> "vdisk-id": "/test.raw", "driver": "vxhs", "tls-creds":"tls0"}'
> 
> Signed-off-by: Ashish Mittal <Ashish.Mittal@veritas.com>

I've not reviewed the i/o related stuff, but from the POV of TLS cred
handling / QAPI / disk open, this all looks fine to me now.

  Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
