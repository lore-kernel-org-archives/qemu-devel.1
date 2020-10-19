Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD69C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B342225A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ihof0CDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B342225A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUQa6-00025Q-73
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 04:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUQYQ-00015c-OC
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 04:30:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUQYM-0004fl-GO
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 04:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603096199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hsc3fFHAR3r6TZ6h0ZE8QOMSPDwdyYyBTeCZV2JmWSU=;
 b=Ihof0CDEiT6hDDlRMqLtYeMyj/3YjIg22qAoezh9+g+oAv2Tf0FLk/MQrdYEE+JNz7nTlK
 GCrk/FBB+QgpJ9NGJuCrMEvxQ+1v33Ym84gaS0ybpgbZZd4FZ8rwuZH7zUxoIk7xjiMB3D
 hHv4SOJhxzsqT4bLyGKPKKHWOoAvOeE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-rR_Sil-wNbCMckA5GZhIcQ-1; Mon, 19 Oct 2020 04:29:56 -0400
X-MC-Unique: rR_Sil-wNbCMckA5GZhIcQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51C20393BA;
 Mon, 19 Oct 2020 08:29:55 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-6.ams2.redhat.com [10.36.114.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 518CF75132;
 Mon, 19 Oct 2020 08:29:54 +0000 (UTC)
Subject: Re: [PATCH v2 0/9] iOS and Apple Silicon host support
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20201019013928.72770-1-j@getutm.app>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e96f95a1-70ae-b64f-3208-6cdbdef46ec5@redhat.com>
Date: Mon, 19 Oct 2020 10:29:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201019013928.72770-1-j@getutm.app>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/10/2020 03.39, Joelle van Dyne wrote:
> These set of changes brings QEMU TCG to iOS devices and future Apple Silicon
> devices. They were originally developed last year and have been working in the
> UTM app. Recently, we ported the changes to master, re-wrote a lot of the build
> script changes for meson, and broke up the patches into more distinct units.
> 
> A summary of the changes:
> 
> * `CONFIG_IOS` and `CONFIG_IOS_JIT` defined when building for iOS and
>   iOS specific changes (as well as unsupported code) are gated behind it.
> * A new dependency, libucontext is added since iOS does not have native ucontext
>   and broken support for sigaltstack. libucontext is available as a new option
>   for coroutine backend.
> * On stock iOS devices, there is a workaround for running JIT code without
>   any special entitlement. It requires the JIT region to be mirror mapped with
>   one region RW and another one RX. To support this style of JIT, TCG is changed
>   to support writing to a different code_ptr. These changes are gated by the
>   `CONFIG_IOS_JIT`.
> * For (recent) jailbroken iOS devices as well as upcoming Apple Silicon devices,
>   there are new rules for applications supporting JIT (with the proper
>   entitlement). These rules are implemented as well.
> 
> Since v2:
> 
> * Changed getting mirror pointer from a macro to inline functions
> * Split constification of TCG code pointers to separate patch
> * Removed slirp updates (will send future patch once slirp changes are in)
> * Removed shared library patch (will send future patch)
> 
> -j
> 
> osy (9):
>   configure: option to disable host block devices
>   configure: cross-compiling without cross_prefix
>   qemu: add support for iOS host
>   coroutine: add libucontext as external library
>   tcg: add const hints for code pointers
>   tcg: implement mirror mapped JIT for iOS
>   tcg: mirror mapping RWX pages for iOS optional
>   tcg: support JIT on Apple Silicon
>   block: check availablity for preadv/pwritev on mac

Is there maybe also a way to compile-test this automatically in a macOS
container on Cirrus-CI or Travis, too? ... otherwise I'm a little bit afraid
that this support might bit-rot quite fast again, since most developers
don't have the corresponding setup...

 Thomas


