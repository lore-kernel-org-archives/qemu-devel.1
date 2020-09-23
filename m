Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FDFC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 21:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C952311A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 21:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGyTAM12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C952311A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLCZc-0004Sl-Tw
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 17:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLCYM-00040Q-Rh
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 17:43:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22637)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLCYL-0007LU-1f
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 17:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600897432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IhLGb2n3hi3ClqBOB3QTp1Bw5/hlw/K2qNVPcJG046Y=;
 b=bGyTAM12D+XhU9mQGfJtPwvRV+EDQ1o8TBJB69WhvK1FPhyq8vAUmEVprJvXY56KThqegV
 wdjEV1wZ18Epyzrgu8jGaAKF9hQFtNn49ebSGDRF76C6ARa26q0+0XAPBa3LxOxjL9kfyv
 /zd3gn+MkacAokEUFAFQzkEvnN50oFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-ODuWFiWgMh-NbvFqEo4SwA-1; Wed, 23 Sep 2020 17:43:48 -0400
X-MC-Unique: ODuWFiWgMh-NbvFqEo4SwA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0512856BE2;
 Wed, 23 Sep 2020 21:43:47 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1540B10023A5;
 Wed, 23 Sep 2020 21:43:45 +0000 (UTC)
Subject: Re: [PATCH v2 31/38] qapi/introspect.py: add _gen_features helper
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-32-jsnow@redhat.com>
 <20200923163526.GS3312949@habkost.net>
From: John Snow <jsnow@redhat.com>
Message-ID: <dea63eb3-7842-ff29-918d-12e5e7bc90a0@redhat.com>
Date: Wed, 23 Sep 2020 17:43:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923163526.GS3312949@habkost.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 12:35 PM, Eduardo Habkost wrote:
> I believe these two lines above should be removed, as suggested
> in patch 30, but let's ignore that for now.
> 

Yup, headed there.

>> -    if features:
>> -        obj['features'] = [(f.name, Extra(None, f.ifcond)) for f in features]
> I can't say I understand completely why moving these two lines
> outside _make_tree() is useful, but if it makes the cleanup work
> you did easier, I trust this is the right thing to do.  The
> changes look correct.

The basic premise is:

Why pass information you want to add to obj['features'] to a function to 
make that assignment, when you could just perform that assignment yourself?

Otherwise, _make_tree, which accepts any arbitrary object (not just 
dicts!) has to interrogate its arguments to make sure you gave it a dict 
when you give it a features argument.

Type-wise, it's cleaner to perform this transformation when we KNOW we 
have an object than it is to defer to a more abstracted function and 
assert/downcast back to more specific types.


