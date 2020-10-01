Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BED6C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E44720897
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OX4DA2M4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E44720897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0FN-00020W-67
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kO08h-0001fs-F3
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kO08e-0005fv-Bu
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601564695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SCQUZl2S+lveCaCCrAob2GlsoNWmoFSFf02KJUGAzHE=;
 b=OX4DA2M4VqNnYVQkl1he+d0gb8jTHRqn1VCf8QqqANd6XsLYns6RXwhOpQiL2y1buXry1c
 Iqjga40Bol06tLwxE2zIGqfgp3BCXBY4NAVgOASzB8kAKubmpEhbPTPPsspLGpVvoc/aCC
 MTHNkcDY3rU0obq0k4v82ojigcSd48k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-fIfPxOCZPnmsQXivF31mgQ-1; Thu, 01 Oct 2020 11:04:53 -0400
X-MC-Unique: fIfPxOCZPnmsQXivF31mgQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B95A78030CD;
 Thu,  1 Oct 2020 15:04:52 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-107.ams2.redhat.com [10.36.112.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1915119C78;
 Thu,  1 Oct 2020 15:04:50 +0000 (UTC)
Subject: Re: Use of "?" for help has been deprecated for 8 years, can we drop
 it?
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
References: <87k0wa1bf8.fsf@dusky.pond.sub.org>
 <54b77382-78c8-e6bf-45d4-616595baa87f@redhat.com>
 <20201001131714.GC6673@linux.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a6c8482f-df8b-cb86-5aee-2601acdb875f@redhat.com>
Date: Thu, 1 Oct 2020 17:04:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201001131714.GC6673@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/10/2020 15.17, Kevin Wolf wrote:
> Am 01.10.2020 um 15:06 hat Eric Blake geschrieben:
>> On 10/1/20 5:35 AM, Markus Armbruster wrote:
>>> We deprecated "?" more than eight years ago.  We didn't have a
>>> deprecation process back then, but we did purge "?" from the
>>> documentation and from help texts.  Can we finally drop it?
>>>
>>> I'm asking because there is a patch on the list that bypasses
>>> is_help_option() to not add deprecated "?" to a new place: "[PATCH v2
>>> 1/4] keyval: Parse help options".
>>>
>>
>> Did we ever issue a warning when it was used?  It's easier to argue that
>> it can be dropped if users had notice of some form or another.  That
>> said, I'm not heartbroken if we yank it immediately instead of letting
>> it live for 2 more releases.
> 
> A deprecation warning for a help option would somehow feel strange.
> 
> I would consider this a human-only interface that can be changed at
> will, like HMP syntax.

I'm not so sure ... for example we use "-device help" in the qemu-iotest
scripts, so other people out there might use "-device ?" in their
scripts, too, to check for the availability of devices... so IMHO we
should follow the deprecation process properly here.

 Thomas


