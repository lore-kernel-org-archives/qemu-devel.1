Received: from eggs.gnu.org ([2001:4830:134:3::10]:57517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddglB-0002Wq-5V
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddglA-00025H-EY
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:51:41 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:38403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ddglA-000234-8b
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:51:40 -0400
Received: by mail-wr0-x22c.google.com with SMTP id f21so19287229wrf.5
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 10:51:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170804174843.GE2087@work-vm>
References: <CAFEAcA-Se9r30gHpYd34vF0Z-yQbDtpOBi8qyqvtTXMja85Zdg@mail.gmail.com>
	<20170804174843.GE2087@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2017 18:51:18 +0100
Message-ID: <CAFEAcA-tMiei=zaTZ_6nhAfp=Y-2t0cno9eB2-JQB_GR=Rk4UA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Andrew Jones <drjones@redhat.com>

On 4 August 2017 at 18:48, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> Hi; I noticed today that the virt board doesn't have a virt-2.10
>> machine type defined. Do we need to add it before release?
>>
>> (I don't know if there have in fact been any changes between
>> 2.9 and 2.10 that would be compatibility issues.)
>
> I think there's two sub questions:
>   a) The virt-2.9 needs to pick up HW_COMPAT_2_9 if anything
>   in it is relevant for ARM
>
>   b) If anything is relevant in it for ARM then you probably
>   want a virt-2.10 so that you can take advantage of whatever
>   was changed that needed compatibility adding in HW_COMPAT_2_9

...and also, do we as policy want to define a virt-X.Y for
every X.Y release even if it happens that there are no
changes between X.Y-1 and X.Y ? From a user point of view
it seems a bit odd for one to be missing.

thanks
-- PMM
