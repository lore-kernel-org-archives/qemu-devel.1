Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B95C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF5920830
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF5920830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8jWj-0004RW-Um
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 07:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i8jW2-0003wH-Mk
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i8jW1-000554-6s
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:13:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37170)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i8jVy-00052N-HF; Fri, 13 Sep 2019 07:13:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 73185A26660;
 Fri, 13 Sep 2019 11:13:21 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-81.ams2.redhat.com
 [10.36.116.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 91BD560600;
 Fri, 13 Sep 2019 11:13:19 +0000 (UTC)
To: ronnie sahlberg <ronniesahlberg@gmail.com>
References: <20190910154110.6905-1-pl@kamp.de>
 <20190910154110.6905-3-pl@kamp.de>
 <e2b37e13-ef22-4a16-38e5-3866e7d5409a@redhat.com>
 <CAN05THTY99Zj84LerBurGsHJDZToiYkhXvM=0eoL4SOHYUf=qw@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <478d0923-a502-c96a-bcfe-49b9e742b5be@redhat.com>
Date: Fri, 13 Sep 2019 13:13:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAN05THTY99Zj84LerBurGsHJDZToiYkhXvM=0eoL4SOHYUf=qw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Oae0sECOFgbl9MmtU4yymbR8G0XxV8Rfl"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Fri, 13 Sep 2019 11:13:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH V2 2/2] block/nfs: add support for
 nfs_umount
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>,
 qemu-devel <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Oae0sECOFgbl9MmtU4yymbR8G0XxV8Rfl
Content-Type: multipart/mixed; boundary="MrM4O78pldliqPIZ0DCBlPszGhyAGg9YB";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: ronnie sahlberg <ronniesahlberg@gmail.com>
Cc: Peter Lieven <pl@kamp.de>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <478d0923-a502-c96a-bcfe-49b9e742b5be@redhat.com>
Subject: Re: [PATCH V2 2/2] block/nfs: add support for nfs_umount
References: <20190910154110.6905-1-pl@kamp.de>
 <20190910154110.6905-3-pl@kamp.de>
 <e2b37e13-ef22-4a16-38e5-3866e7d5409a@redhat.com>
 <CAN05THTY99Zj84LerBurGsHJDZToiYkhXvM=0eoL4SOHYUf=qw@mail.gmail.com>
In-Reply-To: <CAN05THTY99Zj84LerBurGsHJDZToiYkhXvM=0eoL4SOHYUf=qw@mail.gmail.com>

--MrM4O78pldliqPIZ0DCBlPszGhyAGg9YB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.09.19 12:09, ronnie sahlberg wrote:
> On Wed, Sep 11, 2019 at 5:48 PM Max Reitz <mreitz@redhat.com> wrote:
>>
>> On 10.09.19 17:41, Peter Lieven wrote:
>>> libnfs recently added support for unmounting. Add support
>>> in Qemu too.
>>>
>>> Signed-off-by: Peter Lieven <pl@kamp.de>
>>> ---
>>>  block/nfs.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/block/nfs.c b/block/nfs.c
>>> index 2c98508275..f39acfdb28 100644
>>> --- a/block/nfs.c
>>> +++ b/block/nfs.c
>>> @@ -398,6 +398,9 @@ static void nfs_client_close(NFSClient *client)
>>>              nfs_close(client->context, client->fh);
>>>              client->fh =3D NULL;
>>>          }
>>> +#ifdef LIBNFS_FEATURE_UMOUNT
>>> +        nfs_umount(client->context);
>>> +#endif
>>>          nfs_destroy_context(client->context);
>>>          client->context =3D NULL;
>>>      }
>>
>> I don=E2=80=99t understand what unmounting means in this context.  Is =
it just
>> generic clean-up for NFSv3 (it appears that it=E2=80=99s a no-op for N=
FSv4)?
>> Why isn=E2=80=99t that done by nfs_destroy_context()?
>=20
> Umount is weird since there isn't actually any state in NFSv3 and
> "mounting" in nfsv3 is really just a matter of converting the path to
> be mounted into a filehandle.
> That is all the mount protocol is really used for.
>=20
> This is all handled in a separate protocol/server called rpc.mountd
> that is separate from NFSd. Running as a different process and
> listening to a different port.
> And the only purpose of rpc.mountd is to take a path to a share and
> return a nfsv3 filehandle to the root of that path.
> As a side-effect, rpc.mountd also keeps track of which clients have
> called MNT but not yet UMNT and thus showmount -a
> can give a lost of all client that have "mounted" the share but not
> yet called "UMNT".
>=20
> It has no effect at all on NFSv3 and is purely cosmetic. This ONLY
> affects "showmount -a" output.
> NFSv4 does away with all these separate protocols such as mount,
> statd, nlm and even portmapper
> so there is not even a concept of showmount -a for nfsv4.
>=20
>=20
> As the libnfs maintainer, why did I do nfs_umount() the way I did?
> First of all, I think of nfs UMNT as really just cosmetic and didn't
> want to put too much work into it. But people wanted it.
>=20
> I implemented it as a sync function since I think few people would
> actually use it at all and it meant that I just didn't have to invest
> in having to build an async piupelinje.
>=20
> I did NOT implement it inside nfs_destroy_context() since that
> function is supposed to be, in my view, non-blocking andn should just
> tear the connection and immediately return.
> As unmount would be
> * close the tcp socket to the nfs server
> * open new socket to portmapper and ask "where is rpc.mountd"
> * close socket to portmapper, then open new socket to rpc.mountd
>  * tell rpc.mountd to remove us from the showmount -a list
> * close socket
>=20
> I just took the cheap and easy path. Do it as a sync function with my
> own eventloop.
>=20
> Again, UMNT has no real effect on anything related to NFS except what
> showmount -a will return. That is one big reason why
> I was just not much motivated enough to build it as an async function.
>=20
> Once we all switch to NFSv4 this will all be moot since the MOUNT
> protocol no longer exists and neither does rpc.mountd.

OK.  Thanks a lot for the detailed explanation! :-)

Max


--MrM4O78pldliqPIZ0DCBlPszGhyAGg9YB--

--Oae0sECOFgbl9MmtU4yymbR8G0XxV8Rfl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl17ec0ACgkQ9AfbAGHV
z0Ar7Af+NQtaOjhrGDV8+aOZmssh5w9BtpletDfumo26J9/eu8Abw5MzETmLHUiH
IQXP792RP00v618ws8BeyePANeufcAbQ1h0M7oC6byfxfXU/WeKKISBQy5kw3Ugc
AjTZq0Jr+7GZqPNQjxE41TEANdJo/5crGHRTNdWF8sblNcIvPw7pVpVpHn4sf/2t
TUo3dhTNBekrN1PVK5Is7ybDSsm9APXw9DivebRNBNeL27pXdilHXZnPK+6Pp74Z
74HKJyZ2e8BmNrz+cX2sDN62nJ1BsgzgTKBxNXQBllWMEbszTZUu5Q6kxxBRw7iL
TGQ5ollhrT6nNIIz4zco8mqzt3CeJg==
=zvTI
-----END PGP SIGNATURE-----

--Oae0sECOFgbl9MmtU4yymbR8G0XxV8Rfl--

