Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64177C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26240206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MR5vD7dr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26240206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZXX3-0000IX-AX
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 06:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jZXVM-0006cz-LG
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:23:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37439
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jZXVL-0005L2-3f
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589538226;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ptqfW/dI+y0Ty24LReYiuYZ4d2+CTDcjSi2JoSfnAYE=;
 b=MR5vD7drANkRSbX51ZzLgO8NWGkMcc6uDahpyjb8cpg03zGEMCbzTUWbLlRjCy4A0/WVSI
 vONcLcCMR7CRU9HLDpIo484pv+lJtSjPzP0EpMpFM94Z2pbpdI1SSuihNA2UeqF770mDA0
 FAMTGPCKuOj6lULq2ZdFz5TpuoD0b5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-Tn_bDupHMgK7iLM9iOT_5Q-1; Fri, 15 May 2020 06:23:32 -0400
X-MC-Unique: Tn_bDupHMgK7iLM9iOT_5Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C75180183C;
 Fri, 15 May 2020 10:23:31 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4091C341E3;
 Fri, 15 May 2020 10:23:25 +0000 (UTC)
Date: Fri, 15 May 2020 11:23:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: QEMU 5.1: Can we require each new device/machine to provided a
 test?
Message-ID: <20200515102321.GH1300305@redhat.com>
References: <CAAdtpL7gSqz+R5LfbvsuxeeCzf1K-omHSeYo2eTOFYaMS1bp6A@mail.gmail.com>
 <96440c8b-7f38-8fc4-0e9c-07ad878211e2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <96440c8b-7f38-8fc4-0e9c-07ad878211e2@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-discuss@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 15, 2020 at 12:11:17PM +0200, Thomas Huth wrote:
> On 07/04/2020 12.59, Philippe Mathieu-Daudé wrote:
> > Hello,
> > 
> > Following Markus thread on deprecating unmaintained (untested) code
> > (machines) [1] and the effort done to gather the information shared in
> > the replies [2], and the various acceptance tests added, is it
> > feasible to require for the next release that each new device/machine
> > is provided a test covering it?
> > 
> > If no, what is missing?
> 
> If a qtest is feasible, yes, I think we should require one for new
> devices. But what about machines - you normally need a test image for
> this. In that case, there is still the question where testing images
> could be hosted. Not every developer has a web space where they could
> put their test images onto. And what about images that contain non-free
> code?

Yep, it isn't feasible to make this a hard rule.

IMHO this is where a support tier classification comes into play

 - Tier 1: actively maintained, qtest coverage available. Expected
           to work reliably at all times since every commit is CI
	   tested

  - Tier 2: actively maintained, no qtest coverage. Should usually
           work but regression may creep in due to reliance on the
	   maintainer to manually test on adhoc basis

  - Tier 3: not actively maintained, unknown state but liable to
            be broken indefinitely

Tier 1 is obviously the most desirable state we would like everthing to
be at. Contributors will have to fix problems their patches cause as
they will be blocked by CI.

Tier 2 is an admission that reality gets in the way. Ideally stuff in
this tier will graduate to Tier 1 at some point. Even if it doesn't
though, it is still valid to keep it in QEMU long term. Contributors
shouldn't gratuitously break stuff in these board, but if they do,
then the maintainer is ultimately responsible for fixing it, as the
contributors don't have a test rig for it.

Tier 3 is abandonware. If a maintainer doesn't appear, users should
not expect it to continue to exist long term. Contributors are free
to send patches which break this, and are under no obligation to
fix problems in these boards. We may deprecate & delete it after a
while


Over time we'll likely add more criteria to stuff in Tier 1. This
could lead to some things dropping from Tier 1 to Tier 2. This is
OK, as it doesn't make those things worse than they already were.
We're just saying that Tier 2 isn't as thoroughly tested as we
would like it to be in an ideal world.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


