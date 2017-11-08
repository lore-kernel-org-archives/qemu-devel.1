Received: from eggs.gnu.org ([2001:4830:134:3::10]:50375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eCNpF-0006ho-Gb
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:43:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eCNpC-00026R-Dk
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:43:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eCNpC-000264-7w
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:43:14 -0500
References: <20171108022828.7242-1-f4bug@amsat.org>
	<20171108022828.7242-6-f4bug@amsat.org>
	<b49e3557-7593-44ac-3337-41ee95451457@ozlabs.ru>
	<17a9e801-0f13-a438-e57d-f511c5ed92ee@amsat.org>
	<20171108091303.GH12670@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c7dcbf77-92ac-78f5-a85e-0f1ba1003fc9@redhat.com>
Date: Wed, 8 Nov 2017 11:43:05 +0100
MIME-Version: 1.0
In-Reply-To: <20171108091303.GH12670@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 5/6] hw/i386: deprecate the pc-0.10 and
 pc-0.11 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On 08.11.2017 10:13, Daniel P. Berrange wrote:
> On Wed, Nov 08, 2017 at 12:28:00AM -0300, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> Hi Alexey,
>>
>> On 11/07/2017 11:48 PM, Alexey Kardashevskiy wrote:
>>> On 08/11/17 13:28, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> Both are deprecated since 2.9.0
>>>
>>> May be so but I could not find where this happened in git history:
>>>
>>> [vpl1 qemu]$ git log -n1 --grep 'pc-0.10'
>>> f6d5a0bad2 2 years, 5 months ago Eduardo Habkost piix: Define PC_COMP=
AT_0_10
>>>
>>> Having some pointers in the commit log would be helpful imho, like [2=
/6].
>>
>> Ok! If there is positive feedback on this series I'll respin trying to
>> be more verbose.
>>
>> I took "2.9.0" from the wiki history [1], which is the formal way to g=
o
>> as I understand:
>=20
> No, the wiki page content was just an initial jumping off point for
> discussions.  The formal list of what's deprecated is kept in the
> qemu-doc.texi file in the "Deprecated features" appendix.
>=20
> We really ought to remove most of the content from that wiki page
> and just point to the formal docs,  to avoid continued confusion
> like this.

I've changed the wording on the wiki page and added a pointer to the
qemu-doc there, so it's hopefully now clearer that the qemu-doc is the
mandatory list of deprecated features / interfaces.

 Thomas
