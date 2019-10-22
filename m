Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3E9CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2223C2184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTNMzSNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2223C2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMrk7-0006I2-8g
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 06:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iMrjP-0005pu-05
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iMrjL-000529-VB
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:49:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35144
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iMrjL-00051m-Rm
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571741375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ktyxo/zaeZ29RTM6oUG0DdnpYT2JfPZGZgwY98oVuqk=;
 b=aTNMzSNV4k9blLqoXjfrTpzOYLZENFYp/gtyHEe3cqXd3MkH3CMbH9JO9pn3ItQdm47NuM
 eiK06WZ+vfqobDPRf8IVu8bkirutNLIgINx7AA6SaxaLt6ju+5otpsjomFIdqBDdp5zxDS
 6OA4UBUU9AZeek43z1K+gxilhNjo+D8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-dgbhETJWPOWA_jOMc5nGIw-1; Tue, 22 Oct 2019 06:49:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 077C1800D4E;
 Tue, 22 Oct 2019 10:49:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC5E760C4E;
 Tue, 22 Oct 2019 10:49:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 339321138619; Tue, 22 Oct 2019 12:49:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/12] QAPI patches for 2019-10-22
References: <20191022075615.956-1-armbru@redhat.com>
 <CAFEAcA-zmrcD-6pLTMuFLYCkGrJdA8bZjkBOHwoF0fWqGzKdMg@mail.gmail.com>
Date: Tue, 22 Oct 2019 12:49:30 +0200
In-Reply-To: <CAFEAcA-zmrcD-6pLTMuFLYCkGrJdA8bZjkBOHwoF0fWqGzKdMg@mail.gmail.com>
 (Peter Maydell's message of "Tue, 22 Oct 2019 10:32:50 +0100")
Message-ID: <874l01jbr9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: dgbhETJWPOWA_jOMc5nGIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 22 Oct 2019 at 09:11, Markus Armbruster <armbru@redhat.com> wrote=
:
>>
>> The following changes since commit e9d42461920f6f40f4d847a5ba18e90d095ed=
0b9:
>>
>>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20191018-pull-=
request' into staging (2019-10-18 14:13:11 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2019-10-22
>>
>> for you to fetch changes up to 0582bce69e8688fd7dd5501d352695e5c675b89b:
>>
>>   qapi: Allow introspecting fix for savevm's cooperation with blockdev (=
2019-10-22 09:28:11 +0200)
>>
>> ----------------------------------------------------------------
>> QAPI patches for 2019-10-22
>>
>> ----------------------------------------------------------------
>
> Fails to build:
>
>   GEN     qapi-gen
> make[1]: Nothing to be done for `all'.
> Traceback (most recent call last):
>   File "/Users/pm215/src/qemu-for-merges/scripts/qapi-gen.py", line
> 13, in <module>
>     from qapi.commands import gen_commands
>   File "/Users/pm215/src/qemu-for-merges/scripts/qapi/commands.py",
> line 17, in <module>
>     from qapi.gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifconte=
xt
>   File "/Users/pm215/src/qemu-for-merges/scripts/qapi/gen.py", line 8
> SyntaxError: Non-ASCII character '\xc3' in file
> /Users/pm215/src/qemu-for-merges/scripts/qapi/gen.py on line 8, but no
> encoding declared; see http://python.org/dev/peps/pep-0263/ for
> details
> make: *** [qapi-gen-timestamp] Error 1

Python 2, how badly you'll be missed!

v2 coming.


