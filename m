Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CAAC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569E121D6C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fk5r1E++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569E121D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGPC7-00074r-Tw
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 12:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGPB9-0006BE-Me
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:12:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGPB6-0006UE-JC
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599754322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zMaH4A2YrrOvluYEXVJt3K+oocxD/kMYHYAmfG4l6PM=;
 b=fk5r1E++Yt+RzHAe3m+Nsu1jUL/W4wO6wLPeeXEs2/fSSMQ793GE2P3UxfkULxSup6IQw7
 +69ili0s4ICyqtfUzOEAu8+7IkcBF1WzRttMFEbiwdy+vJF9gFJSBcit2l8Vc3KdTRaTtB
 cRlJ43N8Nm/ZlvNKL59k2jtkXNJzQho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-OMg3yulbNumeopFi8oYzhg-1; Thu, 10 Sep 2020 12:11:59 -0400
X-MC-Unique: OMg3yulbNumeopFi8oYzhg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3160D801AAF;
 Thu, 10 Sep 2020 16:11:58 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-197.ams2.redhat.com
 [10.36.112.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7CD281C40;
 Thu, 10 Sep 2020 16:11:56 +0000 (UTC)
Subject: Re: [PATCH 29/29] iotests: Test block-export-* QMP interface
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200907182011.521007-1-kwolf@redhat.com>
 <20200907182011.521007-30-kwolf@redhat.com>
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
Message-ID: <a73ae3dc-a2e6-6035-c27e-42045cee77d6@redhat.com>
Date: Thu, 10 Sep 2020 18:11:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907182011.521007-30-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3KMoXkeAhiHrQ41zjJyWvryhQakfYI6tF"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3KMoXkeAhiHrQ41zjJyWvryhQakfYI6tF
Content-Type: multipart/mixed; boundary="HbmhqlPk9l9W6mYXN8U5rlCnGGxh08Sao"

--HbmhqlPk9l9W6mYXN8U5rlCnGGxh08Sao
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.09.20 20:20, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py |  11 +++-
>  tests/qemu-iotests/307        | 117 ++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/307.out    | 111 ++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/group      |   1 +
>  4 files changed, 239 insertions(+), 1 deletion(-)
>  create mode 100755 tests/qemu-iotests/307
>  create mode 100644 tests/qemu-iotests/307.out
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index 6fed77487e..a842a9f92d 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -67,7 +67,8 @@ if os.environ.get('QEMU_IO_OPTIONS_NO_FMT'):
>      qemu_io_args_no_fmt +=3D \
>          os.environ['QEMU_IO_OPTIONS_NO_FMT'].strip().split(' ')
> =20
> -qemu_nbd_args =3D [os.environ.get('QEMU_NBD_PROG', 'qemu-nbd')]
> +qemu_nbd_prog =3D [os.environ.get('QEMU_NBD_PROG', 'qemu-nbd')]

It seems counterintuitive to me that something called =E2=80=9C*_prog=E2=80=
=9D would be
a list.

> +qemu_nbd_args =3D qemu_nbd_prog
>  if os.environ.get('QEMU_NBD_OPTIONS'):
>      qemu_nbd_args +=3D os.environ['QEMU_NBD_OPTIONS'].strip().split(' ')
> =20
> @@ -283,6 +284,14 @@ def qemu_nbd_early_pipe(*args: str) -> Tuple[int, st=
r]:
>                                                     *full_args)
>      return returncode, output if returncode else ''
> =20
> +def qemu_nbd_list(*args: str) -> str:
> +    '''Run qemu-nbd to list remote exports'''
> +    full_args =3D qemu_nbd_prog + ['-L'] + list(args)
> +    output, _ =3D qemu_tool_pipe_and_status('qemu-nbd', *full_args)
> +    log(output, filters=3D[filter_testfiles])

Not sure whether I like functions =E2=80=9Csilently=E2=80=9D auto-logging t=
he result.
I=E2=80=99d be happier if it were called *_log (i.e. qemu_nbd_list_log) lik=
e
most other functions that do.

> +    return output
> +
> +
>  @contextmanager
>  def qemu_nbd_popen(*args):
>      '''Context manager running qemu-nbd within the context'''

This would fit nicely into a dedicated patch.

*shrug*

