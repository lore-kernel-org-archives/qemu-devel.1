Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69EBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 06:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 846082073B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 06:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+npcd9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846082073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc0qW-0008Ru-ND
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 02:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jc0pt-00082B-5B
 for qemu-devel@nongnu.org; Fri, 22 May 2020 02:07:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52963
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jc0pr-0002UJ-Nz
 for qemu-devel@nongnu.org; Fri, 22 May 2020 02:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590127629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKiHd2slf/hPGNW78XDQTRkntinoC0UvQiHk49L7W8Q=;
 b=X+npcd9bEQs/Lxz9h7EnPPd5HTRzC5RLxGSzeuQIYppRx8TT7N97+TjpqjwV3PefwboNuG
 IcxBvENGetOKEEwEM4YXb6KBPk9ZW2RW0HOLci3A9JwT74CboXQ95NZnpx9Xjd76Wq5I8b
 PmMnMGWbkW3eHwNkPIKVDl7F9/Z0lio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-K_Uk7EMFOlKXh6I0-wloSQ-1; Fri, 22 May 2020 02:07:07 -0400
X-MC-Unique: K_Uk7EMFOlKXh6I0-wloSQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEB9B461;
 Fri, 22 May 2020 06:07:05 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0B5782EFA;
 Fri, 22 May 2020 06:07:04 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 5088F1809542;
 Fri, 22 May 2020 06:07:04 +0000 (UTC)
Date: Fri, 22 May 2020 02:07:02 -0400 (EDT)
From: Thomas Huth <thuth@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Message-ID: <1934989075.27890087.1590127622669.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200521185407.25311-2-cfontana@suse.de>
References: <20200521185407.25311-1-cfontana@suse.de>
 <20200521185407.25311-2-cfontana@suse.de>
Subject: Re: [RFC 1/3] cpu-throttle: new module, extracted from cpus.c
MIME-Version: 1.0
X-Originating-IP: [217.92.231.145, 10.4.196.10, 10.5.101.130, 10.4.195.13]
Thread-Topic: cpu-throttle: new module, extracted from cpus.c
Thread-Index: fjuuDLDAe3K3Znb6UONG6B9f6ozldg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 02:07:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "open list:X86 HAXM CPUs" <haxm-team@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Colin Xu <colin.xu@intel.com>,
 Wenchao Wang <wenchao.wang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: "Claudio Fontana" <cfontana@suse.de>
> Sent: Thursday, May 21, 2020 8:54:05 PM
> 
> this is a first step in the refactoring of cpus.c.

Could you maybe extend the commit message in the next version a little bit? ... say something about *what* you are moving to a separate file (and maybe why it is ok to move it), etc.?

 Thanks,
  Thomas


