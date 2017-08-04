Received: from eggs.gnu.org ([2001:4830:134:3::10]:55501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ddgiP-0008HI-6b
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ddgiO-00070v-Ho
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:48:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ddgiO-00070R-BK
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:48:48 -0400
Date: Fri, 4 Aug 2017 18:48:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170804174843.GE2087@work-vm>
References: <CAFEAcA-Se9r30gHpYd34vF0Z-yQbDtpOBi8qyqvtTXMja85Zdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-Se9r30gHpYd34vF0Z-yQbDtpOBi8qyqvtTXMja85Zdg@mail.gmail.com>
Subject: Re: [Qemu-devel] Do we need a "virt-2.10" machine type before the
 2.10 release?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Andrew Jones <drjones@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> Hi; I noticed today that the virt board doesn't have a virt-2.10
> machine type defined. Do we need to add it before release?
> 
> (I don't know if there have in fact been any changes between
> 2.9 and 2.10 that would be compatibility issues.)

I think there's two sub questions:
  a) The virt-2.9 needs to pick up HW_COMPAT_2_9 if anything
  in it is relevant for ARM

  b) If anything is relevant in it for ARM then you probably
  want a virt-2.10 so that you can take advantage of whatever
  was changed that needed compatibility adding in HW_COMPAT_2_9

(The other thing is figuring out what we missed in HW_COMPAT_2_9,
we normally miss something).

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
