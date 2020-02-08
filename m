Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4965C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 07:54:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E0821741
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 07:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUEpR+3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E0821741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Kx6-00085Q-Dj
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 02:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j0KwT-0007gs-5z
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 02:54:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j0KwS-0007IL-6t
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 02:54:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24641
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j0KwS-0007Gn-3I
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 02:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581148455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0eg/p4Nq1GZBp2cdOF/K3oLAHXYPACwWTOB02YBFEyg=;
 b=eUEpR+3JblBUI0xU+u+anpRb7k0zLbDK4qW8Tq/Vlf3p73yjyZNrAyrlhOzAwYK17H1WvX
 4VJid3gn5652n4lDMfO5LsZIScLJCNyBXnmsEQcNKbBUmKxlJyXBANruL6KQfYA1TlieGD
 NQSEni9PvAqnOVV6tKGLiRXjRPmY0VM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-e3WZfWhONYyzt87FLIdFMw-1; Sat, 08 Feb 2020 02:54:11 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3486801E6C;
 Sat,  8 Feb 2020 07:54:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 536E7790CF;
 Sat,  8 Feb 2020 07:54:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 21F2C11386A7; Sat,  8 Feb 2020 08:54:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 08/29] qapi: Use ':' after @argument in doc comments
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-9-peter.maydell@linaro.org>
 <87pnequ4og.fsf@dusky.pond.sub.org>
 <20200207102433.GC6031@linux.fritz.box>
 <CAFEAcA9a8G=RQASBxQGLMBU32w+G7un-xQwOHv4y56W1TQftPQ@mail.gmail.com>
 <87zhdupiem.fsf@dusky.pond.sub.org>
 <CAFEAcA9sxz0i2MKoaM+9RPp=4MVA8j8EEZ1yDDnCiU3Sn8ggJA@mail.gmail.com>
Date: Sat, 08 Feb 2020 08:54:03 +0100
In-Reply-To: <CAFEAcA9sxz0i2MKoaM+9RPp=4MVA8j8EEZ1yDDnCiU3Sn8ggJA@mail.gmail.com>
 (Peter Maydell's message of "Fri, 7 Feb 2020 15:24:18 +0000")
Message-ID: <878sldldk4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: e3WZfWhONYyzt87FLIdFMw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 7 Feb 2020 at 14:43, Markus Armbruster <armbru@redhat.com> wrote:
>
>
>> Here's a style I'd dislike less:
[...]
>>     # @file:
>>     # Node to create the image format on
>>     #
>>     # @size:
>>     # Size of the virtual disk in bytes
>>     #
>>     # @log-size:
>>     # Log size in bytes, must be a multiple of 1 MB (default: 1 MB)
>>     #
>>     # @block-size:
>>     # Block size in bytes, must be a multiple of 1 MB and not larger
>>     # than 256 MB (default: automatically choose a block size depending
>>     # on the image size)
>>     #
>>     # @subformat:
>>     # vhdx subformat (default: dynamic)
>>     #
>>     # @block-state-zero:
>>     # Force use of payload blocks of type 'ZERO'.  Non-standard, but
>>     # default.  Do not set to 'off' when using 'qemu-img convert' with
>>     # subformat=3Ddynamic.
>
> Conveniently this patchset already supports this format :-)
> You can write either
>
> # @foo: bar
> #       baz
> #         indented
>
> or
> # @foo:
> # bar
> # baz
> #   indented
>
> and they'll come out to the same thing (the parser.py code
> sends the same doc strings to the rST visitor).

If we enforce the second format in the QAPI schema parser, we save
ourselves the trouble of normalizing the first format to the second one.
We also promote more uniform style.


