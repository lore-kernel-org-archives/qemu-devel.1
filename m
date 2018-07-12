Received: from eggs.gnu.org ([2001:4830:134:3::10]:43227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fddoG-0007xT-9s
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fddoF-0004ss-Hn
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:47:12 -0400
References: <20180703111949.GB24516@redhat.com>
	<20180703113229.GD3812@localhost.localdomain>
	<20180704150256.408d4a07.cohuck@redhat.com>
	<20180704133440.GE4334@localhost.localdomain>
	<CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
	<20180706131103.4e713911.cohuck@redhat.com>
	<20180706145645.GB3939@localhost.localdomain>
	<CAFEAcA9J=Jmd=+9vEo4LLdk0LcL42fchHcAp3fp_+9q1tsCoNg@mail.gmail.com>
	<87tvp8or4u.fsf@dusky.pond.sub.org>
	<20180709130838.16f011a4.cohuck@redhat.com>
	<20180709111701.GF23731@redhat.com> <87601lge0i.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <751b33cb-d7da-ef47-415d-86b0e3c31129@redhat.com>
Date: Thu, 12 Jul 2018 17:47:00 +0200
MIME-Version: 1.0
In-Reply-To: <87601lge0i.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Krempa <pkrempa@redhat.com>

On 12.07.2018 08:32, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
[...]
>> For libvirt, I think whenever something is proposed for deprecation
>> we could just CC libvir-list, or ask one of the libvirt people to
>> confirm its not being used. If it is, then we should file BZ against
>> libvirt.
>=20
> Makes sense, but relying on developers getting their cc: right every
> time is a setting us up for failure.
>=20
> Our tool to help with getting cc: wrong less often is the MAINTAINERS
> file.  Could one of the libvirt developers watch changes to qemu-doc
> appendix "Deprecated features"?  Would putting the appendix in its own
> .texi help with that?

Sound like a good idea to put the appendix in its own texi file. Then
add an "R: libvir-list" entry for that file to MAINTAINERS and we should
be fine (at least for the people who use the get_maintainers.pl script).

 Thomas
