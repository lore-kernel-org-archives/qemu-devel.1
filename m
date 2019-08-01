Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D56C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BAAF20838
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BAAF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htGBM-0006UK-UM
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 14:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34835)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1htGA3-0005RM-Ew
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1htGA2-0003nk-8X
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:50:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53556)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1htGA2-0003l8-0X
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:50:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 56B1E30E3CC2;
 Thu,  1 Aug 2019 18:50:45 +0000 (UTC)
Received: from localhost (ovpn-116-22.gru2.redhat.com [10.97.116.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1D865D6B2;
 Thu,  1 Aug 2019 18:50:44 +0000 (UTC)
Date: Thu, 1 Aug 2019 15:50:43 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190801185043.GC20035@habkost.net>
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-24-armbru@redhat.com>
 <20190729194414.GG4313@habkost.net>
 <87d0hreqh3.fsf_-_@dusky.pond.sub.org>
 <8bea0201-f796-d682-22e6-069985b45523@redhat.com>
 <0eb2518f-147c-2b47-f48c-3af26bf5d264@redhat.com>
 <20190730210718.GU4313@habkost.net>
 <e995c6d9-f63a-be72-7d15-ac59a343b487@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e995c6d9-f63a-be72-7d15-ac59a343b487@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 01 Aug 2019 18:50:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] HACKING: Document 'struct' keyword usage
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 31, 2019 at 10:35:31AM +0200, Thomas Huth wrote:
> On 30/07/2019 23.07, Eduardo Habkost wrote:
> > Sometimes we use the 'struct' keyword to help us reduce
> > dependencies between header files.  Document that practice.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > I wonder if this is too terse?  Should we give examples?
> > ---
> >  HACKING | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/HACKING b/HACKING
> > index 0fc3e0fc04..112685bdaf 100644
> > --- a/HACKING
> > +++ b/HACKING
> > @@ -101,6 +101,8 @@ it points to, or it is aliased to another pointer that is.
> >  
> >  2.3. Typedefs
> >  Typedefs are used to eliminate the redundant 'struct' keyword.
> > +However, the 'struct' keyword may be sometimes used in header
> > +files to avoid unnecessary dependencies between headers.
> 
> See also the discussion earlier this year:
> 
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg586180.html

Nice, it adds even more information than this patch.

For reference, this is the patch at the URL above:

-Typedefs are used to eliminate the redundant 'struct' keyword.
+Typedefs can be used to eliminate the redundant 'struct' keyword. This is
+especially helpful for common types that are used all over the place. Since
+certain C compilers choke on duplicated typedefs, you should avoid them and
+declare a typedef only in one header file. For common types, you can use
+"include/qemu/typedefs.h" for example. Note that it is also perfectly fine to
+use forward struct definitions without typedefs for references in headers
+to avoid the problem with duplicated typedefs.

I don't agree with the first two sentences, and I agree with what Paolo said
here:
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg586214.html

("I agree 100% with the wording after 'Since'.  However, I think the first
part should be made stronger, not weaker.")

Paolo sent the following proposal:

| Typedefs are use to eliminate the redundant 'struct' keyword, since type
| names have a different style than other identifiers ("CamelCase" versus
| "snake_case").  Each struct should have a CamelCase name and a
| corresponding typedef.
| 
| Since certain C compilers choke on duplicated typedefs, you should avoid
| them and declare a typedef only in one header file.  For common types,
| you can use "include/qemu/typedefs.h" for example.  However, as a metter
| of convenience it is also perfectly fine to use forward struct
| definitions instead of typedefs in headers and function prototypes; this
| avoids problems with duplicated typedefs and reduces the need to include
| headers from other headers.

It seems perfect to me.

Paolo, do I have your signed-off-by to send that in a patch?

> 
> ... and we should merge HACKING and CODING_STYLE finally (that was on my
> private TODO list, but I never found the time to do it).

Agreed, but I prefer to fix one problem at a time.

-- 
Eduardo

