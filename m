Received: from eggs.gnu.org ([2001:4830:134:3::10]:39337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEaYj-0000eG-2H
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:15:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEaYe-0005GV-Tm
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:15:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fEaYe-0005Fg-BW
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:15:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7AD24722C3
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 13:15:28 +0000 (UTC)
References: <1525431107-44981-1-git-send-email-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bcd15427-246c-1d54-2c6a-bf5bf7dd0094@redhat.com>
Date: Fri, 4 May 2018 08:15:23 -0500
MIME-Version: 1.0
In-Reply-To: <1525431107-44981-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] rename included C files to foo.inc.c,
 remove osdep.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

On 05/04/2018 05:51 AM, Paolo Bonzini wrote:
> osdep.h is only needed for files that are compiled directly.
> Remove it from included C source files, and rename them to
> *.inc.c so that scripts/clean-includes knows to skip them.
> 
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/cris/translate.c                            |    2 +-
>   .../cris/{translate_v10.c => translate_v10.inc.c}  |    0
>   target/mips/translate.c                            |    2 +-
>   .../{translate_init.c => translate_init.inc.c}     |    0
>   target/ppc/int_helper.c                            |    2 +-
>   target/ppc/{mfrom_table.c => mfrom_table.inc.c}    |    0
>   target/ppc/translate.c                             |    2 +-
>   .../ppc/{translate_init.c => translate_init.inc.c} |    1 -
>   ui/vnc-enc-zrle.c                                  |   22 ++++++++++----------
>   ui/{vnc-enc-zrle-template.c => vnc-enc-zrle.inc.c} |    0
>   10 files changed, 15 insertions(+), 16 deletions(-)
>   rename target/cris/{translate_v10.c => translate_v10.inc.c} (100%)
>   rename target/mips/{translate_init.c => translate_init.inc.c} (100%)
>   rename target/ppc/{mfrom_table.c => mfrom_table.inc.c} (100%)
>   rename target/ppc/{translate_init.c => translate_init.inc.c} (99%)
>   rename ui/{vnc-enc-zrle-template.c => vnc-enc-zrle.inc.c} (100%)

How did we ever manage rename patches without git's nice compressed 
patch representation? :)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
