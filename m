Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FD8C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:39:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17222223BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xf4QnI8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17222223BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIaSW-0004aJ-6y
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIaQu-0003eV-IW
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:37:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25443
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIaQs-0002pU-Ha
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600274241;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=g+5GtK/uEu7vVqZm4XoxUTZZLMVRmI82WlzVMt4YFZ8=;
 b=Xf4QnI8zNUT9keE8OvVgydIkm7j2iNwBLhMLtc8Q5CFtY31W10JzZJsOtII3Z2iijP2VUR
 LkcZjrjlfro+JbGT/2ySamOqEPejykPIEZ4TmhIJCV6/ipsmA9NAC4wdnnqh7Ifu0A9DvJ
 qkR51iDrP0c3AH3cMMfa7X7rM45BwXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-axUzXuf9MMO71ZlWmGDOVQ-1; Wed, 16 Sep 2020 12:37:19 -0400
X-MC-Unique: axUzXuf9MMO71ZlWmGDOVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DC4F186DD3F
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 16:37:18 +0000 (UTC)
Received: from redhat.com (ovpn-113-248.ams2.redhat.com [10.36.113.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EC7881C45;
 Wed, 16 Sep 2020 16:37:17 +0000 (UTC)
Date: Wed, 16 Sep 2020 17:37:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Python docstrings and licensing/authorship
Message-ID: <20200916163714.GT1535709@redhat.com>
References: <361aad7f-c2a3-524e-bd5a-2fc1fa6fe38a@redhat.com>
 <5C5765B1-3E0F-4577-B7B3-8BFFCB2D936F@redhat.com>
 <d6b98fa9-ee29-a9d3-c3e7-30ae84b8e4cd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d6b98fa9-ee29-a9d3-c3e7-30ae84b8e4cd@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 11:53:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Christophe de Dinechin <cdupontd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 16, 2020 at 12:22:37PM -0400, John Snow wrote:
> On 9/16/20 12:05 PM, Christophe de Dinechin wrote:
> > 
> > 
> > > On 16 Sep 2020, at 17:47, John Snow <jsnow@redhat.com> wrote:
> > > 
> > > For some of the Python cleanup work I am doing, I am moving preamble comments into docstrings. These docstrings are visible in interactive editors and may be visible when using Sphinx to generate documentation manuals for Python code.
> > > 
> > > My instinct is to remove the licensing and authorship information from the preamble and leave the docstring only with information functionally relevant to the module, while leaving licensing and authorship information in a comment (above? below?).
> > > 
> > > The end effect would be that using e.g. `help(qapi.parser)` in the interactive Python shell would not show licensing or copyright for the module, but it would still be visible in the source file, as always.
> > > 
> > > Is this in bad taste? Do we have strong feelings about authorship and licensing being visible in help output and generated documentation?
> > 
> > What about putting that in a separate pseudo-entity, so that help(copyright) would show it?
> > 
> 
> help is a Python builtin that shows metadata about an object. If an object
> has a docstring, it is capable of displaying that as part of the help
> output. I'm not sure what type you are suggesting `copyright` to be.
> 
> So, you could do something like:
> 
> __copyright__ == """
> Copyright (C) 2020 John Snow, for Red Hat Inc.
> """
> 
> And you could then theoretically do:
> 
> >>> import qapi
> >>> qapi.__copyright__
> 
> which will show you that information. However, I don't think there's any
> standard for module-level metadata like this, so the odds of this
> information being seen or used is low.
> 
> Python has some standards for package-level metadata, but I don't think
> there are any standards for module-level metadata *except* the __doc__
> attribute -- which is where the module-level docstring goes when we write
> one.
> 
> The real question I have is if anyone thinks it would be "rude" to separate
> out any of the comment preambles (currently not visible at runtime or docs
> in any way, shape or form!) into two pieces:
> 
> 1. Functional stuff relating to the usage of the module, visible in
> help(module_name), visible in generated docs, visible in IDE popups, etc.
> 
> 2. Authorship/copyright and licensing info, not visible in the above places.

I think this makes sense. IME it is not common to include copyright /
author info the module help text, as that s non-technical information.

Including author info in API docs in particular I think is liable to
be harmful becuase it will encourage users to directly email
individual authors for help, rather than using collective comms
channels like the mailing lists or forum or bug tracker.

And of course all of this author and copyright info is generally
horribly out of date, as people rarely add themselves when modifying
existing files.

As long as you don't remove the copyright info entirely, that satisfies
the license requirements to preserve copyright notices.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


