Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CF1C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 08:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED4220726
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 08:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ho2qJznU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED4220726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izyv5-0007sl-Uv
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 03:23:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1izyuQ-0007Nu-LV
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:22:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1izyuP-0004wh-JX
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:22:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41580
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1izyuP-0004uT-Fo
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581063761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYDrnMwGVeixxkUf9kbgDbwdwhVuu5PDph94jerlYB4=;
 b=ho2qJznUyc8EvsWSjlomWgxJ1c71mmzAbiUAxVHtD8b2S1BAE2Y1V/BhJz2JG9oFyucV82
 YK9/XKk/nI+dZxpFcCzBGmHssWDVvnS1dAx/jOXJx9PcSexPz467Gp+5SaCjsIKTPQZXg5
 PjG1iswW1rnIFLBzPbh6ntYjBPS7Ips=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-VmriC6dPM4egaQVdpceHMg-1; Fri, 07 Feb 2020 03:22:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47D2D106BBDC;
 Fri,  7 Feb 2020 08:22:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F37726195;
 Fri,  7 Feb 2020 08:22:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C6AB511386A7; Fri,  7 Feb 2020 09:22:29 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 05/29] qga/qapi-schema.json: Fix indent level on doc
 comments
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-6-peter.maydell@linaro.org>
 <87pneqvmha.fsf@dusky.pond.sub.org>
Date: Fri, 07 Feb 2020 09:22:29 +0100
In-Reply-To: <87pneqvmha.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Fri, 07 Feb 2020 09:18:57 +0100")
Message-ID: <87d0aqvmbe.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: VmriC6dPM4egaQVdpceHMg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: John Snow <jsnow@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> The texinfo doc generation doesn't care much about indentation
>> levels, but we would like to add a rST backend, and rST does care
>> about indentation.
>>
>> Make the doc comments more strongly consistent about indentation
>> for multiline constructs like:
>>
>> @arg: description line 1
>>       description line 2
>>
>> Returns: line one
>>          line 2
>>
>> so that there is always exactly one space after the colon, and
>> subsequent lines align with the first.
>>
>> This commit is a purely whitespace change, and it does not alter the
>> generated .texi files (because the texi generation code strips away
>> all the extra whitespace).  This does mean that we end up with some
>> over-length lines.
>>
>> Note that when the documentation for an argument fits on a single
>> line like this:
>>
>> @arg: one line only
>>
>> then stray extra spaces after the ':' don't affect the rST output, so
>> I have not attempted to methodically fix them, though the preference
>> is a single space here too.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> How is this commit related to PATCH 9?  The commit messages are
> suspiciously similar...

Nevermind, I got it: this one's for qga/, PATCH 9 if for qapi/.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


