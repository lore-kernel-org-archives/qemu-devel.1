Received: from eggs.gnu.org ([2001:4830:134:3::10]:34927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOPCV-0007sh-Sl
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 08:32:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOPCQ-00033G-Gz
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 08:32:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOPCQ-000336-Au
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 08:32:22 -0500
Message-ID: <1483450339.24493.33.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 03 Jan 2017 14:32:19 +0100
In-Reply-To: <20170102161740.08079f53@kitsune.suse.cz>
References: <20161223151253.21338-1-msuchanek@suse.de>
	<81f6aacf-018f-254a-5b85-6d8d9e93adbd@redhat.com>
	<20170102161740.08079f53@kitsune.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH] Fix pasting into serial console in GTK
 ui
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: qemu-devel@nongnu.org

  Hi,

> How do you propose to use that callback? I did not find a
> documentation for it. It takes no argument (except the chr object self)
> so there is no way to pass in the buffer. It cannot be replaced -
> it is set in non-ui code in multiple places and never in ui code.

No docs, but see backend/msmouse.c where I've added chr_accept_input
support recently.

cheers,
  Gerd
