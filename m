Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D6BC433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7410820738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAtUozTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7410820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzbd-0006Hu-NX
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1juzaP-0005Ah-0D
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:37:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59983
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1juzaM-0002B0-4k
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594651057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s2zaisg+Z7+7N5gt57xhSV15wyeLocA5kBevBTvbMtI=;
 b=WAtUozTHOUTVofp6z04JK3zbta3CN7gbcCfJ4QPHv6MBgq3AHvZA297DQoKO5lo8Bzw0nP
 NzlTxtMdxpTEu5vL8arKZphT32+1mzFmJZ5iRctA2C144lQ/+hyGAKAho4cRjmKXEW89FI
 mauc45FA+wmaXLO/xoGxPj2i+hvqNCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-44PrTlm-NNWx7ig-PHlN4w-1; Mon, 13 Jul 2020 10:37:35 -0400
X-MC-Unique: 44PrTlm-NNWx7ig-PHlN4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5984318C63C6;
 Mon, 13 Jul 2020 14:37:34 +0000 (UTC)
Received: from localhost (ovpn-119-232.rdu2.redhat.com [10.10.119.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09A3C76203;
 Mon, 13 Jul 2020 14:37:33 +0000 (UTC)
Date: Mon, 13 Jul 2020 10:37:33 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PULL 10/41] python/qemu: Add ConsoleSocket for optional use in
 QEMUMachine
Message-ID: <20200713143733.GW780932@habkost.net>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
 <20200707070858.6622-11-alex.bennee@linaro.org>
 <fa8ee177-3a53-cde0-a8f1-8b0e8eba678f@redhat.com>
 <CAEyhzFsYb4KvDaeMGwjocSjU0QO957Eg_TQbi0oEr1c=rE5vwQ@mail.gmail.com>
 <9cec0aa2-afc8-43fd-31bc-d74e80588ecd@redhat.com>
 <bd35e56d-118e-0b04-c708-424ec5bfa723@redhat.com>
MIME-Version: 1.0
In-Reply-To: <bd35e56d-118e-0b04-c708-424ec5bfa723@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Robert Foley <robert.foley@linaro.org>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Peter Puhov <peter.puhov@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 13, 2020 at 04:16:50PM +0200, Philippe Mathieu-Daudé wrote:
> On 7/13/20 3:57 PM, John Snow wrote:
> > On 7/11/20 12:15 PM, Robert Foley wrote:
> >> Hi,
> >> Thanks for the detailed feedback!  I will look at making these changes.
> >>
> > 
> > Sorry that it came so late ...
> 
> I was looking for the patch that makes the python-next series rebase
> to fail and now I see your comments :(
> 
> So we lost the race. I'll see what can still be merged.
> 
> Sorry it took so long due to the Avocado tests failing :(
> 
> OTOH I think it is time to declare the Python scripts need more
> maintainers because we can't keep up. There are various scripts
> and tests written in Python that missed the 5.1 freeze.
> 
> Cleber/Eduardo what do you think (about getting more maintainers
> involved)?

I agree.  I am not being able to keep up and dedicate the time
required to be a good maintainer for the parts I maintain.

My suggestion would be to not have maintainers for "Python
scripts" in general, but having actual maintainers for specific
parts (python/*, tests/vm, tests/migration, scripts/tracetool,
scripts/qapi, etc).

-- 
Eduardo


