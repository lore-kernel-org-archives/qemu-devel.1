Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F25C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D99C2098B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0QkH8hY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D99C2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRd6y-0004Sr-H5
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 10:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRd6I-0003wk-AE
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRd6H-0003sX-An
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:45:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53347
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jRd6G-0003n4-So
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587653111;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q9omorazFKDRRNnr1NAof541mZangrjSpDp01f/34gY=;
 b=b0QkH8hYrxjRvNbULR9kL/lv5QKbIMCO4x8ekNfu6LBmUT5+xdmelceGhPTZ3yr96JfzJh
 AQQwpeF9xPNVmRrP+ua0CewJUkmmXyYxIyWr20L9ZhbXSX7oSETbhkFfnyEIdB4RC6tr66
 bUV4VBItR/MxSWuAzJnCg4fvs/mHnjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-W6E7A5n_OnedDOofiMJcwA-1; Thu, 23 Apr 2020 10:45:01 -0400
X-MC-Unique: W6E7A5n_OnedDOofiMJcwA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D77B18FF660;
 Thu, 23 Apr 2020 14:45:00 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26A9326559;
 Thu, 23 Apr 2020 14:44:58 +0000 (UTC)
Date: Thu, 23 Apr 2020 15:44:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dan Christian <dchristian@cardinalpeak.com>
Subject: Re: Need BT support in qemu for Zephyr
Message-ID: <20200423144455.GF1077680@redhat.com>
References: <CADxL6wUGWZO0U=G7UTAebG57m6tG58hoMf_-TCC+0qReUB0G6w@mail.gmail.com>
 <20200423141112.GE1077680@redhat.com>
 <CADxL6wX-0Lt_LKT9pQMiK3Y1L0tdrF9G23dfYU=9FXgFZB-4Fw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADxL6wX-0Lt_LKT9pQMiK3Y1L0tdrF9G23dfYU=9FXgFZB-4Fw@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:42:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 23, 2020 at 08:40:32AM -0600, Dan Christian wrote:
> I'm new to trying to use qemu+bt (via btproxy) and haven't managed to get
> anything working.
>=20
> btproxy is launched first, then Zephyr launches qemu via it's west tool.
> The commands look like:
> sudo tools/btproxy -u -i 0 -d # in a separate window
> x86_64-pokysdk-linux/usr/bin/qemu-system-aarch64 -cpu cortex-a53 -nograph=
ic
> -machine virt -
> net none -pidfile qemu.pid -chardev stdio,id=3Dcon,mux=3Don -serial chard=
ev:con
> -mon chardev=3Dcon,mode=3Dreadline -serial unix:/tmp/bt-server-bredr -ker=
nel
> /home/dchristian/share-fb/zephyrproject/zephy
> r/build/zephyr/zephyr.elf
>=20
> It's failing with a device busy when btproxy tries to bind to the adapter=
.
> I don't think this is a quemu issue.

The command arguments above don't show any use of QEMU's BlueTooth
features. It appears that btproxy is creating a UNIX socket, and QEMU
is just being told to connect a serial port to this UNIX socket. So this
particular setup isn't affected by QEMU removing its BlueTooth support.

As for why it is failing with device busy, I presume this is a btproxy
issue rather than QEMU.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


