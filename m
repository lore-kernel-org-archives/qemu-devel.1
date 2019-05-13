Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79824C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7A921479
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7A921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53883 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ79m-0002MR-Va
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 05:22:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQ78T-0001Ny-0e
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQ6wn-0002cO-9F
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:08:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hQ6wm-0002aD-MB
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:08:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA6FC308792F;
	Mon, 13 May 2019 09:08:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A739960C4D;
	Mon, 13 May 2019 09:08:32 +0000 (UTC)
Date: Mon, 13 May 2019 10:08:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190513090830.GB15029@redhat.com>
References: <20190418224706.14014-1-programmingkidx@gmail.com>
	<723372ae-a37a-d7cd-098f-452c7513ce8a@redhat.com>
	<4B73E5E6-2129-43B8-A35E-0CF7DCAE163B@gmail.com>
	<1c4c309a-b785-64d2-60ce-4f0501fcc415@redhat.com>
	<E694EDDC-BFF1-4BE9-BFCC-43B303DE6BF7@gmail.com>
	<99b26a5a-d756-c1d7-0690-5e419075f5e0@redhat.com>
	<3D0C069E-C946-47E0-8A1C-EF5B28CFFB09@gmail.com>
	<2f0545db-a95c-d4ba-cc46-110c3b15e1e8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f0545db-a95c-d4ba-cc46-110c3b15e1e8@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 13 May 2019 09:08:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] configure: Change capstone's default state
 to disabled
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Programmingkid <programmingkidx@gmail.com>,
	Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 12, 2019 at 03:47:49PM +0200, Thomas Huth wrote:
> Maybe try to clean the folder first:
> 
>  rm -r capstone
>  mkdir capstone
>  make git-submodule-update
> 
> If that does not help, maybe try a completely fresh git checkout?

Rather than deleting stuff like that, it is best to use git to put your
dir back to a clean state.

   git submodule deinit --all --force
   git clean -f -x -d 

After doing this, then run  'configure' again with normal args and try
to build.

If it still fails, please provide the /full/ output printed by configure,
as well as all output from make, and also the contents of the 'config.log'
file.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

