Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E199DC388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532B424182
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUFTli5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532B424182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVb5C-0005i6-Bq
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 09:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVb2F-0001XK-K4
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 09:53:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVb2C-0007OS-H4
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 09:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603374819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oy0smOPzsRvxIKHhTNVRMswqzgzqCJp7ERjXBEuilwo=;
 b=iUFTli5oGV2yN60oBwk5cV+yZu88TOQeJGWy3zGp4NO+hn+HE3gvT1E0psbeHOQNQMYc0U
 V5odeKIP9M4CPyNVAmNQX4q3ZraRm4zCVHOJfRaypDlU74bsejoJcL+ydJ8JYzgbKwPZqM
 u+F7GCP+TjW5G6eeteJzMq7WkBEW558=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-2FrYtvo4PIWqo8b6tU1pYg-1; Thu, 22 Oct 2020 09:53:37 -0400
X-MC-Unique: 2FrYtvo4PIWqo8b6tU1pYg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 452CD1009E32;
 Thu, 22 Oct 2020 13:53:36 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-115-72.ams2.redhat.com [10.36.115.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B4E05B4B1;
 Thu, 22 Oct 2020 13:53:31 +0000 (UTC)
Subject: Re: [PATCH] tests/acceptance: Enable AVOCADO_ALLOW_UNTRUSTED_CODE in
 the gitlab-CI
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201022120145.207094-1-thuth@redhat.com>
Message-ID: <2ffb46ea-9949-b79e-2fcc-c0eaf712868a@redhat.com>
Date: Thu, 22 Oct 2020 15:53:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201022120145.207094-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:09:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/10/2020 14.01, Thomas Huth wrote:
> The tests are running in containers here, so it should be OK to
> run with AVOCADO_ALLOW_UNTRUSTED_CODE enabled in this case.
> We also have to set CONTINUOUS_INTEGRATION in this case to avoid that
> some tests from ppc_prep_40p.py are failing in the CI.

Please disregard this patch ... CONTINUOUS_INTEGRATION also disables a test
that has been working in the CI before ... so this should be handled
differently.

 Thomas


