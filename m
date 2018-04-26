Received: from eggs.gnu.org ([2001:4830:134:3::10]:58409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBheg-00021l-Ul
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:13:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBheb-00069D-3p
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:13:50 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:39119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fBhea-00068c-Ue
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:13:45 -0400
Received: by mail-ot0-x244.google.com with SMTP id l12-v6so1641486oth.6
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 07:13:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8d0fb991-12b8-5660-19c1-4d93299a5ba9@redhat.com>
References: <1524633715-21393-1-git-send-email-thuth@redhat.com>
	<11bfff34-f237-69e3-5491-a048809d84a4@redhat.com>
	<fae01c1a-1780-7bb6-2396-f21dd9b2c6b6@redhat.com>
	<CAFEAcA_chYr1Y00KJQJ+JJ2VDgkcxuh4DqYeP0o_+HbHdJXGFA@mail.gmail.com>
	<8d0fb991-12b8-5660-19c1-4d93299a5ba9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 15:13:23 +0100
Message-ID: <CAFEAcA-sJUR7tddh5=AgymWaOBpLxLfD1VMJFD=QZ+mNf_SHSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1] hw/s390x: Allow to
 configure the consoles with the "-serial" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 25 April 2018 at 15:00, Thomas Huth <thuth@redhat.com> wrote:
> On 25.04.2018 14:31, Peter Maydell wrote:
>> Note that I have a series on-list which removes the MAX_SERIAL_PORTS
>> restriction, so you can have arbitrarily many serial ports.
>> (If that gets into master before this there'll be a conflict,
>> but it's easy to resolve: just change "serial_hds[n]" to "serial_hd(n)".)
>
> Ok, that should be pretty easy to resolve, indeed.

The MAX_SERIAL_PORTS series is now in master.

thanks
-- PMM
