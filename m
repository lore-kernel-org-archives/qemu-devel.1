Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531CBC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 09:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A16F206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 09:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A16F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56092 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE98Y-0002pu-DC
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 05:03:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hE97d-0002TO-MG
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 05:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hE97T-0005Gn-ES
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 05:02:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hE97Q-0005Di-Ra
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 05:02:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1EB97307AD02
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 09:02:07 +0000 (UTC)
Received: from redhat.com (ovpn-116-51.ams2.redhat.com [10.36.116.51])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 98C0916922;
	Wed, 10 Apr 2019 09:02:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Cole Robinson <crobinso@redhat.com>
In-Reply-To: <b991a4d0e6c4253bc08b2794c6084be55fc72e1d.1554851834.git.crobinso@redhat.com>
	(Cole Robinson's message of "Tue, 9 Apr 2019 19:19:57 -0400")
References: <b991a4d0e6c4253bc08b2794c6084be55fc72e1d.1554851834.git.crobinso@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date: Wed, 10 Apr 2019 11:06:35 +0200
Message-ID: <8736mqz0tg.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Wed, 10 Apr 2019 09:02:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: savevm: fix error code with
 migration blockers
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
Reply-To: quintela@redhat.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410090635.LjqT7GxNtMcxkquAqDEBkKEoYJAFLA5hjeKovSJB_DA@z>

Cole Robinson <crobinso@redhat.com> wrote:
> The only caller that checks the error code is looking for != 0,
> so returning false is incorrect.
>
> Fixes: 5aaac467938 "migration: savevm: consult migration blockers"
>
> Signed-off-by: Cole Robinson <crobinso@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

