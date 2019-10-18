Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129F8CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCBED21852
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBED21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLOeh-0004xZ-3h
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 05:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iLObi-000293-Vv
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iLObg-0006wM-Co
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:31:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45458)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iLObg-0006vt-2w
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:31:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 23856307C654
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 09:31:34 +0000 (UTC)
Received: from thuth.remote.csb (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02FC65D9D5;
 Fri, 18 Oct 2019 09:31:20 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH v2 3/4] trace: forbid use of %m in trace
 event format strings
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20190118173103.4903-1-berrange@redhat.com>
 <20190118173103.4903-4-berrange@redhat.com>
 <c18e222d-ae68-968b-7738-edfa21c8ceef@redhat.com>
 <20190122143257.GR13143@redhat.com>
 <c06dd0a6-166f-a522-1f54-736519076432@redhat.com>
 <20190122172333.GA13143@redhat.com>
 <9d0997e0-9019-c7c2-56d6-26c70f0d5c7e@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <8e9b4f93-234b-9ae0-0ffc-d96de3ce02cb@redhat.com>
Date: Fri, 18 Oct 2019 11:31:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9d0997e0-9019-c7c2-56d6-26c70f0d5c7e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oavsMs1krcPZwOrJzYPfxinbIm5aH64IV"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 18 Oct 2019 09:31:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oavsMs1krcPZwOrJzYPfxinbIm5aH64IV
Content-Type: multipart/mixed; boundary="kdmSty2OLfAjJpCraHdFXrDi9XIN2fyqI";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <8e9b4f93-234b-9ae0-0ffc-d96de3ce02cb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] trace: forbid use of %m in trace
 event format strings
References: <20190118173103.4903-1-berrange@redhat.com>
 <20190118173103.4903-4-berrange@redhat.com>
 <c18e222d-ae68-968b-7738-edfa21c8ceef@redhat.com>
 <20190122143257.GR13143@redhat.com>
 <c06dd0a6-166f-a522-1f54-736519076432@redhat.com>
 <20190122172333.GA13143@redhat.com>
 <9d0997e0-9019-c7c2-56d6-26c70f0d5c7e@redhat.com>
In-Reply-To: <9d0997e0-9019-c7c2-56d6-26c70f0d5c7e@redhat.com>

--kdmSty2OLfAjJpCraHdFXrDi9XIN2fyqI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22/01/2019 19.10, Eric Blake wrote:
> On 1/22/19 11:23 AM, Daniel P. Berrang=C3=A9 wrote:
>=20
>>
>>>> On this point though, does anyone know of any platforms we support[1=
],
>>>> or are likely to support in future, where 'strerror' is *not* thread=

>>>> safe ?
>>>
>>> I'm not coming up with one, and I think the problem is independent of=

>>> this series (if we DO have a problem, it's a series all its own to
>>> eradicate the use of strerror() in favor of something safer, either
>>> picking strerror_l() or dealing with the glibc vs. BSD differences in=

>>> strerror_r()).
>>
>> Agree that its not really something for this series - this just
>> made me think of it again.
>=20
> Shoot - FreeBSD strerror() is not threadsafe:
> https://github.com/freebsd/freebsd/blob/master/lib/libc/string/strerror=
=2Ec#L119
>=20
> char *
> strerror(int num)
> {
> 	static char ebuf[NL_TEXTMAX];
>=20
> 	if (strerror_r(num, ebuf, sizeof(ebuf)) !=3D 0)
> 		errno =3D EINVAL;
> 	return (ebuf);
> }
>=20
>>
>> We went through the scrubbing in libvirt to use the sane, but still
>> tedious to call, variant of strerror_r() many years ago. With luck
>> though it is a worry that can be confined the dustbin of ancient
>> UNIX history....unless someone can point to evidence to the contrary ?=

>=20
> libvirt has it easy - they let gnulib do all the work of futzing around=

> with getting a working strerror() despite platform bugs and despite
> glibc's insistence on a non-POSIX signature if _GNU_SOURCE is defined.
> We'll have to do a bit more legwork.
>=20
> That said, I've added it to:
> https://wiki.qemu.org/Contribute/BiteSizedTasks#Error_checking
>=20
> if someone wants to do the grunt work.

I think we should change that task to switch to g_strerror() from glib
instead ... as far as I can see, this is a proper wrapper around
strerror_r(), so we don't have to deal with the implementation oddities
of strerror_r() in QEMU.

 Thomas


--kdmSty2OLfAjJpCraHdFXrDi9XIN2fyqI--

--oavsMs1krcPZwOrJzYPfxinbIm5aH64IV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl2phmMACgkQLtnXdP5w
LbU5Wg//dUv5ZwZalsdAVgj6u6eJo7WE59nDnBMSPiXQgjFPrF3cFZD2UbljkWfE
rmuiwn5wCnlkvawmSsYZs+WALcEAiht8nBVz0qCpQ5hCFvp64/G84HB7JUXkcKdo
TQ2Escn22xefESv7WZK2IToqYxLZs7tsoI6+VMVlDmK6c1rJHpxBZTcUfdTo7nW4
qacDDadolf7+dd7opTDP+6drdJdD7YtrYrhNqB1e9pOu06unMu+J0PM62fNegwUm
3GjqSjoU+mrv7SFOHy8gkXpUfWkgqAHYUbF+SvwHHg9CkJRzSQ4wCHc1aVSGrtlB
U0QnYzbqgKin7N0Rppy3Plf8Dlkg88OJn5N48oE7nkjHwOWF4i8OR6+zu13vR7Vi
xg5ZXqjaT9aV6CDdRD2PSsZDoDEatrn/OXxZdF6Q9wHKsRn5sdE2qMOwUyV0qdpo
z/8GCkCGgo01Six8vL5wcP1IVKVgpAOLN95eM1BC4egEe9lxmP9YVvoxYFfFEn5q
Be1f0Z8mUBmEYuNzcj3CMkLVPzLPHKzG0TRuTHgO7o0msQ5tlLCI9+HtjXzl1AD7
1i+vXAiUCQSrauzXMA1DaScIYO/b4udQ7jWgkUEjQtOTbSeVvFSRRQbHoHD+Ant0
urQIS8EYt3kjt41tjNFi30t65oSmd4nlj+leBz0IUgXsy0hYHVM=
=Ut5Z
-----END PGP SIGNATURE-----

--oavsMs1krcPZwOrJzYPfxinbIm5aH64IV--

