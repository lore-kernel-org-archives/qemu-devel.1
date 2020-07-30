Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2030C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 09:38:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27D92075F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 09:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVqeGek/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27D92075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k151X-0004yb-Po
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 05:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k150u-0004UT-Ea
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 05:38:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45076
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k150q-00075d-BW
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 05:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596101886;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eCSOliA8coQwve9gxdQyLyEBlif6XTePOXzENrrgh4c=;
 b=CVqeGek/I5w6cSXvTRnro42QWmVUUeG+I02ciNRiUK3s7mF0H07OArFJibgaHpOpGRWNbw
 f5sZcGe4y0VZrSUXhZEaLBFyb+pb0LgmmbBDdFqog1JENfgFsYblBe7rVRk0BrOH+Ho9O6
 hlpftvfeboxxukzMnW56DBPoVPHZHhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-uleclHghMSKqrbdWEnYNfQ-1; Thu, 30 Jul 2020 05:37:48 -0400
X-MC-Unique: uleclHghMSKqrbdWEnYNfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7F361005504;
 Thu, 30 Jul 2020 09:37:46 +0000 (UTC)
Received: from redhat.com (ovpn-114-181.ams2.redhat.com [10.36.114.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FB408A177;
 Thu, 30 Jul 2020 09:37:34 +0000 (UTC)
Date: Thu, 30 Jul 2020 10:37:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] schemas: Add vim modeline
Message-ID: <20200730093732.GB3477223@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87ime52wxd.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Andrea Bolognani <abologna@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 30, 2020 at 11:07:26AM +0200, Markus Armbruster wrote:
> Andrea Bolognani <abologna@redhat.com> writes:
> 
> > The various schemas included in QEMU use a JSON-based format which
> > is, however, strictly speaking not valid JSON.
> >
> > As a consequence, when vim tries to apply syntax highlight rules
> > for JSON (as guessed from the file name), the result is an unreadable
> > mess which mostly consist of red markers pointing out supposed errors
> > in, well, pretty much everything.
> >
> > Using Python syntax highlighting produces much better results, and
> > in fact these files already start with specially-formatted comments
> > that instruct Emacs to process them as if they were Python files.
> >
> > This commit adds the equivalent special comments for vim.
> >
> > Signed-off-by: Andrea Bolognani <abologna@redhat.com>

Given that we already have emacs mode-lines, I see no reason to
not also have vim mode-lines, so regardless of the deeper discussion
I think this is patch is fine to merge in the short term

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> Naming QAPI schema files .json even though their contents isn't was a
> mistake.  Correcting it would be a pain.  If we correct it, then the
> sooner the better.
> 
> Renaming them to .py gives decent editor support out of the box.  Their
> contents isn't quite Python, though: true vs. True, false vs. False.  Do
> we care?  Only a few dozen occurences; they could be adjusted.
> 
> Renaming them to .qapi would perhaps be less confusing, for the price of
> "out of the box".

IMHO, the critical rule is that if you a pick a particular file extension
associated with an existing language, you absolutely MUST BE compliant
with that language.

We fail at compliance with both JSON and Python because we're actually
using our own DSL (domain specific language).

IOW if we're going to stick with our current file format, then we should
be naming them .qapi. We can still use an editor mode line if we want to
claim we're approximately equiv to another language, but we can't be
surprised if editors get upset.


The bigger question is whether having our own DSL is justified ?

I'm *really* sceptical that it is.


We can't use JSON because it lacks comments. So we invented our own
psuedo-JSON parser that supported comments, and used ' instead of "
for some reason. We also needed to be able to parse a sequence of
multiple JSON documents in one file. We should have just picked a 
different language because JSON clearly didn't do what we eneeded.

You suggest naming them .py. If we do that, we must declare that they
are literally Python code and modify them so that we can load the 
files straight into the python intepretor as code, and not parse 
them as data. I feel unhappy about treating data as code though.


While JSON doesn't do what we need, its second-cousin YAML is a more
flexible format. Taking one example

---
##
# @ImageInfoSpecificQCow2:
#
# @compat: compatibility level
#
# ...snip...
#
# Since: 1.7
##
struct: ImageInfoSpecificQCow2
data:
  compat: str
  "*data-file": str
  "*data-file-raw": bool
  "*lazy-refcounts": bool
  "*corrupt": bool
  refcount-bits: int
  "*encrypt": ImageInfoSpecificQCow2Encryption
  "*bitmaps":
    - Qcow2BitmapInfo
  compression-type: Qcow2CompressionType


Then we could use a regular off the shelf YAML parser in python.

The uglyiness with quotes is due to the use of "*". Slightly less ugly
if we simply declare that quotes are always used, even where they're
not strictly required.

struct: ImageInfoSpecificQCow2
data:
  "compat": "str"
  "*data-file": "str"
  "*data-file-raw": "bool"
  "*lazy-refcounts": "bool"
  "*corrupt": "bool"
  "refcount-bits": "int"
  "*encrypt": "ImageInfoSpecificQCow2Encryption"
  "*bitmaps":
    - "Qcow2BitmapInfo"
  "compression-type": "Qcow2CompressionType"

With the use of "---" to denote the start of document, we have no trouble 
parsing our files which would actually be a concatenation of multiple 
documents. The python YAML library provides the easy yaml.load_all()
method.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