> diff --git a/tests/qemu-iotests/307 b/tests/qemu-iotests/307
> new file mode 100755
> index 0000000000..06b9eeb15f
> --- /dev/null
> +++ b/tests/qemu-iotests/307
> @@ -0,0 +1,117 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright (C) 2020 Red Hat, Inc.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +# Creator/Owner: Kevin Wolf <kwolf@redhat.com>
> +#
> +# Test the block export QAPI interfaces
> +
> +import iotests
> +import os
> +
> +# Formats that have a request alignment !=3D 1 result in different outpu=
t for
> +# qemu-nbd -L ("min block")

So?  Why not filter that out?

I wonder anyway why the whole export output is logged.  It seems to me
like it would be sufficient to just log the number of exports available
and their names.

(Sure, logging everything gives us the advantage of perhaps finding NBD
bugs with this test even though it isn=E2=80=99t really an NBD test but int=
ended
largely as a test for the new interface.  But when I see something like
=E2=80=9Copt block=E2=80=9D or =E2=80=9Cmax block=E2=80=9D in the output, I=
 get a tingling sensation of
this potentially causing problems in the future depending on where this
test is running.)

((Which is funny, because now I notice I didn=E2=80=99t have this fear for =
=E2=80=9Cmin
block=E2=80=9D, but that=E2=80=99s where you actually did find an issue.))


Though all in all I don=E2=80=99t even know why it is that you write data a=
t all
and use images, instead of just backing the export by a null-co node.

(I do admit I=E2=80=99m sending mixed signals here =E2=80=93 first I ask fo=
r whether we
couldn=E2=80=99t make this test run on more formats, then I propose abandon=
ing
physical images altogether.  I=E2=80=99m just emitting the questions that p=
op
into my head, and my head can be a confusing place from time to time.)

> +iotests.script_initialize(
> +    supported_fmts=3D['raw', 'qcow2', 'vmdk'],
> +    supported_platforms=3D['linux'],
> +)
> +
> +with iotests.FilePath('image') as img, \
> +     iotests.FilePath('socket') as socket, \

The second one should use base_dir=3Diotests.sock_dir.

> +     iotests.VM() as vm:
> +
> +    iotests.qemu_img('create', '-f', iotests.imgfmt, img, '64M')
> +    iotests.qemu_io_log('-f', iotests.imgfmt, '-c', 'write -P 0x11 0 4k'=
, img)
> +
> +    iotests.log('=3D=3D=3D Launch VM =3D=3D=3D')
> +
> +    virtio_scsi_device =3D iotests.get_virtio_scsi_device()
> +
> +    vm.add_object('iothread,id=3Diothread0')
> +    vm.add_blockdev('file,filename=3D%s,node-name=3Dfile' % (img))
> +    vm.add_blockdev('%s,file=3Dfile,node-name=3Dfmt' % (iotests.imgfmt))
> +    vm.add_blockdev('raw,file=3Dfile,node-name=3Dro,read-only=3Don')
> +    vm.add_device('id=3Dscsi0,driver=3D%s,iothread=3Diothread0' % virtio=
_scsi_device)

Format strings would look nicer to me.  Perhaps not to you, though.

