Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9F3C8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:40:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8219020838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSjN1/fG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8219020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU6c3-0003Tr-JO
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 06:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jU6b4-0001zH-A4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jU6b3-0000F2-K7
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:39:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32523
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jU6b3-0000Em-69
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588243152;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZzpLrFaNmL5zrjqJB+7Xjul4O10puM0LVQTANcH2BH8=;
 b=FSjN1/fG794eiTFh+kEHE15ptvIXEx4jgoF/zD/52472JDvlq0Sm5svZHTRucUg4qDD1sT
 7yeUoOeUxGD3NR1ch4GyWj/FdcF1uXrV92aIRfanB/SdIGtI0dQSLICVZc7t4Tp6rQ5ndD
 UFhyhFQ4UWi6+FL7yVusjnnHeFTvvFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-s1z0VKOkMaSNsEd3mj0g1g-1; Thu, 30 Apr 2020 06:39:11 -0400
X-MC-Unique: s1z0VKOkMaSNsEd3mj0g1g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1243800D24;
 Thu, 30 Apr 2020 10:39:09 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA989196AE;
 Thu, 30 Apr 2020 10:39:08 +0000 (UTC)
Date: Thu, 30 Apr 2020 11:39:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests: add a "check-flake8" test for validating python
 code style
Message-ID: <20200430103905.GJ2084570@redhat.com>
References: <20200429153621.1694266-1-berrange@redhat.com>
 <9f000680-d32a-5e43-d45b-58391063b7fc@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9f000680-d32a-5e43-d45b-58391063b7fc@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 30, 2020 at 12:29:28PM +0200, Paolo Bonzini wrote:
> On 29/04/20 17:36, Daniel P. Berrang=C3=A9 wrote:
> > The flake8 program is a standard tool used by Python projects for
> > validating many commonly recommended style rules. It would be desirable
> > for QEMU to come into alignment with normal Python coding style best
> > practices.
> >=20
> > QEMU currently violates a huge number of the style rules, so we can't
> > blindly turn it on. Instead this patch introduces use of flake8 with
> > a huge ignore list to turn off everything that is currently violated.
> >=20
> > The following descriptions are mostly taken from:
> >=20
> >   https://www.flake8rules.com/
>=20
> I suggest instead using "black" and just reformat everything in a huge
> patch; that's what we're using for Patchew.

Personally I'm a fan of automated code formatters that can enforce a
specific style, so no objection from me.

> It's not perfect, and especially one needs to get used to the double
> quotes instead of single quotes for strings.  However overall it is
> pretty good, and I've never seen it do something clearly "wrong".

I've not looked at black in any detail, but if its focused on code
style, then there might be a few bits from flake8 that are still
useful, such as checking for unused imports, or unresolved variable
names. Then again, perhaps Jon's pylint stuff will already catch
that.

> > On its own this patch doesn't really do much of use except try to stop =
the
> > situation getting worse. To be valuable some motivated contributor(s)
> > would need to go through fixing the code, and re-enabling each excluded
> > warning category one at a time.
> >=20
> > I'm mostly proposing this patch as a starting point for discussion, to
> > see if anyone is indeed motivated to take on the code cleanup challenge=
,
> > and feed the fixes in through the various maintainers trees.
>=20
> If we go with "black" I suggest just doing a big patch for everything,
> since it's easy for maintainers to rebase by running black at each step.
>  Overall our usage of Python is small enough that it should not be a big
> deal.



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


