Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FC8C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17FEE2187F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2iChW4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17FEE2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ar1-0007bi-8E
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 08:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2aqB-0006yT-0J
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:17:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2aq9-0007F8-QY
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:17:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60404
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2aq9-0007By-Mg
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581686224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vybReRr96I9wEuqy4WaNp69BLJ7GIRA4iQ6HK9W5cDA=;
 b=M2iChW4q2NdAGQUHUBJHVySTXjOY0a7TeRc/9mJIzyJ8EZ04LkktG6cZwodxwHQppPKwD9
 +H28T+WLElo2DkbHHJ7anI395cqg39biVsjl50AvesWv1zZQkItut4B6ixXeRK1jaY1DNo
 JNjWoMQVfJkbSOd4ByF0BZppAeAQ4K8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-ti0l95XEPb-hWFxu5gM8iQ-1; Fri, 14 Feb 2020 08:17:01 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C8F68C40FF;
 Fri, 14 Feb 2020 13:17:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4769060BF1;
 Fri, 14 Feb 2020 13:16:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BBA8811385C9; Fri, 14 Feb 2020 14:16:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 06/29] qga/qapi-schema.json: minor format fixups for rST
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-7-peter.maydell@linaro.org>
 <871rr6vlu5.fsf@dusky.pond.sub.org>
 <CAFEAcA-DExXM7E21d_0A-JBNwYzRp1KFB==esZaGsQbvqC04pg@mail.gmail.com>
Date: Fri, 14 Feb 2020 14:16:55 +0100
In-Reply-To: <CAFEAcA-DExXM7E21d_0A-JBNwYzRp1KFB==esZaGsQbvqC04pg@mail.gmail.com>
 (Peter Maydell's message of "Thu, 13 Feb 2020 16:20:45 +0000")
Message-ID: <871rqxwbp4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ti0l95XEPb-hWFxu5gM8iQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 7 Feb 2020 at 08:33, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > rST format requires a blank line before the start of a bulleted
>> > or enumerated list. Two places in qapi-schema.json were missing
>> > this blank line.
>> >
>> > Some places were using an indented line as a sort of single-item
>> > bulleted list, which in the texinfo output comes out all run
>> > onto a single line; use a real bulleted list instead.
>> >
>> > Some places unnecessarily indented lists, which confuses rST.
>> >
>> > guest-fstrim:minimum's documentation was indented the
>> > right amount to share a line with @minimum, but wasn't
>> > actually doing so.
>> >
>> > The indent on the bulleted list in the guest-set-vcpus
>> > Returns section meant rST misindented it.
>> >
>> > Changes to the generated texinfo are very minor (the new
>> > bulletted lists, and a few extra blank lines).
>> >
>> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
>> > @@ -767,17 +771,17 @@
>> >  # Returns: The length of the initial sublist that has been successful=
ly
>> >  #          processed. The guest agent maximizes this value. Possible =
cases:
>> >  #
>> > -#          - 0:              if the @vcpus list was empty on input. G=
uest state
>> > -#                            has not been changed. Otherwise,
>> > -#          - Error:          processing the first node of @vcpus fail=
ed for the
>> > -#                            reason returned. Guest state has not bee=
n changed.
>> > -#                            Otherwise,
>> > +#          - 0: if the @vcpus list was empty on input. Guest state
>> > +#            has not been changed. Otherwise,
>> > +#          - Error: processing the first node of @vcpus failed for th=
e
>> > +#            reason returned. Guest state has not been changed.
>> > +#            Otherwise,
>> >  #          - < length(@vcpus): more than zero initial nodes have been=
 processed,
>> > -#                            but not the entire @vcpus list. Guest st=
ate has
>> > -#                            changed accordingly. To retrieve the err=
or
>> > -#                            (assuming it persists), repeat the call =
with the
>> > -#                            successfully processed initial sublist r=
emoved.
>> > -#                            Otherwise,
>> > +#            but not the entire @vcpus list. Guest state has
>> > +#            changed accordingly. To retrieve the error
>> > +#            (assuming it persists), repeat the call with the
>> > +#            successfully processed initial sublist removed.
>> > +#            Otherwise,
>> >  #          - length(@vcpus): call successful.
>>
>> Source readability suffers a bit here.
>>
>> Can we break the line after the colon?
>>
>>    #          - 0:
>>    #            if the @vcpus list was empty on input. Guest state has
>>    #            not been changed. Otherwise,
>>
>> Or would a definition list be a better fit?
>
> A definition list does produce nicer rendering in the rST, but
> it breaks the rendering in the texinfo (which interprets the
> indent of a rST definition list as meaninglist and renders it
> all as one long run-on paragraph). For the purposes of this
> initial cleanup, I'll put in the newlines you suggest, which
> have no effect on rendering output for either texinfo or rST.

Okay.  We can switch to definition lists later.


