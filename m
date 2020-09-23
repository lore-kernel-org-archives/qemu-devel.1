Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01E4C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B882214F1
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WRkcAniS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B882214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7F9-0003vL-UB
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kL7Bm-0001Cw-N1; Wed, 23 Sep 2020 12:00:16 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:41128)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kL7BW-0003Qz-2X; Wed, 23 Sep 2020 12:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=spHDZ4o9v6m4xwbHkeCUvu22JzQGC3FINzTt1hkcT1E=; 
 b=WRkcAniS0nUA1xmLJDGiEYKw6moMQsOLhqNi/bH1Sj0BCS+z5S4S0NN9VKvTLouZCzP3OBQVib7xw+5RZ5TpWWBS31/T2Qt9JfC2Iu5X2ShO1nQv+GmlAV99CFnKayceNe5qMWGWGl9aAdv4gqAx/h8zWzrHoo5Nd5ib500dRhupm5tjck57xRuzinC/ipFH2c50/CbUdifq4WYU+Tl5odGuOeLNgiV9ayovFFJhnat7FAcfsn9tENRBr2F5b3vvT96cSdDP3Yh/F9mbxY4JoeI2FmOPgQ1qYHJ7tpB9edwyrQpkYAZhUAScnRry8RCQNaTdantisBbrpAFLT9DWMg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kL7B2-00079M-Vn; Wed, 23 Sep 2020 17:59:29 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kL7B2-00043q-MK; Wed, 23 Sep 2020 17:59:28 +0200
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] docs: Document the throttle block filter
In-Reply-To: <20200923155522.GF6912@linux.fritz.box>
References: <20200921173016.27935-1-berto@igalia.com>
 <20200923155522.GF6912@linux.fritz.box>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 23 Sep 2020 17:59:28 +0200
Message-ID: <w51wo0ka3hb.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 11:59:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 23 Sep 2020 05:55:22 PM CEST, Kevin Wolf wrote:
>> +A throttle-group can also be created with the -object command line
>> +option but at the moment there is no way to pass a 'limits' parameter
>> +that contains a ThrottleLimits structure. The solution is to set the
>> +individual values directly, like in this example:
>> +
>> +   -object throttle-group,id=group0,x-iops-total=1000,x-bps-write=2097152
>> +
>> +Note however that this not stable API (hence the 'x-' prefixes) and
>> +can change or disappear in the future.
>
> Should we use a stronger wording here, like "will disappear when
> -object gains support for structured options and enables use of
> 'limits'"?

Sounds good, I can send v2 if you want, or feel free to change the
sentence yourself when applying the patch now.

Berto

