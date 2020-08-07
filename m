Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFCEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D2A2177B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNYP5942"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D2A2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3yLw-000537-81
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3yLF-0004Hr-6D
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:07:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57911
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3yLD-0008V7-Hb
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596791226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=MJF1DRTNwQGdYwN5rom/iUICBhK7XCpetir6Yr9WmCo=;
 b=jNYP59422VJpuZiTLzVewiGMnsM3Qs6UU3LQoNJMV76E9j/Ioyo3hmFAenE1BpGszaeH6w
 2v8QCDWiM3tCt/8AnsIa+izaei11+t1atr819yu1kjxK1jZ0yAKBFYicS8b9QzNjE7aRxN
 +sGdIn3khbRVCvS73xqGC5tlKfXcHCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-X6fMbDMWP86X96GPoKSZTg-1; Fri, 07 Aug 2020 05:07:05 -0400
X-MC-Unique: X6fMbDMWP86X96GPoKSZTg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1E4919057A7;
 Fri,  7 Aug 2020 09:07:03 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-31.ams2.redhat.com [10.36.113.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C65B32DE79;
 Fri,  7 Aug 2020 09:06:57 +0000 (UTC)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA-d0F9y2OSX5D7GrzUYU7yf4nAhHabE1dUVii3LRrueLQ@mail.gmail.com>
 <dc73a810-ee9e-711e-dad0-76a566b923e4@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8dedfe22-8659-5684-99a6-e9d503a5b3e2@redhat.com>
Date: Fri, 7 Aug 2020 11:06:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <dc73a810-ee9e-711e-dad0-76a566b923e4@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:21:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/2020 11.02, Paolo Bonzini wrote:
> On 07/08/20 10:49, Peter Maydell wrote:
>>> This the more or less final version of the Meson conversion.  Due to
>>> the sheer size of the series you have been CCed only on the cover
>>> letter.
>>
>> Does this work with actually-released versions of Meson yet?
>> I am still not very enthusiastic about the prospect of having
>> to carry around an entire build system in a submodule. That
>> still seems to me to be living closer to the bleeding edge
>> than I would like...
> 
> Yes it works with 0.55.0, with only a few warnings about possible future
> incompatibility.  Those will be fixed in 0.56.0, where the feature was
> stabilized without introducing any incompatibility.
> 
> Carrying around Meson in a submodule was mostly done to let QEMU build
> transparently on older distros.  Removing it is easy (though it would
> involve modifying the docker files to install the latest meson, so
> whatever you throw out of the door comes back through the window).

From my point of view, we should keep the meson submodule at least 'till
spring next year - then we'll remove support for RHEL7 according to our
support policy. Hopefully the other distros will have a recent version
of Meson at that point in time.

 Thomas


