Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CADC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 07:31:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71D1A2074A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 07:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfWY+MEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D1A2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBCNv-00067d-NS
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 03:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBCKf-0002wq-Hl
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 03:28:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52283
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBCKd-0005yz-HT
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 03:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598513301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48jwv14oLUcp0rGWfpHwgrNhFULIl8PW/W0vrMH3Dt8=;
 b=PfWY+MENLpztoUjsjN/f07qIAbTHtd2eYp0k3U7RMUAL4sWn6CzZMYbmd8+bD8pAHac6ZW
 i8VWug1DJJzXT/eqE70PEN/Na7BH8aI6E3LEXyaOnQDse7o0sNfXrWWxgT0QuFYBovrcXy
 g/P7SQdxXXxgfMcW8cUeh5U4WC1/xR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-mj2fXgCqNzGOopVj5Tncxg-1; Thu, 27 Aug 2020 03:28:18 -0400
X-MC-Unique: mj2fXgCqNzGOopVj5Tncxg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4587785C70A;
 Thu, 27 Aug 2020 07:28:17 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D9D65D9E8;
 Thu, 27 Aug 2020 07:28:16 +0000 (UTC)
Subject: Re: [PATCH] meson: move pixman detection to meson
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20200826070243.11969-1-pbonzini@redhat.com>
 <cc6af807-a24f-42bb-b1f7-8c8c5e59200b@redhat.com>
 <CABgObfYJ=6fRSzTz5C1A8dgbom7-QWtn1J1L7-8+4thkxNTvjA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <80f0ce6c-0bc3-42c5-523c-f81f997a5ab5@redhat.com>
Date: Thu, 27 Aug 2020 09:28:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CABgObfYJ=6fRSzTz5C1A8dgbom7-QWtn1J1L7-8+4thkxNTvjA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.239, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Rafael Kitover <rkitover@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/08/2020 08.14, Paolo Bonzini wrote:
> 
> 
> Il gio 27 ago 2020, 06:53 Thomas Huth <thuth@redhat.com
> <mailto:thuth@redhat.com>> ha scritto:
> 
>     > -else
>     > -  error_exit "pixman >= 0.21.8 not present." \
>     > -      "Please install the pixman devel package."
>     > -fi
> 
>     The "else" part now got completely lost, didn't it?
> 
> 
> It's replaced by "required: have_system" in meson.build. We can add a
> custom "not found" message, but if the current one is not enough we
> should improve Meson so that it figures out a good one from the version
> requirement.

Ah, now it makes sense, thanks for the explanation!

But I've tested the patch now, and it does not work:

.../qemu/meson.build:117:3: ERROR: Unknown variable "have_system".

Should the pixman test maybe be moved to a later spot in the file? It
currently shows up before the have_system variable is initialized...

 Thomas


