Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ED3C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D37862137B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0egPq9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37862137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5Qh-0003nR-2n
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jU5Pf-0002mi-Ua
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jU5OO-0000Te-AW
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:23:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57528
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jU5ON-0000TW-Mz
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588238521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XkUoXClEVl58JBgSQKNej7Q6g0mP78x1gSAc0Brlc5g=;
 b=V0egPq9dJ07tjTSCAkBgH20yNjmGN+CLdgEagyNxwOtE/9eWnxEQLADaZmhU0GU49TthsC
 DM6NZC35gfxx7vnoAZ4w1wTAbAlL8oAQ6ErADA31uWg36abxKCINSvA8KfUO3s6B9vzIIf
 HyZhE9yRdT2ZpSvbPL7VEVxQqob5xxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-6ehl63agPaWBgyHqZX35cA-1; Thu, 30 Apr 2020 05:21:58 -0400
X-MC-Unique: 6ehl63agPaWBgyHqZX35cA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E25688005B7
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 09:21:57 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-177.ams2.redhat.com
 [10.36.112.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E383605DD;
 Thu, 30 Apr 2020 09:21:49 +0000 (UTC)
Subject: Re: [PATCH] virtiofsd: Show submounts
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm> <20200429145720.GA2835@work-vm>
 <8c73f374-fcc8-1684-b581-84a9ab501aa9@redhat.com>
 <20200430085812.GC2874@work-vm>
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
Message-ID: <94924861-d934-0151-aca5-19ea9eb211e1@redhat.com>
Date: Thu, 30 Apr 2020 11:21:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430085812.GC2874@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QfIUrViZs5Euqaf87kfYpcqVjvFsO1FSh"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QfIUrViZs5Euqaf87kfYpcqVjvFsO1FSh
Content-Type: multipart/mixed; boundary="54ZYs4vew8w0glUUsJpzbmIWuUUfoegiz"

--54ZYs4vew8w0glUUsJpzbmIWuUUfoegiz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.04.20 10:58, Dr. David Alan Gilbert wrote:
> * Max Reitz (mreitz@redhat.com) wrote:
>> On 29.04.20 16:57, Dr. David Alan Gilbert wrote:
>>> * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
>>>> * Max Reitz (mreitz@redhat.com) wrote:
>>>>> Currently, setup_mounts() bind-mounts the shared directory without
>>>>> MS_REC.  This makes all submounts disappear.
>>>>>
>>>>> Pass MS_REC so that the guest can see submounts again.
>>>>
>>>> Thanks!
>>>>
>>>>> Fixes: 3ca8a2b1c83eb185c232a4e87abbb65495263756
>>>>
>>>> Should this actually be 5baa3b8e95064c2434bd9e2f312edd5e9ae275dc ?
>>>>
>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>> ---
>>>>>  tools/virtiofsd/passthrough_ll.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passt=
hrough_ll.c
>>>>> index 4c35c95b25..9d7f863e66 100644
>>>>> --- a/tools/virtiofsd/passthrough_ll.c
>>>>> +++ b/tools/virtiofsd/passthrough_ll.c
>>>>> @@ -2643,7 +2643,7 @@ static void setup_mounts(const char *source)
>>>>>      int oldroot;
>>>>>      int newroot;
>>>>> =20
>>>>> -    if (mount(source, source, NULL, MS_BIND, NULL) < 0) {
>>>>> +    if (mount(source, source, NULL, MS_BIND | MS_REC, NULL) < 0) {
>>>>>          fuse_log(FUSE_LOG_ERR, "mount(%s, %s, MS_BIND): %m\n", sourc=
e, source);
>>>>>          exit(1);
>>>>>      }
>>>>
>>>> Do we want MS_SLAVE to pick up future mounts that might happenf rom th=
e
>>>> host?
>>>> What's the interaction between this and the MS_REC|MS_SLAVE that we ha=
ve
>>>> a few lines above for / ?
>>>
>>> Just to confirm something from vgoyal, and what had confused me about
>>> why we hadn't spotted this earlier.
>>>
>>> Even without this patch, the SLAVE stuff worked so if you start the
>>> daemon and *then* mount under the shared directory, the guest sees it
>>> with or without this patch.
>>
>> Hm, I don=E2=80=99t.  Do you really?
>=20
> Yes! With your patch reverted:
>=20
> Start virtiofsd, mount in the guest:
>=20
> host:
> # ./virtiofsd --socket-path=3D/tmp/vhostqemu -o source=3D/home/dgilbert/v=
irtio-fs/fs  -o log_level=3Dwarn -o no_writeback
>=20
> guest:
> # mount -t virtiofs myfs /sysroot

OK, for some reason I didn=E2=80=99t try to mount in the guest first, but d=
id
the host mount after starting virtiofsd.

My mount test uses multiple mounts, and two of them I see mounted, but
three I still don=E2=80=99t see mounted.

Let me see whether I can come up with something reproducible that isn=E2=80=
=99t
a script.

[...]

> Maybe this is related to what Vivek said about default behaviours on
> systemd's, what does:
>=20
> # findmnt -o +PROPAGATION
> TARGET    SOURCE         FSTYPE     OPTIONS                              =
                                                    PROPAGATION
> /         /dev/mapper/fedora_dgilbert--t580-root
> =E2=94=82                        xfs        rw,relatime,seclabel,attr2,in=
ode64,logbufs=3D8,logbsize=3D32k,noquota                        shared
>=20
> say for your source=3D directory?

I have Fedora, too, so pretty much the same.

Max


--54ZYs4vew8w0glUUsJpzbmIWuUUfoegiz--

--QfIUrViZs5Euqaf87kfYpcqVjvFsO1FSh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6qmKsACgkQ9AfbAGHV
z0Db1wf/aIFXWLNFxAHC+g0QoZDUd6nlDlqu3qi7Sf1sJNv0r8mlCEXWMcPn1IN8
jl/vrGskXH6tEM0KuzpQI/H9NEwIQ/nLfnJvNR/taEfFCAx+/PH+QTxh6GA25Xzy
YzUEbeO6+P9wrO/YSeaT/CGVn88U20gA4e/Gyjq7YBxACq/bF7uGvwmCyPoDOqm0
1A9TZkyy54WGSqyzbPrxBtUa2ULMiEwwvjVnTXamOvikVL+oCiopxi/30i1/aRsP
bUNZuJP/1tGFIMazN5R0YnXbTFuvUISe+bFKhkXR7OUEvsJON+lHejJVL1XfZg3Z
AB7ZVxdNAGQKhFhs2vUAvHj0JFS/cg==
=UzY4
-----END PGP SIGNATURE-----

--QfIUrViZs5Euqaf87kfYpcqVjvFsO1FSh--


