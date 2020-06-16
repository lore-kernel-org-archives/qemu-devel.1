Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE8FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F97A208B3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5MTGGAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F97A208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDVq-0006Xf-Ki
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jlDUP-00060n-Px
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:27:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47731
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jlDUP-0004nT-DB
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592321223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=lUycJwrQTtO3JewANEzSb6f8eyOr7JV8bK6SegtQ+KE=;
 b=C5MTGGAxU5aPSidWyDthVHWbZoXREwIfIL9DwbvA9gXTjeQL6lgjFS/Hck6n381DXKm04M
 JT21rvKNAxd+6UGR1qnLiBIzYcdGUQZePhwPCPSdyK4FpyrAb+jNb/LwIhWA5Fjk1EqFEd
 cdemCiLSYCL8Zw50q+IGBpiuv/rYSMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-SrVSpKJ5M5mJJ8bA1Pcv0Q-1; Tue, 16 Jun 2020 11:26:57 -0400
X-MC-Unique: SrVSpKJ5M5mJJ8bA1Pcv0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 276FD835BB8;
 Tue, 16 Jun 2020 15:26:56 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-128.ams2.redhat.com [10.36.114.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CC205D9D7;
 Tue, 16 Jun 2020 15:26:54 +0000 (UTC)
Subject: Re: [PULL 00/84] QOM patches for 2020-06-15
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20200615204008.3069956-1-armbru@redhat.com>
 <CAFEAcA8iy3qzzbcM_X_Xgzz+KOcZ+Nq4=3q=Lag6hpuwrBCb4Q@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e9febd4f-97ea-7832-fae1-14cbd7c9a73d@redhat.com>
Date: Tue, 16 Jun 2020 17:26:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8iy3qzzbcM_X_Xgzz+KOcZ+Nq4=3q=Lag6hpuwrBCb4Q@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:01:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/06/2020 14.26, Peter Maydell wrote:
> On Mon, 15 Jun 2020 at 21:43, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> The following changes since commit 7d3660e79830a069f1848bb4fa1cdf8f666424fb:
>>
>>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-06-12 23:06:22 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://repo.or.cz/qemu/armbru.git tags/pull-qom-2020-06-15
>>
>> for you to fetch changes up to b77b5b3dc7a4730d804090d359c57d33573cf85a:
>>
>>   MAINTAINERS: Make section QOM cover hw/core/*bus.c as well (2020-06-15 22:06:04 +0200)
>>
>> ----------------------------------------------------------------
>> QOM patches for 2020-06-15
>>
>> * Make "info qom-tree" show children sorted
>> * Fixes around device realization
>> * Rework how we plug into devices into their parent bus
> 
> 
> Applied, thanks.
> 
> Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
> for any user-visible changes.

This pull requests (with the patch "qdev: qdev_init_nofail() is now
unused, drop") apparently broke some iotests:

 https://gitlab.com/qemu-project/qemu/-/jobs/597414772#L4376

Can you please have a look?

 Thanks,
  Thomas


