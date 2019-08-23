Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48B7C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86CA421726
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CA421726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i15oY-00051P-BA
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 05:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i15nY-0004LD-Pe
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:23:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i15nW-0001pR-OQ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:23:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53866)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i15nW-0001nF-G2
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:23:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C7171801584;
 Fri, 23 Aug 2019 09:23:53 +0000 (UTC)
Received: from redhat.com (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B6F45C226;
 Fri, 23 Aug 2019 09:23:51 +0000 (UTC)
Date: Fri, 23 Aug 2019 10:23:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190823092347.GA9654@redhat.com>
References: <20190822011620.106337-1-aik@ozlabs.ru>
 <87wof5b7ze.fsf@dusky.pond.sub.org>
 <20190822144940.GV3267@redhat.com>
 <87blwg77o4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87blwg77o4.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 23 Aug 2019 09:23:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 23, 2019 at 07:49:31AM +0200, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Thu, Aug 22, 2019 at 04:16:53PM +0200, Markus Armbruster wrote:
> >> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> >>=20
> >> > This returns MD5 checksum of all RAM blocks for migration debuggin=
g
> >> > as this is way faster than saving the entire RAM to a file and che=
cking
> >> > that.
> >> >
> >> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>=20
> >> Any particular reason for MD5?  Have you measured the other choices
> >> offered by GLib?
> >>=20
> >> I understand you don't need crypto-strength here.  Both MD5 and SHA-=
1
> >> would be bad choices then.
> >
> > We have a tests/bench-crypto-hash test but its hardcoded for sha256.
> > I hacked it to report all algorithms and got these results for varyin=
g
> > input chunk sizes:
> >
> > /crypto/hash/md5/speed-512: 519.12 MB/sec OK
> > /crypto/hash/md5/speed-1024: 560.39 MB/sec OK
> > /crypto/hash/md5/speed-4096: 591.39 MB/sec OK
> > /crypto/hash/md5/speed-16384: 576.46 MB/sec OK
> > /crypto/hash/sha1/speed-512: 443.12 MB/sec OK
> > /crypto/hash/sha1/speed-1024: 518.82 MB/sec OK
> > /crypto/hash/sha1/speed-4096: 555.60 MB/sec OK
> > /crypto/hash/sha1/speed-16384: 568.16 MB/sec OK
> > /crypto/hash/sha224/speed-512: 221.90 MB/sec OK
> > /crypto/hash/sha224/speed-1024: 239.79 MB/sec OK
> > /crypto/hash/sha224/speed-4096: 269.37 MB/sec OK
> > /crypto/hash/sha224/speed-16384: 274.87 MB/sec OK
> > /crypto/hash/sha256/speed-512: 222.75 MB/sec OK
> > /crypto/hash/sha256/speed-1024: 253.25 MB/sec OK
> > /crypto/hash/sha256/speed-4096: 272.80 MB/sec OK
> > /crypto/hash/sha256/speed-16384: 275.59 MB/sec OK
> > /crypto/hash/sha384/speed-512: 322.73 MB/sec OK
> > /crypto/hash/sha384/speed-1024: 369.84 MB/sec OK
> > /crypto/hash/sha384/speed-4096: 406.71 MB/sec OK
> > /crypto/hash/sha384/speed-16384: 417.87 MB/sec OK
> > /crypto/hash/sha512/speed-512: 320.62 MB/sec OK
> > /crypto/hash/sha512/speed-1024: 361.93 MB/sec OK
> > /crypto/hash/sha512/speed-4096: 404.91 MB/sec OK
> > /crypto/hash/sha512/speed-16384: 418.53 MB/sec OK
> > /crypto/hash/ripemd160/speed-512: 226.45 MB/sec OK
> > /crypto/hash/ripemd160/speed-1024: 239.25 MB/sec OK
> > /crypto/hash/ripemd160/speed-4096: 251.31 MB/sec OK
> > /crypto/hash/ripemd160/speed-16384: 255.01 MB/sec OK
> >
> >
> > IOW, md5 is clearly the quickest, by a considerable margin over
> > SHA256/512. SHA1 is slightly slower.
> >
> > Assuming that we document that this command is intentionally
> > *not* trying to guarantee collision resistances we're ok.
> >
> > In fact we should not document what kind of checksum is
> > reported by query-memory-checksum. The impl should be a black
> > box from user's POV.
> >
> > If we're just aiming for debugging tool to detect accidental
> > corruption, could we even just ignore cryptographic hashs
> > entirely and do a crc32 - that'd be way faster than even
> > md5.
>=20
> Good points.
>=20
> The doc strings should spell out "for debugging", like the commit
> message does, and both should spell out "weak collision resistance".
>=20
> I can't find CRC-32 in GLib, but zlib appears to provide it:
> http://refspecs.linuxbase.org/LSB_3.0.0/LSB-Core-generic/LSB-Core-gener=
ic/zlib-crc32-1.html
>=20
> Care to compare its speed to MD5?

I hacked the code to use zlib's crc32 impl and got these for comparison:

/crypto/hash/crc32/speed-512: 1089.18 MB/sec OK
/crypto/hash/crc32/speed-1024: 1124.63 MB/sec OK
/crypto/hash/crc32/speed-4096: 1162.73 MB/sec OK
/crypto/hash/crc32/speed-16384: 1171.58 MB/sec OK
/crypto/hash/crc32/speed-1048576: 1165.68 MB/sec OK
/crypto/hash/md5/speed-512: 476.27 MB/sec OK
/crypto/hash/md5/speed-1024: 517.16 MB/sec OK
/crypto/hash/md5/speed-4096: 554.70 MB/sec OK
/crypto/hash/md5/speed-16384: 564.44 MB/sec OK
/crypto/hash/md5/speed-1048576: 566.78 MB/sec OK


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

