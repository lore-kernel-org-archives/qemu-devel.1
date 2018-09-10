Received: from eggs.gnu.org ([2001:4830:134:3::10]:60787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzQWs-00024L-K4
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzQWl-0005V4-NC
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:03:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53886 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fzQWl-0005Ul-Hz
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:03:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF2DCDFF3
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 18:03:10 +0000 (UTC)
References: <1536067356-44609-1-git-send-email-imammedo@redhat.com>
	<1536067356-44609-2-git-send-email-imammedo@redhat.com>
	<20180905021255.GK12698@habkost.net>
	<20180905112511.1d245cc8@igors-macbook-pro.local>
	<20180905134512.GL12698@habkost.net>
	<20180906100213.3d03e9d0@redhat.com>
	<20180910174923.GE12698@habkost.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8be73d98-6ccb-6b12-252c-d2bd4c41133c@redhat.com>
Date: Mon, 10 Sep 2018 13:03:07 -0500
MIME-Version: 1.0
In-Reply-To: <20180910174923.GE12698@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] [PATCH v5 1/2] vl.c deprecate incorrect
 CPUs topology
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: libvir-list@redhat.com, drjones@redhat.com, qemu-devel@nongnu.org

On 9/10/18 12:49 PM, Eduardo Habkost wrote:

> 
> I was considering something like this:
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 060e015be6..74f6a64b8b 100644
> --- a/qemu-deprecated.texi

> +++ b/qemu-options.hx
> @@ -155,8 +155,13 @@ to 4.
>   For the PC target, the number of @var{cores} per socket, the number
>   of @var{threads} per cores and the total number of @var{sockets} can be
>   specified. Missing values will be computed. If any on the three values is

while here, s/on/of/

> -given, the total number of CPUs @var{n} can be omitted. @var{maxcpus}
> -specifies the maximum number of hotpluggable CPUs.
> +given, the total number of CPUs @var{n} can be omitted.
> +
> +@var{maxcpus} specifies the maximum number of hotpluggable CPUs
> +and should be equal to @math{@var{sockets} * @var{cores} * @var{threads}}
> +(even if @var{sockets}, @var{cores}, or @var{threads} is omitted
> +and computed automatically).
> +
>   ETEXI
>   
>   DEF("numa", HAS_ARG, QEMU_OPTION_numa,
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
