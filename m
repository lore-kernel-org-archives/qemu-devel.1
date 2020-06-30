Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC71C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 05:11:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 498FD20720
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 05:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTJsRShG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498FD20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq8Yd-0001UN-Jc
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 01:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jq8Xz-000151-Kg
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 01:11:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37465
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jq8Xx-0001cR-8a
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 01:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593493863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R3VAJZf12THaUJQL5rMZNLXGkDtJhvbNsNbvlpuReTw=;
 b=QTJsRShGykYhyGOph7LzGBlyGtuyEfes7Qfaucar+Oon8xZ+cRn4/MCG+4LdOsJPzmncLg
 pilcY/g3P+nLIJPvSBjFp7T1/IWEDzo1lpVYWz638ynDGhbC2HOf85CwiM6QOMkgT+Af//
 DgbZlkvkAB47GJp7CjQw+HDbIbQ6NgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-olP40-u3P5KAWOmhtWLatA-1; Tue, 30 Jun 2020 01:11:01 -0400
X-MC-Unique: olP40-u3P5KAWOmhtWLatA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2463A8031F6;
 Tue, 30 Jun 2020 05:11:00 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-46.ams2.redhat.com [10.36.112.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C043310013D7;
 Tue, 30 Jun 2020 05:10:58 +0000 (UTC)
Subject: Re: Building in Solaris 11.4
To: Michele Denber <mdenber@gmx.com>, qemu-devel@nongnu.org
References: <5EF3C648.4060506@gmx.com> <5EF772B6.2010901@gmx.com>
 <fcdd4b6c-eec5-2bfd-1004-8ac86e80bf0e@redhat.com> <5EFA4E46.3090101@gmx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ee1672f3-d42f-c9c7-5648-3e4a036b4da8@redhat.com>
Date: Tue, 30 Jun 2020 07:10:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5EFA4E46.3090101@gmx.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 01:11:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Peter Tribble <peter.tribble@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/06/2020 22.25, Michele Denber wrote:
> On 06-29-2020 8:12 AM, Thomas Huth wrote:
>> ...
>> It's not the same bug as last year, but a new one: Seems like newer 
>> versions of Solaris now have this functions in their libraries!
> Yes - I just checked. Solaris 10 does not have openpty, but Solaris 11.4 
> indeed does have it
>> So what you want is something like this (completely untested):
> 
> So just to make sure I have this right - I save that code into a patch 
> file and then apply it where?  At the qemu-5.0.0 level?

Yes. I used the current git master branch, but I assume that it will 
also still apply to the 5.0 release.

>  Then run  configure again?

Yes. Please let me know if it works, then I can try to get the patch 
submitted.

  HTH,
   Thomas


