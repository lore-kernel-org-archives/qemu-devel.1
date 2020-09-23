Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ED8C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 07:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C36B42220D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 07:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBfpKMD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36B42220D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKz7g-0006v2-OB
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 03:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKz6N-00061F-AE
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 03:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKz6J-00051U-2U
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 03:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600845721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oIuaNhpx9z3xLeJZX7X1LmHzlL+4f5T7B4NniLfWUew=;
 b=ZBfpKMD8bAPdPneFeNg+lerNVmeB3gGGPsqWbsNhTVHMtzNwLg3DyNOQwrgR+h+7K4GGqP
 9Lyu+WqGlS7haRJHIX6LyIAnW1vqz6PiCR1QrniiT1BhxRjNT16LAI8BjdRwuCtB1y5MS2
 ByFVxxQvfhOoW08gLVUv0TkrGlPIaR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-gbzUA3gQO_CekgJ440PnsA-1; Wed, 23 Sep 2020 03:21:34 -0400
X-MC-Unique: gbzUA3gQO_CekgJ440PnsA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B4A21007485;
 Wed, 23 Sep 2020 07:21:33 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-169.ams2.redhat.com
 [10.36.113.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47D1E619B5;
 Wed, 23 Sep 2020 07:21:28 +0000 (UTC)
Subject: Re: [PATCH v2 00/20] block/export: Allow exporting BDSs via FUSE
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200922104932.46384-1-mreitz@redhat.com>
 <20200922155838.GR1989025@redhat.com>
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
Message-ID: <563c7810-91ab-f7d9-ff16-b12a7c4efdbd@redhat.com>
Date: Wed, 23 Sep 2020 09:21:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922155838.GR1989025@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sY20p9uS3vV98lf7Su0BtRC4A1jwix5HY"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sY20p9uS3vV98lf7Su0BtRC4A1jwix5HY
Content-Type: multipart/mixed; boundary="6BXTEyzenMRcaypXwAHkOWAl5hBq3n3lr"

--6BXTEyzenMRcaypXwAHkOWAl5hBq3n3lr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.09.20 17:58, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Sep 22, 2020 at 12:49:12PM +0200, Max Reitz wrote:
>> Based-on: <20200907182011.521007-1-kwolf@redhat.com>
>>           (=E2=80=9Cblock/export: Add infrastructure and QAPI for block =
exports=E2=80=9D)
>>
>> (Though its patch 16 needs a s/=3D \&blk_exp_nbd/=3D drv/ on top.)
>>
>> v1: https://lists.nongnu.org/archive/html/qemu-block/2019-12/msg00451.ht=
ml
>>
>> Branch: https://github.com/XanClic/qemu.git fuse-exports-v2
>> Branch: https://git.xanclic.moe/XanClic/qemu.git fuse-exports-v2
>>
>>
>> Hi,
>>
>> Ever since I found out that you can mount FUSE filesystems on regular
>> files (not just directories), I had the idea of adding FUSE block
>> exports to qemu where you can export block nodes as raw images.  The
>> best thing is that you=E2=80=99d be able to mount an image on itself, so
>> whatever format it may be in, qemu lets it appear as a raw image (and
>> you can then use regular tools like dd on it).
>>
>> The performance is quite bad so far, but we can always try to improve it
>> if the need arises.  For now I consider it mostly a cute feature to get
>> easy access to the raw contents of image files in any format (without
>> requiring root rights).
>=20
> Aside from the iotests, so you forsee any particular use cases
> where this feature is desirable / important ?

No.

I implemented this feature for fun last year (when I realized that FUSE
allows regular files to be mount points), and I got positive reactions.
 I assumed others would find it as nice as me to be able to quickly
access an image file without requiring root rights (and then device file
accesses), or setting up an NBD chain.

(Though it should be noted that when I first came up with the feature,
nbdfuse did not exist yet.)

(It should also be noted that my original idea was to have a new
executable qemu-blkfuse that would basically allow you to invoke
=E2=80=9Cqemu-blkfuse $img=E2=80=9D, and then $img would appear as a raw im=
age.  To me,
that appeared very useful because it was so simple.  I admit that the
current proposal, which relies on the storage-daemon, has none of that
simplicity.  But if that=E2=80=99s the problem that prevents this from bein=
g
considered useful, I=E2=80=99m sure we (I) can figure something out.  Perha=
ps a
simple script, bundled with qemu, that can generate -blockdev
invocations based on the result of file(1).)

> Looking at it from a security POV, I'm not thrilled about the
> idea of granting QEMU permission to use the mount syscall for
> seccomp or SELinux. IOW, I expect this feature won't be something
> we want to expose in QEMU guests managed by libvirt, which would
> limit how widely it can be used.

I don=E2=80=99t expect this to be used through QEMU very much, but through =
the
storage daemon.  I assume that for the storage daemon, the permissions
can effectively be fine-tuned for each export, because you can =E2=80=9Cjus=
t=E2=80=9D
launch another instance.

> QEMU can export NBD. Would it make sense to do this as an NBD
> client ? There's already https://libguestfs.org/nbdfuse.1.html
> but IIUC that exposes it as a file within a dir. Presumably
> it is not too hard to make it support exposing it directly as
> a file too.

I don=E2=80=99t like that idea very much, because my main gripe with the cu=
rrent
state of my proposal is that it=E2=80=99s more cumbersome than
=E2=80=9Cqemu-blkfuse $img=E2=80=9D.  Adding more indirections won=E2=80=99=
t make it simpler.

> I wonder how performance compares between your native FUSE
> impl in QEMU vs NBD FUSE ?

Last year, I tried various ways of improving performance and nothing
really amounted to much.  So in the end I settled for a simple and naive
implementation, for it to be improved in case anyone cares for it.

Max


--6BXTEyzenMRcaypXwAHkOWAl5hBq3n3lr--

--sY20p9uS3vV98lf7Su0BtRC4A1jwix5HY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9q93YACgkQ9AfbAGHV
z0CUIQf/UOXwOlDUkJArOiE55H6c7fSUaI4YiZ3tmjhTFJ+ZL+F7l29hEhzB2l8q
LfVQ2rld2DgeOi7vvqOZWTHoiyeT0F5nWQg+0oBSHL5Ub310x2KYRiRCUAs3u+R9
IJ2/QSWuh74VImnrJtN6RwS8tUq9mKMLTToiqj4OTjX8chfs+ZRwb6dTeRszvcE7
WxBQfEB5vd/yfh4z0ZmDuucOFR60cXrEnmSj8ITqc3VLSBgA8aCcHrom6e7yKBu9
W3K0OervrKaqQxocH4WZSElMGql9RGNS4ch6IBjhnq4Q4QlI1nEu4j4QwhWe4X8J
L9exkGi0Xiy0/ZB2+axw16vRvLMuMw==
=JNAp
-----END PGP SIGNATURE-----

--sY20p9uS3vV98lf7Su0BtRC4A1jwix5HY--


