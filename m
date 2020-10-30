Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7EFC4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:16:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7840A206DB
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blYMo4hY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7840A206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYQW4-00061w-3S
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 05:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kYQUp-0005J4-5t
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kYQUn-00088v-7W
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604049292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fO8EaRjiZYxc0lqAWLxvWjUf/fykUjMU9zS7BtVN2V8=;
 b=blYMo4hYWQVePtSHVbZJYZamilI0n3rUbyVMFYtObFgz4oGBdLZqIgYOwIVVwBItY5DH7y
 PCmungaYwYY5Y9ESl0lAUIhynS8tuhrNZwUi1a05MCvyrsJEsKCCINgvYttgpmG742IjCq
 IX/F8MxlvboUrRFBbTZHK0quIKnC9OU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-VK3dPsn6MlK842R3-HWURQ-1; Fri, 30 Oct 2020 05:14:49 -0400
X-MC-Unique: VK3dPsn6MlK842R3-HWURQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3445C1868420
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 09:14:48 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AEB435C1C4;
 Fri, 30 Oct 2020 09:14:40 +0000 (UTC)
Subject: Re: [PATCH v2 7/7] tests/acceptance: Add virtiofs_submounts.py
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20201029171744.150726-1-mreitz@redhat.com>
 <20201029171744.150726-8-mreitz@redhat.com>
 <20201029204601.GM5733@habkost.net>
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
Message-ID: <20680712-df27-3a7d-13bc-720c37121274@redhat.com>
Date: Fri, 30 Oct 2020 10:14:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201029204601.GM5733@habkost.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kQ6oBDaZ53EqzpVqDqjuL2arePh4sQckW"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kQ6oBDaZ53EqzpVqDqjuL2arePh4sQckW
Content-Type: multipart/mixed; boundary="re4RYIjmYwKatmkUQHS60A7dAi5BAKYC6"

--re4RYIjmYwKatmkUQHS60A7dAi5BAKYC6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.10.20 21:46, Eduardo Habkost wrote:
> On Thu, Oct 29, 2020 at 06:17:44PM +0100, Max Reitz wrote:
>> This test invokes several shell scripts to create a random directory
>> tree full of submounts, and then check in the VM whether every submount
>> has its own ID and the structure looks as expected.
>>
>> (Note that the test scripts must be non-executable, so Avocado will not
>> try to execute them as if they were tests on their own, too.)
>>
>> Because at this commit's date it is unlikely that the Linux kernel on
>> the image provided by boot_linux.py supports submounts in virtio-fs, the
>> test will be cancelled if no custom Linux binary is provided through the
>> vmlinuz parameter.  (The on-image kernel can be used by providing an
>> empty string via vmlinuz=3D.)
>>
>> So, invoking the test can be done as follows:
>> $ avocado run \
>>     tests/acceptance/virtiofs_submounts.py \
>>     -p vmlinuz=3D/path/to/linux/build/arch/x86/boot/bzImage
>>
>> This test requires root privileges (through passwordless sudo -n),
>> because at this point, virtiofsd requires them.  (If you have a
>> timestamp_timeout period for sudoers (e.g. the default of 5 min), you
>> can provide this by executing something like "sudo true" before invoking
>> Avocado.)
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>  tests/acceptance/virtiofs_submounts.py        | 289 ++++++++++++++++++
>>  .../virtiofs_submounts.py.data/cleanup.sh     |  46 +++
>>  .../guest-cleanup.sh                          |  30 ++
>>  .../virtiofs_submounts.py.data/guest.sh       | 138 +++++++++
>>  .../virtiofs_submounts.py.data/host.sh        | 127 ++++++++
>>  5 files changed, 630 insertions(+)
>>  create mode 100644 tests/acceptance/virtiofs_submounts.py
>>  create mode 100644 tests/acceptance/virtiofs_submounts.py.data/cleanup.=
sh
>>  create mode 100644 tests/acceptance/virtiofs_submounts.py.data/guest-cl=
eanup.sh
>>  create mode 100644 tests/acceptance/virtiofs_submounts.py.data/guest.sh
>>  create mode 100644 tests/acceptance/virtiofs_submounts.py.data/host.sh
>>
>> diff --git a/tests/acceptance/virtiofs_submounts.py b/tests/acceptance/v=
irtiofs_submounts.py
>> new file mode 100644
>> index 0000000000..8b207b3e57
>> --- /dev/null
>> +++ b/tests/acceptance/virtiofs_submounts.py
>> @@ -0,0 +1,289 @@
>> +import logging
>> +import re
>> +import os
>> +import subprocess
>> +import time
>> +
>> +from avocado import skipUnless
>> +from avocado_qemu import Test, BUILD_DIR
>> +from avocado_qemu import wait_for_console_pattern
>> +from avocado.utils import ssh
>> +
>> +from qemu.accel import kvm_available
>> +
>> +from boot_linux import BootLinux
>> +
>> +
>> +def run_cmd(args):
>> +    subp =3D subprocess.Popen(args,
>> +                            stdout=3Dsubprocess.PIPE,
>> +                            stderr=3Dsubprocess.PIPE,
>> +                            universal_newlines=3DTrue)
>> +    stdout, stderr =3D subp.communicate()
>> +    ret =3D subp.returncode
>> +
>> +    return (stdout, stderr, ret)
>> +
>> +def has_passwordless_sudo():
>> +    """
>> +    This function is for use in a @avocado.skipUnless decorator, e.g.:
>> +
>> +        @skipUnless(*has_passwordless_sudo())
>> +        def test_something_that_needs_sudo(self):
>> +            ...
>> +    """
>> +
>> +    _, stderr, exitcode =3D run_cmd(('sudo', '-n', 'true'))
>=20
> This seems to break if sudo is not available in the host:

