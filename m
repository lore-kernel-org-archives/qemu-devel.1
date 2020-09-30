Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DC4C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C360B206A1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UP4shsW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C360B206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZpy-0004G9-S4
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kNZlD-0006wm-Iy
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kNZlB-0000wQ-57
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601463296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyUew8VnIm0OjCVp89pbIXyGS2wB0QeTHlXADfEryHo=;
 b=UP4shsW8eRUhbNqoFjl8QFvMQhT+teRSxL8qcxszotIWgAwAdcjgP5ej4EKOoWddjO8PMp
 4N0lsEdJprqZ6qUod/moAZbjmFvNe1p/to1/4CeKpJCcjNv5/8BboFHeec3GdvhqgBES5P
 YiKVY9fWW8ZHz3aggSGzU5EFPogjTDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-BsXwBAazNOmmjW9eLgnmvw-1; Wed, 30 Sep 2020 06:54:53 -0400
X-MC-Unique: BsXwBAazNOmmjW9eLgnmvw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDDD5425D0;
 Wed, 30 Sep 2020 10:54:52 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-148.ams2.redhat.com [10.36.112.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED58B73664;
 Wed, 30 Sep 2020 10:54:51 +0000 (UTC)
Subject: Re: [PATCH v1 03/15] meson: move libmpathpersist test
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200925154027.12672-1-alex.bennee@linaro.org>
 <20200925154027.12672-4-alex.bennee@linaro.org>
 <f5fc27fa-0c02-b1a9-7f29-dd48aa40fd6a@redhat.com> <87ft70pgpq.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0e0ebdd5-d9b9-17dd-82c9-2c63a73f4eea@redhat.com>
Date: Wed, 30 Sep 2020 12:54:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87ft70pgpq.fsf@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/09/2020 12.51, Alex Bennée wrote:
> 
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 25/09/20 17:40, Alex Bennée wrote:
>>> From: Paolo Bonzini <pbonzini@redhat.com>
>>>
>>> This is the first compiler/linker test that has been moved to Meson.
>>> Add more section headings to keep things clearer.
>>>
>>> [thuth: Add check for mpathpersist.found() before showing mpathpersist_new_api]
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> Message-Id: <20200918103430.297167-3-thuth@redhat.com>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> <snip>
>>
>> This is not the latest version of the series, can you drop patches 2
>> and 3?
> 
> Hmm so now I'm seeing failures in the bionic builds thanks to libmpath:

Paolo's PR with the fix is still not merged yet (see "[PULL v7 00/87]
Misc patches for 2020-09-24") ... but maybe you could pick the newer
version of the libmpath patches from his PR into your queue?

 Thomas


