Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE5CC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8086D2082C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8086D2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6BoC-0001Zc-Mz
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 06:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i6BmK-0008QY-6y
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i6BmH-0001pH-KL
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:47:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44002)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i6BmH-0001or-AO
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:47:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9459A3082B67;
 Fri,  6 Sep 2019 10:47:40 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96F415EE1D;
 Fri,  6 Sep 2019 10:47:33 +0000 (UTC)
Date: Fri, 6 Sep 2019 11:47:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190906104730.GU5119@redhat.com>
References: <20190905152136.30637-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190905152136.30637-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 06 Sep 2019 10:47:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 0/3] virtiofsd: get/set log level via DBus
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
Cc: virtio-fs@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Eryu Guan <eguan@linux.alibaba.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 05, 2019 at 04:21:33PM +0100, Stefan Hajnoczi wrote:
> It is likely that virtiofsd will need to support "management commands" for
> reconfiguring it at runtime.  The first use case was proposed by Eryu Guan for
> getting/setting the current log level.
> 
> I promised to try out DBus as the management interface because it has a rich
> feature set and is accessible from most programming languages.  It should be
> able to support all the use cases we come up with.
> 
> This patch series is a prototype that implements the get-log-level and
> set-log-level management commands via DBus.  Use the new virtiofsctl tool to
> talk to a running virtiofsd process:
> 
>   # dbus-run-session ./virtiofsd ...
>   ...
>   Using dbus address unix:abstract=/tmp/dbus-H9WBbpjk3O,guid=0be16acefb868e6025a8737f5d7124d2
>   # export DBUS_SESSION_BUS_ADDRESS=unix:abstract=/tmp/dbus-H9WBbpjk3O,guid=0be16acefb868e6025a8737f5d7124d2
>   # ./virtiofsctl set-log-level err
> 
> Most of the work is done by gdbus-codegen(1).  It generates code for the
> org.qemu.Virtiofsd.xml interface definition.  Our code can use the simple
> virtiofsd_get/set_log_level() APIs and it will make corresponding DBus calls.
> 
> I'm pretty happy with this approach because the code is straightforward.  It
> hasn't even triggered seccomp failures yet :).
> 
> Error handling is a little problematic.  I noticed that virtiofsctl silently
> returns success even if it cannot talk to virtiofsd.  This is due to the code
> generated by gdbus-codegen(1) which has no error reporting :(.  This can be
> solved by writing more low-level GDBus code instead of using the high-level
> generated bindings.

You declared a simple property for the log level, which gets mapped into
GObject properties, and hence hit the error reporting limitations they
have.  DBus at the protocol level can report errors for properties.

For log level settings I'm not worried, but more generally we may well
hit cases where error reporting is functionally critical. So we have a
choice I think

 - Enhance gdbus-codegen so that it can map DBus properties to a different
   impl, with explicit getters/setters, ignoring GObject's properties. This
   would allow for a GError ** parameter to handle/report errors

 - Don't use properties at the DBus protocol level. Instead simply define
   explicit setter & getter methods in DBus. These woudl again bypass
   GObject's properties

Option 2 is probably easier to be honest, especially since in the code
you end up calling what are setters & getters on the client side anyway.

> What do you think about this approach?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

