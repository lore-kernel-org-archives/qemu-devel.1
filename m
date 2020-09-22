Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DC2C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1ABA221EB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDmZ+1lN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1ABA221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKgmp-0007Km-Hs
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 07:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKglx-0006uh-G1
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 07:47:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKglv-0002ak-Ei
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 07:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600775266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6nkTYDyDiTT5jItVBtAFI0cDtBc9v27g23OanPmzCV0=;
 b=HDmZ+1lNzUCuuyPiPNZZIxp9QOF0cnSNzaU7wkh4t0atGX3xo4tpuJ1qRIi3NVs4ffY+Ih
 5pus0antlQX9wkCr/wXvAv9OvEcBzk0I/Rzle/975UkOtw46nFcUqa1mfqjojmpQ985OsT
 kcyZT8o7ApmeYUSlITn7KQn+Fa2BkKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-qc-dWBGcPsGBHFs6kDzb8A-1; Tue, 22 Sep 2020 07:47:44 -0400
X-MC-Unique: qc-dWBGcPsGBHFs6kDzb8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8B9A107465D;
 Tue, 22 Sep 2020 11:47:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 88E945C1A3;
 Tue, 22 Sep 2020 11:47:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1E97C1132E9A; Tue, 22 Sep 2020 13:47:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 09/20] docs/sphinx: Add new qapi-doc Sphinx extension
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-10-peter.maydell@linaro.org>
 <87eenh38lp.fsf@dusky.pond.sub.org>
 <CAFEAcA8unnV=bQiaks-YnD0LOrfwMx2FQFN=Zf4zshrgccrwAQ@mail.gmail.com>
Date: Tue, 22 Sep 2020 13:47:42 +0200
In-Reply-To: <CAFEAcA8unnV=bQiaks-YnD0LOrfwMx2FQFN=Zf4zshrgccrwAQ@mail.gmail.com>
 (Peter Maydell's message of "Mon, 21 Sep 2020 17:50:42 +0100")
Message-ID: <87363arq1t.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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

> On Fri, 4 Sep 2020 at 15:44, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> $ pycodestyle docs/sphinx/qapidoc.py
>> docs/sphinx/qapidoc.py:42:1: E302 expected 2 blank lines, found 1
>> docs/sphinx/qapidoc.py:50:1: E302 expected 2 blank lines, found 1
>> docs/sphinx/qapidoc.py:74:80: E501 line too long (80 > 79 characters)
>> docs/sphinx/qapidoc.py:388:80: E501 line too long (80 > 79 characters)
>> docs/sphinx/qapidoc.py:391:80: E501 line too long (80 > 79 characters)
>> docs/sphinx/qapidoc.py:430:1: E302 expected 2 blank lines, found 1
>> docs/sphinx/qapidoc.py:489:80: E501 line too long (80 > 79 characters)
>> docs/sphinx/qapidoc.py:495:1: E302 expected 2 blank lines, found 1
>
> All fixed.
>
>> $ PYTHONPATH=scripts pylint docs/sphinx/qapidoc.py
>> ************* Module qapidoc
>> docs/sphinx/qapidoc.py:36:4: E0611: No name 'AutodocReporter' in module 'sphinx.ext.autodoc' (no-name-in-module)
>> docs/sphinx/qapidoc.py:45:10: R1708: Do not raise StopIteration in generator, use return statement instead (stop-iteration-return)
>> docs/sphinx/qapidoc.py:104:4: R0201: Method could be a function (no-self-use)
>> docs/sphinx/qapidoc.py:253:4: R0201: Method could be a function (no-self-use)
>> docs/sphinx/qapidoc.py:34:4: C0412: Imports from package sphinx are not grouped (ungrouped-imports)
>
> Not fixed: I disagree with the linter on all these.
>
> The first and fifth of these are unfixable because they are the
> result of code that is trying to adapt to multiple versions of
> Sphinx (one of which has AutodocReporter and the other of which
> does not).
>
> The second makes no sense and appears to me to be a linter
> bug, because the code doesn't (directly) raise StopIteration.
> In any case the function being complained about is just a
> straight borrowing from pydash.
>
> The third and fourth would mean that two of the 10 or so
> _nodes_for_whatever methods would become functions and
> gratuitously different in call signature from the rest
> just because it happens that the current implementation
> doesn't need 'self'.

As I said, use your judgement.

> (The version of pylint I have also warns about:
>  * comments that say "TODO", both of which are ones that
>    are carried over from the texinfo generator about dropping
>    fallback code when undocumented members are outlawed
>  * methods that are part of the QAPISchemaVisitor
>    interface and apparently have "too many arguments")
>  * single-letter variables
>  * the Use_SSI variable name which is from the kerneldoc plugin
> I'm going to ignore those too.)

John Snow is working on a combination of pylint configuration that suits
us, genuine removal of lint, and the occasional pylint directive to shut
it up when it's wrong.  Informational, don't worry about it now.


