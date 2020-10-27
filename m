Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140E1C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:59:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DB4922283
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1AJpHuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB4922283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQS5-0003g2-AW
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXPqr-0006ET-3T
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 10:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59554)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXPqo-0008A7-Ee
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 10:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603808483;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=bfbWGSjCkq1lSlf3EPHLeT8EwFANleLl+fyQz3OJpyk=;
 b=O1AJpHuhoRFWaeXjBiO+cvnmt+m4U+yCOva+sERkQGaYe+izzSmXZkQxcXM+L8nrI8gUpy
 duXsZOqdHPrXx6mgaNnAOaWUSZPDFwBaZkgA+7sIjDFusHPiz4519iGVtp37+ro+c/K/VD
 KCS3GUm7Pq1AzHUsQOT9dxDcKMVG6Y4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-t0kawjb6MV25LBumJtBBFg-1; Tue, 27 Oct 2020 10:21:11 -0400
X-MC-Unique: t0kawjb6MV25LBumJtBBFg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DEBA10E2183;
 Tue, 27 Oct 2020 14:21:10 +0000 (UTC)
Received: from redhat.com (ovpn-115-46.ams2.redhat.com [10.36.115.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 91BEF19647;
 Tue, 27 Oct 2020 14:20:58 +0000 (UTC)
Date: Tue, 27 Oct 2020 14:20:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC] Using gitlab for upstream qemu repo?
Message-ID: <20201027142055.GD529052@redhat.com>
References: <672b8aa0-2128-23e1-b778-01a4d96b209d@redhat.com>
 <CAFEAcA8OjeQ-utD56inorMk8dM6RNRzr-6Dv-YEW4n=qBi_MBQ@mail.gmail.com>
 <20201027140818.GC102411@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201027140818.GC102411@stefanha-x1.localdomain>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, kraxel@redhat.com,
 "Justin M. Forbes" <jforbes@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Andreas Faerber <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 27, 2020 at 02:08:18PM +0000, Stefan Hajnoczi wrote:
> On Mon, Oct 26, 2020 at 11:04:06AM +0000, Peter Maydell wrote:
> > On Thu, 22 Oct 2020 at 17:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > now that Gitlab is the primary CI infrastructure for QEMU, and that all
> > > QEMU git repositories (including mirrors) are available on Gitlab, I
> > > would like to propose that committers use Gitlab when merging commits to
> > > QEMU repositories.
> > 
> > > Nothing would change for developers, who would still have access to all
> > > three sets of repositories (git.qemu.org, gitlab.com and github.com).
> > > Committers however would need to have an account on the
> > > https://gitlab.com/qemu-project organization with access to the
> > > repositories they care about.  They would also lose write access to
> > > /srv/git on qemu.org.
> > 
> > Yes, this makes sense. Who in practice does it actually affect?
> > For the main qemu.git repo, my guess is just me, Michael Roth
> > for the stable branches, plus Richard H and Stefan H who both
> > volunteered to do a turn on the merge-handling rota once we
> > eventually get it set up to not depend on my ad-hoc CI setup.
> > 
> > I have a gitlab account so I'm set for this. Michael, do you
> > have an account there and are you OK with switching to doing
> > git pushes to the repo on gitlab rather than direct to qemu.org ?
> 
> Here are the users with commit access to qemu.org repos:
> 
> berkeley-softfloat-3 - pmaydell,mdroth,stefanha
> berkeley-testfloat-3 - pmaydell,mdroth,stefanha
> capstone - pmaydell,mdroth,stefanha
> dtc - pmaydell,mdroth,stefanha
> edk2 - pmaydell,mdroth,stefanha
> ipxe - kraxel,lprosek
> keycodemapdb - pmaydell,mdroth,stefanha

Mirroring this on gitlab is a little silly when the primary upstream
is already on gitlab :-)

   https://gitlab.com/keycodemap/keycodemapdb

> libslirp - pmaydell,mdroth,stefanha
> meson - pmaydell,mdroth,stefanha
> openbios - pmaydell,mdroth,stefanha
> openhackware - pmaydell,mdroth,stefanha
> opensbi - <none>
> qboot - pmaydell,mdroth,stefanha
> qemu - pmaydell,mdroth,stefanha
> qemu-jeos - pmaydell,mdroth,stefanha
> QemuMacDrivers - pmaydell,mdroth,stefanha
> qemu-palcode - pmaydell,mdroth,stefanha


> qemu-stable-0.10 - jforbes,afaerber,mdroth
> qemu-stable-0.14 - jforbes,afaerber,mdroth
> qemu-stable-0.15 - jforbes,afaerber,mdroth
> qemu-stable-1.0 - jforbes,afaerber,mdroth
> qemu-stable-1.1 - jforbes,afaerber,mdroth
> qemu-stable-1.2 - jforbes,afaerber,mdroth
> qemu-stable-1.3 - jforbes,afaerber,mdroth
> qemu-stable-1.4 - jforbes,afaerber,mdroth

IIUC, the content from these is present in the main qemu.git.

Should we mark them "archived" in gitlab, so they're not listed
by default as active repos.

> qemu-web - paolo,jcody,pmaydell,mdroth,thuth
> s390-tools - pmaydell,mdroth,stefanha
> seabios - pmaydell,mdroth,stefanha
> seabios-hppa - pmaydell,mdroth,stefanha
> sgabios - paolo
> skiboot - pmaydell,mdroth,stefanha
> SLOF - pmaydell,mdroth,stefanha
> u-boot - pmaydell,mdroth,stefanha
> u-boot-sam460ex - pmaydell,mdroth,stefanha
> vbootrom - pmaydell,mdroth,stefanha
> vgabios - pmaydell,mdroth,stefanha
> 
> Quite a few of those repos are mirrors and actually don't need human
> push access.
> 
> The people who need push access are:
>  * bonzini - qemu-web
>  * mdroth - qemu-stable
>  * pmaydell - qemu
>  * rth - qemu
>  * stefanha - qemu
>  * thuth - qemu-web
> 
> Does this sound good?

Doesn't  mdrooth need  'qemu-web' access for updating the list of
releases ?

We probably ought to have more than one person with push to qemu-stable,
even if mdroth normally does it all, just to improve a bus factor.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


