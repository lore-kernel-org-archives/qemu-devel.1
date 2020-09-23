Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4133C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C55120791
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gh7Irv2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C55120791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7un-0004se-Fa
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kL7t3-0003vR-W5
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:44:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52118
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kL7t1-0004NQ-Vt
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600879494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ro9vaC3ybk5v7z1l7JduSdhwAG6tigh9HuaODsMKltI=;
 b=Gh7Irv2G3V9FEDBa2q9Sz6L+xaSKyROYqpX9VjC+89ujpVOFpjDlReEjiKNTFfAiPH5dOA
 rLRwowt1vwkjWgvvxsgllhShqfIXgjYJ8R4lpgIwKqLtpOIq77TRhN8ynd0oLl+n/vKNUz
 uI/dHnfoiAT6GqyeMZB3ZIeNr+Wzsdk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-EIzkPQ5ANBKXLGV0jeKPxA-1; Wed, 23 Sep 2020 12:44:50 -0400
X-MC-Unique: EIzkPQ5ANBKXLGV0jeKPxA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CE2C801AFE;
 Wed, 23 Sep 2020 16:44:49 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-49.ams2.redhat.com [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5F1C9CBA;
 Wed, 23 Sep 2020 16:44:47 +0000 (UTC)
Subject: Re: [PATCH v2 7/7] configure: Bump the minimum required Python
 version to 3.6
To: luoyonggang@gmail.com
References: <CAFEAcA-P5gngMXmBUtOGNn=ZUN8C2dmC=5Phxs7C5fYV=Odhjw@mail.gmail.com>
 <20200923162908.95372-1-thuth@redhat.com>
 <CAE2XoE_BiPL7JH+Uz9VVRHKMiJEHjX7a+FCLv_TEDqa5srAaQA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0a08e595-4ec5-6667-4b38-9acea7874020@redhat.com>
Date: Wed, 23 Sep 2020 18:44:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_BiPL7JH+Uz9VVRHKMiJEHjX7a+FCLv_TEDqa5srAaQA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 11:18:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/09/2020 18.34, 罗勇刚(Yonggang Luo) wrote:
> Should we also warning it in meson.build, cause configure finally shoud
> be removed.

Sounds like a good idea for a separate patch (let's do one issue at a
time...).

 Thomas


