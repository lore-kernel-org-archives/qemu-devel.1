Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8498EC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274D222286
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adHJf95e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274D222286
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGjvY-0006aG-86
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 10:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kGjuH-0005OJ-IO
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:20:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42413
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kGjuF-0002V6-W9
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599834002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=So/5nPBcdYC2mqLQktJKLnJwkts7IAXZqsuBz7gvOCE=;
 b=adHJf95eVaZzYpuXAYJ1ieG4uCz9OpQuPgW33adlPeWchZLmJx8oOZ4u91Tpz4LzNXZ8yg
 M4rNlnpUjmPZAcoTUHJg012gsQE6Ow2dKR7KD4oxOWAxxT0yrxrgIhx9RlPz9ozLPA/4fA
 7XDV8M03E3/+sav7Ag19uD1HZqXZ9aU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-fYKKNlOQNm-LyQQnZP9d8g-1; Fri, 11 Sep 2020 10:20:01 -0400
X-MC-Unique: fYKKNlOQNm-LyQQnZP9d8g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 328C3802B6D;
 Fri, 11 Sep 2020 14:20:00 +0000 (UTC)
Received: from [10.10.112.73] (ovpn-112-73.rdu2.redhat.com [10.10.112.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0C3D19C66;
 Fri, 11 Sep 2020 14:19:53 +0000 (UTC)
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <20200911104642.GE1203593@redhat.com>
 <6599e4a5-cccb-d0f5-9408-25d59359d76f@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ec8c0afc-6d88-e348-cb68-560d0236931b@redhat.com>
Date: Fri, 11 Sep 2020 10:19:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6599e4a5-cccb-d0f5-9408-25d59359d76f@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:28:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: stefanha@gmail.com, qemu-devel@nongnu.org, slp@redhat.com,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/20 7:28 AM, Paolo Bonzini wrote:
> On 11/09/20 12:46, Daniel P. Berrangé wrote:
>> Do we actually need/want it to be in the same monolithic repo
>> as qemu, as opposed to a qemu-qapi-rust repo ?
> 
> I think QAPI and qemu-ga should be separate repos altogether.  QAPI
> should be included as a submodule in both qemu and qemu-ga.  qemu-ga
> instead has absolutely no dependency on QEMU and viceversa, and is a
> prime candidate for removing all traces of the configure script and
> being a pure meson project.
> 
> Paolo
> 

I am still actively invested in moving ./scripts/qapi to ./python/qapi 
and turning it into its own installable module as I am doing with 
./python/qemu.

The benefit is that it could be used for the build system in other 
projects; or possibly new backend plugins can be developed and 
maintained separately for it.

(I am working on a JSON-SCHEMA backend.)

((Also, I want to enforce a single flake8/pylint/mypy regime for all of 
our critical Python code. Considered critical: testing infrastructure, 
anything used for the build process. This means everything in 
./python/qemu, the tracetool, and the QAPI parser.))

I have a 20-30 patch series doing the usual mypy/flake8/pylint thing to 
the QAPI parser and it will be able to stand alone in short time.

--js


