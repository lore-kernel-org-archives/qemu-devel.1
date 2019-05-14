Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01ACC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CDAF20675
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDAF20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43747 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQTUq-0001YU-K9
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 05:13:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hQTS9-0007X7-6l
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hQTS6-0004hO-Kb
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:10:28 -0400
Received: from foss.arm.com ([217.140.101.70]:48970)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>)
	id 1hQTRv-0004Ns-RV; Tue, 14 May 2019 05:10:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B911374;
	Tue, 14 May 2019 02:10:12 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.72.51.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94ED23F71E;
	Tue, 14 May 2019 02:10:10 -0700 (PDT)
Date: Tue, 14 May 2019 10:10:08 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190514091005.GN28398@e103592.cambridge.arm.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-6-drjones@redhat.com>
	<20190513124356.GG28398@e103592.cambridge.arm.com>
	<20190513140726.vpmenrfw4uocmtnc@kamzik.brq.redhat.com>
	<20190513143929.GK28398@e103592.cambridge.arm.com>
	<956f9bc9-1024-b02a-e792-98b01d016ef4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <956f9bc9-1024-b02a-e792-98b01d016ef4@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.140.101.70
Subject: Re: [Qemu-devel] [PATCH 05/13] target/arm/kvm: Add
 kvm_arch_get/put_sve
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	Andrew Jones <drjones@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"abologna@redhat.com" <abologna@redhat.com>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"alex.bennee@linaro.org" <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 13, 2019 at 05:58:59PM +0100, Richard Henderson wrote:
> On 5/13/19 7:39 AM, Dave Martin wrote:
> > On that point, could TCG easily be made to expose a larger vector length
> > to the kernel?  I'd be interested to see what happened.
> 
> It would be easy enough to extend the maximum vector length within TCG.
> 
> Increase ARM_MAX_VQ.  Alter the couple of places where we manipulate ZCR.LEN to
> extend the current 4-bit mask.
> 
> How large do you need the max to be, for testing?

Anything upwards of 256 bytes is interesting.

The architecture reserves space for it to grow up to 9 bits, though it's
unlikely it would ever get that large in reality.

So if you wanted to go crazy, you might be able to go up to 8192 bytes.

This is just for fun, since it goes outside the architecture and Linux
officially doesn't support it today in any case.  So definitely not a
priority!

Cheers
---Dave

