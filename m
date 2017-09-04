Received: from eggs.gnu.org ([2001:4830:134:3::10]:38092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bauerman@linux.vnet.ibm.com>) id 1dowsn-0003WK-SH
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 15:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bauerman@linux.vnet.ibm.com>) id 1dowsi-0005NF-Tu
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 15:18:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bauerman@linux.vnet.ibm.com>)
	id 1dowsi-0005Lj-LM
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 15:18:00 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v84JEYBc113034
	for <qemu-devel@nongnu.org>; Mon, 4 Sep 2017 15:17:57 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cs909b5h4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 15:17:57 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bauerman@linux.vnet.ibm.com>;
	Mon, 4 Sep 2017 15:17:56 -0400
References: <20170818174614.10930-1-bauerman@linux.vnet.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
In-reply-to: <20170818174614.10930-1-bauerman@linux.vnet.ibm.com>
Date: Mon, 04 Sep 2017 16:17:50 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87k21e1dep.fsf@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] .dir-locals.el: Explicitly set indentation
 level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>


Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> At least in some configurations, setting c-file-style is not enough to
> conform to the QEMU coding style, so explicitly set c-basic-offset as well.
>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>
> My emacs was using indentation level of 8 spaces and this patch convinced
> it to use the correct value.
>
> I set c-basic-offset set to tab-width in my ~/.spacemacs which perhaps
> isn't the wisest thing to do, but since there's a .dir-locals.el we can
> make the editor always do the right thing.
>
>  .dir-locals.el | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.dir-locals.el b/.dir-locals.el
> index 3ac0cfc6f0d6..8e47418c5996 100644
> --- a/.dir-locals.el
> +++ b/.dir-locals.el
> @@ -1,2 +1,3 @@
>  ((c-mode . ((c-file-style . "stroustrup")
> -	    (indent-tabs-mode . nil))))
> +	    (indent-tabs-mode . nil)
> +	    (c-basic-offset . 4))))

Ping?

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
