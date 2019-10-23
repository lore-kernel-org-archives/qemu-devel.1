Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C24FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 01:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 289C32086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 01:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOMuA7KH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289C32086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN5VU-0000oz-9I
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 21:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iN5Ul-0000MI-Ur
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 21:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iN5Uk-00049Z-1L
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 21:31:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30788
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iN5Uj-00048k-Td
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 21:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571794285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Y/7jVB7FkwgPRucjKCwiiJVKFmSEbOpS9vwKR7oubU=;
 b=HOMuA7KHSulx2FUaT/I4VwGrsOGaDakf8xbFSh2gDzTKXcuGOe7FVZPSbNJdpF3VfFeihZ
 iUYCWtHV4JILDwRXPDohqGpjZ/9LeI4F7xqmRFSjdyEr9BlYnU10n8aBgUmlapYk+43GkU
 4+HHC5l0L9OzXYsvKtGmViHxhlNersE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-JSr8-n93NnSaBmndKRFZ2Q-1; Tue, 22 Oct 2019 21:31:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86955476;
 Wed, 23 Oct 2019 01:31:20 +0000 (UTC)
Received: from [10.3.117.0] (ovpn-117-0.phx2.redhat.com [10.3.117.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4666B1001DC2;
 Wed, 23 Oct 2019 01:31:14 +0000 (UTC)
Subject: Re: [PATCH v10 3/3] iotests: test nbd reconnect
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191009084158.15614-1-vsementsov@virtuozzo.com>
 <20191009084158.15614-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0c87e5cd-cddf-b91a-3cca-fa3af9799d2b@redhat.com>
Date: Tue, 22 Oct 2019 20:31:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191009084158.15614-4-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: JSr8-n93NnSaBmndKRFZ2Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org,
 stefanha@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/19 3:41 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add test, which starts backup to nbd target and restarts nbd server
> during backup.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/264        | 95 +++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/264.out    | 13 +++++
>   tests/qemu-iotests/group      |  1 +
>   tests/qemu-iotests/iotests.py | 11 ++++
>   4 files changed, 120 insertions(+)
>   create mode 100755 tests/qemu-iotests/264
>   create mode 100644 tests/qemu-iotests/264.out
>=20
> diff --git a/tests/qemu-iotests/264 b/tests/qemu-iotests/264
> new file mode 100755
> index 0000000000..c8cd97ae2b
> --- /dev/null
> +++ b/tests/qemu-iotests/264

> +import iotests
> +from iotests import qemu_img_create, qemu_io_silent_check, file_path, \
> +        qemu_nbd_popen, log
> +
> +disk_a, disk_b, nbd_sock =3D file_path('disk_a', 'disk_b', 'nbd-sock')
> +nbd_uri =3D 'nbd+unix:///?socket=3D' + nbd_sock

Needs rebasing on top of Max's patches to stick sockets in SOCK_DIR:

https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04201.html

[or, if my pull request lands first, Max needs to add this one to the=20
list of affected tests...]


> +vm.qmp_log('blockdev-add', filters=3D[iotests.filter_qmp_testfiles],
> +           **{'node_name': 'backup0',
> +              'driver': 'raw',
> +              'file': {'driver': 'nbd',
> +                       'server': {'type': 'unix', 'path': nbd_sock},
> +                       'reconnect-delay': 10}})
> +vm.qmp_log('blockdev-backup', device=3D'drive0', sync=3D'full', target=
=3D'backup0',
> +           speed=3D(1 * 1024 * 1024))

This starts the job throttled, to give us time...

> +
> +# Wait for some progress
> +t =3D 0
> +while t < wait_limit:
> +    jobs =3D vm.qmp('query-block-jobs')['return']
> +    if jobs and jobs[0]['offset'] > 0:
> +        break
> +    time.sleep(wait_step)
> +    t +=3D wait_step
> +
> +if jobs and jobs[0]['offset'] > 0:
> +    log('Backup job is started')
> +
> +log('Kill NBD server')
> +srv.kill()
> +srv.wait()
> +
> +jobs =3D vm.qmp('query-block-jobs')['return']
> +if jobs and jobs[0]['offset'] < jobs[0]['len']:
> +    log('Backup job is still in progress')
> +
> +vm.qmp_log('block-job-set-speed', device=3D'drive0', speed=3D0)
> +
> +# Emulate server down time for 1 second
> +time.sleep(1)

...but once we restart,...

> +
> +log('Start NBD server')
> +srv =3D qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b)
> +
> +e =3D vm.event_wait('BLOCK_JOB_COMPLETED')

...should we unthrottle the job to allow the test to complete slightly=20
faster after the reconnect?  But that can be done as an improvement on=20
top, if it helps.


> +++ b/tests/qemu-iotests/iotests.py
> @@ -165,6 +165,13 @@ def qemu_io_silent(*args):
>                            (-exitcode, ' '.join(args)))
>       return exitcode
>  =20
> +def qemu_io_silent_check(*args):
> +    '''Run qemu-io and return the true if subprocess returned 0'''
> +    args =3D qemu_io_args + list(args)
> +    exitcode =3D subprocess.call(args, stdout=3Dopen('/dev/null', 'w'),
> +                               stderr=3Dsubprocess.STDOUT)

This discards the stdout data, even on failure. Is there a smarter way=20
to grab the output into a variable, but only dump it to the log on=20
failure, rather than outright discarding it?

But for the sake of getting this test in before freeze, that can be a=20
followup, if at all.

Reviewed-by: Eric Blake <eblake@redhat.com>

I'll send a pull request soon.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


