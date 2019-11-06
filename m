Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60C2C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A966D2166E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icH0Hc//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A966D2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSLXx-0000gp-V5
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSLXC-00007l-1l
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:39:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSLXA-0003Wn-Lm
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:39:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35244
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSLXA-0003VN-Hf
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573047580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=prcyAE/kfFDPqS+uk36mLSo92kODL6s5DuoJArbOEZk=;
 b=icH0Hc//yUHEtCATYK5DKdrxrn2gSCg81PJUMwtbPqONbPd/Zj1eL0yrkhvrS7M9mlgf5+
 ymGvHjCf3iJlROOqL2OYYRGfdXgCMFoL9+BPOxTPLd8KGgKgOxKne41fDNes3+DJSt97e1
 X24BA336zAXmEc8kYWRLBHd5KfgchS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-thrBCqWOOkmqas9InEDXbQ-1; Wed, 06 Nov 2019 08:39:36 -0500
X-MC-Unique: thrBCqWOOkmqas9InEDXbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04A0E1800D6B;
 Wed,  6 Nov 2019 13:39:36 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-212.ams2.redhat.com
 [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1396E600C4;
 Wed,  6 Nov 2019 13:39:33 +0000 (UTC)
Subject: Re: [RFC PATCH 08/18] qemu-storage-daemon: Add --export option
To: Kevin Wolf <kwolf@redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-9-kwolf@redhat.com>
 <5d920618-219a-6dd2-5823-3fc3f09e6a61@redhat.com>
 <20191106133458.GB7548@dhcp-200-226.str.redhat.com>
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
Message-ID: <2deaa15f-9509-099a-e570-4b8c2d7681a4@redhat.com>
Date: Wed, 6 Nov 2019 14:39:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106133458.GB7548@dhcp-200-226.str.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QxRXkBPtJNiqEym2E3q3ekYaWef7Jy9lW"
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
Cc: pkrempa@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QxRXkBPtJNiqEym2E3q3ekYaWef7Jy9lW
Content-Type: multipart/mixed; boundary="Jr4sA97Bw7aokSxDUEFKEXxeJzjkC5iUn"

--Jr4sA97Bw7aokSxDUEFKEXxeJzjkC5iUn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.11.19 14:34, Kevin Wolf wrote:
> Am 06.11.2019 um 14:11 hat Max Reitz geschrieben:
>> On 17.10.19 15:01, Kevin Wolf wrote:
>>> Add a --export option to qemu-storage-daemon to export a block node. Fo=
r
>>> now, only NBD exports are implemented. Apart from the 'type' option
>>> (which is the implied key), it maps the arguments for nbd-server-add to
>>> the command line. Example:
>>>
>>>     --export nbd,device=3Ddisk,name=3Dtest-export,writable=3Don
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  qapi/block.json       | 27 +++++++++++++++++++++++++++
>>>  qemu-storage-daemon.c | 31 +++++++++++++++++++++++++++++++
>>>  2 files changed, 58 insertions(+)
>>
>> Would it be better to collect the BlockExports in a list and work on it
>> after all arguments have been parsed?  As it is, it=E2=80=99s important =
that
>> users define block devices and things like NBD servers before --export.
>>  Yes, I know, that=E2=80=99s exactly how it works with qemu, but is that=
 really
>> the best way?
>=20
> It's actually not how QEMU works generally. QEMU collects things in
> QemuOptsLists and then tries to interpret them in the right order. Of
> course, we never get the order actually right, which results in constant
> reshuffling of the order of initialisations in vl.c.
>=20
> It also means that vl.c (!) has a list of -object types that need to be
> created early so that other backends can make use of them, and of those
> types that actually depend on a backend already being present (see
> object_create_initial() for details).
>=20
> I think it's much cleaner to simply use the order in the command line
> instead of adding magic that tries to resolve (and fails at actually
> resolving) all the dependencies. I seem to remember that this was in
> fact one of the things Markus keeps mentioning he would change if he
> were to rewrite the QEMU command line parser from scratch without
> compatibility requirements.

OK.

Max


--Jr4sA97Bw7aokSxDUEFKEXxeJzjkC5iUn--

--QxRXkBPtJNiqEym2E3q3ekYaWef7Jy9lW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3CzRQACgkQ9AfbAGHV
z0A6CAf/QNyhqDZ/9fL9kVosnkjmxOMiC3z3ZaSF3WxmaR4YF+MtYFX2PlQNH47q
DEP8VrRKyFqYfntGCnKz0SkwhHG8nJuKc8QqfuKDaMYVg/tH/hHfhll7UGcgACjD
fU8E1ndSBkp0O+sp/uxDFV/B5mOEhK0R703HDFQpgtWEA5zDD+ff7cYOijYzAQy+
pTWmNwqE7/ywP/WTLbs4B1IytlCYDKcjWL9/sxQYCpAf7fn2g10mBdT5881fEe8e
JLEWDB+d1Xc+kMp6H5mzVMosVoae+JVsv2UIc/sQMsWsQqopvrZW5zDliRXcYoak
uEoTlmpwGFtcLOjNOgb8sJfrAkGASw==
=GRE/
-----END PGP SIGNATURE-----

--QxRXkBPtJNiqEym2E3q3ekYaWef7Jy9lW--


