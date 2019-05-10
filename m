Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8AEC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 08:29:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D0620850
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 08:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D0620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38882 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP0ub-00066k-TX
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 04:29:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1hP0tr-0005pj-8q
	for qemu-devel@nongnu.org; Fri, 10 May 2019 04:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1hP0tq-0004E4-FG
	for qemu-devel@nongnu.org; Fri, 10 May 2019 04:29:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1hP0tq-0004Dd-AA
	for qemu-devel@nongnu.org; Fri, 10 May 2019 04:29:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4BCCB3086262;
	Fri, 10 May 2019 08:29:01 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-117-82.ams2.redhat.com [10.36.117.82])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A1A555DF4B;
	Fri, 10 May 2019 08:28:58 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
	id F20D43E0060; Fri, 10 May 2019 10:28:56 +0200 (CEST)
Date: Fri, 10 May 2019 10:28:56 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190510082856.GW4675@paraplu>
References: <20190510081526.15507-1-kchamart@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510081526.15507-1-kchamart@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Fri, 10 May 2019 08:29:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] VirtIO-RNG: Update default entropy
 source to `/dev/urandom`
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
Cc: rjones@redhat.com, berrange@redhat.com, armbru@redhat.com,
	stefanha@redhat.com, amit@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 10, 2019 at 10:15:25AM +0200, Kashyap Chamarthy wrote:

[...]

> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>

I didn't intentionally retain Dan and Rich's "Reviewed-by" tags.  Maybe
I should have, because I only updated the commit message.

> ---
> v2:
>  - Update commit message to mention justification for preferring
>    `/dev/urandom` over `/dev/random` [stefanha]
> ---
>  backends/rng-random.c | 2 +-
>  qemu-options.hx       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

[...]

-- 
/kashyap

