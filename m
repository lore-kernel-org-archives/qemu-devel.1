Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92E4C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 11:43:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F04221848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 11:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F04221848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i17yO-00028n-RP
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 07:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i17wp-0000nB-Et
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 07:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i17wn-00006F-6n
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 07:41:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33042)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i17wm-0008VO-IQ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 07:41:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1AA211801599;
 Fri, 23 Aug 2019 11:41:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3C5519C77;
 Fri, 23 Aug 2019 11:41:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 371ED1162B63; Fri, 23 Aug 2019 13:41:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
References: <20190822011620.106337-1-aik@ozlabs.ru>
 <87wof5b7ze.fsf@dusky.pond.sub.org> <20190822144940.GV3267@redhat.com>
 <87blwg77o4.fsf@dusky.pond.sub.org> <20190823092347.GA9654@redhat.com>
Date: Fri, 23 Aug 2019 13:41:32 +0200
In-Reply-To: <20190823092347.GA9654@redhat.com> ("Daniel P. =?utf-8?Q?Berr?=
 =?utf-8?Q?ang=C3=A9=22's?=
 message of "Fri, 23 Aug 2019 10:23:47 +0100")
Message-ID: <874l285csz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 23 Aug 2019 11:41:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH qemu] qapi: Add query-memory-checksum
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Aug 23, 2019 at 07:49:31AM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Thu, Aug 22, 2019 at 04:16:53PM +0200, Markus Armbruster wrote:
>> >> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>> >>=20
>> >> > This returns MD5 checksum of all RAM blocks for migration debugging
>> >> > as this is way faster than saving the entire RAM to a file and chec=
king
>> >> > that.
>> >> >
>> >> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> >>=20
>> >> Any particular reason for MD5?  Have you measured the other choices
>> >> offered by GLib?
>> >>=20
>> >> I understand you don't need crypto-strength here.  Both MD5 and SHA-1
>> >> would be bad choices then.
>> >
>> > We have a tests/bench-crypto-hash test but its hardcoded for sha256.
>> > I hacked it to report all algorithms and got these results for varying
>> > input chunk sizes:
>> >
>> > /crypto/hash/md5/speed-512: 519.12 MB/sec OK
>> > /crypto/hash/md5/speed-1024: 560.39 MB/sec OK
>> > /crypto/hash/md5/speed-4096: 591.39 MB/sec OK
>> > /crypto/hash/md5/speed-16384: 576.46 MB/sec OK
>> > /crypto/hash/sha1/speed-512: 443.12 MB/sec OK
>> > /crypto/hash/sha1/speed-1024: 518.82 MB/sec OK
>> > /crypto/hash/sha1/speed-4096: 555.60 MB/sec OK
>> > /crypto/hash/sha1/speed-16384: 568.16 MB/sec OK
>> > /crypto/hash/sha224/speed-512: 221.90 MB/sec OK
>> > /crypto/hash/sha224/speed-1024: 239.79 MB/sec OK
>> > /crypto/hash/sha224/speed-4096: 269.37 MB/sec OK
>> > /crypto/hash/sha224/speed-16384: 274.87 MB/sec OK
>> > /crypto/hash/sha256/speed-512: 222.75 MB/sec OK
>> > /crypto/hash/sha256/speed-1024: 253.25 MB/sec OK
>> > /crypto/hash/sha256/speed-4096: 272.80 MB/sec OK
>> > /crypto/hash/sha256/speed-16384: 275.59 MB/sec OK
>> > /crypto/hash/sha384/speed-512: 322.73 MB/sec OK
>> > /crypto/hash/sha384/speed-1024: 369.84 MB/sec OK
>> > /crypto/hash/sha384/speed-4096: 406.71 MB/sec OK
>> > /crypto/hash/sha384/speed-16384: 417.87 MB/sec OK
>> > /crypto/hash/sha512/speed-512: 320.62 MB/sec OK
>> > /crypto/hash/sha512/speed-1024: 361.93 MB/sec OK
>> > /crypto/hash/sha512/speed-4096: 404.91 MB/sec OK
>> > /crypto/hash/sha512/speed-16384: 418.53 MB/sec OK
>> > /crypto/hash/ripemd160/speed-512: 226.45 MB/sec OK
>> > /crypto/hash/ripemd160/speed-1024: 239.25 MB/sec OK
>> > /crypto/hash/ripemd160/speed-4096: 251.31 MB/sec OK
>> > /crypto/hash/ripemd160/speed-16384: 255.01 MB/sec OK
>> >
>> >
>> > IOW, md5 is clearly the quickest, by a considerable margin over
>> > SHA256/512. SHA1 is slightly slower.
>> >
>> > Assuming that we document that this command is intentionally
>> > *not* trying to guarantee collision resistances we're ok.
>> >
>> > In fact we should not document what kind of checksum is
>> > reported by query-memory-checksum. The impl should be a black
>> > box from user's POV.
>> >
>> > If we're just aiming for debugging tool to detect accidental
>> > corruption, could we even just ignore cryptographic hashs
>> > entirely and do a crc32 - that'd be way faster than even
>> > md5.
>>=20
>> Good points.
>>=20
>> The doc strings should spell out "for debugging", like the commit
>> message does, and both should spell out "weak collision resistance".
>>=20
>> I can't find CRC-32 in GLib, but zlib appears to provide it:
>> http://refspecs.linuxbase.org/LSB_3.0.0/LSB-Core-generic/LSB-Core-generi=
c/zlib-crc32-1.html
>>=20
>> Care to compare its speed to MD5?
>
> I hacked the code to use zlib's crc32 impl and got these for comparison:
>
> /crypto/hash/crc32/speed-512: 1089.18 MB/sec OK
> /crypto/hash/crc32/speed-1024: 1124.63 MB/sec OK
> /crypto/hash/crc32/speed-4096: 1162.73 MB/sec OK
> /crypto/hash/crc32/speed-16384: 1171.58 MB/sec OK
> /crypto/hash/crc32/speed-1048576: 1165.68 MB/sec OK
> /crypto/hash/md5/speed-512: 476.27 MB/sec OK
> /crypto/hash/md5/speed-1024: 517.16 MB/sec OK
> /crypto/hash/md5/speed-4096: 554.70 MB/sec OK
> /crypto/hash/md5/speed-16384: 564.44 MB/sec OK
> /crypto/hash/md5/speed-1048576: 566.78 MB/sec OK

Twice as fast.  Alexey, what do you think?

