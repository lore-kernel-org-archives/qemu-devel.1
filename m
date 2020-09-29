Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745F3C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A665A20848
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLapHbjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A665A20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFYF-0005HZ-MQ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNFWt-0004Oa-Lh
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:18:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNFWq-0006SP-06
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:18:51 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601385526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oIsjJio2HZAHLcI+yK59P+oIBh6ir975ANdT4BX+8Y0=;
 b=bLapHbjE69vWP1nqxSX4lhsSbfr948v6PAM+WcwKX/+5JIQDyxP9lHy/+TKC6VP08/x3Bp
 LaemT8y63y0dW2IUFdVGX3ku+6z8B4vlG3WRSvCGQNAN+I4tbU/qM+Q76sPlMONE5u1Ryj
 s7VbGeh/vll38tBsmRvbqJH9cO28yBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-x9h_JSpiP52qNvUtQQlhbg-1; Tue, 29 Sep 2020 09:18:43 -0400
X-MC-Unique: x9h_JSpiP52qNvUtQQlhbg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52C4F80EF9D;
 Tue, 29 Sep 2020 13:18:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F207D5D9CA;
 Tue, 29 Sep 2020 13:18:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7A644113864A; Tue, 29 Sep 2020 15:18:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 15/21] tests/qapi-schema: Add test of the rST QAPI
 doc-comment outputn
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-16-peter.maydell@linaro.org>
 <877dscvkp5.fsf@dusky.pond.sub.org>
 <CAFEAcA_fQPYbf4TG3TayQ5Y5NBJCOq6wuBiqXZMp3MUVj7XFrA@mail.gmail.com>
