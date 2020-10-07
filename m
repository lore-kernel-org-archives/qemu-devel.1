Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEFDC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 07:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B5220797
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 07:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMhsGavo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B5220797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ3oZ-0006UG-B1
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 03:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kQ3n9-0005kg-4u
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 03:23:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54447)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kQ3n6-0001Dp-EO
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 03:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602055391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u3bfw0uzGZCFblfV5bfh1bUsJZ/142xOozCWKPQcOBI=;
 b=BMhsGavoLtSqY9ERaOEtjHlqedWXLx4XOUqqurZkV7X5ByCqQHMovcZzBpi4CXhHXMvuad
 shQkU0zt7l7pea7J/dkTWdplbxgFMQUVIdaaLjvpDOCFm7u4dyJMJp185AAWo/UBWtLxuW
 tIrE7E1lFFsMKNqdgxER6Yretcp3H/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-KlOHqDxLN72ebV6OcNNCTQ-1; Wed, 07 Oct 2020 03:23:07 -0400
X-MC-Unique: KlOHqDxLN72ebV6OcNNCTQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 461C2CE2E4;
 Wed,  7 Oct 2020 07:23:06 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-72.ams2.redhat.com [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E45315D9E2;
 Wed,  7 Oct 2020 07:23:03 +0000 (UTC)
Subject: Re: acceptance-system-fedora failures
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
References: <f9e09f0b-3915-382c-d670-8d33d164ad7b@redhat.com>
 <4e191372-c332-8f69-85e2-1ff6ead0f40d@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e577dded-ed2b-6cd0-5119-9bde4ab0c492@redhat.com>
Date: Wed, 7 Oct 2020 09:23:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4e191372-c332-8f69-85e2-1ff6ead0f40d@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/10/2020 07.20, Philippe Mathieu-Daudé wrote:
> On 10/7/20 1:07 AM, John Snow wrote:
>> I'm seeing this gitlab test fail quite often in my Python work; I don't
>> *think* this has anything to do with my patches, but maybe I need to try
>> and bisect this more aggressively.
[...]
> w.r.t. the error in your build, I told Thomas about the
> test_ppc_mac99/day15/invaders.elf timeouting but he said this is
> not his area. Richard has been looking yesterday to see if it is
> a TCG regression, and said the test either finished/crashed raising
> SIGCHLD, but Avocado parent is still waiting for a timeout, so the
> children become zombie and the test hang.
> 
> Not sure that helps :)

No clue why that invaders.elf is now failing with the replay test, but if
you look at the history of the CI runs:

 https://gitlab.com/qemu-project/qemu/-/pipelines

... you can clearly see that the problem started with John's
ide-pull-request 5 days ago:

 https://gitlab.com/qemu-project/qemu/-/pipelines/197124608

So maybe it's worth the effort to have a look at the patches that got merged
here?

 Thomas


