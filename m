Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0656C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 08:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5881B20729
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 08:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EgRnyfcy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5881B20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36505 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVWgJ-00050y-8B
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 03:10:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iVWe7-0002mQ-El
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 03:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iVWe5-0002FN-0j
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 03:07:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52771
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iVWe4-0002D6-Kh
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 03:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573805273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rrvg7CgO7jlaQY7fHcK9rWZ8NGrl8vk+08jktZnHHYI=;
 b=EgRnyfcyhLH4v6Hqj3Q0OA7886XW4ciQzgoE4zoOwZd3jrxIR8Z5ska+QvM9vJvu0H0N0s
 IhU8xxKLRppcIh2xSkHXSJbulX6qnnD4ClgibPtEff7003NwrkqHgC42b1yOhhGeQK/Do+
 JmvCAEOKa6Ox46J0ohN/f952hjvL110=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-6LopJdKrMhqfynA3Rhlt3A-1; Fri, 15 Nov 2019 03:07:50 -0500
X-MC-Unique: 6LopJdKrMhqfynA3Rhlt3A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46E1A1005500;
 Fri, 15 Nov 2019 08:07:49 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-227.ams2.redhat.com
 [10.36.116.227])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BA3E101E3CB;
 Fri, 15 Nov 2019 08:07:47 +0000 (UTC)
Subject: Re: Convert VMDK to RAW
To: janine.schneider@fau.de
References: <009201d59b06$475883f0$d6098bd0$@fau.de>
 <97e53c9c-7d3d-75e7-8227-7a1ff186f52e@redhat.com>
 <000401d59b12$8024ce30$806e6a90$@fau.de>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <a58d3266-4e7a-f651-7dba-0381ddd35038@redhat.com>
Date: Fri, 15 Nov 2019 09:07:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <000401d59b12$8024ce30$806e6a90$@fau.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hhXRofxlm1xBcIPaanr95f2TjqFmOfONQ"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hhXRofxlm1xBcIPaanr95f2TjqFmOfONQ
Content-Type: multipart/mixed; boundary="JysJtWR3vTNzwshA5XwuXQKSDBtzeU38Q"

--JysJtWR3vTNzwshA5XwuXQKSDBtzeU38Q
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.11.19 18:39, janine.schneider@fau.de wrote:
> Hello,
>=20
> thank you for the quick feedback. I am sorry that I expressed myself so
> unclearly. I don't want to use qemu but want to know how qemu converts vm=
dk
> to raw. So how exactly is the conversion programmed? How are the sparse
> grains put together to get an uncompressed virtual disk? I am a programme=
r
> and would like to reimplement this function. I already looked at the qemu
> code, but couldn't figure out how the conversion works.

Oh, OK.  Well, even (or maybe especially) programmers sometimes want to
reuse existing functionality, so I assumed it would be sufficient for
you to just use qemu tools. ;-)  (For example, qemu-nbd allows
presenting a VMDK image as a local block device that you can randomly
access.)

The code to interpret the VMDK format is in block/vmdk.c.  The function
to read an arbitrary guest offset of the disk image is vmdk_co_preadv().
 The conversion just iterates over the whole image and copies everything
read with that function to the output image, so I don=92t think you need
to look at anything but block/vmdk.c.

vmdk_open() opens the image and thus parses the description file.  I
suppose (I=92m no expert in the VMDK code) of particular interest are
vmdk_parse_extents() and anything that calls vmdk_add_extent().  These
code paths create a list of all extent files.

From a quick look at vmdk_co_preadv(), find_extent() then looks up the
corresponding extent file based on the guest offset;
get_cluster_offset() looks up the file offset in that extent file for
the respective guest offset; and vmdk_read_extent() then reads from the
file at that offset, decompressing the data if necessary.

(Note that
https://www.vmware.com/support/developer/vddk/vmdk_50_technote.pdf
probably understands the concepts of VMDK much better than I do *cough*)

Max


--JysJtWR3vTNzwshA5XwuXQKSDBtzeU38Q--

--hhXRofxlm1xBcIPaanr95f2TjqFmOfONQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3OXNEACgkQ9AfbAGHV
z0CxOwf6A9Q0QrNbk/8+2AdXUUnx/u77RDeoMWe5D/AJ5EwLYm+CH/cRp9wnnag3
6zEALDmeMzRXkSqI7BjDeiw31DwkAQfsh76rYkL1kikTMdud5l5qsqV1fLY7Fd++
IrvFg73R8O6E+Wdrwh09RqBXVoO9b3nwqlX8ut0BVnlpHTE30ctIdfkA3HT064y1
UFAz9coIEbhkYQxLh4VpqXx/W2ze992VYVnvOUhR3GppbvbVbK7ZeHh9T8PSUZ0P
3jOqbAy7c3TaViGkyogrPw1ms040iXs2sdiO+tf4MYc2u0mUVgXmfwTlg6YFayzv
WrTfToxCXk17VidKVs9vzOASCFYweQ==
=KOZT
-----END PGP SIGNATURE-----

--hhXRofxlm1xBcIPaanr95f2TjqFmOfONQ--


