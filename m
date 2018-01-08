Received: from eggs.gnu.org ([2001:4830:134:3::10]:37142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYaMT-0003Zh-MZ
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:33:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYaMQ-00017s-EG
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:33:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eYaMQ-00017J-39
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:33:18 -0500
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
	<CAFEAcA_4ZBLNcJXqJ78TmEZz1FqGVqvFuL1NdR2WaWNWxhVLVg@mail.gmail.com>
	<CAO_EM_nzdoQPPtvcf4tEU1=WoNtDpoAHFUBXBGa=EU7skG+40w@mail.gmail.com>
	<4a83359d-408a-35a9-1a81-d201783c3465@redhat.com>
	<CAO_EM_=NgT1f+bM7_2ztw1S0ZvkDYZyJjwvRMWV6FVyvODMWfA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eeb7de3f-5b0f-0c64-7e31-62d6bb046b9a@redhat.com>
Date: Mon, 8 Jan 2018 10:33:15 -0600
MIME-Version: 1.0
In-Reply-To: <CAO_EM_=NgT1f+bM7_2ztw1S0ZvkDYZyJjwvRMWV6FVyvODMWfA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lDg1BzqQ9T90dKJtQxOUoWC3F2hm2aucV"
Subject: Re: [Qemu-devel] [PULL 00/18] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lDg1BzqQ9T90dKJtQxOUoWC3F2hm2aucV
From: Eric Blake <eblake@redhat.com>
To: Ed Swierk <eswierk@skyportsystems.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang
 <jasowang@redhat.com>, qemu-devel@nongnu.org
Message-ID: <eeb7de3f-5b0f-0c64-7e31-62d6bb046b9a@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/18] Net patches
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
 <CAFEAcA_4ZBLNcJXqJ78TmEZz1FqGVqvFuL1NdR2WaWNWxhVLVg@mail.gmail.com>
 <CAO_EM_nzdoQPPtvcf4tEU1=WoNtDpoAHFUBXBGa=EU7skG+40w@mail.gmail.com>
 <4a83359d-408a-35a9-1a81-d201783c3465@redhat.com>
 <CAO_EM_=NgT1f+bM7_2ztw1S0ZvkDYZyJjwvRMWV6FVyvODMWfA@mail.gmail.com>
In-Reply-To: <CAO_EM_=NgT1f+bM7_2ztw1S0ZvkDYZyJjwvRMWV6FVyvODMWfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/08/2018 09:54 AM, Ed Swierk wrote:

>> It's also a factor of how strict your ISP is about DMARC handling; the=

>> list automatically rewrites the 'From:' header to insert the 'via
>> Qemu-devel' tag if it detects DMARC settings at your ISP that won't
>> allow your email through as originally written.  Sadly, mailman doesn'=
t
>> know to insert a manual 'From:' line in the body when it rewrites the
>> original From: header; but if you know that DMARC settings are going t=
o
>> munge your original header, you can probably convince git to always
>> insert an explicit From: line in the message body to override whatever=

>> munging the list does.
>=20
> I'm trying to figure out what I need to fix on my end. I went back and
> looked at the email headers. Here are the two that ended up with the
> wrong author:

https://dmarc.org/wiki/FAQ has some more information on DMARC.  There's
two aspects to it: one is that the domain in charge of the policy can
choose default reactions to any mail claiming to be sent from that
domain (valid, none, flag, reject); the other is that recipients can
choose whether to honor DMARC settings (some recipients let all mail
through, even if DMARC said to flag or reject it, others are stricter
and drop mail that DMARC marked as reject).  We had list readers
complaining about not getting emails (tending to come from recipients
that drop mails when DMARC says reject, and only mails from senders
where DMARC was set to reject rather than to flag), so we enabled the
mailman settings that rewrite the From: line based on a DMARC lookup of
the sender's information.

>=20
> Return-Path: <eswierk@skyportsystems.com>
> Received: from eswierk-sc.localdomain
> (67-207-112-138.static.wiline.com. [67.207.112.138])
>         by smtp.gmail.com with ESMTPSA id
> d9sm20150979pfk.117.2017.11.14.15.23.43
>         (version=3DTLS1_2 cipher=3DECDHE-RSA-AES128-SHA bits=3D128/128)=
;
>         Tue, 14 Nov 2017 15:23:44 -0800 (PST)
> From: Ed Swierk <eswierk@skyportsystems.com>

Here, it looks like your local system picked gmail.com as its SMTP
server, and since gmail does not have an IP address in the range that
skyportsystems.com claims under its DMARC listings, your mail is
rejected rather than flagged by recipients that honor DMARC, so mailman
munged the header to let recipients get the mail anyway.

> This one had the correct author:
>=20
> Return-Path: <eswierk@skyportsystems.com>
> Received: from eswierk-sc.localdomain
> (67-207-112-138.static.wiline.com. [67.207.112.138])
>         by smtp.gmail.com with ESMTPSA id s3sm4082810pfk.7.2017.11.16.0=
6.06.36
>         (version=3DTLS1_2 cipher=3DECDHE-RSA-AES128-SHA bits=3D128/128)=
;
>         Thu, 16 Nov 2017 06:06:37 -0800 (PST)
> From: Ed Swierk <eswierk@skyportsystems.com>

That shows the same IP address as the sending location and again shows a
path through gmail.com, so I'm not sure why it was handled differently,
unless skyportsystems.com was changing DMARC policies between the two
messages, or if you really did send the two mails through different
setups.  The most annoying thing about DMARC is that most end users do
NOT have control over their domain's choice of DMARC settings; but the
rule of thumb is "if your domain has a strict DMARC policy, then mail
sent claiming to be from that domain must go through the SMTP servers
whitelisted by that domain", coupled with mailman's policy that "if a
message was sent from a domain with a DMARC that rejects the mailing
list IP, then rewrite the header to make the mail appear to come from
the list instead".

Meanwhile, as an example, I used to be able to spoof my redhat.com email
address when sending from my home computer and connecting to my ISP as
the SMTP sender; but about a year ago, Red Hat tightened their DMARC
settings so that if I want to send a mail that purports to be from
redhat.com, I now have to send it through Red Hat's SMTP server, rather
than my personal one, or else I risk my message not reaching the end
recipient.  But Red Hat's DMARC policy merely flags rather than
rejecting spoofed emails, and because it is not marked as reject,
mailman does not munge the headers of mails I send to the list.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lDg1BzqQ9T90dKJtQxOUoWC3F2hm2aucV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpTnUsACgkQp6FrSiUn
Q2pkrgf+LU9Rl4DzL5TOglQBJXjyD3ZyuZE5GXv56Ou2g1wyfg8vgefiOZBijUZK
qUggFCG7gIf2VFipC7RNiFCYABZ0xfsWDMucullf8LjxkvLCjDs/XkJoHv0yDa0Y
dzCOhaM44vxY/B+khOx6L+PBPGiLlBgWP2KwCvBD1rxGxpzq34IGF/JZZI0fUtKK
kZfAO43TeSXBuV/IWKILSon1jWtfHIw3U6WyRtMVv1O4Rfu4U+90/xoFLvJubtwy
8fjlkXtQbfwioISJ6Jv6hzZqpANNnLI9PUWwMrspHR9T9FwEN8t1Ywde6xsaZa5N
smKOtK+UGpNcpixCF5XJ93uue3mvag==
=UN2F
-----END PGP SIGNATURE-----

--lDg1BzqQ9T90dKJtQxOUoWC3F2hm2aucV--
