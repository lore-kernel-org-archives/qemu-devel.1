Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EC8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4AE720657
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aThWm8Jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AE720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFzg-0004Xe-2d
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 11:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZFyv-0003Hd-Hn
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:41:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33620
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZFyu-00055z-KX
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589470865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GIaiUQTRoqGbQCqo2keXkIh3Xe5WKmly2cgdti8HEeE=;
 b=aThWm8JzjWmnceAGCHbw5VIsUFB2K6vz2cN0Kn0h5Go0W2J83w+rnNOaoNyoC+eGBEbkt8
 k+F7eeT+wTLaVlvjgSay+TKXUK8DW4IUk+xGCxtCsdO+M6Ahpje2X8bX2LS09urr1ce5aa
 T/kJV8u5HPgTVisp6WrcpV2fYWgLIJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-ZL90IPp-M3KSrLJjJPkDiA-1; Thu, 14 May 2020 11:41:02 -0400
X-MC-Unique: ZL90IPp-M3KSrLJjJPkDiA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD9BA8015D1;
 Thu, 14 May 2020 15:41:01 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-9.ams2.redhat.com [10.36.114.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62B3060BF1;
 Thu, 14 May 2020 15:41:00 +0000 (UTC)
Date: Thu, 14 May 2020 17:40:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v4 2/3] iotests: add JobRunner class
Message-ID: <20200514154059.GK5518@linux.fritz.box>
References: <20200514022536.2568-1-jsnow@redhat.com>
 <20200514022536.2568-3-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200514022536.2568-3-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:41:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.05.2020 um 04:25 hat John Snow geschrieben:
> The idea is that instead of increasing the arguments to job_run all the
> time, create a more general-purpose job runner that can be subclassed to
> do interesting things with.
> 
> pylint note: the 'callbacks' option guards against unused warning
> arguments in functions designated as callbacks. It does not currently
> guard against "no-self-use" though; hence a once-off ignore.
> 
> mypy note: QapiEvent is only a weak alias; it's fully interchangable
> with the type it's declared as. In the future, we may wish to tighten
> these types. For now, this communicates the rough shape of the type and
> (more importantly) the intent.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

> +        # Listen for these events with these parameters:
> +        self._events = {
> +            'BLOCK_JOB_COMPLETED': match_device,
> +            'BLOCK_JOB_CANCELLED': match_device,
> +            'BLOCK_JOB_ERROR': match_device,
> +            'BLOCK_JOB_READY': match_device,
> +            'BLOCK_JOB_PENDING': match_id,
> +            'JOB_STATUS_CHANGE': match_id
> +        }

The old code had a trailing comma here in case we need to add more
events later. Anyway:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


