Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB7CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 282162078B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFVaJriE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282162078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k98D8-0007RF-CC
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k98CX-00071E-Dh
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:39:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24993
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k98CV-000094-14
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598020765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sq9NM5bhOX0fWu58pya/c7atIOIPUEuLv4T9H4mtjbU=;
 b=DFVaJriENgDPAwr/Gyts9C2R61qe5jjydXOO+Zeur9BxbPFfwr0Tkx+2HscceUWFxRgUJY
 XqHQoldx2K2PWjRTTAonwcObTGaaK5d5kT6TGwsyfvMG1BYQRyXXpbjDl5q54OZtrNMxhe
 AEC7IERqQN0Yy85f9TifcR0YUgO0adE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462--Y9LKQbxNBuHBg09xTkVPA-1; Fri, 21 Aug 2020 10:39:22 -0400
X-MC-Unique: -Y9LKQbxNBuHBg09xTkVPA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEFD681F039;
 Fri, 21 Aug 2020 14:39:21 +0000 (UTC)
Received: from [10.3.114.53] (ovpn-114-53.phx2.redhat.com [10.3.114.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64E8A7BE99;
 Fri, 21 Aug 2020 14:39:21 +0000 (UTC)
Subject: Re: ANNOUNCE: build system conversion to Meson has landed
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA-87BcmoPjY9BCodx9+m6QmhfikHv5sLVJ8w20cszDvDA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d9213548-5c05-502e-e660-fbe9b8b1f5ee@redhat.com>
Date: Fri, 21 Aug 2020 09:39:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-87BcmoPjY9BCodx9+m6QmhfikHv5sLVJ8w20cszDvDA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/20 8:49 AM, Peter Maydell wrote:
> Hi; we've just merged Paolo's patchset that converts the build system
> to use Meson. This should mostly be fairly seamless for the average
> developer (we hope) but there are a few things to be aware of:
> 
>   * you probably want to do a distclean or otherwise do a clean build
>     when you first update your git tree to a version of master with Meson
>     (especially if you do in-tree builds)
>   * out-of-tree builds should continue to work basically normally
>   * we have retained compatibility for an "in-tree build" workflow where
>     you run configure/make in the source tree, but this is now implemented
>     by having configure create a build tree for you under-the-hood
>     (but do consider switching to just doing out-of-tree builds)

If you do an in-tree build, do the 'make distclean' _before_ a 'git 
pull' of the new code.  If you don't clean first, the pull attempt is 
likely to complain about various trace.h files, so that is a good 
reminder.  And if you manage to pull anyway, you may need to rewind your 
tree back to v5.1.0 before attempting the in-tree 'make distclean', then 
re-try the pull.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


