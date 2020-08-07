Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08517C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA3C622C9F
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggNFWWTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3C622C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3yIp-0002kQ-WE
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3yH3-00014r-QU
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:02:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34301
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3yGz-0007zT-HR
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596790964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A8YVs2lz1qleJrq/KVosvpeqdBvEWHVLYLaeP4g/WKk=;
 b=ggNFWWTlfUvP/YAeXQPzOTxpXVi2NFKM8C9won0sN9gpsvGmtnK7qASckbgsxUdNvU6Adg
 ha+Dk6zhZgN4Ud4dpt/mVlMCMBnToX+edEkeUvXZScGJrKap0nXqh2RuGJsPaWDsRsnQI7
 ruVUcgrRRiyzExTpBup6SVCq+MC0ghA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-wHK9KZ0wOA6aF6Q9Oa590Q-1; Fri, 07 Aug 2020 05:02:40 -0400
X-MC-Unique: wHK9KZ0wOA6aF6Q9Oa590Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 564471940935;
 Fri,  7 Aug 2020 09:02:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48F641002382;
 Fri,  7 Aug 2020 09:02:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C388F1132801; Fri,  7 Aug 2020 11:02:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <87364y28jp.fsf@dusky.pond.sub.org>
 <20200807082206.GC120942@redhat.com>
Date: Fri, 07 Aug 2020 11:02:34 +0200
In-Reply-To: <20200807082206.GC120942@redhat.com> ("Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9=22's?=
 message of "Fri, 7 Aug 2020 09:22:06 +0100")
Message-ID: <87o8nmygk5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:21:37
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
Cc: peter.maydell@linaro.org, jsnow@redhat.com, qemu-devel@nongnu.org,
 philmd@redhat.com, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Aug 07, 2020 at 09:56:42AM +0200, Markus Armbruster wrote:
[...]
>> I think it's now time to plan the end game, preferably without even more
>> weeks of intense rebasing.
>>=20
>> Do we have consensus to move forward with Meson?  If yes, I'd like to
>> propose to aim for merging as early as practical in the 5.2 cycle.
>> Rationale: rebasing build system changes on top of the Meson work is
>> probably easier than rebasing the Meson work, and avoids turning Paolo
>> into an overworked bottleneck.
>>=20
>> In more detail:
>>=20
>> 1. Pick a tentative deadline.
>
> I'd suggest we need a bare minimum of half a development cycle to.
> So if we want it tin 5.2, we need to make a strong push now and over
> next month to review it and iron out any obvious blocking testing
> problems.

I had less than a "now and over next month" (>7 weeks!) in mind.

The choice of deadline is really about how much of Paolo's time we are
(and he is!) willing to spend on rebasing vs. how much risk of toothing
problems in master we are willing to accept.

"First thing after 5.2 opens" would be ideal from a "avoid more
rebasing" point of view, but it may not be practical.

Once the flood gates are open, we can probably just as well wait for the
initial flood to subside.

>> 2. Cover the testing gaps and get as much review as we can until then.
>>    Fix defects as we go.
>
> In terms of testing I'd suggest the minimium bar is likely the GitLab CI
> and Peter's merge scripts.
>
> Anything beyond that is just nice to have.

Yup.  If you want it not to break in master, get it tested in our gating
CI.

>> 3. If the known defects are expected to disrupt others too much, goto 1.
>>    Do not worry about unknown defects at this point.
>>=20
>> 4. Merge.
>>=20
>> 5. Deal with the fallout.
>
> Yep, there's no substitute for getting it used for real by a wide
> range of people, which is why we we need leave ourselves at min
> 1/2 a dev cycle for this.
>
>
> Regards,
> Daniel


