Received: from eggs.gnu.org ([2001:4830:134:3::10]:50861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evJa8-0001E1-9P
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evJa3-0004Gt-8p
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:17:24 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1evJa3-0004Eq-1K
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:17:19 -0400
Received: by mail-wm0-f46.google.com with SMTP id z9so14541620wmb.3
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 02:17:18 -0700 (PDT)
References: <1520786414-8806-1-git-send-email-aishwaryakadlag@gmail.com>
	<6666720e-6f5c-0e8c-6c5a-ac36d708e314@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fc423157-37c7-1085-aca6-439b497a2ab8@redhat.com>
Date: Mon, 12 Mar 2018 10:17:15 +0100
MIME-Version: 1.0
In-Reply-To: <6666720e-6f5c-0e8c-6c5a-ac36d708e314@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V1]sm501: dead code removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Aishwarya Kadlag <aishwaryakadlag@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

On 12/03/2018 06:58, Thomas Huth wrote:
> I don't know the hw/display code very well, but I think it's not that
> easy... Putting Gerd on CC:, maybe he can describe the details of that
> BiteSizeTask a little bit better.
> 
> (When sending patches, please also always use the get_maintainers.pl
> script to get a set of people who should be put on CC: or the patch
> might get lost in the high traffic of the qemu-devel mailing list).

It's _almost_ that easy.

First, get_depth_index must be adjusted to reflect that you have removed
the first three elements from the array.  It doesn't hurt to add an

	assert(surface_bits_per_pixel(surface) == 32)

in the function, too.

Second, the PIXEL_TYPE macro in sm501_template.h now is always uint32_t
and it can be replaced everywhere.  Likewise for BPP, which is always 4,
and DEPTH, which is always 32.

Thanks!

Paolo
