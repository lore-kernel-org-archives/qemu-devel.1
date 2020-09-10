Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66A2C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:13:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E19420882
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDqHjgu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E19420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGS0t-0002fE-EL
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGS0B-0001nh-QV
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:12:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43821
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGS09-0003LL-Jg
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599765176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rh6250KPoRcyYSZINonz1JyP13iF4XW9OJlOcDFm32c=;
 b=JDqHjgu7WJ96jiROsrC0uGdf6AkHbOqIqNXomRUEPijo5iFB2xzsFPT0oWstt6dxtRJMXc
 +I+OYSiMY+tF0qI7kEP5QebFQDKqJhHeKOk5RdbB4m02U12O+YA/XwuKbnJclCnF3XCHW3
 06omT5YhUsnRPQZxKyNyU67cvmzDDpY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-Z8ECA4L4MgKHIfwRoUb1Iw-1; Thu, 10 Sep 2020 15:12:54 -0400
X-MC-Unique: Z8ECA4L4MgKHIfwRoUb1Iw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AE3B100747E;
 Thu, 10 Sep 2020 19:12:53 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CB0275134;
 Thu, 10 Sep 2020 19:12:52 +0000 (UTC)
Date: Thu, 10 Sep 2020 15:12:51 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 1/2] Introduce (x86) CPU model deprecation API
Message-ID: <20200910191251.GN1618070@habkost.net>
References: <1591843676-102054-1-git-send-email-robert.hu@linux.intel.com>
 <20200909181506.GM1618070@habkost.net>
 <3f823308-149c-6759-35ae-4df7d0116cb6@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3f823308-149c-6759-35ae-4df7d0116cb6@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com, chenyi.qiang@intel.com,
 armbru@redhat.com, pbonzini@redhat.com, robert.hu@intel.com,
 Robert Hoo <robert.hu@linux.intel.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 10, 2020 at 07:29:03AM +0200, Philippe Mathieu-Daudé wrote:
> On 9/9/20 8:15 PM, Eduardo Habkost wrote:
> > Hi,
> > 
> > Thanks for the patch, and sorry for taking so long to review
> > this.  I'm finally getting to the patches that were postponed to
> > 5.2.
> 
> Sorry I missed that patch too.
> 
> Why restrict this to CPUClass, and not provide this feature to
> all ObjectClass?

We could do it, but the field would be left unused for anything
that's not a CPU model or machine type, as there are no other QMP
interfaces for querying deprecation status yet.

A QMP interface for querying deprecation status of device types
in general would be useful, though.

-- 
Eduardo


