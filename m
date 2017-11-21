Received: from eggs.gnu.org ([2001:4830:134:3::10]:35816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eHA8k-0007EN-6y
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:07:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eHA8g-0003fX-6B
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:07:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48042
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eHA8f-0003Fu-UD
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:07:06 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vALF4W0X079479
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 10:06:00 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ecpdk8chq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 10:05:58 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 21 Nov 2017 08:05:17 -0700
References: <20171121142538.22072-1-berrange@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 21 Nov 2017 13:05:12 -0200
MIME-Version: 1.0
In-Reply-To: <20171121142538.22072-1-berrange@redhat.com>
Content-Language: en-US
Message-Id: <ccabd46e-ed04-f04a-3b67-f32e59c06b0d@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] build: disarm the TCG unit test trap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

On 11/21/2017 12:25 PM, Daniel P. Berrange wrote:
> Developers sometimes mistakenly run 'make test' instead of 'make check'.
> 'make test' triggers the ancient, unmaintained tcg unit tests in
> tests/tcg/Makefile which have long since ceased compiling.
>
> Even if someone fixes the TCG tests, it makes little sense to put
> them in a 'make test' target, rather they should be 'make check-tcg',
> possibly wired up as a dependency of 'make check'.
>
> In the meantime, this patch disarms the 'make test' trap by simply
> deleting it so users get an immediate error. This should be enough
> for them to remember to type 'make check' instead (or 'make help'
> to learn). It also deletes 'make speed' which is another route
> into the tcg tests.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>
> Changed in v2:
>
>   - Remove 'test' & 'speed' targets, instead of making 'test'
>     a synonym for 'check'
>
>   Makefile | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index d2e31d98af..ab0354c153 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -253,7 +253,7 @@ Makefile: ;
>   configure: ;
>
>   .PHONY: all clean cscope distclean html info install install-doc \
> -	pdf txt recurse-all speed test dist msi FORCE
> +	pdf txt recurse-all dist msi FORCE
>
>   $(call set-vpath, $(SRC_PATH))
>
> @@ -716,10 +716,6 @@ endif
>   	$(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=$$d/ -C $$d $@ || exit 1 ; \
>           done
>
> -# various test targets
> -test speed: all
> -	$(MAKE) -C tests/tcg $@
> -
>   .PHONY: ctags
>   ctags:
>   	rm -f tags
