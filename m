Received: from eggs.gnu.org ([2001:4830:134:3::10]:58208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYqpb-0005gR-4T
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYqpY-0005FD-0Y
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:40:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36596 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYqpX-0005ES-Qh
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:40:43 -0400
References: <153026817452.402489.13386335348113684056.stgit@bahia.lan>
	<8730183a-3e16-931e-c990-24a5e169b2d9@redhat.com>
	<20180629103910.GE27016@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <65a3597e-5560-1fd3-4f04-8a60e9e99b44@redhat.com>
Date: Fri, 29 Jun 2018 12:40:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180629103910.GE27016@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] accel: forbid early use of
 kvm_enabled() and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 29/06/2018 12:39, Daniel P. Berrang=C3=A9 wrote:
>> Also asserting current_machine !=3D NULL is not necessary, since you'r=
e
>> immediately dereferencing it.
> Is there a practical way to simply initialize the accelerators earlier
> in startup sequence, so we just remove or at least reduce, the liklihoo=
d
> of accessing it too early ?

We can try, though not for 3.0 of course.

Paolo
