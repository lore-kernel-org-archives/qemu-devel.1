Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C2DC4363D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52AAC221E2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eeIHy4IS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52AAC221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKQTK-0006Mw-HQ
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 14:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKQEC-00027Y-1G
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 14:07:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKQE9-0003WY-2u
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 14:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600711668;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=PtZ7r3WsAvJjqb08OKZYM8g/0SC3J1JnwX6NevgEAiY=;
 b=eeIHy4IS0vbPVf3Da41zUPqvBHpNOCGdRM3TZz8WLOzKrlzwojYVMrd/dVzSEhWW6Mbe4G
 O+rwjfty8BU8fZVnzKuV+jEmQB7UGJqJs8S23UPWb3mRKMZ/xG4jTkSc+3uO33euBSS2LR
 KS5Pox02BtIX0ritO4/PqsVoBu8xuVk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-_-ASZlj6NsmIc8kOUf0NUg-1; Mon, 21 Sep 2020 14:07:44 -0400
X-MC-Unique: _-ASZlj6NsmIc8kOUf0NUg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86321801FD7;
 Mon, 21 Sep 2020 18:07:43 +0000 (UTC)
Received: from redhat.com (ovpn-113-113.ams2.redhat.com [10.36.113.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8850673688;
 Mon, 21 Sep 2020 18:07:38 +0000 (UTC)
Date: Mon, 21 Sep 2020 19:07:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 4/7] shippable.yml: Remove the Debian9-based MinGW
 cross-compiler tests
Message-ID: <20200921180735.GW1942072@redhat.com>
References: <20200921174320.46062-1-thuth@redhat.com>
 <20200921174320.46062-5-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200921174320.46062-5-thuth@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 21, 2020 at 07:43:17PM +0200, Thomas Huth wrote:
> We're not supporting Debian 9 anymore, and we are now testing
> MinGW cross-compiler builds in the gitlab-CI, too, so we do not
> really need these jobs in the shippable.yml anymore.

For that matter aren't all the other shippable entries obsolete
now too since we added .gitlab-ci.d/crossbuilds.yml ?

IOW, can we remove shippable entirely at this point ?

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .shippable.yml | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/.shippable.yml b/.shippable.yml
> index 0b4fd6df1d..14350e6de8 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -7,10 +7,6 @@ env:
>    matrix:
>      - IMAGE=debian-amd64
>        TARGET_LIST=x86_64-softmmu,x86_64-linux-user
> -    - IMAGE=debian-win32-cross
> -      TARGET_LIST=arm-softmmu,i386-softmmu
> -    - IMAGE=debian-win64-cross
> -      TARGET_LIST=aarch64-softmmu,sparc64-softmmu,x86_64-softmmu
>      - IMAGE=debian-armel-cross
>        TARGET_LIST=arm-softmmu,arm-linux-user,armeb-linux-user
>      - IMAGE=debian-armhf-cross

> -- 
> 2.18.2
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


