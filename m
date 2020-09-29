Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74B6C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDCBA2076B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dp6Qvty1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCBA2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNM59-0001Fk-Jn
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM49-0000on-F2
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM46-0003Jm-P4
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:17:36 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601410653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R/+CQOAzX7bizPyTNl3TyqizMvMm0U29iOrC4li8pM0=;
 b=dp6Qvty12Is0QDL3RfPH1hIyHuTvMAGJSQSK7T92fCP0UOEuTQNN51U8ZRoVZ1ng0oKp6F
 khrISKC7B9+bKIIYCBx24ai7a8HTNo7PfwT+KfEFr6lONzaSkTT+yK+alcsDP8i1DXASW6
 y+XD/sJKpSk1w0TFAmt4hVv/TrwLiPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-lJOd8g8bNHm7j1IuIBwJ5Q-1; Tue, 29 Sep 2020 16:17:27 -0400
X-MC-Unique: lJOd8g8bNHm7j1IuIBwJ5Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7566018BE164;
 Tue, 29 Sep 2020 20:17:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F1A810023A7;
 Tue, 29 Sep 2020 20:17:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A9AFD113864A; Tue, 29 Sep 2020 22:17:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 00/21] Convert QAPI doc comments to generate rST
 instead of texinfo
References: <20200925162316.21205-1-peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 22:17:24 +0200
In-Reply-To: <20200925162316.21205-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 25 Sep 2020 17:22:55 +0100")
Message-ID: <87ft70mj6z.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> This series switches all our QAPI doc comments over from texinfo
> format to rST.  It then removes all the texinfo machinery, because
> this was the last user of texinfo.
>
> I think I have now resolved all of Markus' issues raised in his
> review of v5, and IMHO this is ready to commit.  If there are still
> things needing fixing, it would be nice if we were able to commit
> patches 1-5, which are the ones which add the new indent-sensitive
> code to the QAPI parser.  That would put a stop to the steady trickle
> of doc-comment changes which break the new rules...
>
> Also available as a git branch at
> https://git.linaro.org/people/peter.maydell/qemu-arm.git sphinx-conversions-v6
>
> The basic approach is somewhat similar to how we deal with kerneldoc
> and hxtool: we have a custom Sphinx extension which is passed a
> filename which is the json file it should run the QAPI parser over and
> generate documentation for. Unlike 'kerneldoc' but somewhat like
> hxtool, I have chosen to generate documentation by generating a tree
> of docutils nodes, rather than by generating rST source that is then
> fed to the rST parser to generate docutils nodes.  Individual lumps of
> doc comment go to the rST parser, but the structured parts we render
> directly. This makes it easier to get the structure and heading level
> nesting correct.
>
> Changes from v5:
>  * rebased (in particular, updated to meson build system)
>  * new patch 1 fixes indent issues that hit master since v5
>  * new patch 2 makes block-latency-histogram-set's use of Example
>    sections match everybody else's, instead of special casing it
>    in the parser
>  * the .gitignore got pruned after meson conversion so we only
>    need to change git.orderfile now
>  * slightly reordered patches to bring the parser.py indent change nearer
>    the start of the series in the hopes of being able to get at least
>    that much of the series into master
>  * we now tell Sphinx about all the json files for dependency info,
>    so editing a json file correctly rebuilds the docs
>  * added a test case for the bad-de-indent parser error
>  * Adopted the various Python scripting suggestions from Markus
>  * We don't insist on section headings being the only thing in their
>    doc comment block any more (the existing "must be first line"
>    requirement is sufficient)
>  * added a test case for doc-generation that does a compare of
>    the sphinx plain-text builder output against a reference file
>  * Added the Python source files for Sphinx extensions (including
>    the QAPI source files) to the dependency lists for the manuals,
>    so that changes made to them correctly trigger a docs rebuild
>  * qemu-ga-ref.rst and qemu-qmp-ref.rst now have a TODO note about
>    making the manual licensing more visible to readers
>  * fixed bug in reported file/line info for some errors in rST
>    in doc comments when using Sphinx 1.6
>  * don't insist on section headers being in their own freeform doc
>    comment block; they're (after commit dcdc07a97cbe) always the
>    first line in the comment block, so just handle the possibility
>    of having text after that.
>
> There are a few things I have left out of this initial series:
>
>  * unlike the texinfo, there is no generation of index entries
>    or an index in the HTML docs
>  * although there are HTML anchors on all the command/object/etc
>    headings, they are not stable but just serial-number based
>    tags like '#qapidoc-35', so not suitable for trying to link
>    to from other parts of the docs
>
> My view is that we can add niceties like this later; the series
> already seems big enough to me.

Queued, thanks!


