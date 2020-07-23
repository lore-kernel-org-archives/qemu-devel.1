Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C92EC433FB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D089B207BB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IS8IS+0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D089B207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jycnW-0007Fh-4h
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 11:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jycmn-0006mR-BJ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 11:05:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21471
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jycml-0004rw-R3
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 11:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595516727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+uwxOvw/wKMUU0Zv/ZOo6qsmH6lJn446pamIIhX4sqA=;
 b=IS8IS+0ZmwnklGeIt4nusTbiQ/OlyiGrwRFUAonJVJFxf4m5zomGFfjr0oBmHF+GD7r21m
 EUUgV83E7XrN/BwZVQfWI6h+voXDI3efvbH9xV4B6GVh8VaK749UDfQP5rWiZvN85NRPFW
 IFMHgsqg1OotCM4nkzqcGPP189oKiKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-2iM9UTerNnmxm-hgI9XeDA-1; Thu, 23 Jul 2020 11:05:23 -0400
X-MC-Unique: 2iM9UTerNnmxm-hgI9XeDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9D941005504;
 Thu, 23 Jul 2020 15:05:21 +0000 (UTC)
Received: from gondolin (ovpn-112-228.ams2.redhat.com [10.36.112.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F7C15D9D3;
 Thu, 23 Jul 2020 15:05:17 +0000 (UTC)
Date: Thu, 23 Jul 2020 17:05:15 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/1] s390x/protvirt: allow to IPL secure execution
 guests with -no-reboot
Message-ID: <20200723170515.4e2ee21e.cohuck@redhat.com>
In-Reply-To: <d2d0d040-3fa9-df7b-eb05-8a5906212486@de.ibm.com>
References: <20200721103202.30610-1-borntraeger@de.ibm.com>
 <ecec58d9-4b9c-c677-e2d2-ca3cf0632530@linux.ibm.com>
 <d2d0d040-3fa9-df7b-eb05-8a5906212486@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 14:29:29 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 21.07.20 14:25, Janosch Frank wrote:
> > On 7/21/20 12:32 PM, Christian Borntraeger wrote:  
> >> Right now -no-reboot does prevent secure execution guests from running.  
> > 
> > s/-no-reboot/--no-reboot/  
> 
> Actually qemu --help gives the parameters with just one "-"
> 
> 
> Not sure about secure vs protected. Whatever Conny prefers.

The doc seems to talk about "protected virtualization", "protected
mode", and "secure guests". What about (slight rewording):

"s390x/protvirt: allow to IPL secure guests with -no-reboot

Right now, -no-reboot prevents secure guests from running. This is
correct from an implementation point of view, as we have modeled the
transition from non-secure to secure as a program directed IPL. From a
user perspective, this is not the behavior of least surprise.

We should implement the IPL into protected mode similar to the functions
that we use for kdump/kexec. In other words, we do not stop here when
-no-reboot is specified on the command line. Like function 0 or function
1, function 10 is not a classic reboot. For example, it can only be called
once. Before calling it a second time, a real reboot/reset must happen
in-between. So function code 10 is more or less a state transition
reset, but not a "standard" reset or reboot."

I think this is still appropriate for hard freeze.


