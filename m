Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D54C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 07:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CDB821527
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 07:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRbim6/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDB821527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVrBP-0008I5-7R
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 03:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVrAq-0007tG-7s
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 03:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVrAn-0002YK-89
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 03:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603436856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZwTJ2Amn5BnMCnA7WL3O+6BxGg0CBdmzBl1hEeUKR7g=;
 b=BRbim6/jo1OeH7h7uOWM5g8b5qMvfNjG4HZBSbqoh+sZeRk22JHuj4vv/lFTsmXk7niUIR
 mklx9glbnJrMDTRVZHeriCZ+QDZG5nVWByfZ3eZTklpSbAGGgpJBFyQstc2mY1ujfeZvay
 2FC4jvYq0lwlhsfVRVzYKOVsrKRzZH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-mmeZey8hNoKog1rD_ZN18Q-1; Fri, 23 Oct 2020 03:07:34 -0400
X-MC-Unique: mmeZey8hNoKog1rD_ZN18Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7AAF1006CAF;
 Fri, 23 Oct 2020 07:07:32 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-123.ams2.redhat.com [10.36.112.123])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C40C66EF57;
 Fri, 23 Oct 2020 07:07:30 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] accel: move qtest CpusAccel functions to a common
 location
To: Jason Andryuk <jandryuk@gmail.com>, qemu-devel@nongnu.org
References: <20201013140511.5681-1-jandryuk@gmail.com>
 <20201013140511.5681-3-jandryuk@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5bf10ae2-dfd1-a6b4-ad75-6dd3b3cd4d1e@redhat.com>
Date: Fri, 23 Oct 2020 09:07:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201013140511.5681-3-jandryuk@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/10/2020 16.05, Jason Andryuk wrote:
> Move and rename accel/qtest/qtest-cpus.c files to accel/dummy-cpus.c so
> it can be re-used by Xen.
> 
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> 
> ---
> v2:
>  - Use accel/dummy-cpus.c
>  - Put prototype in include/sysemu/cpus.h
> ---
>  accel/{qtest/qtest-cpus.c => dummy-cpus.c} | 22 ++++------------------
>  accel/meson.build                          |  7 +++++++
>  accel/qtest/meson.build                    |  1 -
>  accel/qtest/qtest-cpus.h                   | 17 -----------------
>  accel/qtest/qtest.c                        |  5 ++++-
>  include/sysemu/cpus.h                      |  3 +++
>  6 files changed, 18 insertions(+), 37 deletions(-)
>  rename accel/{qtest/qtest-cpus.c => dummy-cpus.c} (75%)
>  delete mode 100644 accel/qtest/qtest-cpus.h

Acked-by: Thomas Huth <thuth@redhat.com>


