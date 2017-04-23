Received: from eggs.gnu.org ([2001:4830:134:3::10]:33897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d2L7L-0008Sf-EN
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 13:16:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d2L7I-0003FG-AJ
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 13:16:11 -0400
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
	<20170311132256.22951-4-marcandre.lureau@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <db21dce3-9613-02eb-64f8-9ff888e5f03d@msgid.tls.msk.ru>
Date: Sun, 23 Apr 2017 20:16:04 +0300
MIME-Version: 1.0
In-Reply-To: <20170311132256.22951-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/21] object: fix potential leak in getters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, armbru@redhat.com, anderson@redhat.com, pbonzini@redhat.com, lersek@redhat.com

11.03.2017 16:22, Marc-Andr=C3=A9 Lureau wrote:
> If the property is not of the requested type, the getters will leak a
> QObject.

I'm not really sure it's -trivial material.

Not applying 01/23 either.

Should whole series be applied to the same tree perhaps?

Thanks,

/mjt
