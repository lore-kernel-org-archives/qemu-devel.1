Received: from eggs.gnu.org ([2001:4830:134:3::10]:57685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gSJpB-0002Qc-O6
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gSJp8-0006be-Gr
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:45:37 -0500
Received: from smtp.mail.uni-mannheim.de ([134.155.96.80]:43357)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1gSJp8-0006au-6l
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:45:34 -0500
References: <20181122110039.15972-1-marcandre.lureau@redhat.com>
	<2a53c96f-a712-5719-6e29-4df04b7256af@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <da361a05-a31f-9ae1-f268-589f632ca9cf@weilnetz.de>
Date: Thu, 29 Nov 2018 11:45:45 +0100
MIME-Version: 1.0
In-Reply-To: <2a53c96f-a712-5719-6e29-4df04b7256af@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 0/4] build-sys: require Vista API
 by default globally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Michael Roth <mdroth@linux.vnet.ibm.com>, samuel.thibault@ens-lyon.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Am 29.11.2018 um 11:16 schrieb Paolo Bonzini:
> On 22/11/18 12:00, Marc-Andr=C3=A9 Lureau wrote:
>>  include/qemu/osdep.h      | 17 ++++++++++
>>  accel/tcg/translate-all.c |  4 ---
>>  qga/commands-win32.c      | 70 +-------------------------------------=
-
>>  util/qemu-thread-win32.c  |  4 ---
>>  configure                 |  3 --
>>  roms/seabios              |  2 +-
>>  6 files changed, 19 insertions(+), 81 deletions(-)
>>
> Queued, thanks.
>
> Paolo


Was the change for roms/seabios intentional?

Stefan
