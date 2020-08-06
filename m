Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF00C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 14:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6396123121
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 14:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIFdu8i5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6396123121
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3gi9-0008Tr-CQ
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 10:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3gh7-0007Rx-1z
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 10:16:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32492
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3gh5-0007p0-DT
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 10:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596723390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GaX62uKtIf5webo2+dAfiPMrUqauCjwMCPPrUKbfFxU=;
 b=aIFdu8i5wDoV9+S0i5GGnYB4n3xS4UC05835Gpo1j5TPYaajM9N85US+ShH8QqlTuEQKh+
 yjIUDiEX6RRtXo+Gt6xfodkyuDPM/RmFR+quZw6JZFWu+3SDxOmQbqTartKMZxiWkpt2rF
 S3z1vktZQyRDdLV2JfkmR1+78HDInm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-0jmEjuXtMbqgf8l7VwyeJA-1; Thu, 06 Aug 2020 10:16:28 -0400
X-MC-Unique: 0jmEjuXtMbqgf8l7VwyeJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B60098017FB;
 Thu,  6 Aug 2020 14:16:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8B1119C71;
 Thu,  6 Aug 2020 14:16:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6BF0B1132801; Thu,  6 Aug 2020 16:16:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] softmmu: Add missing trace-events file
References: <20200805130221.24487-1-philmd@redhat.com>
 <87wo2dmde8.fsf@dusky.pond.sub.org>
 <8a260e67-2bae-17d7-d34c-239df1c5eb5c@redhat.com>
Date: Thu, 06 Aug 2020 16:16:17 +0200
In-Reply-To: <8a260e67-2bae-17d7-d34c-239df1c5eb5c@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 5 Aug 2020 15:57:25
 +0200")
Message-ID: <87tuxf6ery.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Claudio Fontana <cfontana@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 8/5/20 3:27 PM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>=20
>>> Commit c7f419f584 moved softmmu-only files out of the root
>>> directory, but forgot to move the trace events, which should
>>> no longer be generated to "trace-root.h". Fix that by adding
>>> softmmu/trace-events.
>>=20
>> Dang!  I'd like to have this in 5.1 if at all possible.
>>=20
> [...]
>>=20
>> scripts/cleanup-trace-events.pl finds these (and corrects them in-place,
>> which is not what we want here).  It finds a few more.  I'll look more
>> closely and report back.
>
> Congratulation, you just found the first job you'll add to our GitLab CI
> =3D)

cleanup-trace-events.pl is not fit for use in CI; see the list of
funnies in "[PATCH 4/4] trace-events: Fix attribution of trace points to
source".  Perhaps it could be sufficiently improved.


