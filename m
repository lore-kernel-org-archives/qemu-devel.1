Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A863AC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 14:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CBD620879
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 14:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBD620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44414 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTSOl-0007Wd-7H
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 10:39:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTSHK-0001JX-85
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTSHI-0002Al-DB
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:31:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hTSH3-0001ZR-Nd; Wed, 22 May 2019 10:31:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3A163082163;
	Wed, 22 May 2019 14:31:20 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.176])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2761C54474;
	Wed, 22 May 2019 14:31:18 +0000 (UTC)
To: qemu-block@nongnu.org
References: <20190522142854.22983-1-mreitz@redhat.com>
	<20190522142854.22983-3-mreitz@redhat.com>
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
Message-ID: <c5a3333f-c9d4-8e89-43f1-2cd50dc93fee@redhat.com>
Date: Wed, 22 May 2019 16:31:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522142854.22983-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hXBJBjzC5gaHZQPUpvWyCbgxmcWAH3AVq"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 22 May 2019 14:31:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: Test cancelling a job and
 closing the VM
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hXBJBjzC5gaHZQPUpvWyCbgxmcWAH3AVq
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <c5a3333f-c9d4-8e89-43f1-2cd50dc93fee@redhat.com>
Subject: Re: [PATCH 2/2] iotests: Test cancelling a job and closing the VM
References: <20190522142854.22983-1-mreitz@redhat.com>
 <20190522142854.22983-3-mreitz@redhat.com>
In-Reply-To: <20190522142854.22983-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22.05.19 16:28, Max Reitz wrote:
> This patch adds a test where we cancel a throttled mirror job and
> immediately close the VM before it can be cancelled.  Doing so will
> invoke bdrv_drain_all() while the mirror job tries to drain the
> throttled node.  When bdrv_drain_all_end() tries to lift its drain on
> the throttle node, the job will exit and replace the current root node
> of the BB drive0 (which is the job's filter node) by the throttle node.=

> Before the previous patch, this replacement did not increase drive0's
> quiesce_counter by a sufficient amount, so when
> bdrv_parent_drained_end() (invoked by bdrv_do_drained_end(), invoked by=

> bdrv_drain_all_end()) tried to end the drain on all of the throttle
> node's parents, it decreased drive0's quiesce_counter below 0 -- which
> fails an assertion.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/255     | 54 ++++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/255.out | 24 +++++++++++++++++
>  2 files changed, 78 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/255 b/tests/qemu-iotests/255
> index c0bb37a9b0..b1bbe3ff0a 100755
> --- a/tests/qemu-iotests/255
> +++ b/tests/qemu-iotests/255
> @@ -35,6 +35,10 @@ def blockdev_create(vm, options):
>          vm.run_job('job0')
>      iotests.log("")
> =20
> +iotests.log('Finishing a commit job with background reads')
> +iotests.log('=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
')
> +iotests.log('')
> +
>  with iotests.FilePath('t.qcow2') as disk_path, \
>       iotests.FilePath('t.qcow2.mid') as mid_path, \
>       iotests.FilePath('t.qcow2.base') as base_path, \
> @@ -80,4 +84,54 @@ with iotests.FilePath('t.qcow2') as disk_path, \
>      vm.run_job('job0', auto_finalize=3DFalse, pre_finalize=3Dstart_req=
uests,
>                  auto_dismiss=3DTrue)
> =20
> +    #vm.qmp_log('block-job-cancel', device=3D'job0')
> +
> +    vm.shutdown()

Er, oops, I took so much time with the commit messages that I forgot
this.  Let me try again...

Shamefully,

Max


--hXBJBjzC5gaHZQPUpvWyCbgxmcWAH3AVq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzlXTUACgkQ9AfbAGHV
z0DHhAgAmys9/3qjIE6M5u1Z8Up/Q2B4iVppPlFhWwFCclFEd6cvdDT3UKinfFlU
/DUelJIqY5IUvlKqUpILiVysQSRlpOSCh4y0azWVwCpVXhJLifZte4vBr6vUEZsf
jdfgIDvA5BR2QqmozhDXEOsGqe+D7uMsThwgYtj+O0lRYr8xR6RhPDKqca3KC/o3
NUk6CUsOBxXnb7u7WJ5m0rxn0qEGDCt0bcH4F4Me2chW9JxpRz3CD2qFYwP0jQTG
q4OMNqznJdxKPcxc7miMtnyhc7wgyCrX1rk/didzJ0JGzGH2Rd9S6eI8s7pYu1HC
nwRlbxaDdSYwJhmlwl1RdQID3mfAEw==
=Yuw+
-----END PGP SIGNATURE-----

--hXBJBjzC5gaHZQPUpvWyCbgxmcWAH3AVq--

