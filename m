Received: from eggs.gnu.org ([209.51.188.92]:46812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gtCz0-00005I-Ql
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gtCyz-0003Pg-SO
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:54:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gtCyz-0002Io-KC
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:54:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 258F9E6A62
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 14:54:31 +0000 (UTC)
References: <20181206215026.7716-1-pbonzini@redhat.com>
	<20181206215026.7716-3-pbonzini@redhat.com>
	<20190208124844.GE4494@dhcp-200-176.str.redhat.com>
	<d9b84d67-dfb8-6dd7-dc77-9ea442bc9c5c@redhat.com>
	<20190208160013.GA4441@dhcp-200-176.str.redhat.com>
	<fffb008e-c16c-5db9-14bf-c779b7b08ae1@redhat.com>
	<20190211143208.GD8135@linux.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20ef34db-5dfd-e269-9a92-ebe981df076b@redhat.com>
Date: Mon, 11 Feb 2019 15:54:26 +0100
MIME-Version: 1.0
In-Reply-To: <20190211143208.GD8135@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] test: replace gtester with a TAP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On 11/02/19 15:32, Kevin Wolf wrote:
> $(patsubst %, check-%, $(check-unit-y) $(check-speed-y)): check-%: %
>     $(if $(CONFIG_GCOV),@rm -f *.gcda */*.gcda */*/*.gcda */*/*/*.gcda,)
>     $(call quiet-command, \
>         MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))} \
>         gtester $(GTESTER_OPTIONS) -m=$(SPEED) $*,"GTESTER","$*")
>     $(if $(CONFIG_GCOV),@for f in $(gcov-files-$(subst tests/,,$*)-y) $(gcov-files-generic-y); do \
>       echo Gcov report for $$f:;\
>       $(GCOV) $(GCOV_OPTIONS) $$f -o `dirname $$f`; \
>     done,)
> 
> So it used quiet-command (but I'm okay with changing this) and it set
> MALLOC_PERTURB_ (I think this would still be nice to have).

Yes, of course.  I'll send a real patch.

Paolo
