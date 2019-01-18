Received: from eggs.gnu.org ([209.51.188.92]:50711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gkW1h-0000RG-66
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gkW1g-0002DV-8Z
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:25:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gkW1f-0001o6-HS
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:25:43 -0500
References: <CALm7yL1oob_T+--=iW-iOQfEzJjP7reX9KrozEL2c4mYyX51jA@mail.gmail.com>
	<20190118100159.GA2483@work-vm>
	<8f0f7339-5f47-46d0-20a9-343badad4d0f@redhat.com>
	<20190118101633.GC2146@work-vm> <20190118102102.GH20660@redhat.com>
	<328f912c-e332-3bdc-d333-55c4af1a1fa1@redhat.com>
	<CALm7yL0nFGC1hYfvASrOL2FzO88oZURiLs-a6pR7Cjp3XS0U_g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <19ec0017-bd05-a847-b211-ebbdb141ebf6@redhat.com>
Date: Fri, 18 Jan 2019 16:25:27 +0100
MIME-Version: 1.0
In-Reply-To: <CALm7yL0nFGC1hYfvASrOL2FzO88oZURiLs-a6pR7Cjp3XS0U_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Live migration from Qemu 2.12 hosts to Qemu 3.2
 hosts, with VMX flag enabled in the guest?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Mielke <mark.mielke@gmail.com>
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, christian.ehrhardt@canonical.com

On 18/01/19 14:41, Mark Mielke wrote:
> It is useful to understand the risk. However, this is the same risk we
> have been successfully living with for several years now, and it seems
> abrupt to declare 3.1 and 3.2 as the Qemu version beyond which migratio=
n
> requires a whole cluster restart whether or not a L2 guest had been, or
> will ever be started on any of the guests.

Only if nested was enabled for the kvm_intel module.  If you didn't
enable it, you didn't see any change with 3.1.

Nested was enabled for kvm_amd years ago.  It was a mistake, but that's
why we didn't add such a blocker for AMD.

Paolo
