Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BE1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B11A2086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wc7zP0mE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B11A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2tGS-0007XX-PO
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 05:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k2tFt-00071b-7n
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 05:29:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47249
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k2tFp-0000fd-IF
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 05:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596533343;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfutSi0Q8RBLBfDyW+DvLMVCARlQsPqELQzkkU5c36s=;
 b=Wc7zP0mE9knR6awvFpQJpbZ2LNLu+yU51EDUx4xjo1VO/kexcT0RzB4pmofxULpHoVcxSg
 eXp5j6PMosb0Ohb8M5JOYpYe0+BOiGR9dwEEqrskVwIx+iOHVqYZGFja0zqwWfj8VPj6Pn
 RzlxEB7OFci/jfHDzMg4wBHBqUNJYf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-Y7NsoZZwNMeIJxs7M9x-ow-1; Tue, 04 Aug 2020 05:28:59 -0400
X-MC-Unique: Y7NsoZZwNMeIJxs7M9x-ow-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E69518C63C0;
 Tue,  4 Aug 2020 09:28:58 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B979D282C9;
 Tue,  4 Aug 2020 09:28:56 +0000 (UTC)
Date: Tue, 4 Aug 2020 10:28:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH for-5.1] Add GitHub action for Windows build
Message-ID: <20200804092853.GD4020825@redhat.com>
References: <20200803202042.1869013-1-sw@weilnetz.de>
 <5373338e-0be6-83f4-e370-d693a06ce26b@amsat.org>
MIME-Version: 1.0
In-Reply-To: <5373338e-0be6-83f4-e370-d693a06ce26b@amsat.org>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:16
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 04, 2020 at 09:29:50AM +0200, Philippe Mathieu-Daudé wrote:

> > diff --git a/.github/workflows/win.yml b/.github/workflows/win.yml
> > new file mode 100644
> > index 0000000000..81cf48530f
> > --- /dev/null
> > +++ b/.github/workflows/win.yml
> > @@ -0,0 +1,34 @@
> > +# GitHub actions - Create QEMU installers for Windows
> > +
> > +# The action is restricted to https://github.com/qemu/qemu.
> > +# That avoids an unnecessary waste of resources when each fork
> > +# runs the action, too.
> > +
> > +name: Cross build for Windows
> > +
> > +on: [push]
> > +
> > +jobs:
> > +  build32:
> > +    if: github.repository == 'qemu/qemu'
> > +    runs-on: [ubuntu-20.04]
> 
> Since it is based on Ubuntu, we should be able to run it on GitLab
> directly (and simplifies our CI). Also we could drop the Shippable
> docker images too.
> 
> This works, so:
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> But I'm not keen on not using GitLab instead.

Agreed, I realllly don't want to see us introduce yet another CI
environment. This increases the cost for maintainers and contributors
alike. Especially as we're introducing GitLab as our gating CI
platform, we need to be doing whatever we can to consolidate stuff
onto GitLab CI, not adding new CI systems.

For things we can't do in GitLab CI directly, we need to use a
shim job in GitLab that calls out to the alternative service
and sends results back, so that we still have GitLab as the
single portal to watch all jobs. eg  cirrus-run for integrating
with Cirrus CI.

> The only point I see of using GitHub/Azureus is if we then install
> and run testing in the Windows Server 2019 environment:
> 
> https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idruns-on

Cirrus CI has the ability to provide Windows Service 2019 containers
too, and since we already use Cirrus CI and can integrate it with
GitLab via cirrrus-run, I think that's preferrable to GitHub.

https://cirrus-ci.org/guide/windows/

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


