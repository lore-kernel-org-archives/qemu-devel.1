Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0B2C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EEC020897
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhCLYCAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EEC020897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW2BR-0003FV-3C
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 14:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kW2AM-0001w9-Ba
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:51:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kW2AG-0003PT-I0
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603479105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hY/glQQa4W5Ct0mMD2m6fRv2JnpsEf0mMjyATkDzhGA=;
 b=ZhCLYCAIUrmO0HQH/FvHtDs3TACB+i/qOJNVFzMRa1rES0HUw1N0+yrnjxV7EI0reMgvLD
 9q+n0yJ5GgvRDZFU65BvTX/beoqt1pqKd36Op0uB4o5HPyORRZcoUEuGowIxzfZI1Xq1Fn
 QqZNnnOLb8uGiuYli+auFe/mb+YQSMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-i6bv6nr_PRCpEZRADZAaYQ-1; Fri, 23 Oct 2020 14:51:37 -0400
X-MC-Unique: i6bv6nr_PRCpEZRADZAaYQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5B2F10557CF;
 Fri, 23 Oct 2020 18:51:36 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-25.ams2.redhat.com [10.36.112.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EABA055760;
 Fri, 23 Oct 2020 18:51:34 +0000 (UTC)
Subject: Re: [PATCH] CHANGELOG: remove disused file
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201022162843.1841780-1-jsnow@redhat.com>
 <576a881d-2c64-3e40-31b7-43680a1988f8@redhat.com>
 <22839fc4-a1b9-0510-ff19-3a713fd8a187@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <88ac9998-51fb-0cca-8b7a-a2204ee0f9b2@redhat.com>
Date: Fri, 23 Oct 2020 20:51:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <22839fc4-a1b9-0510-ff19-3a713fd8a187@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/10/2020 18.34, John Snow wrote:
> On 10/23/20 1:43 AM, Thomas Huth wrote:
>> On 22/10/2020 18.28, John Snow wrote:
>>> There's no reason to keep this here; the versions described are
>>> ancient. Everything here is still mirrored on
>>> https://wiki.qemu.org/ChangeLog/old if anyone is curious; otherwise, use
>>> the git history.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>   Changelog | 580 ------------------------------------------------------
>>>   1 file changed, 580 deletions(-)
>>>   delete mode 100644 Changelog
>>>
>>> diff --git a/Changelog b/Changelog
>>> deleted file mode 100644
>>> index f7e178ccc01..00000000000
>>> --- a/Changelog
>>> +++ /dev/null
>>> @@ -1,580 +0,0 @@
>>> -This file documents changes for QEMU releases 0.12 and earlier.
>>> -For changelog information for later releases, see
>>> -https://wiki.qemu.org/ChangeLog or look at the git history for
>>> -more detailed information.
>>
>> I agree with removing the old log. But should we maybe leave a pointer to
>> https://wiki.qemu.org/ChangeLog / the git history here to let people know
>> how to see the changelogs?
>>
>>   Thomas
>>
> 
> Maybe in README.rst, just below "Bug Reporting" and above "Contact" ?
> 
> 
> Changelog
> =========
> 
> For version history and release notes, please visit
> `<https://wiki.qemu.org/ChangeLog/>`_ or look at the git history for more
> detailed information.

Ok, but IIRC the "ChangeLog" file is a standard file in GNU coding
conventions, so it might be worth to keep the information in this file ...
of course we are not bound to the GNU conventions in QEMU, but users still
might expect to find the information in here...

 Thomas


