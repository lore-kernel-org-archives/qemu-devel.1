Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A660C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 12:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9875206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 12:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqkNLziB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9875206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k57IX-00076F-3I
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 08:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1k57Hv-0006g0-RG
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 08:52:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30921
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1k57Hr-0004Bu-Eh
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 08:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597063942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QPfm+4L4jZ0goJORweHIIspeSDwcwGYihFJsiPOuos0=;
 b=WqkNLziB0IM6RvCs/JawEbdUC1ZWpDN3V2JCpT6cAZ+irTuoGfLzHquXL7d35p1xVuPh3v
 6d5btymEJ1A0EeHzkwTA5mHmta0EvPcAfrPPTZ4z9g4GIWL2rqi5r0mTUAJzVrTKM0A+US
 I1SVtL92WqP5bRFOoNAUGqoQUPHZoN4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-ZUghRYJuM8GDc7BIB2RUXg-1; Mon, 10 Aug 2020 08:52:18 -0400
X-MC-Unique: ZUghRYJuM8GDc7BIB2RUXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E148800470;
 Mon, 10 Aug 2020 12:52:17 +0000 (UTC)
Received: from localhost (ovpn-114-99.ams2.redhat.com [10.36.114.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 458468BA1C;
 Mon, 10 Aug 2020 12:52:16 +0000 (UTC)
Date: Mon, 10 Aug 2020 13:52:15 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Subject: Re: [PATCH for 5.2 1/1] qemu-io: add -V flag for read sub-command
Message-ID: <20200810125215.GJ3888@redhat.com>
References: <20200810123555.30481-1-den@openvz.org>
MIME-Version: 1.0
In-Reply-To: <20200810123555.30481-1-den@openvz.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=rjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=rjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 05:06:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 10, 2020 at 03:35:55PM +0300, Denis V. Lunev wrote:
> The problem this patch is trying to address is libguestfs behavior on the
> appliance startup. It starts supporting to use root=UUID definition in
> the kernel command line of its root filesystem using
>     file --  /usr/lib64/guestfs/appliance/root
> This works fine with RAW image, but we are using QCOW2 as a storage to
> save a bit of file space and in this case we get
>     QEMU QCOW Image (v3), 1610612736 bytes
> instead of UUID of the root filesystem.
> 
> The solution is very simple - we should dump first 256k of the image file
> like the follows
>     qemu-io -c "read -V 0 256k" appliance | file -
> which will provide correct result for all possible types of the appliance
> storage.
> 
> Unfortunately, additional option for qemu-io is the only and the simplest
> solution as '-v' creates very specific output, which requires to be
> parsed. 'qemu-img dd of=/dev/stdout' does not work and the fix would be
> much more intrusive.

I like the idea of the flag - we could also use it in the nbdkit test
suite.

I wonder if the actual flag ('V') is a good idea because I would
normally associate that with getting the version of a command.  But
as these are subcommand flags, that's probably not too relevant here.

So I think this is fine from my point of view.

Rich.

> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Richard W.M. Jones <rjones@redhat.com>
> ---
> P.S. Patch to libguestfs will follow.
> 
>  qemu-io-cmds.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index baeae86d8c..7aae9726cd 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -718,7 +718,7 @@ static const cmdinfo_t read_cmd = {
>      .cfunc      = read_f,
>      .argmin     = 2,
>      .argmax     = -1,
> -    .args       = "[-abCqv] [-P pattern [-s off] [-l len]] off len",
> +    .args       = "[-abCqvV] [-P pattern [-s off] [-l len]] off len",
>      .oneline    = "reads a number of bytes at a specified offset",
>      .help       = read_help,
>  };
> @@ -728,6 +728,7 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
>      struct timespec t1, t2;
>      bool Cflag = false, qflag = false, vflag = false;
>      bool Pflag = false, sflag = false, lflag = false, bflag = false;
> +    bool vrawflag = true;
>      int c, cnt, ret;
>      char *buf;
>      int64_t offset;
> @@ -737,7 +738,7 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
>      int pattern = 0;
>      int64_t pattern_offset = 0, pattern_count = 0;
>  
> -    while ((c = getopt(argc, argv, "bCl:pP:qs:v")) != -1) {
> +    while ((c = getopt(argc, argv, "bCl:pP:qs:vV")) != -1) {
>          switch (c) {
>          case 'b':
>              bflag = true;
> @@ -777,6 +778,9 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
>          case 'v':
>              vflag = true;
>              break;
> +        case 'V':
> +            vrawflag = true;
> +            break;
>          default:
>              qemuio_command_usage(&read_cmd);
>              return -EINVAL;
> @@ -869,10 +873,15 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
>      if (vflag) {
>          dump_buffer(buf, offset, count);
>      }
> +    if (vrawflag) {
> +        write(STDOUT_FILENO, buf, count);
> +    }
>  
>      /* Finally, report back -- -C gives a parsable format */
> -    t2 = tsub(t2, t1);
> -    print_report("read", &t2, offset, count, total, cnt, Cflag);
> +    if (!vrawflag) {
> +        t2 = tsub(t2, t1);
> +        print_report("read", &t2, offset, count, total, cnt, Cflag);
> +    }
>  
>  out:
>      qemu_io_free(buf);
> -- 
> 2.17.1

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v


