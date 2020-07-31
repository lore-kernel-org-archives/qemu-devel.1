Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5F2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F4D2245C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJoLQ5bP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F4D2245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Ype-00043U-DI
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 13:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k1Yox-0003Y4-26
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:27:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55174
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k1Yot-0007oL-Hs
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596216466;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Lr2jCozN/zo2AclNrCGbSjh8CbuUR6mWWmzZJMuoQUQ=;
 b=gJoLQ5bPF5cIX7pGJf6mCa1BlyggJaqBUGDvQetCMOUJ42IrFC98Of/gMH58dh7a1eyJan
 1JaulWFZL1+VFstZuwmrVN2/HSKh4EbVCO9xIDlG3NRs//l8l+VnvPjCKNWdn+809S1Vww
 YS44MAJgX2h7bEAzjYtzu+RF+8VfQZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-dHtfDrUwMOqic3KexUvv5A-1; Fri, 31 Jul 2020 13:27:40 -0400
X-MC-Unique: dHtfDrUwMOqic3KexUvv5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A9E28014D7;
 Fri, 31 Jul 2020 17:27:39 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67F457C0F1;
 Fri, 31 Jul 2020 17:27:26 +0000 (UTC)
Date: Fri, 31 Jul 2020 18:27:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: cleanups with long-term benefits (was Re: [PATCH] schemas: Add
 vim modeline)
Message-ID: <20200731172723.GH3660103@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org>
 <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org>
 <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org>
 <20200731150738.GB3660103@redhat.com>
 <2cf1a431-9d2c-8ad6-446e-f10b36219764@redhat.com>
 <20200731170500.GF3660103@redhat.com>
 <c2ad1dd6-d53e-b4fa-79e2-0006ddf2f5b2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c2ad1dd6-d53e-b4fa-79e2-0006ddf2f5b2@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 12:28:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jul 31, 2020 at 07:16:54PM +0200, Paolo Bonzini wrote:

> >>> Another example would be adopting a standard code style and using a
> >>> tool like clang-format to enforce this for entire of existing code
> >>> base and future contributions and throwing away our checkpatch.pl
> >>> which nearly everyone is scared of touching as it is Perl code.
> >> Checkpatch does much more than that, though the scary part is indeed the 
> >> one that enfoces coding style.  I wouldn't have a problem with using
> >> clang-format and calling it a day.
> > If there are things missing that we consider important, a long term
> > better strategy would be to use the Python binding to libclang to
> > detect the problem, instead of trying to parse C code with Perl and
> > regexes.
> 
> Most of it is simply "use this function instead of this one" or "place a
> comment to explain why you're using this".  The main feature of
> checkpatch.pl however is that it works on patches, not just files, but
> still there would be a substantial advantage in employing clang-format.

You say "main feature", I say "biggest flaw" ;-P

Doing checks on patches is the single worst thing about the way
we do code style validation, at it means the bulk of committed code
is never in compliance. The need to check patches is precisely because
the committed code is unclean and so can't be checked without raising
pages of problems.

Once clang-format forces the entire codebase to be in compliance then
there is (almost) no reason to check patches at all. Simply apply the
patch and check the resulting tree.  You do still want a check on the
patch to validate Signed-off-by, but that can be done as a standalone
script eg in libvirt when using GitLab CI for validating patch series,
we have this as a job:

https://gitlab.com/libvirt/libvirt-ci/-/blob/master/containers/check-dco/check-dco.py

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


