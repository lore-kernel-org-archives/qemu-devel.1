Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02B2C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 06:25:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE6F2076B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 06:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcJaiDv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE6F2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQPN8-0006eV-OU
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 02:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kQPLM-0005f1-22
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 02:24:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kQPLF-0006AO-S4
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 02:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602138232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1x1IevKNGxdaE3Ghq7QXMVnbRGazny19seJ3MxyjZkY=;
 b=LcJaiDv+jbyXHtTlqJakyFGFud2IkhZQRZym6WwELiRHzUfP7wyEJFu4a4rMi96TDnrubn
 NiSvuYFyUW3GvfjHedr0iPEQMsC4/GszNQWezHjnSMpyuXG+NTUpVpwxn4/iAnQbtt6AKm
 AFOVLrq1DqbuUembGcn6GV1c04wcaGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-3B1fqYa6MWSjoIyU-5lgbA-1; Thu, 08 Oct 2020 02:23:50 -0400
X-MC-Unique: 3B1fqYa6MWSjoIyU-5lgbA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0DC318A076B;
 Thu,  8 Oct 2020 06:23:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-40.ams2.redhat.com [10.36.113.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3D969F63;
 Thu,  8 Oct 2020 06:23:44 +0000 (UTC)
Subject: Re: [PATCH v10] scripts: Convert qemu-version.sh to qemu-version.py
To: luoyonggang@gmail.com, Paolo Bonzini <pbonzini@redhat.com>
References: <20201007195934.297-1-luoyonggang@gmail.com>
 <CABgObfboc5-01TVBgLw-u8eKzR2QJkRYA5cTQ0wpx4SD2D92yw@mail.gmail.com>
 <CAE2XoE8JV0G=3yK3HzMuXb19925p1J76rm2rVQH-OMhniPS8-g@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3c8e44c9-d302-1869-258c-65fa77ecbbb4@redhat.com>
Date: Thu, 8 Oct 2020 08:23:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE8JV0G=3yK3HzMuXb19925p1J76rm2rVQH-OMhniPS8-g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/10/2020 23.51, 罗勇刚(Yonggang Luo) wrote:
> 
> On Thu, Oct 8, 2020 at 4:31 AM Paolo Bonzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>> wrote:
>>
>> You won't hear no for an answer, right?...
> I am trying to figure out the real issue, it's the issue of git,
> https://github.com/msys2/MSYS2-packages/issues/2176
Can you at least please stop crap-flooding the QEMU mailing list with
multiple versions of your patches each day? We are all busy, so nobody is
going to review 5 or more iterations of your patches each day. Work on your
patches first, make sure that they are working, and only if you think that
they are really, really good, then send them to the list. Thanks.

 Thomas


