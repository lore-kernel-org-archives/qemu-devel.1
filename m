Received: from eggs.gnu.org ([2001:4830:134:3::10]:43165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gUsOn-0003Qk-HJ
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:04:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gUsOj-0002aQ-Ig
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:04:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:30954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gUsOj-0002a0-8r
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:04:53 -0500
Date: Thu, 6 Dec 2018 17:34:44 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <CAFEAcA9N9sqi4fSp1epPdCV7PkqXpZK4kyoHErvfx3hwcN3kag@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1812061734090.2113@xnncv>
References: <20181206084816.30485-1-ppandit@redhat.com>
	<20181206105830.43eb1d05@redhat.com>
	<nycvar.YSQ.7.76.1812061637070.2113@xnncv>
	<CAFEAcA90U=8s=f-pcFS+8VF3GZby__GnwXy_van=FxiE7fK7gQ@mail.gmail.com>
	<CAFEAcA9N9sqi4fSp1epPdCV7PkqXpZK4kyoHErvfx3hwcN3kag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] i2c: pm_smbus: check smb_index before
 block transfer write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, public@hansmi.ch, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

+-- On Thu, 6 Dec 2018, Peter Maydell wrote --+
| > > Do we need patch v2, or it can be done while merging it?
| >
| > I can add in the Fixes line when I apply the patch to master.
| 
| Oh, I think we should also add to the commit message something
| along the lines of:
| 
| "Note that this bug is exploitable by a guest to escape
| from the virtual machine. However the commit which
| introduced the bug was only made after the 3.0 release,
| and so it is not present in any released QEMU version."
| 
| to clarify that this is a serious bug but also that it's
| not one that will be affecting anybody's production systems.

Okay, preparing patch v2...
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
