Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAEBC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664282065D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vskg/lWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664282065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw0OF-0005ej-OD
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 05:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jw0NO-00055g-Kh
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 05:40:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51731
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jw0NM-0004Jo-QU
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 05:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594892423;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CFhoSKnQ0iRCIUok0udE/VUXmMOjC72xwbEpsmp2iMM=;
 b=Vskg/lWDdRVqmy1Ewa9MqV8M4ccOStCxLWp1wLS7kJiOGdGif2ytZB05daH1CZyj3e5knu
 KKUDrzRzyPN/w2VlBKP76KFZ5sVG+NzW6djJfMDNpN3Pig/dyAw9KW3SXHbF37MOCl8QpN
 BJ/FlSQTgnIIBwOon5bPWPa5K5FNzDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-U7hsmhUHNj6lBkGx5TtVfA-1; Thu, 16 Jul 2020 05:39:59 -0400
X-MC-Unique: U7hsmhUHNj6lBkGx5TtVfA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4836C8015F4;
 Thu, 16 Jul 2020 09:39:58 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 480215C1C3;
 Thu, 16 Jul 2020 09:39:50 +0000 (UTC)
Date: Thu, 16 Jul 2020 10:39:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: introduce cve or security quotient field
Message-ID: <20200716093947.GH227735@redhat.com>
References: <20200714083631.888605-2-ppandit@redhat.com>
 <CAFEAcA9QWLmi1fGuPW93GXFKV2KCwNs6Xp3U9MU2r4wtendzhg@mail.gmail.com>
 <20200714095233.GC25187@redhat.com>
 <20200714060916-mutt-send-email-mst@kernel.org>
 <CAFEAcA_ca4JN655GW=eGyjrjDmiv0EktaZZ7RMghO5rBwm9tGQ@mail.gmail.com>
 <20200714064921-mutt-send-email-mst@kernel.org>
 <nycvar.YSQ.7.78.906.2007141723140.6870@xnncv>
 <20200716085543.7082f047.cohuck@redhat.com>
 <20200716083654.GA227735@redhat.com>
 <nycvar.YSQ.7.78.906.2007161428570.950384@xnncv>
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.78.906.2007161428570.950384@xnncv>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:55:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 16, 2020 at 02:51:55PM +0530, P J P wrote:
> +-- On Thu, 16 Jul 2020, Daniel P. Berrangé wrote --+
> | > Failing to start (with a message that explains why) if one of the command 
> | > line options is not covered by a specified security policy is not 
> | > unreasonable (after all, we fail to start for other cases of incompatible 
> | > command line options as well.)
> 
>   Yes, that's right.
> 
> | > However, we also need to cover dynamically-added devices. Aborting seems 
> | > very bad there, just failing to add the device seems like what we'd want.
> | 
> | Yep, aborting is simply not an option for the inner code. It all has to 
> | propagate to a proper Error **errp object. The ultimate entry-point at the 
> | CLI vs QMP then decides whether to turn the error into an abort or feed back 
> | to the client app.
> 
>   True, handling dynamic devices is tricky.
> 
> Though it seems kind of uniform workflow to check for '--security' flag at 
> options parsing OR while handling dynamic devices at run time; It is a huge 
> task to cover all options/use-cases for all QEMU emulators across various 
> architectures.

Yes, I mentioned earlier in the thread that doing this security check at
runtime is going to be a huge amount of work, because it will need to be
wired up across a wide range of subsystems and APIS and implemnetations
in the QEMU codebase.

I don't think option parsing time will be the place you want a check
at all. You need to parse the --security flag, but once that's done
I think everything else needs to be done at time of object creation,
not config parsing. That ensures the check is present in all possible
codepaths that lead to the functionality being used.

> * If this approach is reasonable, I'll try to make an initial patch towards 
>   it.
> 
> * We'd still need to figure out similar way for compile time option, to 
>   exclude building insecure features at build time.

My suggestion is to do compile time stuff first, as that ought to be a
simpler problem. Having said that, if Paolo's work on meson is likely
to arrive any time soon, then it might make sense to wait for that,
instead of implementing something for Make and then throwing it away
a release later and doing it from scratch in Meson.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


