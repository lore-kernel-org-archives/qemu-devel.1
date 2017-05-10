Received: from eggs.gnu.org ([2001:4830:134:3::10]:36280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8TBj-0007XO-D1
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8TBf-0004vS-9C
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:06:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d8TBf-0004vO-3j
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:05:59 -0400
References: <1494398933-8366-1-git-send-email-thuth@redhat.com>
	<20170510090841.GF31558@redhat.com> <20170510145125.GE4230@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3f0edb37-eb07-d8d6-016b-bb98487c66f8@redhat.com>
Date: Wed, 10 May 2017 17:05:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170510145125.GE4230@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Deprecate the machines pc-0.10 to
 pc-0.15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com, Richard Henderson <rth@twiddle.net>



On 10/05/2017 16:51, Dr. David Alan Gilbert wrote:
> I'll give you a manual one; I just migrated:
>    /opt/qemu/v1.0.1/bin/qemu-system-x86_64 -M pc-1.0 -m 2G /home/vms/f2=
3-serial-010.qcow2 -M pc-1.0 -nographic
> to
>    /opt/qemu/v2.9.0/bin/qemu-system-x86_64 -M pc-1.0 -m 2G /home/vms/f2=
3-serial-010.qcow2 -M pc-1.0 -nographic -incoming tcp::4444
>=20
> seems to have survived.
> Not exactly conclusive or heavy coverage, but it's not completely
> broken.

Yeah, I think resetting the VM will fail, or something like that.

Paolo
