Received: from eggs.gnu.org ([2001:4830:134:3::10]:45475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1fOLNG-0002HA-Nw
	for qemu-devel@nongnu.org; Thu, 31 May 2018 07:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1fOLNC-0001Qn-Nr
	for qemu-devel@nongnu.org; Thu, 31 May 2018 07:04:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1fOLNC-0001QA-GQ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 07:04:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id r15-v6so25607645wmc.1
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 04:04:02 -0700 (PDT)
Date: Thu, 31 May 2018 13:03:59 +0200
From: Sergio Lopez <slp@redhat.com>
Message-ID: <20180531110359.3ejv77jwxh5ectti@dritchie>
References: <20180531074601.10647-1-slp@redhat.com>
	<20180531074601.10647-3-slp@redhat.com>
	<CAJ+F1C+1-n0K=qF2HuNGYmgMZEU_91A2i-1kJ-tbZ+jrHuGKQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1C+1-n0K=qF2HuNGYmgMZEU_91A2i-1kJ-tbZ+jrHuGKQA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] chardev: On QIO_CHANNEL_ERR_BROKEN set
 errno to EPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Thu, May 31, 2018 at 11:48:25AM +0200, Marc-André Lureau wrote:
> On Thu, May 31, 2018 at 9:46 AM, Sergio Lopez <slp@redhat.com> wrote:
> > This allows callers to identify this potentially unrecoverable error.
> 
> (missing signed-off)

Ouch, sorry, will add it in v2.

Sergio.
