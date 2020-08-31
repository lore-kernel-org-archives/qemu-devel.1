Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A29C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B3A20684
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="il6oAYap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B3A20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kChmz-0002ck-A7
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 07:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kChmO-0002Cj-2V
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:15:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26300
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kChmM-0001VY-AV
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598872513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ta6Pf8pjwmhnQp2iuv4zHskaw60g68HnPvxcL92VHY8=;
 b=il6oAYapn6mRbAQjnvsfGMABOhDMWfg1XlN1gQZnS3pJxGvoPCQeUPWmJ/8aKVSbbeR5CP
 PtuFQYyTZ9ky2tJoUcbmuVwE8eMNQoKtM01WKvNG2AVi1a7lxt7QyCGfM4QhZblhwpuM4m
 eA+ZK66UPtxxsZLQ4vc2yg4/anXXAAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-I863Xhp3O9eNc4NdNnvsfA-1; Mon, 31 Aug 2020 07:15:11 -0400
X-MC-Unique: I863Xhp3O9eNc4NdNnvsfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91B6B10199AD
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:15:10 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-174.ams2.redhat.com [10.36.112.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC4065D9DC;
 Mon, 31 Aug 2020 11:15:04 +0000 (UTC)
Subject: Re: [PATCH] meson: fix keymaps witout qemu-keymap
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200827102617.14448-1-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <772abf5c-30e2-149f-2507-2c47c016dd7b@redhat.com>
Date: Mon, 31 Aug 2020 13:15:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200827102617.14448-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 02:13:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 27/08/2020 12.26, Gerd Hoffmann wrote:
> In case the qemu-keymap tool generating them is neither installed on the
> system nor built from sources (due to xkbcommon not being available)
> qemu will not find the keymaps when started directly from the build
> tree,
> 
> This happens because commit ddcf607fa3d6 ("meson: drop keymaps symlink")
> removed the symlink to the source tree, and the special handling for
> install doesn't help in case we do not install qemu.
> 
> Lets fix that by simply copying over the file from the source tree as
> fallback.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  pc-bios/keymaps/meson.build | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)

Thanks, this fixes the acceptance tests on gitlab-CI for me!

Tested-by: Thomas Huth <thuth@redhat.com>


