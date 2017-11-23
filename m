Received: from eggs.gnu.org ([2001:4830:134:3::10]:60039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHrVW-0006Wv-3W
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:25:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHrVS-0001HH-5t
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:25:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eHrVR-0001GT-Uz
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:25:30 -0500
References: <CAFEAcA83-oqifsZboJmvDVYhhr4=QOEEGF1TZba-jCewpUFtyg@mail.gmail.com>
	<1dff6d6c-be83-f6e1-2b7e-82d98bdb8a63@redhat.com>
	<6dd7061e-2ebe-7a51-8142-f67d5d75a81a@redhat.com>
	<8cd1c0b3-8386-d41e-ccfb-1a2073cdf4fb@redhat.com>
	<16011ac4-77c4-af75-5754-5f9586d6d629@redhat.com>
	<20171123130908.6ab004d3.cohuck@redhat.com>
	<b3b9837e-c6b0-d718-faaf-1ef198256634@redhat.com>
	<20171123133924.60e9f616.cohuck@redhat.com>
	<20171123125949.GN8166@redhat.com>
	<7f92f916-4858-15b7-89e9-bd9c1d6f1be9@redhat.com>
	<20171123132325.GO8166@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f68f4669-195f-f145-5bb7-5ad81a7c0602@redhat.com>
Date: Thu, 23 Nov 2017 14:25:23 +0100
MIME-Version: 1.0
In-Reply-To: <20171123132325.GO8166@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, sergio.g.delreal@gmail.com, alex@alex.org.uk

On 23/11/2017 14:23, Daniel P. Berrange wrote:
> On Thu, Nov 23, 2017 at 02:08:42PM +0100, Paolo Bonzini wrote:
>> On 23/11/2017 13:59, Daniel P. Berrange wrote:
>>>> I'm not sure I like that. For me, qemu-kvm comes with the connotation
>>>> of "there used to be a fork of qemu for kvm usage, and we stuck with
>>>> the name because it is likely scattered through scripts".
>>>
>>> Yes, qemu-kvm is a historical artifact in Fedora solely because of the
>>> previous fork.
>>
>> In Fedora, Debian, Ubuntu, Arch Linux and NixOS at least.  AFAICS only
>> Gentoo doesn't have it.
>>
>> Looks like something that upstream should provide, let's not fight
>> windmills.
> 
> I thought that Ubuntu / Debian had /usr/bin/kvm originally instead of
> qemu-kvm

Yeah, though the package is named qemu-kvm (confusing...).  Still the
point stands that if there is distro confusion, we should consider
looking at what the de facto standards are, and provide it ourselves in
a way that makes sense (and /usr/bin/kvm doesn't).

Paolo
