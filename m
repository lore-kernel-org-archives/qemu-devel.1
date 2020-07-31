Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D2BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 15:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A8A21744
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 15:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNuLNR7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A8A21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1WeZ-0005Ft-1O
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 11:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k1Wds-0004l8-2a
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 11:08:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20380
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k1Wdp-0004KO-4U
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 11:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596208091;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jY6lhzu26CxIzvdMyKvm0trMT4SNao1zKsW85j3G+WM=;
 b=WNuLNR7J4xsiVAslwO2v3zLxZhXN30J1WBIgAglofNIxfwkycVispdxCXTq4YexYvHc5we
 YLZ4bxHvdolb0QcKBpWF1VtWhTnW+BWIaimPk9aFjOShoOz4sX3ueamdbLQ0ZNQfExffpM
 2nqpF22Al3ci0DIqhihB6Exlv7jIKBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-hQs0s23xOnixpSzT9nDkmQ-1; Fri, 31 Jul 2020 11:07:55 -0400
X-MC-Unique: hQs0s23xOnixpSzT9nDkmQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE66B802B41;
 Fri, 31 Jul 2020 15:07:53 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41F4A7C0ED;
 Fri, 31 Jul 2020 15:07:41 +0000 (UTC)
Date: Fri, 31 Jul 2020 16:07:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] schemas: Add vim modeline
Message-ID: <20200731150738.GB3660103@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org>
 <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org>
 <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <875za33ku1.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 04:39:53
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
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 31, 2020 at 02:55:34PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:

> >> Some of the criticism there doesn't matter for our use case.
> >
> > Yeah, what matters is whether it can do the job we need in a way that is
> > better than what we have today, and whether there are any further options
> > to consider that might be viable alternatives.
> 
> Would it improve things enough to be worth the switching pain?

The short answer is that I don't think that question matters. We should
do the conversion regardless, as our JSON-but-not file format has no
compelling reason to exist as a thing when there's a variety of standard
file formats that could do the job. I'd explicitly ignore the sunk costs
and minor amount of work to convert to a new format.

The long answer is that as a general philosophy I'm in favour of agressively
eliminating anything that is custom to a project and isn't offering an
compelling benefit over a functionally equivalent, commonly used / standard
solution.

Any time a project re-invents the wheel, that is one more piece of custom
knowledge a contributor has to learn. Each one may seem insignificant on
its own, but cummulatively they result in death by a 1000 cuts. This makes
a project increasingly less attractive to contribute to over the long term.

Measuring the long term benefit of the change is generally quite difficult,
because while you can see what impact a change will have today on current
code, it is hard to usefully evaluate future benefits as you're trying to
imagine the impact on things that don't even exist.

Overall my POV is not to think too hard about measuring improvements, and
discard any concern about sunk costs. Instead have a general presumption
in favour of eliminating any examples of wheel re-invention in a project.
Even if regular contributors don't want to spend time on such work, this
kind of thing is pretty amenable to new contributors looking for tasks to
start their involvement.

The QAPI JSON-but-not file format is a case where I think we should just
adopt a standard file format no matter what. A conversion will have some
short term work, but this is really simple data to deal with and the code
involved is nicely self contained. Again I'm not saying QAPI maintainers
must do it, just put the idea out there as a piece of work that would
be welcomed if someone is interested in working ont.

Another example would be elimination of anything in QEMU code that is
duplicating functionality in GLib, even if there zero functional
difference between the two impls.

Another example would be adopting a standard code style and using a
tool like clang-format to enforce this for entire of existing code
base and future contributions and throwing away our checkpatch.pl
which nearly everyone is scared of touching as it is Perl code.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


