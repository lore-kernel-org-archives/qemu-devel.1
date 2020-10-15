Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DC1C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:11:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF37D22249
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4umNwD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF37D22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSwTk-0004uE-H7
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 02:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSwSl-00045X-L7
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 02:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSwSi-0005Nq-Vt
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 02:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602742202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GrXhy9iOKe9qW7HK1kBLtY2hEw9tblpnacm34Qsg+GI=;
 b=b4umNwD0pRsRjlvJPD6nT0yU4Wx5lzruasSF/re0GzbWzH6PTddRQR1F6GzqNrdvbqLIpE
 Drso/Y8oiv7/QT7skPm9YA1ppVfQqgLy4Ur8kJ1xqG7nolCT+8gmXsRwBURUVtM2oh7mQU
 7x7PrWXXL8XHhrFbFxJqsd7txvFXXaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-UCiP1znXMv--gswo3TND1Q-1; Thu, 15 Oct 2020 02:09:58 -0400
X-MC-Unique: UCiP1znXMv--gswo3TND1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEEA8802B76;
 Thu, 15 Oct 2020 06:09:55 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-212.ams2.redhat.com [10.36.112.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC3ED76655;
 Thu, 15 Oct 2020 06:09:48 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] Jobs based on custom runners: add job definitions
 for QEMU's machines
To: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20201014052140.1146924-1-crosa@redhat.com>
 <20201014052140.1146924-5-crosa@redhat.com>
 <20201014174655.GW115189@redhat.com>
 <20201014211356.GA1199212@localhost.localdomain>
 <20201014232430.GB1203215@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f13ea3be-9b53-78e9-1660-18aa5b337a0a@redhat.com>
Date: Thu, 15 Oct 2020 08:09:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201014232430.GB1203215@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>, Willian Rampazzo <wrampazz@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/10/2020 01.24, Cleber Rosa wrote:
> On Wed, Oct 14, 2020 at 05:14:01PM -0400, Cleber Rosa wrote:
>> On Wed, Oct 14, 2020 at 06:46:55PM +0100, Daniel P. Berrangé wrote:
>>>
>>> This bug links to
>>>
>>>   https://bugs.launchpad.net/ubuntu/+source/libssh/+bug/1847514
>>>
>>> which is marked as fixed. So I'm thinking we can drop the --disable-libssh
>>> arg from all these jobs
>>>
>>
>> OK, I'll double check that and, if the fix is comfirmed beyond the bug
>> tracker, I'll update it.
>>
> 
> I was still able to reproduce the build failure with the latest packages.
> 
> The last update on the bug, is very misleading, but there's a hint of
> its outcome:
> 
> ---
> Martin Wimpress (flexiondotorg) on 2019-12-17
> tags:	added: rls-bb-notfixing
> tags:	removed: bionic
> no longer affects:	libssh (Ubuntu Bionic)
> ---
> 
> So, *notfixing* means it no longer affects that package on that
> distro? Right...
> 
> Anyway, keeping this AS IS.

I can confirm that the libssh bug is still there in Ubuntu 18.04 ... when I
was updating our .travis.yml some weeks ago to stop using Xenial, I also hit
the bug again on Bionic.

Maybe rather a question for Peter, but what about updating the runners to
20.04 (Focal) instead? The libssh bug is gone there.

 Thomas


