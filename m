Received: from eggs.gnu.org ([2001:4830:134:3::10]:35478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1deSyw-00080R-AQ
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 17:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1deSyr-0006io-C6
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 17:21:06 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1deSyr-0006hU-5s
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 17:21:01 -0400
Received: by mail-wm0-f48.google.com with SMTP id m85so54901646wma.0
	for <qemu-devel@nongnu.org>; Sun, 06 Aug 2017 14:21:01 -0700 (PDT)
References: <CAFEAcA-Se9r30gHpYd34vF0Z-yQbDtpOBi8qyqvtTXMja85Zdg@mail.gmail.com>
	<20170804174843.GE2087@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e4691b84-d83e-4bec-117d-1d7637ac35f1@redhat.com>
Date: Sun, 6 Aug 2017 23:20:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170804174843.GE2087@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jones <drjones@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 04/08/2017 19:48, Dr. David Alan Gilbert wrote:
>>
>> (I don't know if there have in fact been any changes between
>> 2.9 and 2.10 that would be compatibility issues.)
> I think there's two sub questions:
>   a) The virt-2.9 needs to pick up HW_COMPAT_2_9 if anything
>   in it is relevant for ARM

Except for intel-iommu, everything else in HW_COMPAT_2_9 is relevant for
virt-2.9.  This implies that a virt-2.10 would be useful too.

Paolo

>   b) If anything is relevant in it for ARM then you probably
>   want a virt-2.10 so that you can take advantage of whatever
>   was changed that needed compatibility adding in HW_COMPAT_2_9
