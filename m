Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABC0C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:14:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404E42078E
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JccRWFKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404E42078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDTX5-0004Ok-G7
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 10:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDTWY-0003qT-NC
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:14:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36762
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDTWW-00085K-Vc
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599056043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rLcRj5GVgbYgirzcCKhv+eB26j3DMeLL0oerG8HpKlU=;
 b=JccRWFKMcBDS/l65tXxyJ8AKMXBLzALbX6MiM5cK15ukLuwDjovw/cN6VPRwAjVd9+p1sj
 AxGkDpxfD5ezlWNsLY2su39iFYKqBmw8Mql+ndQ9epM3GjQxma8Sp5CmtrjrKuAyPqrK/q
 yyt4KzNnYEwCY5aY5BkUvvL2RIkATjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-d7onVGS_P_WBQQSPoa1dEw-1; Wed, 02 Sep 2020 10:14:01 -0400
X-MC-Unique: d7onVGS_P_WBQQSPoa1dEw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 856C2800C78;
 Wed,  2 Sep 2020 14:14:00 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-129.ams2.redhat.com [10.36.112.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4948D19D7C;
 Wed,  2 Sep 2020 14:13:59 +0000 (UTC)
Subject: Re: [PULL 0/8] Cirrus-CI improvements, and other CI-related fixes,
 m68k
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200901152050.255165-1-thuth@redhat.com>
 <CAFEAcA-RpQHgafHGvgBE_w2xZjJ4abWKNWXO3VO9yXwD5V=vNA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9844626b-84c8-5d6e-4611-63a3f76b11ea@redhat.com>
Date: Wed, 2 Sep 2020 16:13:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-RpQHgafHGvgBE_w2xZjJ4abWKNWXO3VO9yXwD5V=vNA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:33:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Ed Maste <emaste@freebsd.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/2020 14.56, Peter Maydell wrote:
> On Tue, 1 Sep 2020 at 16:21, Thomas Huth <thuth@redhat.com> wrote:
>>
>>  Hi Peter,
>>
>> the following changes since commit 2f4c51c0f384d7888a04b4815861e6d5fd244d75:
>>
>>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200831-pull-request' into staging (2020-08-31 19:39:13 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-09-01
>>
>> for you to fetch changes up to df496fb0532758cffb5ad4075b4e60a43c723492:
>>
>>   hw/m68k: QOMify the mcf5206 system integration module (2020-09-01 17:09:17 +0200)
>>
>> ----------------------------------------------------------------
>> - Cirrus-CI improvements and fixes (compile with -Werror & fix for 1h problem)
>> - Two build system fixes to fix some failures the CI
>> - One m68k QOMification patch
>> ----------------------------------------------------------------
> 
> Hi -- this has a conflict in pc-bios/keymaps/meson.build (probably
> a clash with Paolo's series I just merged). Could you rebase and
> resend, please?

Sure, will do.

 Thomas


