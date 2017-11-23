Received: from eggs.gnu.org ([2001:4830:134:3::10]:48906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHrKN-0001e3-Nc
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:14:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHrKM-0005zH-Um
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:14:03 -0500
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:46311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHrKM-0005ya-NT
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:14:02 -0500
Received: by mail-oi0-x22b.google.com with SMTP id a81so13127327oii.13
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 05:14:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519a9dc-5f0b-7ddd-18ac-d1f33782656d@redhat.com>
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
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Nov 2017 13:13:41 +0000
Message-ID: <CAFEAcA_G_oG==OprY+NCGELyZx+rxgNFBMwQtLeGf6JsSHOQYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] QEMU 3.0 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?Q?Sergio_Andr=C3=A9s_G=C3=B3mez_Del_Real?= <sergio.g.delreal@gmail.com>, Alex Bligh <alex@alex.org.uk>

On 23 November 2017 at 13:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
> In theory I don't like it either (and I hadn't thought about it until
> today).  In practice, qemu-kvm is not going away from
> blogs/scripts/tutorials in a decade, so we might as well embrace it...

Isn't this distro-specific? In ubuntu by default there isn't
any wrapper, and if you do install the optional 'qemu-kvm' package
the wrapper it provides is /usr/bin/kvm, not /usr/bin/qemu-kvm.

thanks
-- PMM
