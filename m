Received: from eggs.gnu.org ([2001:4830:134:3::10]:54523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eu0fy-0001OU-M4
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eu0ft-0006PI-RD
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:54:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38626 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eu0ft-0006P2-LL
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:53:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 101174001872
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 18:53:57 +0000 (UTC)
References: <20180308172834.3281-1-pbonzini@redhat.com>
	<20180308172834.3281-2-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <87dead83-e215-74d1-371f-536f62092d2b@redhat.com>
Date: Thu, 8 Mar 2018 19:53:55 +0100
MIME-Version: 1.0
In-Reply-To: <20180308172834.3281-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] qom: introduce
 object_class_get_list_sorted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 08.03.2018 18:28, Paolo Bonzini wrote:
> Unify half a dozen copies of very similar code (the only difference being
> whether comparisons were case-sensitive) and use it also in Tricore,
> which did not do any sorting of CPU model names.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qom/object.h    | 11 +++++++++++
>  qdev-monitor.c          |  9 +--------
>  qom/object.c            | 13 +++++++++++++
>  target/alpha/cpu.c      | 15 +--------------
>  target/hppa/cpu.c       | 15 +--------------
>  target/lm32/cpu.c       | 15 +--------------
>  target/sh4/cpu.c        | 15 +--------------
>  target/tricore/helper.c |  2 +-
>  8 files changed, 30 insertions(+), 65 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
