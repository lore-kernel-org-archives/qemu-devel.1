Received: from eggs.gnu.org ([2001:4830:134:3::10]:36660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eCOlv-0002wH-IN
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:43:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eCOlu-0000FC-Sw
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:43:55 -0500
Date: Wed, 8 Nov 2017 12:43:43 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171108114343.GB30890@localhost.localdomain>
References: <20171103143902.18039-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171103143902.18039-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: don't permit changing encryption
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 03.11.2017 um 15:39 hat Daniel P. Berrange geschrieben:
> Currently if trying to change encryption parameters on a qcow2 image, qemu-img
> will abort. We already explicitly check for attempt to change encrypt.format
> but missed other parameters like encrypt.key-secret. Rather than list each
> parameter, just blacklist changing of all parameters with a 'encrypt.' prefix.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Thanks, applied to the block branch.

Kevin
