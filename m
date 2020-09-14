Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B431AC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 05:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B8E214F1
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 05:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0SK6LSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B8E214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHhBF-0003wO-R3
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 01:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kHhAa-0003EE-Af
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 01:36:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26266
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kHhAX-0007Ru-CT
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 01:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600061807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hVDco7s3DT5FrUhr7u6KQzF8Go9IADGfWCrpwsrGuvk=;
 b=U0SK6LSwwzRF73mZvn9DESx+YjfM8SdNbCGCCe8nLZ/S6lqw0IbUJ5szpFwjPoZsYg029V
 tmYZesXNubQxDZjKK4tWyPXrjWjcp2VRvbMpVUrilu14XVLfeuQ4Lot0tbPdvctF31NyjC
 7WPuKbuySd7CkP7xRPIIF6AASZWaFw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-g0TuM7P-N2aeJZMcc3SFQw-1; Mon, 14 Sep 2020 01:36:45 -0400
X-MC-Unique: g0TuM7P-N2aeJZMcc3SFQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 795B78015A4;
 Mon, 14 Sep 2020 05:36:44 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-134.ams2.redhat.com [10.36.112.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A4A55C699;
 Mon, 14 Sep 2020 05:36:43 +0000 (UTC)
Subject: Re: [PULL v2] Block layer patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200908115322.325832-1-kwolf@redhat.com>
 <CAFEAcA-wrgOC9oqdqBuVSTiidaRcwbgQWF08zD=TSetSwn_tjA@mail.gmail.com>
 <480db253-9aa4-39c3-592f-bc5cfea1997b@redhat.com>
 <06214b2c-adc7-1e3b-a15f-fe3c16ff0983@redhat.com>
 <CAFEAcA99YnJ2nC-Cw6JaYJMSMmvy-idC+625KYfOVUx_wb60=A@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1d97b582-a530-ac54-5afc-5f4c1e6fa547@redhat.com>
Date: Mon, 14 Sep 2020 07:36:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA99YnJ2nC-Cw6JaYJMSMmvy-idC+625KYfOVUx_wb60=A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:36:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/09/2020 20.38, Peter Maydell wrote:
> On Sat, 12 Sep 2020 at 13:27, Thomas Huth <thuth@redhat.com> wrote:
>> Peter, why did this slip through your merge tests, do you still skip the
>> iotests there?
> 
> I forget what the reason for them being skipped is, maybe
> it's because they demand a gnu sed ?

The tests/check-block.sh script should tell you when you run "make
check-block" ... but yes, they need gnu sed - which should be available
via homebrew.

 Thomas


