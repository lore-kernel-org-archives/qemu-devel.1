Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5EFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1978C22248
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F85Sz0La"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1978C22248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT5Id-0005Nf-Om
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 11:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kT55x-0000bx-2z
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kT55v-00067u-G7
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602775386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=i7Afng0mD3++Ez5X6lKP7UOBYKXt9907Pu/4PooO9EE=;
 b=F85Sz0LaoS7equkqNgWI8jSH8Q8S2xPmLUv/sgKNBc46Me3ZSGVXlUHWHvLTYYtVY0qjF9
 BRiJxsw5GlKsBQrhoZFCKJVoywv+h0MOkr7ksZjw7CLja36jY6j6NCK8e7PitaWMlX/9Ux
 sSFx6kgT6zF7pne+t9/W4C1tFDhLMLs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-odapbwAWPsGY_f831vWuEQ-1; Thu, 15 Oct 2020 11:23:03 -0400
X-MC-Unique: odapbwAWPsGY_f831vWuEQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2C7E18C5200;
 Thu, 15 Oct 2020 15:23:02 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D5C6619C66;
 Thu, 15 Oct 2020 15:22:58 +0000 (UTC)
Subject: Re: [PATCH v2 17/20] iotests: Give access to the qemu-storage-daemon
To: Kevin Wolf <kwolf@redhat.com>
References: <20200922104932.46384-1-mreitz@redhat.com>
 <20200922104932.46384-18-mreitz@redhat.com>
 <20201015112712.GE4610@merkur.fritz.box>
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
Message-ID: <8ee707ba-026f-c2ef-0cac-a8a9422f973b@redhat.com>
Date: Thu, 15 Oct 2020 17:22:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201015112712.GE4610@merkur.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rW3eMLFwnqJTrR3TG4RXlGcTkmPFCU64P"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rW3eMLFwnqJTrR3TG4RXlGcTkmPFCU64P
Content-Type: multipart/mixed; boundary="ijuiWoiXgmBKOpwVf6T9KLrYOnGAxPwI2"

--ijuiWoiXgmBKOpwVf6T9KLrYOnGAxPwI2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.10.20 13:27, Kevin Wolf wrote:
> Am 22.09.2020 um 12:49 hat Max Reitz geschrieben:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/check     | 11 +++++++++++
>>  tests/qemu-iotests/common.rc | 17 +++++++++++++++++
>>  2 files changed, 28 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
>> index e14a1f354d..467a7cf1b7 100755
>> --- a/tests/qemu-iotests/check
>> +++ b/tests/qemu-iotests/check
>> @@ -644,6 +644,17 @@ if [ -z $QEMU_NBD_PROG ]; then
>>  fi
>>  export QEMU_NBD_PROG=3D"$(type -p "$QEMU_NBD_PROG")"
>> =20
>> +if [ -z "$QEMU_STGD_PROG" ]; then
>=20
> No series without some bikeshedding:
>=20
> This is the first time I see "QEMU_STGD" as a short form. Without the
> subject line of the patch, I wouldn't be able to guess what it is.
>=20
> If the full name ($QEMU_STORAGE_DAEMON_PROG) is too long, I think simply
> $QSD_PROG would be an alternative, because "qsd" is what people already
> use an as abbreviation.

I asked myself for a second what this QEMU Street Day you=E2=80=99re referr=
ing
to is (I blame the [k] at the beginning of both ?SDs), but sure, why not.

Max


--ijuiWoiXgmBKOpwVf6T9KLrYOnGAxPwI2--

--rW3eMLFwnqJTrR3TG4RXlGcTkmPFCU64P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+IaVEACgkQ9AfbAGHV
z0ByjQf9FKhwFgxjXo5jC00k8BK66aodd/TI914BH7vsZPSbGrjyjbU6zN5qN8xC
TByQBeSdiUMos+kimXeYita+1NUMIoOcntq/VFHQRMjRmuPTTZ+HAGM3LCobm7c9
aafAXIBiSo0YwqQTJ/HFWLm81EKZJPEooqW0jrJOAON1V4+68vaF1MCpguVqrBR7
XBHpKrPXA/k3qQ7WcgZMyZ2/gW9RkLYgO98Youmsgbf3wCCNwuSrFCjCRg0PgDzw
kKPG7e9uJE32TqCHi+f3IfK6Vi6H3SBxliYU5KQHpnV89uCUS1VXCTAxcmozkTU+
OH2LPq5F4SfyrxYbxLR5xnoe1B3IZw==
=xL8R
-----END PGP SIGNATURE-----

--rW3eMLFwnqJTrR3TG4RXlGcTkmPFCU64P--