> +    vm.launch()
> +
> +    vm.qmp_log('nbd-server-start',
> +               addr=3D{'type': 'unix', 'data': {'path': socket}},
> +               filters=3D(iotests.filter_qmp_testfiles, ))
> +    vm.qmp_log('query-block-exports')
> +
> +    iotests.log('\n=3D=3D=3D Create a read-only NBD export =3D=3D=3D')
> +
> +    vm.qmp_log('block-export-add', id=3D'export0', type=3D'nbd', node_na=
me=3D'fmt')
> +    vm.qmp_log('query-block-exports')
> +
> +    iotests.qemu_nbd_list('-k', socket)
> +
> +    iotests.log('\n=3D=3D=3D Try a few invalid things =3D=3D=3D')
> +
> +    vm.qmp_log('block-export-add', id=3D'#invalid_id', type=3D'nbd', nod=
e_name=3D'fmt')
> +    vm.qmp_log('block-export-add', id=3D'export0', type=3D'nbd', node_na=
me=3D'fmt')
> +    vm.qmp_log('block-export-add', id=3D'export1', type=3D'nbd', node_na=
me=3D'ro',
> +               writable=3DTrue)
> +    vm.qmp_log('block-export-del', id=3D'export1')
> +    vm.qmp_log('query-block-exports')
> +
> +    iotests.log('\n=3D=3D=3D Move export to an iothread =3D=3D=3D')
> +
> +    vm.qmp_log('device_add', id=3D'sda', driver=3D'scsi-hd', drive=3D'fm=
t')
> +    vm.qmp_log('query-block-exports')
> +    iotests.qemu_nbd_list('-k', socket)
> +
> +    iotests.log('\n=3D=3D=3D Add a writable export =3D=3D=3D')
> +
> +    # This fails because share-rw=3Doff
> +    vm.qmp_log('block-export-add', id=3D'export1', type=3D'nbd', node_na=
me=3D'fmt',
> +               name=3D'export1', writable=3DTrue, writethrough=3DTrue,
> +               description=3D'This is the writable second export')
> +
> +    vm.qmp_log('device_del', id=3D'sda')
> +    event =3D vm.event_wait(name=3D"DEVICE_DELETED",
> +                          match=3D{'data': {'device': 'sda'}})
> +    iotests.log(event, filters=3D[iotests.filter_qmp_event])
> +    vm.qmp_log('device_add', id=3D'sda', driver=3D'scsi-hd', drive=3D'fm=
t',
> +               share_rw=3DTrue)
> +
> +    # Now it should work
> +    vm.qmp_log('block-export-add', id=3D'export1', type=3D'nbd', node_na=
me=3D'fmt',
> +               name=3D'export1', writable=3DTrue, writethrough=3DTrue,
> +               description=3D'This is the writable second export')
> +
> +    vm.qmp_log('query-block-exports')
> +    iotests.qemu_nbd_list('-k', socket)
> +
> +    iotests.log('\n=3D=3D=3D Connect qemu-io to export1, try removing ex=
ports =3D=3D=3D')
> +
> +    nbd_url =3D 'nbd+unix:///export1?socket=3D%s' % socket
> +    qemu_io =3D iotests.QemuIoInteractive('-f', 'raw', nbd_url)
> +
> +    iotests.log(qemu_io.cmd('read -P 0x11 0 4k'),
> +                filters=3D[iotests.filter_qemu_io])
> +    iotests.log(qemu_io.cmd('write -P 0x22 4k 4k'),
> +                filters=3D[iotests.filter_qemu_io])
> +
> +    vm.qmp_log('block-export-del', id=3D'export1')
> +    vm.qmp_log('block-export-del', id=3D'export0')

Should we check for the BLOCK_EXPORT_DELETED event?

> +    qemu_io.close()
> +
> +    vm.qmp_log('query-block-exports')
> +    iotests.qemu_nbd_list('-k', socket)

It might be nice to reconnect with qemu-io, and then see whether a hard
del works.

Max

> +
> +    iotests.log('\n=3D=3D=3D Shut down QEMU =3D=3D=3D')
> +    vm.shutdown()


--HbmhqlPk9l9W6mYXN8U5rlCnGGxh08Sao--

--3KMoXkeAhiHrQ41zjJyWvryhQakfYI6tF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9aUEsACgkQ9AfbAGHV
z0C4sggAiRZUt0vxK1E8AiMKj2TGlfHLwXF3x9tOxwmMP0iDjiklnDW94YxJTK7T
7XjZPgQI7AuxkX7mTjp0LYPwbKE3TJh69UNp62gIHlm5rrPUOfSG9avIarNbjV9t
47nA/GePyyJFmTsYotQOS2eaK5r/y+1HjutFrBsb34TJnPQChSQZcSjHclG1hFON
eNsygAZRu3Ui7SWIJTqmhLDwmQdOMsxOgciyJatIyFdRWtyEi/6/EUBgGolyV60V
gQuUsIZOmPTQPGL+pCudNJvA6HstudbHTu3ZCn8v4bEy2q8YFhKbKhc0IRoTJJfS
VrquwTbLtwVKee6h8otZQRQL6m2Vcw==
=liBt
-----END PGP SIGNATURE-----

--3KMoXkeAhiHrQ41zjJyWvryhQakfYI6tF--


