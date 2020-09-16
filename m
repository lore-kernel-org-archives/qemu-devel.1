Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4BCC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:48:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A847B20771
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iy+NPawT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A847B20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIREr-0008Vm-PF
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 02:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIREG-0007xT-Gj
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:47:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIREE-0001eH-CU
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600238860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ygxeKLcRZsUzt4rH0KKZhESbevDvXYyFlvB5kq6/HzA=;
 b=Iy+NPawT2vQsPHYOC75juyUxiILtjyRXkVo060+hFUi1ZQXZBxDvJIl6FzQtVKiNNon49j
 U+LJidiy+tFwlFCsfJuWdHRPlGYxs86Sk7QXIO2Yvz6ezvoNxmI0CG4yoa6xztiouVzF/9
 8dBvFmOsyO5FcZ3Ky+aAUm6E0x9JMho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-zBbbNyZdMWy46yk1N3uGsQ-1; Wed, 16 Sep 2020 02:47:39 -0400
X-MC-Unique: zBbbNyZdMWy46yk1N3uGsQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B353580732A;
 Wed, 16 Sep 2020 06:47:37 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-19.ams2.redhat.com [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4AC0A1002393;
 Wed, 16 Sep 2020 06:47:32 +0000 (UTC)
Subject: Re: [PATCH] guest agent: Fixes for windows guest agent building on
 msys2/mingw
To: luoyonggang@gmail.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>
References: <20200915163343.1100-1-luoyonggang@gmail.com>
 <06c76888-b2c1-866f-f6f5-78ee9a2bac0c@redhat.com>
 <CAE2XoE8OmSSnzzUivS0jNQu=QEe8c_gPasfksoihdYhO6f4CYg@mail.gmail.com>
 <ba164474-7cb0-1f8f-ef01-2529954a1df9@amsat.org>
 <CAE2XoE_N=XWeg1y74=ohb_p5qiH+rewDtwSGfSwkhHJpA2V06A@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b3c62fe6-6233-c7d0-e120-074ac976ceb4@redhat.com>
Date: Wed, 16 Sep 2020 08:47:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_N=XWeg1y74=ohb_p5qiH+rewDtwSGfSwkhHJpA2V06A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/09/2020 21.17, 罗勇刚(Yonggang Luo) wrote:

> I agree with that, seems QEMU currently are calling ANSI api all the
> time, better not change that,
>  so globally define -DUNICODE -D_UNICODE is not a option

I agree, -DUNICODE is currently not an option. I'll go with my patch
("qga/commands-win32: Fix problem with redundant protype declaration")
for the time being, until someone found a nicer solution that works.

 Thomas


