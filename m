Received: from eggs.gnu.org ([209.51.188.92]:49663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h0sNu-0003xz-TO
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:32:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h0sNu-0003OT-54
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:32:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h0sNt-0003LD-T7
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:32:18 -0500
References: <20190303104430.7692-1-samuel.thibault@ens-lyon.org>
	<20190303104430.7692-3-samuel.thibault@ens-lyon.org>
	<20190304080338.jalgvluxwqiygqi2@sirius.home.kraxel.org>
	<20190304080622.fvrsvkkq4h4k2z37@function>
	<CAF0C5SLZzDpR3qin4kixXpb-ewLoYThFLHBHG26=pi5Oa-6dGw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2b019fbb-ef70-1f57-b08a-0bed20365c18@redhat.com>
Date: Mon, 4 Mar 2019 12:32:06 -0600
MIME-Version: 1.0
In-Reply-To: <CAF0C5SLZzDpR3qin4kixXpb-ewLoYThFLHBHG26=pi5Oa-6dGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] curses: add option to specify VGA font
 encoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kohler@seas.harvard.edu, Samuel Thibault <samuel.thibault@gnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com

On 3/4/19 10:56 AM, Eddie Kohler wrote:
> Another difference is that Samuel's patch supports platforms on which
> wchar_t is not Unicode.
> 
> I don't know if there are many/any such platforms but it does support them!

I know Cygwin is such a platform, and suspect that mingw is too 
(although I didn't actually check) - in general, Windows picked wchar_t 
to be 2 bytes, which is incompatible with full Unicode support requiring 
4-byte wchar_t, and hence explaining why C11 introduced char16_t and 
char32_t to work around the legacy mess that wchar_t causes.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
