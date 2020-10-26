Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC7EC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C677122400
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdjvuX8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C677122400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX4nA-000809-Px
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 11:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kX4l5-0006LW-1f
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kX4l0-0003k9-DR
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603727400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JZqipi+3QTB2ZIHe5SXUNK4do8a3mH83/qWhcfH6N14=;
 b=KdjvuX8M5Ie1EHmseA68G0r2PoogfdBjAa5NsaxuLKORfcQedfnPg6hk64CDgmE+CJkBXo
 yTr0uoaxLCSnjMJMOph4RpzYJ3P8+jiZne2FtLiqApmrKlosFq3qPt5Fhvs4LfX2Ks9zG6
 XGhyZNPlrgVYiqSgW2WS0kWDr1oEzAQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-sKtVZGZWNU--q6Q_JFoujg-1; Mon, 26 Oct 2020 11:49:55 -0400
X-MC-Unique: sKtVZGZWNU--q6Q_JFoujg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD55D8064C1;
 Mon, 26 Oct 2020 15:49:54 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4EAE5B4A4;
 Mon, 26 Oct 2020 15:49:53 +0000 (UTC)
Subject: Re: [PATCH] CHANGELOG: remove disused file
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201022162843.1841780-1-jsnow@redhat.com>
 <576a881d-2c64-3e40-31b7-43680a1988f8@redhat.com>
 <22839fc4-a1b9-0510-ff19-3a713fd8a187@redhat.com>
 <88ac9998-51fb-0cca-8b7a-a2204ee0f9b2@redhat.com>
 <35df91c4-49e5-bc9e-e153-a27b7f443ffd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f3b1f8ce-367b-c740-ebcd-2bce425d8d81@redhat.com>
Date: Mon, 26 Oct 2020 16:49:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <35df91c4-49e5-bc9e-e153-a27b7f443ffd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/10/2020 16.21, John Snow wrote:
> On 10/23/20 2:51 PM, Thomas Huth wrote:
>> On 23/10/2020 18.34, John Snow wrote:
>>> On 10/23/20 1:43 AM, Thomas Huth wrote:
>>>> On 22/10/2020 18.28, John Snow wrote:
>>>>> There's no reason to keep this here; the versions described are
>>>>> ancient. Everything here is still mirrored on
>>>>> https://wiki.qemu.org/ChangeLog/old if anyone is curious; otherwise, use
>>>>> the git history.
>>>>>
>>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>>> ---
>>>>>    Changelog | 580 ------------------------------------------------------
>>>>>    1 file changed, 580 deletions(-)
>>>>>    delete mode 100644 Changelog
>>>>>
>>>>> diff --git a/Changelog b/Changelog
>>>>> deleted file mode 100644
>>>>> index f7e178ccc01..00000000000
>>>>> --- a/Changelog
>>>>> +++ /dev/null
>>>>> @@ -1,580 +0,0 @@
>>>>> -This file documents changes for QEMU releases 0.12 and earlier.
>>>>> -For changelog information for later releases, see
>>>>> -https://wiki.qemu.org/ChangeLog or look at the git history for
>>>>> -more detailed information.
>>>>
>>>> I agree with removing the old log. But should we maybe leave a pointer to
>>>> https://wiki.qemu.org/ChangeLog / the git history here to let people know
>>>> how to see the changelogs?
>>>>
>>>>    Thomas
>>>>
>>>
>>> Maybe in README.rst, just below "Bug Reporting" and above "Contact" ?
>>>
>>>
>>> Changelog
>>> =========
>>>
>>> For version history and release notes, please visit
>>> `<https://wiki.qemu.org/ChangeLog/>`_ or look at the git history for more
>>> detailed information.
>>
>> Ok, but IIRC the "ChangeLog" file is a standard file in GNU coding
>> conventions, so it might be worth to keep the information in this file ...
>> of course we are not bound to the GNU conventions in QEMU, but users still
>> might expect to find the information in here...
>>
>>   Thomas
>>
> 
> My point in removing it is just getting rid of the runaround. If we don't
> have the changelog information in CHANGELOG, why have the file and pretend
> like we do?
> 
> Moving it into README.rst makes it visible on github and gitlab to people
> stopping by for the first time.

Ok, fair point.

 Thomas


