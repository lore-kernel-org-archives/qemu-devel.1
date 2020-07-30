Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC87C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A2092082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqO2cnkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2092082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1BPq-0001HX-OJ
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 12:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k1BMb-0007ot-2N
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:25:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25078
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k1BMW-0002Mp-2w
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596126295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H0GGEhLjZ8fCuLFFdOUQsD1fD/rgaaDqh8AO2iYLwUU=;
 b=HqO2cnkzkmcHFQq8N3+4xm3H7V8qmQrqZg74hPOPmsdKyCnUZZ3wvzXN+2suIM8ov4YFPT
 6Aoskbo+ns6aIZnZemYzQ/Hq4+olLDpG129zGzsY3MYWlFLixKsG+w+1/EGc9Sb69GDQzL
 40Noc13BsNs5yWcuMTCNPQsIjw8kB1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-RiJsT7_gMyqx5I2rBMsEYg-1; Thu, 30 Jul 2020 12:24:53 -0400
X-MC-Unique: RiJsT7_gMyqx5I2rBMsEYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31B89107ACCA;
 Thu, 30 Jul 2020 16:24:52 +0000 (UTC)
Received: from [10.3.114.255] (ovpn-114-255.phx2.redhat.com [10.3.114.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C43D76111F;
 Thu, 30 Jul 2020 16:24:51 +0000 (UTC)
Subject: Re: [PATCH] osdep.h: Add doc comment for qemu_get_thread_id()
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200716154114.10838-1-peter.maydell@linaro.org>
 <0f8b8fea-2bd0-7616-292b-8fb0f87cec75@redhat.com>
 <CAFEAcA9ukzKGiaV6Tazu8Aezn39v81DKQik1b=jEy=NLnau05w@mail.gmail.com>
 <87k0ylvy0t.fsf@dusky.pond.sub.org>
 <CAFEAcA-AYJ64HE698TMRS6cV=u4ig6S6TU2xufns7fCVbcQXrg@mail.gmail.com>
 <20200730155939.GP3477223@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4d2cba04-04d8-9b82-562f-acb84b6010d2@redhat.com>
Date: Thu, 30 Jul 2020 11:24:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730155939.GP3477223@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:41:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/20 10:59 AM, Daniel P. Berrangé wrote:

>> Well, I suspect that management-layer code currently has
>> gone for "assume we're always running on Linux" and was
>> written by people who knew they were getting a Linux tid...
> 
> Yes, on the libvirt side, the functionality that relies on thread_is is
> only compiled on Linux. If someone wants to use it on other OS, they'll
> have to provide an impl using their platforms equivalent of
> sched_setaffinity and friends since none of this stuff is standardized
> across OS.
> 
> 
>>> The PID is quite unlikely to be "an OS-specific identifier of the
>>> current thread".  Shouldn't we fail instead of lie when we don't know
>>> how to compute the truth?
>>
>> Yeah, I think the default codepath is pretty bogus too. Should
>> the QMP functions have a mechanism for saying "we don't know
>> a thread-id on this platform" ?
> 
> Thread_id should be optional and thus not filled in if we
> can't provide a sensible value. Unfortunately we made it
> mandatory in QMP.

Normally, converting a mandatory output value to optional is a 
back-compatibility risk (we could break apps that depended on it being 
present).  But if the only apps that depended on it being present are 
compiled on Linux, where the member will actually be present, I think 
that changing the schema to make it optional for non-Linux platforms 
won't be a back-compatibility nightmare (but we will have to be careful 
in our documentation).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


