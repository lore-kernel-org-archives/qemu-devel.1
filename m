Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FA3C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 464EF222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0L/F9YK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464EF222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2b6d-0001rb-9t
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 08:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2b1e-0001fZ-W9
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2b1d-0008Nj-OW
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:28:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45189
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2b1d-0008JB-Jw
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581686937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Bbd/JoID4YurDEn/vg4032xJTpvfCXCtZc9Jvo50Zo=;
 b=U0L/F9YK8AlqTlliYiZ48NiugyPtKLXnemwjKOZE683p0q1mpivYzLmTPSVdrO77Mrln63
 5sE1XZAUYMLx5sNKs7KLLgayM0fDsyp73q3KJL059l70AB6/V2D59ynwbhrxMejrGkRRqY
 FDVffuU5JMBI11AM3CMcamWjiU9hJKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-RrPiZQCzNZWWwmTxb4kjNA-1; Fri, 14 Feb 2020 08:28:53 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4801C18A6EC2;
 Fri, 14 Feb 2020 13:28:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BFC35C1C3;
 Fri, 14 Feb 2020 13:28:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 00F6311385C9; Fri, 14 Feb 2020 14:28:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 08/30] qapi: Use ':' after @argument in doc comments
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-9-peter.maydell@linaro.org>
 <87h7ztwcdn.fsf@dusky.pond.sub.org>
Date: Fri, 14 Feb 2020 14:28:47 +0100
In-Reply-To: <87h7ztwcdn.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Fri, 14 Feb 2020 14:02:12 +0100")
Message-ID: <87sgjduwkw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: RrPiZQCzNZWWwmTxb4kjNA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> Some qapi doc comments have forgotten the ':' after the
>> @argument, like this:
>>
>> # @filename         Filename for the new image file
>> # @size             Size of the virtual disk in bytes
>>
>> The result is that these are parsed as part of the body
>> text and appear as a run-on line:
>>   filename Filename for the new image file size Size of the virtual disk=
 in bytes"
>> followed by
>>   filename: string
>>     Not documented
>>   size: int
>>     Not documented
>>
>> in the 'Members' section.
>>
>> Correct the formatting.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> The title sounds like it's just a tweak, but it actually fixes bugs in
> the generated documentation.  Suggest to change the title to
>
>     qapi: Fix incorrect "Not documented" claims in QMP documentation
>
> R-by stands regardless.

Forgot to mention:

[...]
>> @@ -4645,17 +4645,17 @@
>>  #
>>  # Driver specific image creation options for vhdx.
>>  #
>> -# @file             Node to create the image format on
>> -# @size             Size of the virtual disk in bytes
>> -# @log-size         Log size in bytes, must be a multiple of 1 MB
>> -#                   (default: 1 MB)
>> -# @block-size       Block size in bytes, must be a multiple of 1 MB and=
 not
>> -#                   larger than 256 MB (default: automatically choose a=
 block
>> -#                   size depending on the image size)
>> -# @subformat        vhdx subformat (default: dynamic)
>> -# @block-state-zero Force use of payload blocks of type 'ZERO'. Non-sta=
ndard,
>> -#                   but default.  Do not set to 'off' when using 'qemu-=
img
>> -#                   convert' with subformat=3Ddynamic.
>> +# @file: Node to create the image format on
>> +# @size: Size of the virtual disk in bytes
>> +# @log-size: Log size in bytes, must be a multiple of 1 MB
>> +#            (default: 1 MB)
>> +# @block-size: Block size in bytes, must be a multiple of 1 MB and not
>> +#              larger than 256 MB (default: automatically choose a bloc=
k
>> +#              size depending on the image size)
>> +# @subformat: vhdx subformat (default: dynamic)
>> +# @block-state-zero: Force use of payload blocks of type 'ZERO'. Non-st=
andard,
>> +#                    but default.  Do not set to 'off' when using 'qemu=
-img
>> +#                    convert' with subformat=3Ddynamic.
>>  #
>>  # Since: 2.12
>>  ##

Kevin dislikes the loss of visual alignment here.  I dislike the
formatting before and after the patch.  I suggested a new style:

    # @file:
    # Node to create the image format on
    #
    # @size:
    # Size of the virtual disk in bytes
    #
    # @log-size:
    # Log size in bytes, must be a multiple of 1 MB (default: 1 MB)
    #
    # @block-size:
    # Block size in bytes, must be a multiple of 1 MB and not larger
    # than 256 MB (default: automatically choose a block size depending
    # on the image size)
    #
    # @subformat:
    # vhdx subformat (default: dynamic)
    #
    # @block-state-zero:
    # Force use of payload blocks of type 'ZERO'.  Non-standard, but
    # default.  Do not set to 'off' when using 'qemu-img convert' with
    # subformat=3Ddynamic.

Nobody disliked this style.  Peter reports his code already supports it,
but objects to converting to it in his series.  Okay; we can convert
later.  More churn, but the individual patches / series are simpler.


