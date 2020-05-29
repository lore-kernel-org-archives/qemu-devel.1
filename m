Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B959FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 17:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811B720814
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 17:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="irkir2u+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811B720814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeiVa-00058s-Km
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 13:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jeiUt-0004i4-MH
 for qemu-devel@nongnu.org; Fri, 29 May 2020 13:08:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55199
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jeiUr-0003Mx-Ob
 for qemu-devel@nongnu.org; Fri, 29 May 2020 13:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590772120;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MrJ6R9eNz6j1q7mtfzRvl/r6SiIqhcgnJqvr28yekI8=;
 b=irkir2u+SZLe8YV8KpFrbaGyUn1yRUgdMg3rs+WwRY9g9j97jHjWj5EVpR3hzlmY8HbDuT
 o6zt9riJW/kF7YItEaK+hWkbKo9kqhb7tVhs07CSAMICb0U/lxoAPNBk0fvPIDBMBXXs41
 Ezbpjm/FK94yhckisnlBiEvsmZIULZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-Xhuempw4OYiNVqReNf258A-1; Fri, 29 May 2020 13:08:34 -0400
X-MC-Unique: Xhuempw4OYiNVqReNf258A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2CAF461
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 17:08:33 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F1BC219733
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 17:08:32 +0000 (UTC)
Date: Fri, 29 May 2020 18:08:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL 0/5] Qcrypto next patches
Message-ID: <20200529170830.GK2755532@redhat.com>
References: <20200529103555.2759928-1-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200529103555.2759928-1-berrange@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 29, 2020 at 11:35:50AM +0100, Daniel P. Berrangé wrote:
> The following changes since commit b8bee16e94df0fcd03bdad9969c30894418b0e6e:
> 
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200528-pull-request=
> ' into staging (2020-05-28 18:13:20 +0100)
> 
> are available in the Git repository at:
> 
>   https://github.com/berrange/qemu tags/qcrypto-next-pull-request
> 
> for you to fetch changes up to efd6cd2328064b569a7a92ad4aea1dc985d98601:
> 
>   crypto: Remove use of GCRYPT_VERSION macro. (2020-05-29 11:33:19 +0100)
> 
> ----------------------------------------------------------------
> Misc crypto subsystem fixes
> 
> * Add support for fetching secret from Linux keyring
> * Remove redundant version check in gcrypt initialization
> * Allow for RNG provider to be disabled at build time
> 
> ----------------------------------------------------------------
> 
> Alexey Krasikov (3):
>   crypto/secret: move main logic from 'secret' to 'secret_common'.
>   crypto/linux_keyring: add 'secret_keyring' secret object.
>   test-crypto-secret: add 'secret_keyring' object tests.
> 
> Marek Marczykowski-G=C3=B3recki (1):
>   crypto: add "none" random provider
> 
> Richard W.M. Jones (1):
>   crypto: Remove use of GCRYPT_VERSION macro.
> 
>  configure                       |  73 ++++++
>  crypto/Makefile.objs            |   5 +-
>  crypto/init.c                   |   2 +-
>  crypto/random-none.c            |  38 +++
>  crypto/secret.c                 | 347 +--------------------------
>  crypto/secret_common.c          | 403 ++++++++++++++++++++++++++++++++
>  crypto/secret_keyring.c         | 148 ++++++++++++
>  include/crypto/secret.h         |  20 +-
>  include/crypto/secret_common.h  |  68 ++++++
>  include/crypto/secret_keyring.h |  52 +++++
>  tests/Makefile.include          |   4 +
>  tests/test-crypto-secret.c      | 158 +++++++++++++
>  12 files changed, 959 insertions(+), 359 deletions(-)
>  create mode 100644 crypto/random-none.c
>  create mode 100644 crypto/secret_common.c
>  create mode 100644 crypto/secret_keyring.c
>  create mode 100644 include/crypto/secret_common.h
>  create mode 100644 include/crypto/secret_keyring.h

Seems the mingw build is broken due to mistakes in configure, so
i'll respin this.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


