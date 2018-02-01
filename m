Received: from eggs.gnu.org ([2001:4830:134:3::10]:38195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehIeh-0002AX-GX
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:28:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehIec-0004nX-Ih
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:28:11 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ehIec-0004n9-Bd
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:28:06 -0500
Received: by mail-wr0-f195.google.com with SMTP id y3so10017100wrh.3
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 09:28:06 -0800 (PST)
References: <20180125143218.29528-1-kraxel@redhat.com>
	<20180125143218.29528-3-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <65124689-6705-71ee-561c-8d4b25b30e16@redhat.com>
Date: Thu, 1 Feb 2018 12:28:02 -0500
MIME-Version: 1.0
In-Reply-To: <20180125143218.29528-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 2/8] ui: convert the SDL2 frontend to
 keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Daniel Berrange <berrange@redhat.com>

On 25/01/2018 09:32, Gerd Hoffmann wrote:
> --- a/include/ui/input.h
> +++ b/include/ui/input.h
> @@ -80,4 +80,7 @@ extern const guint16 qemu_input_map_qnum_to_qcode[];
>  extern const guint qemu_input_map_qcode_to_linux_len;
>  extern const guint16 qemu_input_map_qcode_to_linux[];

Is there any reason to use the length variables rather than just
ARRAY_SIZE()?  Coverity isn't able to see through the initializer and
incorrectly complains that

    for (i = 0 ;
         i < SDL_NUM_SCANCODES && i < qemu_input_map_usb_to_qcode_len ;
         i++) {

might access past the end of qemu_input_map_usb_to_qcode.

Thanks,

Paolo
