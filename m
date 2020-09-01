Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC76C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74691208DB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ol1hIgfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74691208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCzTZ-0002xd-Iu
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 02:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kCzSs-0002WX-By
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 02:08:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46132
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kCzSq-0007s4-P0
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 02:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598940495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bbP+2q05LvVxLipeI/2SLdjXZ2J8BCujEly32TJ2suE=;
 b=Ol1hIgfKFGpfGf/BixV91x49gG3+HEZZb2kYzBlGGVOC1/gnAehdwzpniWiBuvTh2c/xqK
 uzkj+fMnDNPXcdoEUJRe7KMiKYD3Uasm79LPQSuzZSJEhm3kYI43+J0S9acu0bNr0vxytI
 uATmxTKIv7QSgYjCgVbT72BDUZvowd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-TvcqMq8nO4uM9RwC9ieJZw-1; Tue, 01 Sep 2020 02:08:12 -0400
X-MC-Unique: TvcqMq8nO4uM9RwC9ieJZw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7558C1888A1E;
 Tue,  1 Sep 2020 06:08:11 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-188.ams2.redhat.com [10.36.112.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA48C5D9CD;
 Tue,  1 Sep 2020 06:07:59 +0000 (UTC)
Subject: Re: [PATCH] gitlab-ci.yml: Run check-qtest and check-unit at the end
 of the fuzzer job
To: Alexander Bulekov <alxndr@bu.edu>
References: <20200831153228.229185-1-thuth@redhat.com>
 <20200831164047.z4njpacixgjhcvjs@mozz.bu.edu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <12d05770-8e10-7c54-53d6-7453c8b44b48@redhat.com>
Date: Tue, 1 Sep 2020 08:07:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200831164047.z4njpacixgjhcvjs@mozz.bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 02:08:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/08/2020 18.40, Alexander Bulekov wrote:
> On 200831 1732, Thomas Huth wrote:
>> The fuzzer job finishes quite early, so we can run the unit tests and
>> qtests with -fsanitize=address here without extending the total test time.
>>
> 
> Sounds good to me, though its too bad that this is limited to i386 and
> we aren't using the --enable-sanitizers configure argument due to the
> strange oss-fuzz build script.
> 
> Speaking of testing with sanitizers, does it make sense to have a job
> that does check-qtest with --enable-tsan, now that we have
> ThreadSanitizer support? 
> 
> Can --enable-sanitizers --enable-tsan be added to some existing job,
> without severely increasing the pipeline's exeuction time?

Good idea, I'll have a try when I've got some spare time again (probably
not this week, though, it's a pretty busy one for me).

> Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

Thanks!

 Thomas


