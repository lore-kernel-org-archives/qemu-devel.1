Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376F5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0141E2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjuoyOqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0141E2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQMs-00030w-8P
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jjQL7-0001Dp-4h
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:46:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26086
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jjQL3-0003Q9-Ja
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591893958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gfW0+nvo2978Ic6c8AX83DZu98rIYzMrl7NVl+J7Sbo=;
 b=GjuoyOqH5PAGbqKwjIyeeNpyTu+WybrAcI09loxDUqyGMQM+AFMWOaiqMJD0Y8adlYqoRw
 qKhx0cHbJBaEJqP42ndjrPewxKoedAa8qhc4v2e/iKnn/kqDO+mbhatvn6eJ+WcQYWnK6j
 gjKN5ZnVKIjVm3QtytV8xC56G3zPUPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-A-I3wBbuPXGHTo5GGmrD9A-1; Thu, 11 Jun 2020 12:45:55 -0400
X-MC-Unique: A-I3wBbuPXGHTo5GGmrD9A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F8AC9119F
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 16:45:54 +0000 (UTC)
Received: from work-vm (ovpn-114-116.ams2.redhat.com [10.36.114.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B2FC7C3C5;
 Thu, 11 Jun 2020 16:45:53 +0000 (UTC)
Date: Thu, 11 Jun 2020 17:45:50 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 0/2] monitor openfd commands
Message-ID: <20200611164550.GG2968@work-vm>
References: <20200611111703.159590-1-dgilbert@redhat.com>
 <cec98884-f2cd-02f3-1806-a6579ce68961@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cec98884-f2cd-02f3-1806-a6579ce68961@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: thuth@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eric Blake (eblake@redhat.com) wrote:
> On 6/11/20 6:17 AM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > The monitors currently have a 'getfd' command that lets you pass an fd
> > via the monitor socket.  'openfd' is a new command that opens a file
> > and puts the fd in the same fd pool.  The file is opened RW and created
> > if it doesn't exist.
> > It makes it easy to test migration to and from a file.
> 
> We have two fd-passing mechanisms: getfd and add-fd.  add-fd is newer, and
> allows things like /dev/fdset/NNN to work anywhere a filename works.

Ewww I do dislike fake paths, they tend to be the source of great
security bugs.

>  I'm
> guessing that the issue here is that migration hasn't been tweaked to work
> nicely with the newer add-fd, but instead insists on the older getfd
> interface (where you have to use getfd to associate an fd with a name, then
> tell migration to use that special name, but the special name is via a
> different parameter than the normal filename parameter).  At which point
> openfd looks like it is just sugar to make getfd easier to use.

Yep, openfd is just intended to be sugar; it's a pain to use getfd at
runtime because you have to play all the passing fd's over socket magic.
My main reason here is because I wanted an easy way to migrate to
/dev/null for performance testing, but it would make life easier when
migrating to/from a file.

> Would it instead be worth modifying migration to work with add-fd?

Probably.  At the moment what we have is an 'fd:string' syntax for both
inbound and outbound migration.
The outbound migration looks up the string in the getfd index and uses
it. (via monitor_get_fd)

The inbound migration checks if the string starts with a number, if it
is then it uses it raw as the unix fd; else it passes it to getfd index.
(via monitor_fd_param).
(getfd disallows names that are numeric)

I can see a few solutions here:
  a) Teach qemu a new fdset:number syntax - it's a bit of a pain
     but is discoverable.
  b) Modify the getfd string lookup to parse /dev/fdset and go use
     the fdset

The problem with (b) is that the getfd mechanism doesn't have a
concept of open mode, and only has a single fd bound to a name,
so none of the existing parsing code would know which entry to use in an
fdset. (I'm assuming here no one created a getfd entry named
/dev/fdset/0 - although it seems legal).

The problem with (a) is that adding a new syntax is a bit more code;
but I guess it's probably more discoverable.

ANy preferences?

> add-fd need the same sort of sugar?

Yep, I'd like to have a way to open a file other than via scmrights.
I'd also need to add an HMP equivalent.

Dave

> 
> > 
> > Dr. David Alan Gilbert (2):
> >    qmp: Add 'openfd' command
> >    hmp: Add 'openfd' command
> > 
> >   hmp-commands.hx        | 16 +++++++++++++-
> >   include/monitor/hmp.h  |  1 +
> >   monitor/hmp-cmds.c     | 10 +++++++++
> >   monitor/misc.c         | 48 +++++++++++++++++++++++++++++++++---------
> >   qapi/misc.json         | 23 +++++++++++++++++++-
> >   tests/qtest/test-hmp.c |  2 ++
> >   6 files changed, 88 insertions(+), 12 deletions(-)
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