Date: Tue, 29 Sep 2020 15:18:40 +0200
In-Reply-To: <CAFEAcA_fQPYbf4TG3TayQ5Y5NBJCOq6wuBiqXZMp3MUVj7XFrA@mail.gmail.com>
 (Peter Maydell's message of "Tue, 29 Sep 2020 13:33:30 +0100")
Message-ID: <877dscsoun.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 29 Sep 2020 at 13:20, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> In subject, s/outputn/output/
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > Add a test of the rST output from the QAPI doc-comment generator,
>> > similar to what we currently have that tests the Texinfo output.
>> >
>> > This is a bit more awkward with Sphinx, because the generated
>> > output is not 100% under our control the way the QAPI-to-Texinfo
>> > generator was. However, in practice Sphinx's plaintext output
>> > generation has been identical between at least Sphinx 1.6 and
>> > 3.0, so we use that. (The HTML output has had changes across
>> > versions). We use an exact-match comparison check, with the
>> > understanding that perhaps changes in a future Sphinx version
>> > might require us to implement something more clever to cope
>> > with variation in the output.
>> >
>> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> It's not just the potential Sphinx version dependence that makes this
>> awkward.
>>
>> We can no longer check what our doc generator does (at least not without
>> substantial additional coding), we can only check what it does together
>> with Sphinx.  We do so for one output format.
>>
>> Our doc generator output could change in ways that are not visible in
>> the Sphinx output format we test, but are visible in some other output
>> format.
>>
>> We choose to test plain text, because it has the lowest risk of unwanted
>> Sphinx version dependence, even though it probably has the highest risk
>> of "rendering stuff invisible".
>>
>> Certainly better than nothing, and probably the best we can do now, but
>> let's capture the tradeoff in the commit message.  Perhaps:
>>
>>   This is a bit more awkward with Sphinx, because the generated output
>>   is not 100% under our control the way the QAPI-to-Texinfo generator
>>   was. We can't observe the data we generate, only the Sphinx
>>   output. Two issues.
>>
>>   One, the output can vary with the Sphinx version.  In practice
>>   Sphinx's plaintext output generation has been identical between at
>>   least Sphinx 1.6 and 3.0, so we use that. (The HTML output has had
>>   changes across versions). We use an exact-match comparison check, with
>>   the understanding that perhaps changes in a future Sphinx version
>>   might require us to implement something more clever to cope with
>>   variation in the output.
>>
>>   Two, the test can only protect us from changes in the data we generate
>>   that are visible in plain text.
>>
>> What do you think?
>
> Yes, seems worth recording that in the commit message (especially
> now you've written the text :-)).

:)

>> > +# Test the document-comment document generation code by running a test schema
>> > +# file through Sphinx's plain-text builder and comparing the result against
>> > +# a golden reference. This is in theory susceptible to failures if Sphinx
>> > +# changes its output, but the text output has historically been very stable
>> > +# (no changes between Sphinx 1.6 and 3.0), so it is a better bet than
>> > +# texinfo or HTML generation, both of which have had changes. We might
>>
>> Texinfo
>>
>> > +# need to add more sophisticated logic here in future for some sort of
>> > +# fuzzy comparison if future Sphinx versions produce different text,
>> > +# but for now the simple comparison suffices.
>> > +qapi_doc_out = custom_target('QAPI rST doc',
>> > +                             output: ['doc-good.txt'],
>> > +                             input: files('doc-good.json', 'doc-good.rst'),
>>
>> Gawk at my Meson ignorance...
>>
>> Looks like this builds doc-good.txt from doc.good.json and doc-good.rst.
>>
>> doc-good.txt is also a source file.  Works, because we use a separate
>> build tree.  Might be confusing, though.
>
> Yes. We could change the name of the reference source file that
> we have checked into the git repo if you wanted. (The output file
> written by Sphinx has to be the same name as the input .rst file AFAICT.)

I'll see what I can do (and thanks for the hint).

>> > +                             build_by_default: build_docs,
>> > +                             depend_files: sphinx_extn_depends,
>> > +                             # We use -E to suppress Sphinx's caching, because
>> > +                             # we want it to always really run the QAPI doc
>> > +                             # generation code. It also means we don't
>> > +                             # clutter up the build dir with the cache.
>> > +                             command: [SPHINX_ARGS,
>> > +                                       '-b', 'text', '-E',
>> > +                                       '-c', meson.source_root() / 'docs',
>> > +                                       '-D', 'master_doc=doc-good',
>> > +                                       meson.current_source_dir(),
>> > +                                       meson.current_build_dir()])
>> > +
>> > +# Fix possible inconsistency in line endings in generated output and
>> > +# in the golden reference (which could otherwise cause test failures
>> > +# on Windows hosts). Unfortunately diff --strip-trailing-cr
>> > +# is GNU-diff only. The odd-looking perl is because we must avoid
>> > +# using an explicit '\' character in the command arguments to
>> > +# a custom_target(), as Meson will unhelpfully replace it with a '/'
>> > +# (https://github.com/mesonbuild/meson/issues/1564)
>>
>> Rather disappointing.
>>
>> > +qapi_doc_out_nocr = custom_target('QAPI rST doc newline-sanitized',
>> > +                                  output: ['doc-good.txt.nocr'],
>> > +                                  input: qapi_doc_out[0],
>> > +                                  build_by_default: build_docs,
>> > +                                  command: ['perl', '-pe', '$x = chr 13; s/$x$//', '@INPUT@'],
>> > +                                  capture: true)
>>
>> I figure this strips \r from the build tree's doc-good.txt.
>
> Close; it turns either CRLF or LF into the host OS's
> line-ending sequence (see below).
>
>> > +qapi_doc_ref_nocr = custom_target('QAPI rST doc reference newline-sanitized',
>> > +                                  output: ['doc-good.ref.nocr'],
>> > +                                  input: files('doc-good.txt'),
>> > +                                  build_by_default: build_docs,
>> > +                                  command: ['perl', '-pe', '$x = chr 13; s/$x$//', '@INPUT@'],
>> > +                                  capture: true)
>>
>> Uh, this strips it from the source tree's doc-good.txt, right?  Why is
>> that necessary?
>
> This is in case the user has a setup that eg has git
> doing line-ending conversion on checkout somehow. As a
> non-Windows user I opted to be belt-and-braces about
> converting both files to a known-consistent line ending.
> It's also necessary because the perl rune isn't really
> "delete \r"; it's "delete any \r and then output the
> line with the OS line ending" because the files it processes
> are being read and written in text mode. So the output
> will be \r\n on Windows and \n on Unix; the test passes
> in both cases because both files have the same
> line endings after conversion.

Uff.  Thanks!

Reviewed-by: Markus Armbruster <armbru@redhat.com>


