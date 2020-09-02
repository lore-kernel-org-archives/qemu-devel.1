Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E46FC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDDC920826
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PB1RuKKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDC920826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDUVC-0003YU-3j
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 11:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDUTa-0002g6-PE
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:15:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41445
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDUTX-0000Av-TM
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599059702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gHClOj26AbnUjimGboyg2DlE9nQY1IvMkT66QrZnlCM=;
 b=PB1RuKKjWXdt6cNRQ78LVR8ZxoRkeHDIaHNxN3C3Tl24y2p20fDe01e6BEc5k/6zsftb02
 BQuotD6ljk1iPvf2CNcU80vecG6TZKkyFPm+TbmloL8S6uSCzKqIXn+gHVV4SeZOZwFRGI
 MR+fDrztq6tuUeCxs7IuDNZ2lk5Z5dU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-QJkh86WEOTWBANfbR8Ndrg-1; Wed, 02 Sep 2020 11:14:59 -0400
X-MC-Unique: QJkh86WEOTWBANfbR8Ndrg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4F1E56B2D;
 Wed,  2 Sep 2020 15:14:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4A9188D44;
 Wed,  2 Sep 2020 15:14:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5241F113865F; Wed,  2 Sep 2020 17:14:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC v2] checkpatch: detect missing changes to trace-events
References: <20200807111447.15599-1-cfontana@suse.de>
Date: Wed, 02 Sep 2020 17:14:26 +0200
In-Reply-To: <20200807111447.15599-1-cfontana@suse.de> (Claudio Fontana's
 message of "Fri, 7 Aug 2020 13:14:47 +0200")
Message-ID: <87sgc06wj1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Da?= =?utf-8?Q?ud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Claudio Fontana <cfontana@suse.de> writes:

> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  scripts/checkpatch.pl | 37 ++++++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 7 deletions(-)
>
> v1 -> v2 :
>
> * track the "from" file in addition to the "to" file,
>   and grep into both (if they exist), looking for trace.h, trace-root.h
>
>   If files are reachable and readable, emit a warning if there is no
>   update to trace-events.
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index bd3faa154c..37db212fc6 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1300,6 +1300,7 @@ sub process {
>  	my $in_header_lines = $file ? 0 : 1;
>  	my $in_commit_log = 0;		#Scanning lines before patch
>  	my $reported_maintainer_file = 0;
> +	my $reported_trace_events_file = 0;
>  	my $non_utf8_charset = 0;
>  
>  	our @report = ();
> @@ -1309,6 +1310,7 @@ sub process {
>  	our $cnt_chk = 0;
>  
>  	# Trace the real file/line as we go.
> +	my $fromfile = '';
>  	my $realfile = '';
>  	my $realline = 0;
>  	my $realcnt = 0;
> @@ -1454,10 +1456,15 @@ sub process {
>  		$here = "#$realline: " if ($file);
>  
>  		# extract the filename as it passes
> -		if ($line =~ /^diff --git.*?(\S+)$/) {
> -			$realfile = $1;
> -			$realfile =~ s@^([^/]*)/@@ if (!$file);
> +		if ($line =~ /^diff --git.*?(\S+).*?(\S+)$/) {
> +			$fromfile = $1;
> +			$realfile = $2;
> +			if (!$file) {
> +				$fromfile =~ s@^([^/]*)/@@ ;
> +				$realfile =~ s@^([^/]*)/@@ ;
> +			}
>  	                checkfilename($realfile, \$acpi_testexpected, \$acpi_nontestexpected);
> +

Drop this blank line.

>  		} elsif ($line =~ /^\+\+\+\s+(\S+)/) {
>  			$realfile = $1;
>  			$realfile =~ s@^([^/]*)/@@ if (!$file);
> @@ -1470,6 +1477,11 @@ sub process {
>  			}
>  
>  			next;
> +

And this one.

> +		} elsif ($line =~ /^---\s+(\S+)/) {
> +			$fromfile = $1;
> +			$fromfile =~ s@^([^/]*)/@@ if (!$file);
> +			next;
>  		}
>  
>  		$here .= "FILE: $realfile:$realline:" if ($realcnt != 0);

Aside: I don't understand why we need to match both the diff line and
the --- line (and now the +++ line, too).

> @@ -1524,15 +1536,26 @@ sub process {
>  		if ($line =~ /^\s*MAINTAINERS\s*\|/) {
>  			$reported_maintainer_file = 1;
>  		}
> -
> +# similar check for trace-events
> +		if ($line =~ /^\s*trace-events\s*\|/) {
> +			$reported_trace_events_file = 1;
> +		}

These are meant to match in the diffstat (took me a stare to figure that
out).

The existing one matches MAINTAINERS in the source root.  Good; that's
where it is.

The new one matches trace-events in the source root.  Not so good; We
use one trace-events per directory.

If I update trace-events in the source root, I won't be warned about
other trace-events in need of updating (false negative), will I?

If I don't update trace-events in the source root, I will be warned
regardless of what other trace-events I update (false positive), won't
I?

>  # Check for added, moved or deleted files
> -		if (!$reported_maintainer_file && !$in_commit_log &&
> +		if (!$in_commit_log &&
>  		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
>  		     $line =~ /^rename (?:from|to) [\w\/\.\-]+\s*$/ ||
>  		     ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/ &&
>  		      (defined($1) || defined($2))))) {
> -			$reported_maintainer_file = 1;
> -			WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
> +			if (!$reported_maintainer_file) {
> +				$reported_maintainer_file = 1;
> +				WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
> +			}
> +			if (!$reported_trace_events_file) {
> +				if (`grep -F -s -e trace.h -e trace-root.h ${fromfile} ${realfile}` ne '') {
> +					$reported_trace_events_file = 1;
> +					WARN("added, moved or deleted file(s), does trace-events need updating?\n" . $herecurr);
> +				}
> +			}
>  		}
>  
>  # Check for wrappage within a valid hunk of the file

Regarding Stefan's observations:

* Yes, the grep patterns need tightening.

* Yes, forking grep could be replaced by a simple function that slurps
  in the file and searches it.  Could doesn't imply should, let alome
  must.

As discussed in review of v1, I'm not sure checkpatch.pl is the best
home for this kind of check.  I'm not going to reject a working patch
because of that.


