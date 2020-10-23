Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17274C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFE1208FE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmsuOMpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFE1208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0aG-0005CF-Sf
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 13:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVznN-0000VC-Uy
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVznL-0008Pr-RB
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603469999;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GI829ZvrWXiramj4WzqAaOzgkvgbs7eYCY/WSWdf2no=;
 b=fmsuOMpPDhMYfES2JwxG86/yZFSWS58w2Av0GKLpHWlBxlDwI9PgIwM5zqI1yfKQUSF/Cx
 o0W59y/Zn5/22Q1TB45IOggbPdUN8nz2PetFxVZbNRJX1nxQBfkKeScmTcwnuUJN3f8hYv
 GRoJHALaYVrhIR2vhLTB4y4u2gdwouA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-38Dh8J_FNKCmB4zDkU_eDg-1; Fri, 23 Oct 2020 12:19:53 -0400
X-MC-Unique: 38Dh8J_FNKCmB4zDkU_eDg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E430835BB8
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 16:19:16 +0000 (UTC)
Received: from redhat.com (ovpn-113-189.ams2.redhat.com [10.36.113.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BD5155798;
 Fri, 23 Oct 2020 16:19:14 +0000 (UTC)
Date: Fri, 23 Oct 2020 17:19:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [qemu-web PATCH 6/7] Add link to "edit this page" for all pages
Message-ID: <20201023161912.GB463062@redhat.com>
References: <20201023152957.488974-1-berrange@redhat.com>
 <20201023152957.488974-7-berrange@redhat.com>
 <d61c100e-fb49-6f13-77e0-2262cb06946d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d61c100e-fb49-6f13-77e0-2262cb06946d@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 05:47:45PM +0200, Paolo Bonzini wrote:
> On 23/10/20 17:29, Daniel P. Berrangé wrote:
> > The link takes the user directly to the source markdown file in gitlab,
> > where they can press the "Edit" button and make changes directly in the
> > browser. They will be prompted to fork the project when committing the
> > changes if they don't already have a fork.  The result is a commit which
> > can be submitted for review per the contributing guidelines.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> I think this is a good idea *if* we switch to merge requests for website
> edits---which isn't something I'm opposed to.

Note if you disable merge requests, then the page we link to doesn't
show a live editor. It merely shows the read-only source. Not as
useful, at least the user can see which source file they need to
touch in their fork, which is still a step forwards I think.

> 
> Paolo
> 
> > ---
> >  _includes/footer.html        | 3 +++
> >  assets/css/style-desktop.css | 4 ++++
> >  assets/css/style.css         | 2 +-
> >  3 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/_includes/footer.html b/_includes/footer.html
> > index 2dd247b..0a77d8e 100644
> > --- a/_includes/footer.html
> > +++ b/_includes/footer.html
> > @@ -1,4 +1,7 @@
> >  <div id="footer">
> > +	<div id="edit-page">
> > +		<a href="https://gitlab.com/qemu-project/qemu-web/-/blob/master/{{page.path}}">edit this page</a>
> > +	</div>
> >  	<div id="external-links">
> >  		<ul class="style">
> >  			<li><a href="http://qemu-advent-calendar.org">Advent calendar</a></li>
> > diff --git a/assets/css/style-desktop.css b/assets/css/style-desktop.css
> > index d45ec15..19272ad 100644
> > --- a/assets/css/style-desktop.css
> > +++ b/assets/css/style-desktop.css
> > @@ -102,6 +102,10 @@
> >  /* Footer                                                                        */
> >  /*********************************************************************************/
> >  
> > +	#edit-page {
> > +		text-align: right;
> > +	}
> > +
> >  	#licenses {
> >  		float: right;
> >  	}
> > diff --git a/assets/css/style.css b/assets/css/style.css
> > index e2fee29..50bbcd1 100644
> > --- a/assets/css/style.css
> > +++ b/assets/css/style.css
> > @@ -514,7 +514,7 @@
> >  		margin: 0em;
> >  	}
> >  
> > -	#conservancy, #licenses {
> > +	#conservancy, #licenses, #edit-page {
> >  		padding: 0em;
> >  		padding-left: 1em;
> >  		padding-right: 1em;
> > 
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


