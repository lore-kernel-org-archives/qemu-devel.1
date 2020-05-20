Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD69C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2DDF207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNPPAOTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DDF207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbPng-0003tA-WD
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbPn6-0003AL-C5
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:33:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28098
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbPn4-00007Y-LF
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589985228;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/rxmbQB15XnjJ5QvoIuLRmig8PuytryiGJ+2pjE9AqY=;
 b=dNPPAOTVZkdn6UPtOhVwLJpC/cFVNS6ARCq91RE1HwnhDn6LLCk8O5yN3AHsOt3iM40t5c
 oCiBzUytDG/8MZOFzulstmrhfnWRzfMeHuriIOm+I1INgsWBnk/43HMzq2oWL7QUGMOFKj
 ja576nK1hqLkL/rvmedSyOpBqYruI+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-xIpU26LgPyavmfBphgB0XQ-1; Wed, 20 May 2020 10:33:46 -0400
X-MC-Unique: xIpU26LgPyavmfBphgB0XQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB1971800D42;
 Wed, 20 May 2020 14:33:45 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3FA182A24;
 Wed, 20 May 2020 14:33:38 +0000 (UTC)
Date: Wed, 20 May 2020 15:33:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PULL 1/3] qemu-sockets: add abstract UNIX domain socket support
Message-ID: <20200520143335.GL2194189@redhat.com>
References: <20200520130025.2201467-1-berrange@redhat.com>
 <20200520130025.2201467-2-berrange@redhat.com>
 <87imgqr8g9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87imgqr8g9.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: xiaoqiang zhao <zxq_yx_007@163.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 04:23:50PM +0200, Markus Armbruster wrote:
> I apologize for chiming in so late...
> 
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > From: xiaoqiang zhao <zxq_yx_007@163.com>
> >
> > unix_listen/connect_saddr now support abstract address types
> >
> > two aditional BOOL switches are introduced:
> > tight: whether to set @addrlen to the minimal string length,
> >        or the maximum sun_path length. default is TRUE
> 
> When and why would anyone pass 'tight': false?

In the abstract namespace the length of the socket is critical
information. ie

   "\0foo" (length == 4,  tight=true)

is a completely different socket from

   "\0foo\0..repeated...\0" (length == sizeof(sun_path), tight=false)

In theory you can have any length in between those extremes,
each being a different socket, but in practice no one is that
insane. Apps either use the full length, or the minimal
length. The "tight" terminology is copied from "socat" which
uses this same option name


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


