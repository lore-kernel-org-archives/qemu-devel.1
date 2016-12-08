Received: from eggs.gnu.org ([2001:4830:134:3::10]:56234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cF0zn-0004s8-3Z
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:52:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cF0zj-0006yp-Gg
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:52:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cF0zj-0006yJ-B4
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:52:27 -0500
Date: Thu, 8 Dec 2016 15:52:19 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161208155219.GO26641@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1481164408-194252-1-git-send-email-longpeng2@huawei.com>
	<e88d4b8b-651d-4821-517a-a8201750bafb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e88d4b8b-651d-4821-517a-a8201750bafb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] crypto: add 3des-ede support
 when using libgcrypt/nettle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Longpeng(Mike)" <longpeng2@huawei.com>, armbru@redhat.com, wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

On Thu, Dec 08, 2016 at 09:45:13AM -0600, Eric Blake wrote:
> On 12/07/2016 08:33 PM, Longpeng(Mike) wrote:
> > Libgcrypt and nettle support 3des-ede, so this patch add 3des-ede
> > support when using libgcrypt or nettle.
> > 
> > Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> > ---
> 
> > +++ b/qapi/crypto.json
> > @@ -63,6 +63,7 @@
> >  # @aes-192: AES with 192 bit / 24 byte keys
> >  # @aes-256: AES with 256 bit / 32 byte keys
> >  # @des-rfb: RFB specific variant of single DES. Do not use except in VNC.
> > +# @3des: 3DES(EDE) with 192 bit / 24 byte keys (since 2.9)
> >  # @cast5-128: Cast5 with 128 bit / 16 byte keys
> >  # @serpent-128: Serpent with 128 bit / 16 byte keys
> >  # @serpent-192: Serpent with 192 bit / 24 byte keys
> > @@ -75,7 +76,7 @@
> >  { 'enum': 'QCryptoCipherAlgorithm',
> >    'prefix': 'QCRYPTO_CIPHER_ALG',
> >    'data': ['aes-128', 'aes-192', 'aes-256',
> > -           'des-rfb',
> > +           'des-rfb', '3des',
> 
> Not your fault that this is yet another enum name that is not a valid C
> identifier. QAPI at least handles it when referring to the enum constant
> (since we already have other such enums, in describing key codes), but
> it might make it awkward if we later want to use the enum type as a
> discriminator of a flat union (where I'm not sure that QAPI will still
> do the right thing).  Is there some name we can pick that starts with a
> letter, to reduce the worry?  But if not, I can live with '3des'.

I can make it 'des3' easily enough if you'd prefer :-)

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
