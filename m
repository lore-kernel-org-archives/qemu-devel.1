Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ACAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E742074B
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLbJJCSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E742074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1YUD-0000xt-L7
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 13:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k1YTS-0008Uk-Si
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:05:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52942
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k1YTP-0004yg-Iy
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596215133;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iiCr5qznu4rh2hLQbGvra+znxIrLum5WX5PnHK/YTfA=;
 b=cLbJJCSYHYrrDVcw/b3y2xPkEXXyz5vg8+sYdOJkuKGMPsQm+q5SPIAukd8kylQh6gDdNB
 UcmVXxyucS+WZ9po2JkkR1emBccM+lF7buxfwqMqvEiBEpoxsgEZrC9EeGAHqVFPYIEX/K
 slhVRiXeuil1m/O1PuUn0FPm/7bH0lY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-wyM7XUxrPCyz5ASwXb6wug-1; Fri, 31 Jul 2020 13:05:21 -0400
X-MC-Unique: wyM7XUxrPCyz5ASwXb6wug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13AEC1DE2;
 Fri, 31 Jul 2020 17:05:20 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 790B36179C;
 Fri, 31 Jul 2020 17:05:03 +0000 (UTC)
Date: Fri, 31 Jul 2020 18:05:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: cleanups with long-term benefits (was Re: [PATCH] schemas: Add
 vim modeline)
Message-ID: <20200731170500.GF3660103@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org>
 <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org>
 <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org>
 <20200731150738.GB3660103@redhat.com>
 <2cf1a431-9d2c-8ad6-446e-f10b36219764@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2cf1a431-9d2c-8ad6-446e-f10b36219764@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 08:55:49
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
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 31, 2020 at 06:28:06PM +0200, Paolo Bonzini wrote:
> On 31/07/20 17:07, Daniel P. Berrangé wrote:
> > The QAPI JSON-but-not file format is a case where I think we should just
> > adopt a standard file format no matter what. A conversion will have some
> > short term work, but this is really simple data to deal with and the code
> > involved is nicely self contained. Again I'm not saying QAPI maintainers
> > must do it, just put the idea out there as a piece of work that would
> > be welcomed if someone is interested in working ont.
> 
> The main issues with JSON-but-not in QEMU are:
> 
> - the 64-bit integers, which does not apply to the QAPI schema though
> 
> - the comments, which are a common extension to JSON (see JSON5, NodeJS
> config files, json_verify's -c option, etc.) so I find it quite surprising
> that no off-the-shelf Python component can parse JSON + comments
> 
> - the single-quote strings, which are not particularly useful in QAPI schema

NB our files are not JSON documents, they are a concatenation of a list
of JSON documents. 

> 
> If we changed the single-quote strings to double-quote, jsonc.vim
> (https://github.com/neoclide/jsonc.vim) seems to support JSON + comments.
> In Emacs you'd probably add an epilogue like
> 
> (defconst json-mode-comments-re (rx (group "#" (zero-or-more nonl) line-end)))
> (push (list json-mode-comments-re 1 font-lock-comment-face) json-font-lock-keywords-1)
> 
> Did I miss anything?
> 
> Besides that, why are we using Python and not JavaScript in the mode line?

If you use javascript mode, then emacs will highlight all the javascript
language keywords in the comments because it doesn't recognise "#" as a
comment - you need // or /* .. */ for comments in JavaScript

We could of course convert to genuinely use Javascript comment syntax
if we want to consider these files to be JavaScript code instead of
JSON data.


> > Another example would be elimination of anything in QEMU code that is
> > duplicating functionality in GLib, even if there zero functional
> > difference between the two impls.
> 
> Would you consider intrusive lists vs. GList/GSList to be duplicating 
> functionality?  I don't think we have that many duplicates at this 
> point.

Yep, I'd have a preference for use of GList / GSList. Anything which
uses G_DEFINE_AUTOPTR_CLEANUP_FUNC() automatically gets support for
auto cleanup of GList, GSList and GQueue, deep free'ing each element.

https://developer.gnome.org/glib/stable/glib-Miscellaneous-Macros.html#g-autolist

Some of the io/ subsystem could start making more use of GIO APIs. We
didn't use GIO originally as our min-GLib version at the time meant
we couldn't use the functionality we needed.

I'd also suggest replacing  fprintf/printf/sprintf with the g*printf*
equivalents. The benefit here is that GLib guarantees that its variants
work the same way on Windows as on Linux. They pulled in the GNULIB
printf impl to replace Microsoft's broken impl.

There's various silly little things like ARRAY_SIZE vs G_N_ELEMENTS,
and __attribute__ macros - QEMU_NORETURN vs G_GNUC_NORETURN.
QEMU_BUILD_BUG_ON vs G_STATIC_ASSERT

There's QEMU's threads related wrappers. I vaguely there were a couple of
cases where GLib's threads APIs didn't do what we needed. Even if we can't
eliminate all our threads APIs, I expect we can cull alot.

There's util/buffer.{c.h} that can be replaced by GString or GArray.


There's some places where we have misc utility functions that we should
just contribute back to GLib upstream. eg our util/base64.c which offers
improved error checking on base64 decoding. GLib would benefit from this,
and while it won't help qemu immediately, in the long term it will.


> We have qemu_strto*, but unfortunately the GLib function g_ascii_strtoll
> does nothing to fix the awful design of the C standard strto* functions
> (especially the overloading of the return value for error and result).
> If there are cases that are clear cut against adopting the GLib version,
> I think patches would be easily accepted.

The g_ascii_strtoll aren't a drop in replacement for qemu_strto*, as they
have intentionally different semantics from each other, so not an example
I was considering here.

The GLib functions are explicitly always using C-locale, while QEMU's
current places are honouring current locale.

There are some places in QEMU that really should be forcing C-locale,
and so g_ascii_strtoll would actually be a bug fix in those cases.
Other places simply have to stick with what they're currently using
to honour the locale.

> > Another example would be adopting a standard code style and using a
> > tool like clang-format to enforce this for entire of existing code
> > base and future contributions and throwing away our checkpatch.pl
> > which nearly everyone is scared of touching as it is Perl code.
> 
> Checkpatch does much more than that, though the scary part is indeed the 
> one that enfoces coding style.  I wouldn't have a problem with using
> clang-format and calling it a day.

If there are things missing that we consider important, a long term
better strategy would be to use the Python binding to libclang to
detect the problem, instead of trying to parse C code with Perl and
regexes.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


