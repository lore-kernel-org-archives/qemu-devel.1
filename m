Received: from eggs.gnu.org ([2001:4830:134:3::10]:33080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dejgK-0004Nn-GK
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dejgF-0001b7-Ea
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:11:00 -0400
Date: Mon, 7 Aug 2017 16:10:31 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170807151031.GM18259@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-57-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1502117160-24655-57-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 56/56] crypto: Make
 QCryptoBlockInfoLUKS offsets unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, qemu-block@nongnu.org

On Mon, Aug 07, 2017 at 04:46:00PM +0200, Markus Armbruster wrote:
> Byte offsets should use QAPI type 'size' (uint64_t).
> QCryptoBlockInfoLUKS member @payload-offset and
> QCryptoBlockInfoLUKSSlot member @key-offset are 'int' (int64_t).
> qcrypto_block_luks_get_info() gets the former QCryptoBlock member
> @payload_offset, implicitly converting from uint64_t, and computes the
> latter from QCryptoBlockLUKSKeySlot member @key_offset, implicitly
> converting from long long.
> 
> Change both offsets to 'size'.
> 
> query-block and query-named-block-nodes now report @payload-offset
> values above 2^63-1 correctly instead of their (negative) two's
> complement.  Should never occur in practice.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
