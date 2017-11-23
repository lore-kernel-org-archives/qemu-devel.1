Received: from eggs.gnu.org ([2001:4830:134:3::10]:44274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHrFN-00087w-Rg
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHrFI-0002Uz-BG
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:08:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eHrFI-0002UT-51
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:08:48 -0500
References: <715a7bd1-7aa5-fa64-a9b8-76782ee20576@redhat.com>
	<20171123110345.03541b50.cohuck@redhat.com>
	<CAFEAcA83-oqifsZboJmvDVYhhr4=QOEEGF1TZba-jCewpUFtyg@mail.gmail.com>
	<1dff6d6c-be83-f6e1-2b7e-82d98bdb8a63@redhat.com>
	<6dd7061e-2ebe-7a51-8142-f67d5d75a81a@redhat.com>
	<8cd1c0b3-8386-d41e-ccfb-1a2073cdf4fb@redhat.com>
	<16011ac4-77c4-af75-5754-5f9586d6d629@redhat.com>
	<20171123130908.6ab004d3.cohuck@redhat.com>
	<b3b9837e-c6b0-d718-faaf-1ef198256634@redhat.com>
	<20171123133924.60e9f616.cohuck@redhat.com>
	<20171123125949.GN8166@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7f92f916-4858-15b7-89e9-bd9c1d6f1be9@redhat.com>
Date: Thu, 23 Nov 2017 14:08:42 +0100
MIME-Version: 1.0
In-Reply-To: <20171123125949.GN8166@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU 3.0 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, sergio.g.delreal@gmail.com, alex@alex.org.uk

On 23/11/2017 13:59, Daniel P. Berrange wrote:
>> I'm not sure I like that. For me, qemu-kvm comes with the connotation
>> of "there used to be a fork of qemu for kvm usage, and we stuck with
>> the name because it is likely scattered through scripts".
>
> Yes, qemu-kvm is a historical artifact in Fedora solely because of the
> previous fork.

In Fedora, Debian, Ubuntu, Arch Linux and NixOS at least.  AFAICS only
Gentoo doesn't have it.

Looks like something that upstream should provide, let's not fight
windmills.

Paolo

 We can't easily get rid of it because the path is encoded
> in libvirt XML files and countless end user scripts/configs.
