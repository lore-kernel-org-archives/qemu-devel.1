Received: from eggs.gnu.org ([2001:4830:134:3::10]:55734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fFkb8-0001zw-H9
	for qemu-devel@nongnu.org; Mon, 07 May 2018 14:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fFkb3-0007Bf-TL
	for qemu-devel@nongnu.org; Mon, 07 May 2018 14:10:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33808 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fFkb3-0007BT-OK
	for qemu-devel@nongnu.org; Mon, 07 May 2018 14:10:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F3648DC4E
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 18:10:45 +0000 (UTC)
References: <20180507101013.32736-1-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1c74cdf2-defc-0969-87c9-f1ef6432e50e@redhat.com>
Date: Mon, 7 May 2018 13:10:40 -0500
MIME-Version: 1.0
In-Reply-To: <20180507101013.32736-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vga: print friendly error message in case
 multiple vga devices are added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 05/07/2018 05:10 AM, Gerd Hoffmann wrote:
> ... to a virtual machine.  Without that we fail a ramblock register
> sanity check, leading to a abort(), which isn't exactly user friendly.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1206037
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/display/vga.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 

>   
> +    if (global_vmstate) {
> +        static int have_vga;

It looks funny to declare this as int,

> +        if (have_vga) {
> +            error_report("only one vga device is supported");
> +            exit(1);
> +        }
> +        have_vga = true;

but to treat it as bool.  Why not just declare it as bool to begin with?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
