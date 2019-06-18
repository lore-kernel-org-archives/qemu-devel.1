Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C796C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 08:58:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C448F2084B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 08:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C448F2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54930 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd9wP-00038g-PL
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 04:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45821)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hd9to-00021R-Fb
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 04:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hd9tg-0002qJ-8U
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 04:55:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54436)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hd9te-0002oY-Bc
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 04:55:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C5E593098576;
 Tue, 18 Jun 2019 08:55:09 +0000 (UTC)
Received: from redhat.com (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE10782081;
 Tue, 18 Jun 2019 08:54:59 +0000 (UTC)
Date: Tue, 18 Jun 2019 09:54:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: elena.ufimtseva@oracle.com
Message-ID: <20190618085456.GD28525@redhat.com>
References: <20190617181450.29092-1-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190617181450.29092-1-elena.ufimtseva@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 18 Jun 2019 08:55:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/35] Initial support of
 multi-process qemu
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
Cc: john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com,
 qemu-devel@nongnu.org, ross.lagerwall@citrix.com, liran.alon@oracle.com,
 stefanha@redhat.com, kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 17, 2019 at 11:14:50AM -0700, elena.ufimtseva@oracle.com wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> 
> Initial support of multi-process qemu
> 
> Started with the presentation in October 2017 made by
> Marc-Andre (Red Hat) and Konrad Wilk (Oracle)
> (http://events17.linuxfoundation.org/sites/events/files/slides/KVM%20FORUM%20multi-process.pdf,
> https://www.youtube.com/watch?v=Kq1-coHh7lg) and
> continued in the BoF session at the KVM forum in 2018 with Jag leading
> the discussion, the multi-process project is now in the prototype version
> and presented by this patchset.
> 
> The proof of the concept patches were posted on the qemu-devel mailing
> list before the BoF session at the KVM forum and can be found here:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg566538.html
> 
> This series presents the initial support for QEMU that can
> launch some of the devices in the remote processes.
> 
> Thanks to a v1 review and some of the question Stefan and Daniel asked, we
> were able to incorporate your ideas into our goals.
> 
> We would like to present version 2 of the patchset.
> This version has addressed comments made during the review of v1 and includes:
> 
> - support for libvirt fork/exec of remote processes;
>   QEMU is still capable of fork/execing the remote processes unless its disabled
>   by seccomp.
>   When using libvirt, the daemon will spawn remote processes and pass the communication
>   file descriptors to main QEMU process and the remote processes.
>   The libvirt patches are in the making and will be sent out shortly;
> - using existing -device/-drive command line options to specify remote devices with
>   additional suboptons;
> - refractor message sending code;
> - remove specific HMP/QMP commands and use the one that exist now;
> - extend existing QMP commands;
> - added timeout to communication channel;
> 
> Following people contributed to this patchset:
> 
> John G Johnson <john.g.johnson@oracle.com>
> Jagannathan Raman <jag.raman@oracle.com>
> Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Kanth Ghatraju <kanth.ghatraju@oracle.com>
> 
> For full concept writeup about QEMU disaggregation refer to
> docs/devel/qemu-multiprocess.txt.
> 
> This series has a limited scope and allows QEMU to launch
> LSI SCSI controller emulation in the separate process and
> execute HMP commands to manipulate the devices.
> This series with appropriate libvirt patches allows to
> launch a guest with remote processes using libvirt.
> (libvirt patches will be posted and will be reflected in the reply to
> this patch).
> 
> Please refer to the docs/qemu-multiprocess.txt for usage
> information.
> 
> his series is based on qemu upstream commit
> 3284aa128153750f14a61e8a96fd085e6f2999b6.
> 
> TODO items:
>   - bus support for remote process (non-default);
>   - live migration;
>   - performance improvements;
>   - support for more devices;
>   - support for seccomp for remote processes;
>   - support for CPU disaggregated emulation;
> 
> We would like to welcome all your ideas, concerns and questions
> for this patchset.

For future versions please make sure the mails sent a fully
threaded, so that all the patches are in-reply-to the cover
letter mail, rather than each scattered as a standalone mail.

The best way todo this is to use the excellent "git-publish"
tool. The added benefit of git-publish is that it will CC
all the subsystem maintainers whose code is touched

  https://github.com/stefanha/git-publish

It is packaged in Debian, Ubuntu, Fedora & EPEL

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

