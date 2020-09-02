Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51B7C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:22:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92BCF2078B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmL9GZSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BCF2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDPul-0001OX-Qg
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 06:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDPu3-0000uW-Th
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:22:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41807
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDPty-0002oB-Np
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599042122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfU80aw4wilLXOYHs+xv3nK1ZkYkzKtJKJjJaNBQaeY=;
 b=SmL9GZSL9QYAUiv9Rp3NbQGgjTjaPvsWE+clyUFjh1PfsVAu//5HH9ukYhjhdToVIa5TF0
 DYDD34SoZjZc5rdoDj/Ami+V3j4Wn0/r0dfqW7+QA886PLTUJUEmxVgPTpFTeRcVyHuVQ9
 gQSy9fFPjOiIczhkyEn5rfGy8djQwp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-9WgksSXtPxCXkDtuGjYVsA-1; Wed, 02 Sep 2020 06:21:58 -0400
X-MC-Unique: 9WgksSXtPxCXkDtuGjYVsA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 000CE80BCA1;
 Wed,  2 Sep 2020 10:21:57 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-129.ams2.redhat.com [10.36.112.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8598319C59;
 Wed,  2 Sep 2020 10:21:52 +0000 (UTC)
Subject: Re: [PATCH] qemu-iotests: move check-block back to Makefiles
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200902080046.10412-1-pbonzini@redhat.com>
 <20200902081933.GE403297@redhat.com>
 <579e9d08-6235-0cdc-bbf6-07f2fc489426@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4ec5c197-3ff9-da88-9dac-c0e85042f586@redhat.com>
Date: Wed, 2 Sep 2020 12:21:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <579e9d08-6235-0cdc-bbf6-07f2fc489426@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:33:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Lukas Doktor <ldoktor@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Wainer Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/2020 10.37, Paolo Bonzini wrote:
> On 02/09/20 10:19, Daniel P. Berrangé wrote:
>> On Wed, Sep 02, 2020 at 04:00:46AM -0400, Paolo Bonzini wrote:
>>> check-block has its own test harness, unlike every other test.  If
>>> we capture its output, as is in general nicer to do without V=1,
>>> there will be no sign of progress.  So for lack of a better option
>>> just move the invocation of the test back to Makefile rules.
>>
>> I expect the correct long term solution here is to stop using the
>> check-block.sh script.  Instead have code which sets up each
>> of the I/O tests as an explicit test target in meson. We could
>> use meson's test grouping features too.
> 
> I'm not sure, "check-acceptance" will never be integrated in Meson, and
> it may well be the same for "check-block".  Actually I wonder if Avocado
> would be a better check-block.sh than check-block.sh.

Wasn't there even some support for the iotests in avocado (or
avocado-vt) at one point in time? ... not sure anymore, Cleber, Wainer,
do you remember?

 Thomas


