Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F04BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28DD02065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKVk0/ZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DD02065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFuN-00069C-8F
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 11:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jZFta-0005OU-Ol
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:35:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60911
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jZFtZ-0003aQ-9I
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589470535;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7L79hraQRHHTmNchjUQwCVuH9Y6HsuVX8gpzXalr1H4=;
 b=WKVk0/ZIlkv4CORxd0hm8gag79n83/lySMhT9aAU7FPUKnjT8o8ri3M6ipuh+/gZ0GgdoG
 Ovd9rOrt56Pm8BxgIBVTWH2JRSdRsxIvo+DQ8kQNcHpgAS7NvyVKjwRA6y8Zzya0XSigvM
 Eq4R53EoL/ESK85Hm4Wq6pRkNMyVEgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-TKiPXbgeMGOmrv3ULWOE2w-1; Thu, 14 May 2020 11:35:24 -0400
X-MC-Unique: TKiPXbgeMGOmrv3ULWOE2w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1B7D8B1A03;
 Thu, 14 May 2020 15:35:09 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B597A619DA;
 Thu, 14 May 2020 15:34:59 +0000 (UTC)
Date: Thu, 14 May 2020 16:34:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: proposal: deprecate -readconfig/-writeconfig
Message-ID: <20200514153456.GL1280939@redhat.com>
References: <7599153e-89a2-9a86-16ad-4a3c6a107b18@redhat.com>
 <20200514085622.GB1280939@redhat.com>
 <56379563-c1f3-3270-f9ac-5bdd49b324aa@redhat.com>
MIME-Version: 1.0
In-Reply-To: <56379563-c1f3-3270-f9ac-5bdd49b324aa@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:35:35
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
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 14, 2020 at 10:40:40AM -0400, John Snow wrote:
> 
> 
> On 5/14/20 4:56 AM, Daniel P. Berrangé wrote:
> > On Thu, May 14, 2020 at 10:09:21AM +0200, Paolo Bonzini wrote:
> >> IMHO configuration files are in general a failed experiment.  In
> >> practice, they do not add much value over just a shell script because
> >> they don't allow configuring all QEMU options, they are very much fixed
> >> (by their nature).  I think it's more or less agreed that they are not
> >> solving any problem for higher-level management stacks as well; those
> >> would prefer to configure the VM via QMP or another API.
> >>
> >> So, any objections to deprecating -readconfig and -writeconfig?
> > 
> > Libvirt would like to have a config file for QEMU, but it would have
> > to be one that actually covers all the config options QEMU supports,
> > and ideally using a data format in common with that used for runtime
> > changes. So for libvirt's needs the current readconfig is entirely
> > useless.
> > 
> 
> Yeah. In this sense, would a json/yaml config file help, under the
> premise that you could just cat it into the pipe to configure a machine?
> 
> (Assuming we had proper runtime configuration commands, of course.)

Yeah, the key thing is that you really want to be able to provide the
whole initial config in one go as an atomic action. I don't want to
issue 100 individual QMP commands to load each initial device. With
that in mind it doesn't really matter whether you do

  $ qemu -qmp stdio
  (qmp) load-config /some/file.yaml

vs

  $ qemu -qmp stdio -load-config /some/file.yaml

though the latter is probably slightly nicer as it lets you grep
for the VM based on the filename visible in the CLI. 

> > Overall, I don't object, just cautioning that we should be aware that
> > we're likely to have some users of this feature we're conciously going
> > to break.
> 
> Sometimes I feel like a broken and impartial solution is really worse
> than having none. If we don't truly support the read/write config
> options, we shouldn't pretend that we do.
> 
> Funneling users back to using the CLI is likely the better thing, even
> with no replacement.
> 
> I realize this is a pretty hostile thing to do in general, though, but
> it might truly be the kinder option to start simplifying and unifying
> configuration, documentation, and support efforts.
>
> We don't have to actually remove it right away, either. We can just
> start sounding the alarms that we're preparing to remove it, and falling
> back to using the CLI would be a safe thing to do for now.

My gut feeling is that we need to do something a bit more adventurous
if we're to get QEMU to move forward in solving the 10+ year old problem
of a formally described, consistent configuration syntax.

Just deprecating & removing -readconfig is just one small mole hill out
of 100 so doesn't move things along much on its own.


I tend to think we'd be better served by focusing on introducing a new set
of binaries,  qemu-vm-$TARGET, which exclusively use a new config syntax,
free of any legacy baggage present in qemu-system-$TARGET.

Work on qemu-vm-$TARGET will involve refactoring, and that will certainly
risk causing bugs in qemu-system-$TARGET. The premise though is that this
risk is lower, than if we tried to retrofit a new config syuntax directly
into qemu-system-$TARGET.

In particular I think it is basically impossible to do any meaningful
changes in the main() method of softmmu/vl.c, due to the fragile ordering
for creation of various different devices/backends, and its interaction
with the argv parsing. By using a new qemu-vm-$TARGET we can have a new
softmmu/vm.c, instead of vl.c. We'll still likely need to modify parts of
vl.c to use new/changed API calls, but that's less distruptive, as we
can leave the crazy logic for ordering of device creation untouched.


In the past we've been fairly cautious of any change which might risk
back compat problems in qemu-system-$TARGET. I think we can say we're not
going to gratuitously break qemu-system-$TARGET, but at the same time we
are not going to make heroic efforts at (unachievable) perfection.

IOW, accept that we'll probably cause regressions in some edge cases in
qemu-system-$TARGET. We'll make reasonable effort to fix them if they
are reported, but we're willing to accept the risk of disruption in the
short term, in order to get to a better long term solution.

Depending on how much of a burden it is to keep qemu-system-$TARGET around
long term, it could exist forever without any new feature work on its CLI;
Or it could be turned into a shim around qemu-vm-$TARGET; Or it could
be deprecated over a prolonged period (as opposed to the usual 2 release
minimum).

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


