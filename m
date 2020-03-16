Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEF9C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 094E420658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4ys7Qs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094E420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDock-0000FF-Me
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 08:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jDnl3-0005YZ-TA
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jDnl2-0003Uc-C5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:18:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49564
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jDnl2-0003MX-4l
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584357487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tYV2Z1yIfUHJKAR4weRJObEb0tvA/Yg/Xc3+A8vyxpo=;
 b=g4ys7Qs3n1yQ/0tDFI4hMR9/EuF927JMjqIJDSsKsGQACKORBAbB8qtFEvXJmGCcQgHd9b
 9ht9lmheWJpEktJGf6pyKD2j9212Yc+FWeJPo1Bdlc/3ynGrZrYmtbLK2qbzP6eDY+zUTG
 aotVkluo0JnlyXNPxpZqygb9WTsLh18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-T-qHoOalOFe5ekCT1R9ipA-1; Mon, 16 Mar 2020 07:18:06 -0400
X-MC-Unique: T-qHoOalOFe5ekCT1R9ipA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9314DB20;
 Mon, 16 Mar 2020 11:18:04 +0000 (UTC)
Received: from localhost (ovpn-200-42.brq.redhat.com [10.40.200.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A2FD60BF3;
 Mon, 16 Mar 2020 11:17:56 +0000 (UTC)
Date: Mon, 16 Mar 2020 12:17:55 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] checkpatch: enforce process for expected files
Message-ID: <20200316121755.45fa97c2@redhat.com>
In-Reply-To: <20200315113323.526984-1-mst@redhat.com>
References: <20200315113323.526984-1-mst@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 15 Mar 2020 07:35:46 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> If the process documented in tests/qtest/bios-tables-test.c
> is followed, then same patch never touches both expected
> files and code. Teach checkpatch to enforce this rule.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Tested-by: Igor Mammedov <imammedo@redhat.com>

> ---
> 
> Peter, Igor what do you think?
> 
>  scripts/checkpatch.pl | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index b27e4ff5e9..96583e3fff 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -35,6 +35,8 @@ my $summary_file = 0;
>  my $root;
>  my %debug;
>  my $help = 0;
> +my $testexpected;
> +my $nontestexpected;
>  
>  sub help {
>  	my ($exitcode) = @_;
> @@ -1256,6 +1258,26 @@ sub WARN {
>  	}
>  }
>  
> +# According to tests/qtest/bios-tables-test.c: do not
> +# change expected file in the same commit with adding test
> +sub checkfilename {
> +	my ($name) = @_;
> +        if ($name =~ m#^tests/data/acpi/# and
> +            # make exception for a shell script that rebuilds the files
> +            not $name =~ m#^\.sh$# or
> +            $name =~ m#^tests/qtest/bios-tables-test-allowed-diff.h$#) {
> +            $testexpected = $name;
> +        } else {
> +            $nontestexpected = $name;
> +        }
> +        if (defined $testexpected and defined $nontestexpected) {
> +            ERROR("Do not add expected files together with tests, " .
> +                  "follow instructions in " .
> +                  "tests/qtest/bios-tables-test.c: both " .
> +                  $testexpected . " and " . $nontestexpected . " found\n");
> +        }
> +}
> +
>  sub process {
>  	my $filename = shift;
>  
> @@ -1431,9 +1453,11 @@ sub process {
>  		if ($line =~ /^diff --git.*?(\S+)$/) {
>  			$realfile = $1;
>  			$realfile =~ s@^([^/]*)/@@ if (!$file);
> +                        checkfilename($realfile);
>  		} elsif ($line =~ /^\+\+\+\s+(\S+)/) {
>  			$realfile = $1;
>  			$realfile =~ s@^([^/]*)/@@ if (!$file);
> +                        checkfilename($realfile);
>  
>  			$p1_prefix = $1;
>  			if (!$file && $tree && $p1_prefix ne '' &&


