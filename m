Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D11C10F0B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 04:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE97C2183E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 04:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE97C2183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35758 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGz30-0005Fv-5s
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 00:53:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGz1x-0004lq-N1
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGz1w-0002jn-Nw
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:52:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>)
	id 1hGz1w-0002iw-Eu; Thu, 18 Apr 2019 00:52:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 093F730031AC;
	Thu, 18 Apr 2019 04:52:11 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 506C2608C8;
	Thu, 18 Apr 2019 04:52:10 +0000 (UTC)
Date: Thu, 18 Apr 2019 01:52:08 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190418045208.GE25134@habkost.net>
References: <20190417025944.16154-1-ehabkost@redhat.com>
	<20190417025944.16154-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190417025944.16154-4-ehabkost@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Thu, 18 Apr 2019 04:52:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/5] linux-user: Use lookup_cpu_class()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Like Xu <like.xu@linux.intel.com>, Riku Voipio <riku.voipio@iki.fi>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Laurent Vivier <laurent@vivier.eu>,
	Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418045208._Zc22WnZvEqxAjzw3moHkiZCYdQfoPFscvshl9tsXPE@z>

On Tue, Apr 16, 2019 at 11:59:42PM -0300, Eduardo Habkost wrote:
> The return value of cpu_get_model() is just a CPU model name and
> never includes extra options.  We don't need to call
> parse_cpu_option().

Oops.  I was wrong.  linux-user also supports extra features in
the "-cpu" option, so we do need to call parse_cpu_option().

e.g.: this worked before:

  $ qemu-x86_64 -cpu Nehalem,+popcnt /bin/true

and now this is broken:

  $ qemu-x86_64 -cpu Nehalem,+popcnt /bin/true
  unable to find CPU model 'Nehalem,+popcnt'

I will drop patches 2-5 from my queue.  Sorry for the noise.

-- 
Eduardo

