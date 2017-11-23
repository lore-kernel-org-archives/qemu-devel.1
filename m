Received: from eggs.gnu.org ([2001:4830:134:3::10]:36342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHqJo-0001OR-Gs
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 07:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHqJe-00037D-Og
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 07:09:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eHqJe-00034m-Gz
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 07:09:14 -0500
Date: Thu, 23 Nov 2017 13:09:08 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171123130908.6ab004d3.cohuck@redhat.com>
In-Reply-To: <16011ac4-77c4-af75-5754-5f9586d6d629@redhat.com>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-2-clg@kaod.org>
	<715a7bd1-7aa5-fa64-a9b8-76782ee20576@redhat.com>
	<20171123110345.03541b50.cohuck@redhat.com>
	<CAFEAcA83-oqifsZboJmvDVYhhr4=QOEEGF1TZba-jCewpUFtyg@mail.gmail.com>
	<1dff6d6c-be83-f6e1-2b7e-82d98bdb8a63@redhat.com>
	<6dd7061e-2ebe-7a51-8142-f67d5d75a81a@redhat.com>
	<8cd1c0b3-8386-d41e-ccfb-1a2073cdf4fb@redhat.com>
	<16011ac4-77c4-af75-5754-5f9586d6d629@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, sergio.g.delreal@gmail.com, alex@alex.org.uk

On Thu, 23 Nov 2017 13:05:33 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 23/11/2017 12:57, Thomas Huth wrote:
> > On 23.11.2017 12:17, Paolo Bonzini wrote:  
> >> On 23/11/2017 11:57, Thomas Huth wrote:  
> > [...]  
> >>> I've put "--accel kvm:hax:tcg" also on the doable list since I don't
> >>> remember any objections to that idea so far -- feel free to move it to
> >>> the controversial list instead if you think it needs more discussion.  
> >>
> >> "hax" is very far from feature parity with TCG, it doesn't even support
> >> CPUID (-cpu).  "-accel kvm:hvf:tcg" could be a possibility, but only if
> >> we have resources to test it.  As far as I know the only active x86
> >> developer who owns a Mac is Igor?  
> > 
> > hvf hasn't been merged yet ... do you expect it to hit master after 2.11
> > has been released?  
> 
> Yes, more or less.
> 
> > Otherwise, we should maybe rather simply go with
> > "--accel kvm:tcg"?  
> 
> Yes, HVF can come later.

This switch sounds like something we can easily do for the next
release; I'd hope that anyone explicitly requiring tcg already
specifies it.
