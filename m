Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AFCC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 18:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836CB20652
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 18:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836CB20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41149 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF13D-0002y9-OU
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 14:37:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hF12V-0002dW-3h
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hF12U-0004TF-85
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:36:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hF12U-0004Rr-0y
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:36:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C062308792D
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 18:36:36 +0000 (UTC)
Received: from localhost (ovpn-116-78.gru2.redhat.com [10.97.116.78])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D5D8960BEC;
	Fri, 12 Apr 2019 18:36:30 +0000 (UTC)
Date: Fri, 12 Apr 2019 15:36:28 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190412183628.GA31999@habkost.net>
References: <20190411175345.19414-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190411175345.19414-1-thuth@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Fri, 12 Apr 2019 18:36:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1] Declare -realtime as
 deprecated
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
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412183628.bFxp3g1FvpijB1gmj5vS0Nq33zIFYl3FaG7NmjmEXNA@z>

On Thu, Apr 11, 2019 at 07:53:45PM +0200, Thomas Huth wrote:
> The old -realtime mlock=on|off parameter does exactly the same as the
> new -overcommit mem-lock=on|off parameter. Additionally, "-realtime"
> does not activate any additional "realtime" capabilities as the name
> might indicate. We should avoid to confuse the users this way, so
> let's deprecate the old -realtime option.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Paolo, do you want to queue this, or should I do it through the
machine queue?

-- 
Eduardo

