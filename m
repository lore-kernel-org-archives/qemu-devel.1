Received: from eggs.gnu.org ([2001:4830:134:3::10]:58613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dknIB-0006Md-7b
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dknI8-0003J4-3R
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:15:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48489)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dknI7-0003Im-Tk
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:15:04 -0400
Message-ID: <1503562501.22313.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 Aug 2017 10:15:01 +0200
In-Reply-To: <20170823193703.10808-1-mtparkr@gmail.com>
References: <20170823193703.10808-1-mtparkr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] audio: intel-hda: do not use old_mmio
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matt Parker <mtparkr@gmail.com>, qemu-devel@nongnu.org

On Wed, 2017-08-23 at 20:37 +0100, Matt Parker wrote:
> +=C2=A0=C2=A0=C2=A0 intel_hda_reg_write(d, reg, val, (1UL << (size * 8)=
) - 1);

Hmm?  Same as v1, forgot to commit the changes?

cheers,
  Gerd
