Received: from eggs.gnu.org ([2001:4830:134:3::10]:45591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evrtM-0004Qz-Dz
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evrtH-0003bk-VG
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:55:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49436 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evrtH-0003bY-Qg
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:55:27 -0400
References: <20180312183628.394722-1-eblake@redhat.com>
	<CAFEAcA9HLfz77eEHho+Vod=XSsvoNv10noFJjqoAd0=CXT-8dQ@mail.gmail.com>
	<ad8cb727-8e0d-d2ba-659e-9b91f59c30cd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9dab3815-57a8-59e4-f1c7-b5e56b14d64a@redhat.com>
Date: Tue, 13 Mar 2018 16:55:16 -0500
MIME-Version: 1.0
In-Reply-To: <ad8cb727-8e0d-d2ba-659e-9b91f59c30cd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/36] QAPI patches for 2018-03-12,
 2.12 softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

On 03/13/2018 09:17 AM, Eric Blake wrote:
>>> This builds and passes 'make check', so even though the OOB portion
>>> depends on chardev fixes that are still pending a pull request from
>>> Paolo, that dependence can only be observed at runtime by clients
>>> that use the new oob feature.=C2=A0 Given the timing of soft freeze, =
and
>>> the fact that the chardev fixes do not form a build dependency, I
>>> think it's okay if this pull request gets processed before Paolo's
>>> (but it's also okay if Paolo's goes in first).
>=20
> Based on the testsuite failures, it looks like Paolo's pull request wit=
h=20
> chardev fixes DOES have to go in first.

Nearing the end of my workday; I'm not sure what the status is on=20
Paolo's pull request with the chardev fixes, but hope that it doesn't=20
invalidate this pull request from still being considered as soft freeze=20
material.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
