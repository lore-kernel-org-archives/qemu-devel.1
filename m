Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D29BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 15:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC668207F7
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 15:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddDa5niV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC668207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5t30-0006Zk-6L
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 11:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5t2K-0005n4-7d
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 11:51:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52361
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5t2I-0005qo-PP
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 11:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597247490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fIOvVXob0RQ/YciLu4nlebDDkpShYD1fcGC6TZ+DgYI=;
 b=ddDa5niVRaZQ08uW55srsl5WwhIQyCN2pPieeYxIIuAstY1W8Ux710eFQG6gt6cYUVu6Td
 1vAoyjQHY2pBWDUByusMjrdT6Dxw9scyQoBo284BXZSU5zMmejjgk7DZVbelW431bhMOmx
 GbmpHgI7JM92KbPotWgPIqUyz0bGVf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-jeweZYrOP6GgkvKOlHJHmA-1; Wed, 12 Aug 2020 11:51:26 -0400
X-MC-Unique: jeweZYrOP6GgkvKOlHJHmA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1DC480048B;
 Wed, 12 Aug 2020 15:51:25 +0000 (UTC)
Received: from localhost (ovpn-114-96.ams2.redhat.com [10.36.114.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4502A60CF9;
 Wed, 12 Aug 2020 15:51:20 +0000 (UTC)
Date: Wed, 12 Aug 2020 16:51:19 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC v2] checkpatch: detect missing changes to trace-events
Message-ID: <20200812155119.GC112330@stefanha-x1.localdomain>
References: <20200807111447.15599-1-cfontana@suse.de>
MIME-Version: 1.0
In-Reply-To: <20200807111447.15599-1-cfontana@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 10:32:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 07, 2020 at 01:14:47PM +0200, Claudio Fontana wrote:
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

Are there false positives on non-C files (e.g. Makefiles)?

The search expressions can be tightened to avoid false positives (at the
cost of possible false negatives): -e '#include "trace.h"' -e '#include
"trace-root.h"'. This way a C file containing "strace.handler" will not
cause a false positive.

I wonder if there is a native Perl way to do this search instead of
forking grep :). Nevermind though.

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl80D/cACgkQnKSrs4Gr
c8izdwf/eyjviEliG5gACOjufg+L5BMOtbOoMmX1xS9avVZBETLwlSYcdpfFYIZS
LlHcSn2N0gwbhWu3jf8tNsLn2x3HItkySM9ZAPYQODbK8+g6eLrk3ECnVtU9SBAx
86KL1CwW3fiI6mWpC2jITtyatkYWuAN2d8BV8pWFnjX5UCiKj33RCQTuBuCvNRJk
qhFtXKIXDF7Xf6ZlEs545AX/ke/3s2j9Dqyl4sZjhYYZoI7PYFHOOU6S7kSvA7Xt
BjAGxcVBiuJBB2P9K3YOOThFuKa/fq1+3vPZRBus5iBulHrBinlh3xuyOsxXyvx0
uHT3wBybe/DX91dWRTXfpvOw1lflsQ==
=zWmz
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--


