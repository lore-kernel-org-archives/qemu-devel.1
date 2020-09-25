Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FDBC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 06:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4310B21D91
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 06:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVEFpC8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4310B21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLhXQ-00089r-8P
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 02:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kLhWq-0007j2-8Z
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 02:48:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kLhWn-0007HU-JX
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 02:48:23 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601016500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jkqzEu7FgIiIwMiOOBLqiJLl+OCrxNM2p9zHxJa4ODo=;
 b=fVEFpC8YaMum9zn2y4ee4O/EVOICBahQpNZw52HrFT2Cn+82AaIjfI4PDQRWGpqGitoc92
 nQ4/qK+RmvUOOng6ubNX3MATSftwEx9yICXl5uC6iNMsOXBCi5rdGhZfabjsmwoDSrmHJW
 ZyesXvJnbnnLZzGGUodjvneb3uL9TDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-nWX3eSx5O7Ss1Dg9rpssbA-1; Fri, 25 Sep 2020 02:48:16 -0400
X-MC-Unique: nWX3eSx5O7Ss1Dg9rpssbA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C46DA18A224F;
 Fri, 25 Sep 2020 06:48:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-70.ams2.redhat.com
 [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8117055788;
 Fri, 25 Sep 2020 06:48:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 121FE113865F; Fri, 25 Sep 2020 08:48:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 14/20] scripts/qapi: Remove texinfo generation support
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-15-peter.maydell@linaro.org>
 <87y2lp64th.fsf@dusky.pond.sub.org>
 <CAFEAcA-UxY_PZU8woAzHmoHBh6BU+z9y6n4Z=UqQb=x4D1Befw@mail.gmail.com>
Date: Fri, 25 Sep 2020 08:48:13 +0200
In-Reply-To: <CAFEAcA-UxY_PZU8woAzHmoHBh6BU+z9y6n4Z=UqQb=x4D1Befw@mail.gmail.com>
 (Peter Maydell's message of "Thu, 24 Sep 2020 19:14:56 +0100")
Message-ID: <87a6xe5p3m.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 4 Sep 2020 at 14:37, Markus Armbruster <armbru@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > -.PHONY: check-tests/qapi-schema/doc-good.texi
>> > -check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.test.texi
>> > -     @diff -u $(SRC_PATH)/tests/qapi-schema/doc-good.texi $<
>
>> We shouldn't just delete this test.
>>
>> It is for checking the doc generator does what it should for "good"
>> input.  "Bad" input is coverd by the other doc-*.json.
>>
>> With the old doc generation system, the testing "good" input is
>> straightforward: generate Texinfo, diff to expected Texinfo, which is
>> committed to git.
>>
>> This test has been invaliable when maintaining and extending doc.py.
>>
>> With the new system, there is no ouput suitable for diffing, as the
>> various outputs all depend on the version of Sphinx.
>>
>> Or is there?  Is there a way to have Sphinx "unparse" its internal
>> representation of the input?
>
> There is no built-in "unparse the internal representation" option.
> We could add one as a Sphinx extension (basically defining a new
> output format that was "print what you get"). This too is at
> least potentially liable to breakage with future versions, both
> if the Sphinx APIs for output-format extensions and change and
> if core Sphinx gets changes that mean input rST is parsed into
> a different-but-equivalent internal-tree-of-nodes representation.

Yes.  We could update the test for current Sphinx then, and disable it
for old Sphinx.  Not ideal, but good enough, I think.

> The HTML output definitely depends on the Sphinx version.
> The Texinfo output doesn't differ much, but it does differ in
> a couple of places (firstly it has the Sphinx version number
> baked into, and secondly what looks like a null-effect change
> in ordoring of @anchor{} nodes).
> The plain-text output is identical between Sphinx 1.6 and 3.0.
> (I think this is mostly because nobody really cares about it
> as an output generator, so it hasn't had any changes made to
> it other than general whole-tree cleanup type stuff...)
>
> So we could go for a simple comparison of the plaintext, and
> hope future Sphinx versions don't break it. (If they did we'd
> need to put together something like the iotests handling of
> "these parts need to match and these might be anything" in
> the golden-reference).

Again, we could also update the test for current Sphinx then, and
disable it for old Sphinx.

Diffing plain text output is a weaker test than diffing the intermediate
Texinfo or a Sphinx unparse.  Still better than nothing.

Blocking this series on a a yet-to-be-written unparse extension would be
a bad idea.  But thinking things through is not :)


