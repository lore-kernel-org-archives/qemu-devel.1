Received: from eggs.gnu.org ([2001:4830:134:3::10]:39078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cb2pp-0005Oe-Hq
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:17:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cb2pl-0003n6-I9
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:17:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58496
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cb2pl-0003k8-Cq
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:17:13 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v17ADkFa088235
	for <qemu-devel@nongnu.org>; Tue, 7 Feb 2017 05:17:11 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28fah9nj9n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 05:17:11 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 7 Feb 2017 05:17:11 -0500
References: <20170204143245.15974-1-famz@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 7 Feb 2017 11:17:07 +0100
MIME-Version: 1.0
In-Reply-To: <20170204143245.15974-1-famz@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <68083444-6c53-5802-6ad7-549d2da26714@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] Makefile: Make "install" depend on
 "trace-events-all"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com

On 02/04/2017 03:32 PM, Fam Zheng wrote:
> We install this file to data dir but since 0ab8ed18 it's no longer
> required by any objects during "make". List it explicitly as a depended
> target of install and fix the broken "make install" command.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>


> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 4b72a4c..b993741 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -589,7 +589,7 @@ endif
>  endif
> 
> 
> -install: all $(if $(BUILD_DOCS),install-doc) \
> +install: all $(if $(BUILD_DOCS),install-doc) $(BUILD_DIR)/trace-events-all \
>  install-datadir install-localstatedir
>  ifneq ($(TOOLS),)
>  	$(call install-prog,$(subst qemu-ga,qemu-ga$(EXESUF),$(TOOLS)),$(DESTDIR)$(bindir))
> 
