Received: from eggs.gnu.org ([2001:4830:134:3::10]:55839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZxHO-0004Fx-Fy
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:18:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZxHL-0006hk-Ce
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:18:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZxHL-0006hI-3d
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:18:15 -0500
References: <20181219151917.3874-1-pbonzini@redhat.com>
	<CAFEAcA_0jPh6TVOqzfp_O5eFitNocabR1GdLkwwZcv6QcW=iUQ@mail.gmail.com>
	<d5bc276c-b149-acc6-03b8-6f5c5a309e4a@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d96927aa-282e-f24a-324f-b674afc81aa6@redhat.com>
Date: Thu, 20 Dec 2018 13:18:04 +0100
MIME-Version: 1.0
In-Reply-To: <d5bc276c-b149-acc6-03b8-6f5c5a309e4a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/35] Misc patches for 2018-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20/12/18 12:43, Philippe Mathieu-Daud=C3=A9 wrote:
>> subprocess.CalledProcessError: Command '['docker', 'build', '-t',
>> 'qemu:debian9', '-f', '/tmp/docker_buildsvtS6R/tmp74LVkj.docker',
>> '/tmp/docker_buildsvtS6R']' returned non-zero exit status 100
>> /home/petmay01/linaro/qemu-for-merges/tests/docker/Makefile.include:53=
:
>> recipe for target 'docker-image-debian9' failed
>> make: *** [docker-image-debian9] Error 1
>=20
> This looks an unrelated error. The Debian mirror you are using might be
> out of sync (or syncing), or the filesystem where you store your Docker
> image is full?


Indeed I cannot reproduce it.  I'll send the pull request with
g_test_skip fixed (well, removed -- the harness notes 0 tests run and
declares it a SKIP anyway).

Paolo
