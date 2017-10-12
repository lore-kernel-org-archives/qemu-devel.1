Received: from eggs.gnu.org ([2001:4830:134:3::10]:54357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e2f25-0003LS-Rw
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e2f21-0006XB-Tg
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:04:21 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:51938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e2f21-0006WF-Eu
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:04:17 -0400
Received: by mail-wm0-f53.google.com with SMTP id f4so14245008wme.0
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 08:04:17 -0700 (PDT)
References: <20171012112157.15647-1-marcandre.lureau@redhat.com>
	<1507814955.24675.1.camel@redhat.com>
	<CAJ+F1CKjV_bNcT7n9bK+CYbd+si7VzW=Bcv8cQ2MuvWgrPuRVQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca9aab91-2e3b-5302-c9f0-dbf5e4c804c7@redhat.com>
Date: Thu, 12 Oct 2017 17:04:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKjV_bNcT7n9bK+CYbd+si7VzW=Bcv8cQ2MuvWgrPuRVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] usb-ccid: remove needless migration state
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

On 12/10/2017 16:02, Marc-André Lureau wrote:
> I did a simple migration test from a state file with the field to a
> state file without, and the other way around and it seemed to work. I
> probably screwed up the test.
> 
> Looking at vmstate code, it obviously changes the wire format. So
> let's keep the field. (I was wondering how/if the vmdesc was able to
> match field names/version, probably not)

You can use VMSTATE_UNUSED(1) to drop the field from the struct.

Paolo
