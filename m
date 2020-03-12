Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F5CC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 06:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 992F920578
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 06:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFh1SsYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992F920578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCGzh-0003zw-M0
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 02:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jCGz7-0003ZT-Vl
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 02:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jCGz6-0005nd-CP
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 02:06:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32171
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jCGz6-0005nM-8S
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 02:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583993179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FosVh8ol5gdiC+K5OqJUyeK1ra2QkDva3dlUh1g+0Ik=;
 b=iFh1SsYz82Xbxo/sFa//zxLzFpNR84RiO39hj4uSRt8lKuJhp4zwgTg8GoupsxxXIZ8v/J
 66F8BmCGXUw1cC8Cbm+zAmYk4OnvQEwJm1OhQWeKKedcGilBYjPDvPzddnKDKXuMYOqgQI
 nzpjfxD4PPsei7+vPCXox9nFlesVnX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-6_HuLwQBNZKjx7zSixGXYQ-1; Thu, 12 Mar 2020 02:06:14 -0400
X-MC-Unique: 6_HuLwQBNZKjx7zSixGXYQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E6678017CC;
 Thu, 12 Mar 2020 06:06:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1442A272CB;
 Thu, 12 Mar 2020 06:06:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9060C11386A6; Thu, 12 Mar 2020 07:06:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 31/33] docs: Stop building qemu-doc
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-32-peter.maydell@linaro.org>
 <87blp3x7rr.fsf@dusky.pond.sub.org>
 <CAFEAcA9EEuAeKm8kXtSJUtm6F3=VfyMxOkESvrZzoVt87HwKpw@mail.gmail.com>
Date: Thu, 12 Mar 2020 07:06:11 +0100
In-Reply-To: <CAFEAcA9EEuAeKm8kXtSJUtm6F3=VfyMxOkESvrZzoVt87HwKpw@mail.gmail.com>
 (Peter Maydell's message of "Wed, 11 Mar 2020 15:15:53 +0000")
Message-ID: <87sgiertt8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 11 Mar 2020 at 14:53, Markus Armbruster <armbru@redhat.com> wrote=
:
>> This appears to lose plain text, PDF and info output.  Any chance to get
>> plain text back?
>
> This is deliberate. Consensus when we decided on the docs
> transition plan was that plain text was not a useful output
> format. (discussed in
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg04932.html
> and following thread).

I missed this part.  Not your fault.

> Sphinx does support text file generation, so you can if
> you really want it generate it with something like
>  sphinx-build docs /tmp/docs-out -b text
> but:
>  * it produces one text file per input file, so you might
> as well just read the rST sources
>  * at least in the version of Sphinx I have, the text builder
> does not implement some of the table markup we use,
> so it will fall over partway with a NotImplementedError
>
> PDF similarly is in theory possible via 'latex' builder
> (and then running LaTeX on the results). You can also
> download a PDF from
> https://readthedocs.org/projects/qemu/downloads/
> You will find that there are some bits where rendering
> is not good (eg long lines that didn't get wrapped so were
> just truncated).
>
> Personally I think it's difficult enough managing two
> output formats and checking that they look reasonable
> (we already found places in the QAPI docs where
> clearly nobody had looked at *any* of the rendered
> formats) so I think settling on "our supported document
> formats are HTML and manpage" is reasonable.

I see.

With plain text gone, I'll certainly look at any of the rendered stuff
even less than before.

Would it be possible to additionally render a complete manual as one
humongous .html?  Without an index, there's only search, and the
ergonomics of searching within a single page are so much better.

I'm tempted to write a trivial QAPI doc comment backend to spit out
minimally processed doc comments as one plain text file just for that.


