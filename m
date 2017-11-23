Received: from eggs.gnu.org ([2001:4830:134:3::10]:33791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHrvD-0002n0-Qw
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHrv8-00022E-TZ
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:52:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eHrv8-00020z-Mi
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:52:02 -0500
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-2-clg@kaod.org>
	<715a7bd1-7aa5-fa64-a9b8-76782ee20576@redhat.com>
	<20171123110345.03541b50.cohuck@redhat.com>
	<CAFEAcA83-oqifsZboJmvDVYhhr4=QOEEGF1TZba-jCewpUFtyg@mail.gmail.com>
	<1dff6d6c-be83-f6e1-2b7e-82d98bdb8a63@redhat.com>
	<6dd7061e-2ebe-7a51-8142-f67d5d75a81a@redhat.com>
	<8cd1c0b3-8386-d41e-ccfb-1a2073cdf4fb@redhat.com>
	<16011ac4-77c4-af75-5754-5f9586d6d629@redhat.com>
	<20171123130908.6ab004d3.cohuck@redhat.com>
	<b3b9837e-c6b0-d718-faaf-1ef198256634@redhat.com>
	<20171123133924.60e9f616.cohuck@redhat.com>
	<1519a9dc-5f0b-7ddd-18ac-d1f33782656d@redhat.com>
	<CAFEAcA_G_oG==OprY+NCGELyZx+rxgNFBMwQtLeGf6JsSHOQYw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fb4911b9-af89-a0a3-031a-964bf093aa59@redhat.com>
Date: Thu, 23 Nov 2017 14:51:51 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_G_oG==OprY+NCGELyZx+rxgNFBMwQtLeGf6JsSHOQYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU 3.0 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Sergio_Andr=c3=a9s_G=c3=b3mez_Del_Real?= <sergio.g.delreal@gmail.com>, Alex Bligh <alex@alex.org.uk>

On 23/11/2017 14:13, Peter Maydell wrote:
> On 23 November 2017 at 13:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> In theory I don't like it either (and I hadn't thought about it until
>> today).  In practice, qemu-kvm is not going away from
>> blogs/scripts/tutorials in a decade, so we might as well embrace it...
> Isn't this distro-specific? In ubuntu by default there isn't
> any wrapper, and if you do install the optional 'qemu-kvm' package
> the wrapper it provides is /usr/bin/kvm, not /usr/bin/qemu-kvm.

Fedora also has no wrapper in the qemu-system-x86 package, and only
"qemu-kvm" installs one.  In practice if you install the virtualization
package group you get it.  What about Ubuntu?

Paolo
