Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3A7C4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD8E208FE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFG+9Kr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD8E208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFRj-00076B-To
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNFQM-0005la-Cp
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:12:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57123)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNFQI-0005Ry-5E
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:12:05 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601385120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pBO1mueCqYNQQMRtYYtrBf5yCJiJeh+3d560PNeF6bw=;
 b=TFG+9Kr/aSTpD5DVs4ccuzZPk+C6zM4nC16x6wmISODn70k7zKQxJJdZMAo2a5CzUf/t3h
 pb2F6V05jkzgpNpLlfiRitQFSA8pzstW8Xtlwjpgfi7ZxNdLsm/TYOxR4Hqicre0OXoGso
 IMSagEpE+re0ur/JPknolW2crrE9KcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-ds--Gr7gNOy1N8UWPE6s5Q-1; Tue, 29 Sep 2020 09:11:58 -0400
X-MC-Unique: ds--Gr7gNOy1N8UWPE6s5Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9281018B9ED7;
 Tue, 29 Sep 2020 13:11:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 428EC2AA86;
 Tue, 29 Sep 2020 13:11:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BB9D6113864A; Tue, 29 Sep 2020 15:11:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 08/21] docs/interop: Convert qemu-ga-ref to rST
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-9-peter.maydell@linaro.org>
 <87tuvh0zaf.fsf@dusky.pond.sub.org>
 <CAFEAcA90L2YEOU70S_B-o+ZQNz+NJKtRd4UU48RBcqe=Z=eSAw@mail.gmail.com>
Date: Tue, 29 Sep 2020 15:11:55 +0200
In-Reply-To: <CAFEAcA90L2YEOU70S_B-o+ZQNz+NJKtRd4UU48RBcqe=Z=eSAw@mail.gmail.com>
 (Peter Maydell's message of "Tue, 29 Sep 2020 10:26:50 +0100")
Message-ID: <87k0wcsp5w.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 29 Sep 2020 at 09:20, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > Convert qemu-ga-ref to rST format. This includes dropping
>> > the plain-text, pdf and info format outputs for this document;
>> > as with all our other Sphinx-based documentation, we provide
>> > HTML and manpage only.
>> >
>
>> > --- a/docs/interop/conf.py
>> > +++ b/docs/interop/conf.py
>> > @@ -19,4 +19,6 @@ html_theme_options['description'] = u'System Emulation Management and Interopera
>> >  man_pages = [
>> >      ('qemu-ga', 'qemu-ga', u'QEMU Guest Agent',
>> >       ['Michael Roth <mdroth@linux.vnet.ibm.com>'], 8),
>> > +    ('qemu-ga-ref', 'qemu-ga-ref', u'QEMU Guest Agent Protocol Reference',
>> > +     [], 7),
>> >  ]
>>
>> Why do you make the description a unicode legacy literal?  I see it
>> matches existing entries.  I'd like to know regardless :)
>
> I was probably just copying some other example of how to
> write the man_pages[] definition. This also all used to have
> to work with Python 2.7, which might or might not be relevant here.

Let's switch to plain string.  Can do in my tree.

>> > -@titlepage
>> > -@title Guest Agent Protocol Reference Manual
>> > -@subtitle QEMU version @value{VERSION}
>>
>> There is no obvious equivalent to @value{VERSION} in
>> docs/interop/qemu-ga-ref.rst.
>>
>> The manual page generated from it has the version in the footer.  Good.
>>
>> I can't find it in the generated HTML.  Not so good, but it wasn't there
>> before the patch, either.
>>
>> The generated PDF had it on the title page.
>>
>> Suggest to add a TODO comment like the one about the licensing
>> information.
>
> So the version is in the manual page, as it was before the conversion,
> and it's not in the HTML version, which it wasn't before the
> conversion. That doesn't sound to me like there's anything here
> to do...

I think readers of the HTML version will appreciate the version
information.

Similar situation as for the licensing information: your patch doesn't
make things worse[*], but we found something to improve during review.

>          You can add a TODO if you want one, of course.

Thanks!


[*] I guess it would for PDF, if we still supported PDF.


