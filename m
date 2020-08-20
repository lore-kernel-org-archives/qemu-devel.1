Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988A5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B1120658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZmhPUhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B1120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8kSG-0001eS-Fe
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 09:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8kRZ-00018v-Vg
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 09:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54034)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8kRY-0008Vl-1n
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 09:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597929443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZriRS5Leub4nLazWY2+HJbiFTDyaZsmX5OyW5cAatsY=;
 b=IZmhPUhxUSagUrh45qlJyIZlht11JM3pbMMsABYmCFv/Jnv0fiK/tLab2eYcvd9vJE4TLe
 Br3/gfECbKN82/pp99Lp6Y89SzesDh3/FoXy3E7VTXM+8JLSZyseiJ/sgTSLynROVhw3IX
 8PNcEwm0QhfRe7ZmCFL+YxJdBhMSEhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-s4Q2vJSgMT6vcbEy_3-lbA-1; Thu, 20 Aug 2020 09:17:18 -0400
X-MC-Unique: s4Q2vJSgMT6vcbEy_3-lbA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A90DF81F038;
 Thu, 20 Aug 2020 13:17:17 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-133.ams2.redhat.com
 [10.36.113.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE9325DA81;
 Thu, 20 Aug 2020 13:17:15 +0000 (UTC)
Subject: Re: [PATCH v4 4/4] iotests: Test node/bitmap aliases during migration
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200818133240.195840-1-mreitz@redhat.com>
 <20200818133240.195840-5-mreitz@redhat.com>
 <fe00acc5-a06f-5e65-63f6-5f0ed7ec3019@redhat.com>
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
Message-ID: <28314d9e-714a-2acd-5bd0-cf61f9ca41b2@redhat.com>
Date: Thu, 20 Aug 2020 15:17:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fe00acc5-a06f-5e65-63f6-5f0ed7ec3019@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="m3meJuln79jG7dxFdyFZhSuixq0QHdPXf"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 09:00:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m3meJuln79jG7dxFdyFZhSuixq0QHdPXf
Content-Type: multipart/mixed; boundary="hkadBKqvfLpGyVolHA64GnuZHZ9NqgfcS"

--hkadBKqvfLpGyVolHA64GnuZHZ9NqgfcS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.08.20 03:58, Eric Blake wrote:
> On 8/18/20 8:32 AM, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/300=C2=A0=C2=A0=C2=A0=C2=A0 | 595 ++++++++++++=
+++++++++++++++++++++++++
>> =C2=A0 tests/qemu-iotests/300.out |=C2=A0=C2=A0 5 +
>=20
> Rather sparse output (I hate debugging those sorts of outputs when the
> test is failing).

Hm.  I don=E2=80=99t know, the stack trace usually gives a good idea and
./check -d gives QMP context.

The advantage of a sparse output is that we don=E2=80=99t need to adjust th=
e
reference output every time some optional field is added somewhere.

>> =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 3 files changed, 601 insertions(+)
>> =C2=A0 create mode 100755 tests/qemu-iotests/300
>> =C2=A0 create mode 100644 tests/qemu-iotests/300.out
>>
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Dirty some random megabyte=
s
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for _ in range(9):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mb_o=
fs =3D random.randrange(1024)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.vm_a.hmp_qemu_io(self.src_node_name, f'write
>> {mb_ofs}M 1M')
>=20
> It turns out that the discard operation likewise dirties the bitmap, but
> slightly faster (see edb90bbd).=C2=A0 We could optimize it on top, but I'=
m
> not going to require a micro-optimizing to get it in.=C2=A0 The test take=
s
> about 12 seconds to run for me, but you didn't mark it as such in
> 'group', so that's good; but it turns up a problem:
>=20
> 300=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fail=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 [20:55:54] [20:56:06]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 output
> mismatch (see 300.out.bad)
> --- /home/eblake/qemu-tmp2/tests/qemu-iotests/300.out=C2=A0=C2=A0=C2=A0 2=
020-08-19
> 20:53:11.087791988 -0500
> +++ /home/eblake/qemu-tmp2/tests/qemu-iotests/300.out.bad=C2=A0=C2=A0=C2=
=A0 2020-08-19
> 20:56:06.092428756 -0500
> @@ -1,5 +1,41 @@
> -.....................................
> +WARNING:qemu.machine:qemu received signal 11; command:
> "/home/eblake/qemu-tmp2/tests/qemu-iotests/../../x86_64-softmmu/qemu-syst=
em-x86_64
> -display none -vga none -chardev
> socket,id=3Dmon,path=3D/tmp/tmp.qT831UThme/qemu-b-798452-monitor.sock -mo=
n
> chardev=3Dmon,mode=3Dcontrol -qtest
> unix:path=3D/tmp/tmp.qT831UThme/qemu-b-798452-qtest.sock -accel qtest
> -nodefaults -display none -accel qtest -blockdev
> node-name=3Dnode0,driver=3Dnull-co -incoming unix:/tmp/tmp.qT831UThme/mig=
_sock"
> +.............FE.......................
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ERROR: test_migratee_bitmap_is_not_mapped_on_dst
> (__main__.TestBlockBitmapMappingErrors)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +=C2=A0 File
> "/home/eblake/qemu-tmp2/tests/qemu-iotests/../../python/qemu/machine.py",=
 line
> 435, in _do_shutdown
> +=C2=A0=C2=A0=C2=A0 self._soft_shutdown(timeout, has_quit)
> +=C2=A0 File
> "/home/eblake/qemu-tmp2/tests/qemu-iotests/../../python/qemu/machine.py",=
 line
> 415, in _soft_shutdown
> +=C2=A0=C2=A0=C2=A0 self._qmp.cmd('quit')
> +=C2=A0 File
> "/home/eblake/qemu-tmp2/tests/qemu-iotests/../../python/qemu/qmp.py",
> line 266, in cmd
> +=C2=A0=C2=A0=C2=A0 return self.cmd_obj(qmp_cmd)
> +=C2=A0 File
> "/home/eblake/qemu-tmp2/tests/qemu-iotests/../../python/qemu/qmp.py",
> line 246, in cmd_obj
> +=C2=A0=C2=A0=C2=A0 self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8=
'))
> +BrokenPipeError: [Errno 32] Broken pipe
> +
> +The above exception was the direct cause of the following exception:
> +
> +Traceback (most recent call last):
> +=C2=A0 File "300", line 76, in tearDown
> +=C2=A0=C2=A0=C2=A0 self.vm_b.shutdown()
> +=C2=A0 File
> "/home/eblake/qemu-tmp2/tests/qemu-iotests/../../python/qemu/machine.py",=
 line
> 465, in shutdown
> +=C2=A0=C2=A0=C2=A0 self._do_shutdown(timeout, has_quit)
> +=C2=A0 File
> "/home/eblake/qemu-tmp2/tests/qemu-iotests/../../python/qemu/machine.py",=
 line
> 438, in _do_shutdown
> +=C2=A0=C2=A0=C2=A0 raise AbnormalShutdown("Could not perform graceful sh=
utdown") \
> +qemu.machine.AbnormalShutdown: Could not perform graceful shutdown
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +FAIL: test_migratee_bitmap_is_not_mapped_on_dst
> (__main__.TestBlockBitmapMappingErrors)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +=C2=A0 File "300", line 384, in test_migratee_bitmap_is_not_mapped_on_ds=
t
> +=C2=A0=C2=A0=C2=A0 self.migrate(False)
> +=C2=A0 File "300", line 99, in migrate
> +=C2=A0=C2=A0=C2=A0 self.assertEqual(self.vm_a.wait_migration('postmigrat=
e'),
> +AssertionError: False !=3D True
> +
> =C2=A0-------------------------------------------------------------------=
---
> =C2=A0Ran 37 tests
>=20
> -OK
> +FAILED (failures=3D1, errors=3D1)
>=20
> I'm not sure why I'm seeing that, but it looks like you've got a bad
> deref somewhere in the alias code.

Ah, crap.

This should fix it:

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.=
c
index 89cb16b12c..d407dfefea 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -1091,7 +1091,9 @@ static int dirty_bitmap_load_header(QEMUFile *f,
DBMLoadState *s,
             } else {
                 bitmap_name =3D s->bitmap_alias;
             }
+        }

+        if (!s->cancelled) {
             g_strlcpy(s->bitmap_name, bitmap_name, sizeof(s->bitmap_name))=
;
             s->bitmap =3D bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);


I had this originally, and then I decided to drop that hunk just before
sending v4 because I couldn=E2=80=99t see the point.  But we need it, becau=
se if
the bitmap alias is unknown, the migration is cancelled, so we need to
re-check s->cancalled after the alias lookup block.

Would you be OK with squashing that into patch 1?

Max


--hkadBKqvfLpGyVolHA64GnuZHZ9NqgfcS--

--m3meJuln79jG7dxFdyFZhSuixq0QHdPXf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8+d9oACgkQ9AfbAGHV
z0AKjggAqksgaxKrcRmQwOK/FH+U3HKicNfBrouSykz4mdrn+7HxH+7TO1+z8IdY
P+XtCp8F4Dw+J+3eTG6k0/SXNEmFiQDz3DzAC8CezIkZUEneEJNqS/42z0uTIc+u
VcMC8mXDXiC43BYv+FQI9xLDyjAn8YKjQk75gI1avvJvOAB2xI3utBFetvEbhFYZ
BWfgKsF5GaVe5NUdMvFNCBo5CIp9iaeKTw0Qq/9wIKDb/xQRcCC7INtikXostC4O
Vy47aKflA5BlCH+iZz8/Znq5R3X79iKPVPNvfc5s8DlTR/RLVBrpckkoTpQFIrKi
SQQQySD3XoqaIHMRJLffnGdn8w+X5g==
=XiEQ
-----END PGP SIGNATURE-----

--m3meJuln79jG7dxFdyFZhSuixq0QHdPXf--


