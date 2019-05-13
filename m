Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDC0C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8183321019
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8183321019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57820 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQBSx-0000vJ-RJ
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 09:58:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQBOR-0005U9-LG
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQBOQ-0000Bn-HN
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:53:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hQBOQ-0000BM-CO
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:53:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DC8D356E9
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 13:53:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C34E6928F;
	Mon, 13 May 2019 13:53:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id AF33711385E4; Mon, 13 May 2019 15:53:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
References: <20190430131919.GN6818@redhat.com> <20190430144546.GA3065@work-vm>
	<20190430150556.GA2423@redhat.com>
	<87sgtqejn9.fsf@dusky.pond.sub.org>
	<20190507093954.GG27205@redhat.com>
	<875zql3ylk.fsf@dusky.pond.sub.org>
	<20190513120856.GH15029@redhat.com>
Date: Mon, 13 May 2019 15:53:19 +0200
In-Reply-To: <20190513120856.GH15029@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Mon, 13 May 2019 13:08:56 +0100")
Message-ID: <87ef525uls.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Mon, 13 May 2019 13:53:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] QMP; unsigned 64-bit ints;
 JSON standards compliance
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: libvir-list@redhat.com, =?utf-8?Q?J=C3=A1n?= Tomko <jtomko@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, May 08, 2019 at 02:44:07PM +0200, Markus Armbruster wrote:
[...]
>> Double-checking: do you propose to encode *all* numbers as strings, or
>> just certain "problematic" numbers?
>>=20
>> If the latter, I guess your idea of "problematic" is "not representable
>> exactly as double precision floating-point".
>
> We have a few options
>
>  1. Use string format for values > 2^53-1, int format below that
>  2. Use string format for all fields which are 64-bit ints whether
>     signed or unsigned
>  3. Use string format for all fields which are integers, even 32-bit
>     ones
>
> I would probably suggest option 2. It would make the QEMU impl quite
> easy IIUC, we we'd just change the QAPI visitor's impl for the int64
> and uint64 fields to use string format (when the right capability is
> negotiated by QMP).
>
> I include 3 only for completeness - I don't think there's a hugely
> compelling reason to mess with 32-bit ints.

Agree.

> Option 1 is the bare minimum needed to ensure precision, but to me
> it feels a bit dirty to say a given field will have different encoding
> depending on the value. If apps need to deal with string encoding, they
> might as well just use it for all values in a given field.

I guess that depends on what this interoperability capability does for
QMP *input*.

For *output*, QEMU has to encode a number either as JSON number or as
JSON string

For *input*, QEMU could accept either.  Or it could accept only the
encoding it produces on output.

Got a preference?

[...]
>> You wrote Jansson "raises a fatal parse error for unsigned 64-bit values
>> above 2^63-1".  Does that mean it rejects 9223372036854775808, but
>> accepts 9223372036854775808.0 (with loss of precision)?
>
> If it sees a '.' in the number, then it call strtod() and checks for
> the overflow conditions.
>
> If it doesn't see a '.' in the number then it calls strtoll and checks
> for the overflow conditions.
>
> So to answer you question, yes, it looks like it will reject
> 9223372036854775808 and accept 9223372036854775808.0 with loss of
> precision.

Sucks :)

But then JSON does.

