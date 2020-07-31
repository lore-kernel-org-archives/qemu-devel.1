Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CBFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 13:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058A6208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 13:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y19BiLWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058A6208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1VNq-0004lL-9M
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 09:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k1VNB-0004D5-BG
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 09:46:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47511
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k1VN8-0002Es-7f
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 09:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596203212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FKGR5FsMX/sDWugDb5Atfb1RE5Cjh67rKMOizGy++SM=;
 b=Y19BiLWuSjMhJoczXz5GMyYF/s0+kcEm8IyCUQ0ANDSkaWUOKy0wR7AqVFrpDMTNcOjaWG
 yus+/XLL0KrNunIqMDoJCyMRRDTGC4tTY4gYW/CdqxOwVe6Krsrq7pNnnK4+jElOI8poeC
 JvtBt9akTxAYkH0BK3xFIC9trnhKMRw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-tAIlcM1RPQe2E2q5tU0PEQ-1; Fri, 31 Jul 2020 09:46:48 -0400
X-MC-Unique: tAIlcM1RPQe2E2q5tU0PEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CD4B800470;
 Fri, 31 Jul 2020 13:46:47 +0000 (UTC)
Received: from [10.3.113.226] (ovpn-113-226.phx2.redhat.com [10.3.113.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA8A074F4A;
 Fri, 31 Jul 2020 13:46:46 +0000 (UTC)
Subject: Re: [PATCH] osdep.h: Add doc comment for qemu_get_thread_id()
To: Markus Armbruster <armbru@redhat.com>
References: <20200716154114.10838-1-peter.maydell@linaro.org>
 <0f8b8fea-2bd0-7616-292b-8fb0f87cec75@redhat.com>
 <CAFEAcA9ukzKGiaV6Tazu8Aezn39v81DKQik1b=jEy=NLnau05w@mail.gmail.com>
 <87k0ylvy0t.fsf@dusky.pond.sub.org>
 <CAFEAcA-AYJ64HE698TMRS6cV=u4ig6S6TU2xufns7fCVbcQXrg@mail.gmail.com>
 <20200730155939.GP3477223@redhat.com>
 <4d2cba04-04d8-9b82-562f-acb84b6010d2@redhat.com>
 <87pn8ct9ga.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <53b70f7f-1777-64e5-d80f-6af3d6c1252d@redhat.com>
Date: Fri, 31 Jul 2020 08:46:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87pn8ct9ga.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 08:55:49
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
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/20 2:44 AM, Markus Armbruster wrote:

>>> Thread_id should be optional and thus not filled in if we
>>> can't provide a sensible value. Unfortunately we made it
>>> mandatory in QMP.
>>
>> Normally, converting a mandatory output value to optional is a
>> back-compatibility risk (we could break apps that depended on it being
>> present).  But if the only apps that depended on it being present are
>> compiled on Linux, where the member will actually be present, I think
>> that changing the schema to make it optional for non-Linux platforms
>> won't be a back-compatibility nightmare (but we will have to be
>> careful in our documentation).
> 
> Options for systems where don't know how to compute a system-wide thread
> ID:
> 
> 0. Return a bogus value: the PID.  This is the status quo.
> 
> 1. Return a more obviously bogus value: -1.  Semantic compatibility
>     break.  Should be harmless, because a QMP client relying on the
>     thread-id being the PID would be insane.
> 
> 2. Make thread-id optional, present iff we can compute a value.
> 
>     This is what we should have done, but we didn't, and now it's a
>     syntactic compatibility break.  Matters only if it actually breaks
>     QMP clients.  We believe the one we know shouldn't break.
> 
> Preferences?

I'm in favor of 2, but can easily live with 1 if we decide to be that 
much more conservative.  Tooling that can't handle a missing value is 
not going to fare any better with a value that is unusable because it is 
-1, but the important point is that I don't think we have a scenario 
with such tooling depending on the value (the tools that DO depend on 
the value are built on platforms where the value is usable).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


