Received: from eggs.gnu.org ([2001:4830:134:3::10]:35614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g0KmJ-0002Z0-Cc
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g0KmG-0005O8-9k
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:06:59 -0400
References: <1536782900-17656-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1536782900-17656-7-git-send-email-akrowiak@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <386188b7-d6ae-b317-23b9-40c2779386bf@redhat.com>
Date: Thu, 13 Sep 2018 08:06:36 +0200
MIME-Version: 1.0
In-Reply-To: <1536782900-17656-7-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v8 6/6] s390: doc: detailed
 specifications for AP virtualization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, cohuck@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, pbonzini@redhat.com

On 2018-09-12 22:08, Tony Krowiak wrote:
> This patch provides documentation describing the AP architecture and
> design concepts behind the virtualization of AP devices. It also
> includes an example of how to configure AP devices for exclusive
> use of KVM guests.
>=20
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
[...]
> +   To assign an AP adapter to the mediated matrix device, its APID is =
written
> +   to the 'assign_adapter' file. This may be done multiple times to as=
sign more
> +   than one adapter. The APID may be specified using conventional sema=
ntics
> +   as a decimal, hexidecimal, or octal number. For example, to assign =
adapters
> +   4, 5 and 16 to a mediated matrix device in decimal, hexidecimal and=
 octal

s/hexidecimal/hexadecimal/g ?

While some websites say that hexi is an alternative spelling, I have to
admit that I've never seen it before, and there are also not that much
hits on google when you search for it...

[...]
> +* Live guest migration is not supported for guests using AP devices.
> \ No newline at end of file
>=20

Please add a newline at the end of the file.

 Thomas