Oh, makes sense.  I=E2=80=99ll wrap it in a try-except.  Thanks!

Max

> https://gitlab.com/ehabkost/qemu/-/jobs/820072411#L152
>=20
> 0:37:08 ERROR| ERROR 32-tests/acceptance/virtiofs_submounts.py:VirtiofsSu=
bmountsTest.test_pre_virtiofsd_set_up -> TestError: Traceback (most recent =
call last):
>   File "/usr/lib64/python3.6/imp.py", line 235, in load_module
>     return load_source(name, filename, file)
>   File "/usr/lib64/python3.6/imp.py", line 172, in load_source
>     module =3D _load(spec)
>   File "<frozen importlib._bootstrap>", line 684, in _load
>   File "<frozen importlib._bootstrap>", line 665, in _load_unlocked
>   File "<frozen importlib._bootstrap_external>", line 678, in exec_module
>   File "<frozen importlib._bootstrap>", line 219, in _call_with_frames_re=
moved
>   File "/builds/ehabkost/qemu/build/tests/acceptance/virtiofs_submounts.p=
y", line 43, in <module>
>     class VirtiofsSubmountsTest(BootLinux):
>   File "/builds/ehabkost/qemu/build/tests/acceptance/virtiofs_submounts.p=
y", line 195, in VirtiofsSubmountsTest
>     @skipUnless(*has_passwordless_sudo())
>   File "/builds/ehabkost/qemu/build/tests/acceptance/virtiofs_submounts.p=
y", line 36, in has_passwordless_sudo
>     _, stderr, exitcode =3D run_cmd(('sudo', '-n', 'true'))
>   File "/builds/ehabkost/qemu/build/tests/acceptance/virtiofs_submounts.p=
y", line 21, in run_cmd
>     universal_newlines=3DTrue)
>   File "/usr/lib64/python3.6/subprocess.py", line 729, in __init__
>     restore_signals, start_new_session)
>   File "/usr/lib64/python3.6/subprocess.py", line 1364, in _execute_child
>     raise child_exception_type(errno_num, err_msg, err_filename)
> FileNotFoundError: [Errno 2] No such file or directory: 'sudo': 'sudo'
> 20:37:08 INFO |=20
>=20
>> +    if exitcode !=3D 0:
>> +        return (False, f'Failed to use sudo -n: {stderr.strip()}')
>> +    else:
>> +        return (True, '')
>> +
>> +
> [...]
>=20



--re4RYIjmYwKatmkUQHS60A7dAi5BAKYC6--

--kQ6oBDaZ53EqzpVqDqjuL2arePh4sQckW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+b2X4ACgkQ9AfbAGHV
z0AdIgf8Dich9OAPZTYWLvH5kV0dnWtPasCeHHKYWo0dswKuUJmeKndvgfDXLQN2
NSVVefyKtMAiZ90hGvpGF26+mi81BnTOVWKtMSU5pP99S1rsxb2eLyOhWFIktbds
k54VSITwrpFUAX+hh4M11iefvyVCuFFZlpynE5Neu9Kgp3LzrTX2340kYnpJmuib
imogM+G2fSEm+Lm0yDks1IaRjD/0xu3KAY1ael8OPmCfl85KT1564QKv6EwiDezp
MgNrXbRco8EeVVdkNZ6nNO4jdk0moVHjb1ioGpFWkQ6c0YWhaV3pC6HGFv9F2Dme
v7VB08UkPAivvZpwlEXR900j/cfw1g==
=Fq4H
-----END PGP SIGNATURE-----

--kQ6oBDaZ53EqzpVqDqjuL2arePh4sQckW--


