Received: from eggs.gnu.org ([2001:4830:134:3::10]:58100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cJbMR-0000BF-Hj
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 02:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cJbMO-0001Ce-Em
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 02:30:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cJbMO-0001CK-8M
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 02:30:48 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 708B5C0567B2
	for <qemu-devel@nongnu.org>; Wed, 21 Dec 2016 07:30:47 +0000 (UTC)
References: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
	<1482255793-19057-7-git-send-email-ehabkost@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ecccd662-c51d-dbeb-05c5-3006882b5390@redhat.com>
Date: Wed, 21 Dec 2016 08:30:44 +0100
MIME-Version: 1.0
In-Reply-To: <1482255793-19057-7-git-send-email-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 6/7] accel: Move accel.c to accel/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

On 20.12.2016 18:43, Eduardo Habkost wrote:
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  Makefile.objs            | 2 +-
>  accel.c => accel/accel.c | 0
>  accel/Makefile.objs      | 2 ++
>  3 files changed, 3 insertions(+), 1 deletion(-)
>  rename accel.c => accel/accel.c (100%)
> 
> diff --git a/Makefile.objs b/Makefile.objs
> index 06f74b8..6d62f54 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -58,7 +58,7 @@ common-obj-$(CONFIG_SPICE) += spice-qemu-char.o
>  
>  common-obj-y += audio/
>  common-obj-y += hw/
> -common-obj-y += accel.o
> +common-obj-y += accel/

Not sure, but there is already "obj-y += accel/" in patch 2 ... do we
need both ?

 Thomas
