Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B4CC4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4618E206DD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvNjPem9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4618E206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOPJ4-0005cR-E4
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kOPHp-0004Kc-Kr
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kOPHk-0005W8-UE
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601661360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rIyElYhR44is0h6RReT8YJ4TgPcYf9CTiQTT44zOU5A=;
 b=CvNjPem9vbai3yjWRb55HA/sjtvNKPD2H7/16rpSt8DB6PSrydXBrbyPdvwxuwOGSerKPy
 hui9Xt9YX0aez2QOsoZ0DYYaNbaSpOlK/8mtCaSq+1IiRsmlYVGxmkuRyl41FLyzpUYvUH
 Zt7qU77yMnwYmQw5ET36CI5a2kai/uA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-UhqWZ795OemvqvHJQ-FR4Q-1; Fri, 02 Oct 2020 13:55:57 -0400
X-MC-Unique: UhqWZ795OemvqvHJQ-FR4Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43A98186DD41
 for <qemu-devel@nongnu.org>; Fri,  2 Oct 2020 17:55:56 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9A965C1DA;
 Fri,  2 Oct 2020 17:55:55 +0000 (UTC)
Date: Fri, 2 Oct 2020 13:55:54 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL v8 00/86] Misc QEMU patches for 2020-09-24
Message-ID: <20201002175554.GD7303@habkost.net>
References: <20200930195850.278104-1-pbonzini@redhat.com>
 <a0b8e23a-cccb-3c5d-dbf7-f489c0d95f93@redhat.com>
 <20201002162208.GB7303@habkost.net>
 <a793e75b-47f2-5120-24cd-c50a6a45d04b@redhat.com>
 <1a98babe-f6b9-fa73-24ca-07ecbf395225@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1a98babe-f6b9-fa73-24ca-07ecbf395225@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Michal =?utf-8?B?UHLDrXZvem7DrWs=?= <mprivozn@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 02, 2020 at 07:30:17PM +0200, Paolo Bonzini wrote:
> On 02/10/20 19:26, Michal Prívozník wrote:
> > On 10/2/20 6:22 PM, Eduardo Habkost wrote:
> >> On Fri, Oct 02, 2020 at 05:58:55PM +0200, Michal Prívozník wrote:
> >>> On 9/30/20 9:58 PM, Paolo Bonzini wrote:
> >>>>
> >>>> Eduardo Habkost (10):
> >>> <snip/>
> >>>>         docs: Create docs/devel/qom.rst
> >>>
> >>> cd442a45db60a1a72fcf980c24bd1227f13f8a87 is the first bad commit
> >>>
> >>> Sorry for noticing this earlier, but is this known? The build starts
> >>> failing
> >>> for me after this commit:
> >>>
> >>> /usr/bin/sphinx-build -Dversion=5.1.50 -Drelease= -W
> >>> -Ddepfile=docs/devel.d
> >>> -Ddepfile_stamp=docs/devel.stamp -b html -d
> >>> /home/zippy/work/qemu/qemu.git/build/docs/devel.p
> >>> /home/zippy/work/qemu/qemu.git/docs/devel
> >>> /home/zippy/work/qemu/qemu.git/build/docs/devel
> >>> Running Sphinx v3.2.1
> >>> building [mo]: targets for 0 po files that are out of date
> >>> building [html]: targets for 20 source files that are out of date
> >>> updating environment: [new config] 20 added, 0 changed, 0 removed
> >>> reading sources... [100%] testing
> >>>
> >>>
> >>>
> >>>
> >>> Warning, treated as error:
> >>> /home/zippy/work/qemu/qemu.git/docs/../include/qom/object.h:747:Error in
> >>> declarator
> >>> If declarator-id with parameters (e.g., 'void f(int arg)'):
> >>>    Invalid C declaration: Expected identifier in nested name. [error
> >>> at 24]
> >>>      object_initialize_child ( parent,  propname,  child,  type)
> >>>      ------------------------^
> >>> If parenthesis in noptr-declarator (e.g., 'void (*f(int arg))(double)'):
> >>>    Error in declarator or parameters
> >>>    Invalid C declaration: Expecting "(" in parameters. [error at 32]
> >>>      object_initialize_child ( parent,  propname,  child,  type)
> >>>      --------------------------------^
> >>>
> >>> make[1]: *** [Makefile.ninja:9898: docs/devel.stamp] Error 2
> >>> make[1]: *** Deleting file 'docs/devel.stamp'
> >>> make[1]: Leaving directory '/home/zippy/work/qemu/qemu.git/build'
> >>> make: *** [GNUmakefile:11: all] Error 2
> >>
> >> I can't reproduce it using Sphinx v2.2.2.  I'm still trying to
> >> understand what exactly the error means.
> >>
> > 
> > Same here.
> > 
> >> I really wish we used virtualenv + requirements.txt to require a
> >> specific version of Sphinx instead of wasting time dealing a wide
> >> range of Sphinx versions.
> >>
> > 
> > I already have a patch that I keep locally to build with v3:
> > 
> > diff --git a/docs/qemu-option-trace.rst.inc
> > b/docs/qemu-option-trace.rst.inc
> > index 7e09773a9c..ae83f6a1a8 100644
> > --- a/docs/qemu-option-trace.rst.inc
> > +++ b/docs/qemu-option-trace.rst.inc
> > @@ -1,7 +1,7 @@
> > 
> >  Specify tracing options.
> > 
> > -.. option:: [enable=]PATTERN
> > +.. option:: enable=PATTERN
> > 
> >    Immediately enable events matching *PATTERN*
> >    (either event name or a globbing pattern).  This option is only
> > 
> > 
> > That said, I'm not objecting to requiring v2 for now and switching to v3
> > later.
> > 
> > 
> > But interestingly, through trial and error I've came across this hack,
> > which allows me to build again. I have no idea why it works:
> > 
> > diff --git i/include/qom/object.h w/include/qom/object.h
> > index 27aaa67e63..59c729ebb7 100644
> > --- i/include/qom/object.h
> > +++ w/include/qom/object.h
> > @@ -762,13 +762,14 @@ bool object_initialize_child_with_propsv(Object
> > *parentobj,
> >   *                                      child, sizeof(*child), type,
> >   *                                      &error_abort, NULL)
> >   */
> > -#define object_initialize_child(parent, propname, child, type)          \
> > -    object_initialize_child_internal((parent), (propname),              \
> > -                                     (child), sizeof(*(child)), (type))
> >  void object_initialize_child_internal(Object *parent, const char
> > *propname,
> >                                        void *child, size_t size,
> >                                        const char *type);
> > 
> > +#define object_initialize_child(parent, propname, child, type)          \
> > +    object_initialize_child_internal((parent), (propname),              \
> > +                                     (child), sizeof(*(child)), (type))
> > +
> 
> The error is due to kerneldoc treating the macro definition like a
> function, so that makes sense.  If the docs look good (no reference to
> object_initialize_child_internal) then the patch can be applied.

The patch makes the document show object_initialize_child_internal().

-- 
Eduardo


