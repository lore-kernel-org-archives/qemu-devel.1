Received: from eggs.gnu.org ([2001:4830:134:3::10]:51374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fFkNv-0003Xv-Vz
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fFkNs-0006bs-Md
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:57:16 -0400
References: <20180507095539.19584-1-kraxel@redhat.com>
	<20180507095539.19584-3-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8ad7c756-856d-c5aa-8796-7047caa48856@redhat.com>
Date: Mon, 7 May 2018 12:57:09 -0500
MIME-Version: 1.0
In-Reply-To: <20180507095539.19584-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/4] ui: switch trivial displays to qapi
 parser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 05/07/2018 04:55 AM, Gerd Hoffmann wrote:
> Drop the option-less display types (egl-headless, curses, none) from
> parse_display(), so they'll be handled by parse_display_qapi().
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   vl.c | 6 ------
>   1 file changed, 6 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
