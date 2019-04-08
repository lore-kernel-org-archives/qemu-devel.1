Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4A3C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 17:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B84E220870
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 17:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84E220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56527 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDY5O-00019L-Rk
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 13:29:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1hDY4c-0000k9-OP
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 13:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1hDY4a-0002PT-3g
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 13:28:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>)
	id 1hDY4W-0002EY-Px; Mon, 08 Apr 2019 13:28:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A95D9C057F3C;
	Mon,  8 Apr 2019 17:22:12 +0000 (UTC)
Received: from localhost (ovpn-116-243.ams2.redhat.com [10.36.116.243])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 503416092E;
	Mon,  8 Apr 2019 17:22:12 +0000 (UTC)
Date: Mon, 8 Apr 2019 18:22:11 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190408172202.GH3926@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190408083627.7479-3-armbru@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Mon, 08 Apr 2019 17:22:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] Whither qemu's ssh driver? (was: Re: [PATCH 02/15]
 block/ssh: Do not report read/write/flush errors to the user)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	ptoscano@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408172211.8LZZ8cz_mGqhbBAwXcI8l628kceJV3JjpU7sOLef4oA@z>

I don't know much about this patch which looks like internal qemu
rearrangements so I guess fine.  However I do have a few things to say
about the ssh driver ...

As you know I wrote this a few years ago, and it uses libssh2.
libssh2 has not evolved as quickly as we'd like and it may be better
to use libssh instead -- despite the names, these are two separate and
unrelated libraries.  libssh supports a wider range of SSH encryption
and has more features.  It's generally more likely to work against a
random SSH server.  It has also been through the FIPS process.  Indeed
Red Hat made the decision to switch exclusively to libssh in RHEL 8,
if that carries any weight.

Pino posted a libssh2 -> libssh conversion patch a while back, but it
has been somewhat stuck in review.  If I recall the latest concern was
whether it performs as well as the libssh2 version.

  https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg07267.html

In the meantime I added libssh support to nbdkit.  nbdkit can be used
as a complete replacement for qemu's ssh driver.

  nbdkit ssh host=foo.example.com disk.img -U tmpdirXXXXXX/sock
  qemu -hda nbd:unix:tmpdirXXXXXX/sock

In fact it's somewhat superior (IMHO) because all of the tricky code
handling libssh runs outside qemu in a separate process, improving
isolation and potentially allowing separate, restrictive security
policies to be applied.  For example it would no longer be necessary
to give qemu permission to connect to remote SSH servers.

Could we make this really smooth somehow?  nbdkit has a concept
[https://www.mankier.com/1/nbdkit-captive] where we make it easy to
manage external commands owned by nbdkit.  Is there an equivalent
feature of qemu where:

  qemu -object exec,id=nbd1,cmd='nbdkit -f -U $sock ssh ...' \
       -drive file.driver=nbd,file.socket=nbd1

would run the command but also allocate a socket and kill the
subcommand on exit (of qemu)?

Basically I'm trying to think about how to make this a reality:

  https://rwmj.files.wordpress.com/2018/10/drawing2-svg.png

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW

