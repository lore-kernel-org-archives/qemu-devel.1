Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4030EC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:49:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 169BD2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169BD2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48941 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRdF8-0000oj-8x
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 09:49:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hRdBG-00071s-Qk
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hRdBF-0001LK-Mk
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:45:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49275)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hRdBF-0001Db-68; Fri, 17 May 2019 09:45:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5FAF3003E5F;
	Fri, 17 May 2019 13:45:42 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9267517A60;
	Fri, 17 May 2019 13:45:29 +0000 (UTC)
Date: Fri, 17 May 2019 15:45:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190517154527.50ba76c0.cohuck@redhat.com>
In-Reply-To: <20190517114243.8998-1-david@redhat.com>
References: <20190517114243.8998-1-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 17 May 2019 13:45:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL SUBSYSTEM v2 s390x 00/40] s390x/tcg:
 s390x/tcg: Vector Instruction Support Part 2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 May 2019 13:42:43 +0200
David Hildenbrand <david@redhat.com> wrote:

> This pull request is not for master.
> 
> Hi Cornelia,
> 
> This time a signed pull request :)
> 
> The following changes since commit 85fa94e16927af2717093e5b8fe225206ec39e16:
> 
>   s390/css: handle CCW_FLAG_SKIP (2019-05-17 08:16:02 +0200)
> 
> are available in the Git repository at:
> 
>   https://github.com/davidhildenbrand/qemu.git tags/s390x-tcg-2019-05-17-2
> 
> for you to fetch changes up to db156ebfae0d7707d81d13234e2fd43dd3347298:
> 
>   s390x/tcg: Implement VECTOR TEST UNDER MASK (2019-05-17 10:54:13 +0200)
> 
> ----------------------------------------------------------------
> Implement all Vector Integer Instructions introduced with the
> "Vector Facility" for s390x TCG.
> 
> ----------------------------------------------------------------
> David Hildenbrand (40):
>   s390x/tcg: Implement VECTOR ADD
>   s390x/tcg: Implement VECTOR ADD COMPUTE CARRY
>   s390x/tcg: Implement VECTOR ADD WITH CARRY
>   s390x/tcg: Implement VECTOR ADD WITH CARRY COMPUTE CARRY
>   s390x/tcg: Implement VECTOR AND (WITH COMPLEMENT)
>   s390x/tcg: Implement VECTOR AVERAGE
>   s390x/tcg: Implement VECTOR AVERAGE LOGICAL
>   s390x/tcg: Implement VECTOR CHECKSUM
>   s390x/tcg: Implement VECTOR ELEMENT COMPARE *
>   s390x/tcg: Implement VECTOR COMPARE *
>   s390x/tcg: Implement VECTOR COUNT LEADING ZEROS
>   s390x/tcg: Implement VECTOR COUNT TRAILING ZEROS
>   s390x/tcg: Implement VECTOR EXCLUSIVE OR
>   s390x/tcg: Implement VECTOR GALOIS FIELD MULTIPLY SUM (AND ACCUMULATE)
>   s390x/tcg: Implement VECTOR LOAD COMPLEMENT
>   s390x/tcg: Implement VECTOR LOAD POSITIVE
>   s390x/tcg: Implement VECTOR (MAXIMUM|MINIMUM) (LOGICAL)
>   s390x/tcg: Implement VECTOR MULTIPLY AND ADD *
>   s390x/tcg: Implement VECTOR MULTIPLY *
>   s390x/tcg: Implement VECTOR NAND
>   s390x/tcg: Implement VECTOR NOR
>   s390x/tcg: Implement VECTOR NOT EXCLUSIVE OR
>   s390x/tcg: Implement VECTOR OR
>   s390x/tcg: Implement VECTOR OR WITH COMPLEMENT
>   s390x/tcg: Implement VECTOR POPULATION COUNT
>   s390x/tcg: Implement VECTOR ELEMENT ROTATE LEFT LOGICAL
>   s390x/tcg: Implement VECTOR ELEMENT ROTATE AND INSERT UNDER MASK
>   s390x/tcg: Implement VECTOR ELEMENT SHIFT
>   s390x/tcg: Implement VECTOR SHIFT LEFT (BY BYTE)
>   s390x/tcg: Implement VECTOR SHIFT LEFT DOUBLE BY BYTE
>   s390x/tcg: Implement VECTOR SHIFT RIGHT ARITHMETIC
>   s390x/tcg: Implement VECTOR SHIFT RIGHT LOGICAL *
>   s390x/tcg: Implement VECTOR SUBTRACT
>   s390x/tcg: Implement VECTOR SUBTRACT COMPUTE BORROW INDICATION
>   s390x/tcg: Implement VECTOR SUBTRACT WITH BORROW INDICATION
>   s390x/tcg: Implement VECTOR SUBTRACT WITH BORROW COMPUTE BORROW
>     INDICATION
>   s390x/tcg: Implement VECTOR SUM ACROSS DOUBLEWORD
>   s390x/tcg: Implement VECTOR SUM ACROSS QUADWORD
>   s390x/tcg: Implement VECTOR SUM ACROSS WORD
>   s390x/tcg: Implement VECTOR TEST UNDER MASK
> 
>  target/s390x/Makefile.objs      |    2 +-
>  target/s390x/cc_helper.c        |   17 +
>  target/s390x/helper.c           |    1 +
>  target/s390x/helper.h           |   66 ++
>  target/s390x/insn-data.def      |  137 +++
>  target/s390x/internal.h         |    1 +
>  target/s390x/translate.c        |    2 +
>  target/s390x/translate_vx.inc.c | 1420 +++++++++++++++++++++++++++++++
>  target/s390x/vec_int_helper.c   |  616 ++++++++++++++
>  9 files changed, 2261 insertions(+), 1 deletion(-)
>  create mode 100644 target/s390x/vec_int_helper.c
> 

Thanks, pulled.

