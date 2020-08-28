Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2921C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692442073A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nc8nkOvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692442073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBb6n-0006gm-LS
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBb5Y-0005pl-9y
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:54:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27675
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBb5W-0007vC-8G
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598608464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FtQ+nUNwJc2G6dLCVXx9NUBhoPfqhNmFr6llQ1I8hkQ=;
 b=Nc8nkOvftm0A5z6J4btKVFsyb10xD0f83bQoTmEIu2krXuzEKKnJYsd5JsGGYvEP688RiW
 ss4bceXv4l3545H9s86Mkn9lqL0U0R4nbA61Iy+QP0YW2mwWsqyZLNH75827qpjfWm3uLN
 WbJ29Fn6ug4cHIw2uq8Q5WdE/tQCL88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-CVNx0IqgMqyat5kAJ-wsCg-1; Fri, 28 Aug 2020 05:54:20 -0400
X-MC-Unique: CVNx0IqgMqyat5kAJ-wsCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F5B418A2240;
 Fri, 28 Aug 2020 09:54:19 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-79.ams2.redhat.com [10.36.112.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA9DB7C86C;
 Fri, 28 Aug 2020 09:54:17 +0000 (UTC)
Subject: Re: [PATCH] cirrus.yml: Exclude some targets in the FreeBSD job to
 speed up the build
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200824094410.6201-1-thuth@redhat.com>
 <20200828085954.GE224144@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <79c7c98a-bb34-df86-a24f-b7df2ac89242@redhat.com>
Date: Fri, 28 Aug 2020 11:54:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200828085954.GE224144@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 04:08:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.782, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-devel@nongnu.org, Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/08/2020 10.59, Daniel P. Berrangé wrote:
> On Mon, Aug 24, 2020 at 11:44:10AM +0200, Thomas Huth wrote:
>> The FreeBSD jobs currently hit the 1h time limit in the Cirrus-CI.
>> We've got to exclude some build targets here to make sure that the job
>> finishes in time again. The targets that are excluded should not hurt
>> much, since e.g. all the code from i386-softmmu is covered again by
>> x86_64-softmmu.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  Not sure why the FreeBSD builds suddenly got slower and hit the 1h
>>  time limit now. Looking at https://cirrus-ci.com/github/qemu/qemu
>>  it seems like the FreeBSD jobs were already taking ca. 48 minutes
>>  since quite a while, but since the Meson build system has been merged,
>>  they now always hit the 1h limit. Could it be that Meson is slow on
>>  FreeBSD?
>>  
>>  I hope disabling some of the "redundant" targets is ok for everybody
>>  to get this working again. Alternatively, we could also introduce a
>>  second FreeBSD job and run half of the targets in one job, and half
>>  of the targets in the other job if that's preferred?
> 
> I'd probably suggest we go for two jobs, as there doesn't look like
> any constraint on running multiple jobs that we'll hit any time
> soon.

I gave it a try, but either I'm doing something wrong, or it is not
possible to run multiple FreeBSD tasks on cirrus-ci for one commit -
either the second task does not show up, or both FreeBSD tasks do not
show up here. I assume there are some limitations in place (see
https://cirrus-ci.org/faq/#are-there-any-limits), but it even does not
work for me when I limit the number of cpus in the tasks to a lower
value like 4 or 2.

Could somebody else please have a try? Maybe I'm just doing something
stupid here...

 Thomas


