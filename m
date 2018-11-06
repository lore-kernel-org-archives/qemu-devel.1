Received: from eggs.gnu.org ([2001:4830:134:3::10]:56294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gK8r7-0008AM-1V
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:25:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gK8qz-0000t6-Ad
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:25:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:21556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gK8qj-0003ka-Qj
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:25:31 -0500
References: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
	<f5712b07-05a1-650c-332a-a24462fed977@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <454d6ffd-bc43-4f2e-0916-b4c4a14fe788@redhat.com>
Date: Tue, 6 Nov 2018 16:23:56 -0500
MIME-Version: 1.0
In-Reply-To: <f5712b07-05a1-650c-332a-a24462fed977@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] List of files containing devices which have not
 been QOMified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>



On 11/06/2018 02:46 PM, Paolo Bonzini wrote:
> On 06/11/2018 19:43, Peter Maydell wrote:

>> hw/ide/ahci.c
> 
> Even though AHCIState is not a QOM object, all of its users are
> (TYPE_SYSBUS_AHCI is in this file, TYPE_ICH9_AHCI is in hw/ide/ich.c).
> 

Yeah, if there's something *further* that needs to happen, let me know.
I'm not sure what the QOM ideal is.

Is there a reference implementation for what we consider to be a proper
QOM device that I can measure against?

A list of forbidden ABIs I ought not use?

(S/ATA device realization is in itself already particularly bizarre
where we have a skeleton list of properties in QOM and then we just
malloc the bulk of the structure we actually use, but I think it's not
worth fixing to be nicer because I haven't figured out a way to do it
without breaking backwards compatibility, so I've just left it alone.)

--js
