Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01530C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2F12078B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q21PEEt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2F12078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtoBV-0007rD-2o
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 04:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jto9L-00063P-UW
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:12:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51797
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jto9J-00031U-HN
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594368767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=RMzVTisi6ZQ+vniFvCBjv4juFY3mLrmQQKHG2PF1/rc=;
 b=Q21PEEt9KGitR8HgdniZ53ng4efCxd73xAencjXVHUgmuB9gE6Uxj2ARHYGe6DJ667RLKY
 BvtLbHQfrGokFm0l4BnGp0GrMzzG4BpQtlG1HTQ84Ld84c0HyPYyc41Zh5HIqQW6+xf6TR
 5jDYnqInLUgQsqvbkmpaK6lrpEaG34o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-8mECPWvlPr6AJ3TNkd7how-1; Fri, 10 Jul 2020 04:12:44 -0400
X-MC-Unique: 8mECPWvlPr6AJ3TNkd7how-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92BA31009600
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 08:12:43 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-68.ams2.redhat.com [10.36.112.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB36E60C80;
 Fri, 10 Jul 2020 08:12:35 +0000 (UTC)
Subject: Re: [PULL 00/10] Modules 20200707 patches
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200707134229.9773-1-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <72615357-e5de-0f7d-faf3-1582ce668998@redhat.com>
Date: Fri, 10 Jul 2020 10:12:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200707134229.9773-1-kraxel@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/07/2020 15.42, Gerd Hoffmann wrote:
> The following changes since commit 7623b5ba017f61de5d7c2bba12c6feb3d55091b1:
> 
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-pull-request' into staging (2020-07-06 11:40:10 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kraxel.org/qemu tags/modules-20200707-pull-request
> 
> for you to fetch changes up to ef138c77249771081d8c2d09b8e729f7e92cdf28:
> 
>   chardev: enable modules, use for braille (2020-07-07 15:33:59 +0200)
> 
> ----------------------------------------------------------------
> qom: add support for qom objects in modules.
> build some devices (qxl, virtio-gpu, ccid, usb-redir) as modules.
> build braille chardev as module.
> 
> v2: more verbose comment for "build: fix device module builds" patch.
> 
> note: qemu doesn't rebuild objects on cflags changes (specifically
>       -fPIC being added when code is switched from builtin to module).
>       Workaround for resulting build errors: "make clean", rebuild.
> 
> ----------------------------------------------------------------
> 
> Gerd Hoffmann (10):
>   module: qom module support
>   object: qom module support
>   qdev: device module support
>   build: fix device module builds
>   ccid: build smartcard as module
>   usb: build usb-redir as module
>   vga: build qxl as module
>   vga: build virtio-gpu only once
>   vga: build virtio-gpu as module
>   chardev: enable modules, use for braille

 Hi Gerd,

something in this series seems to cause a build failure on Travis:

 https://travis-ci.com/github/huth/qemu/jobs/359586799#L7404

Could you please have a look?

 Thanks,
  Thomas


