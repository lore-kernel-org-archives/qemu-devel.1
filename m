Received: from eggs.gnu.org ([2001:4830:134:3::10]:50993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ew5ZK-0002w6-NO
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 08:31:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ew5ZJ-00025R-TI
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 08:31:46 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:35703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ew5ZJ-00025B-OG
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 08:31:45 -0400
Received: by mail-ot0-x22d.google.com with SMTP id r30-v6so3051706otr.2
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 05:31:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9dab3815-57a8-59e4-f1c7-b5e56b14d64a@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
	<CAFEAcA9HLfz77eEHho+Vod=XSsvoNv10noFJjqoAd0=CXT-8dQ@mail.gmail.com>
	<ad8cb727-8e0d-d2ba-659e-9b91f59c30cd@redhat.com>
	<9dab3815-57a8-59e4-f1c7-b5e56b14d64a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Mar 2018 12:31:24 +0000
Message-ID: <CAFEAcA_eCkXB2Aw-aNfD97WBFDhd5H19YywPFwkZ4uHmqtZL0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/36] QAPI patches for 2018-03-12,
 2.12 softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

On 13 March 2018 at 21:55, Eric Blake <eblake@redhat.com> wrote:
> On 03/13/2018 09:17 AM, Eric Blake wrote:
>>>>
>>>> This builds and passes 'make check', so even though the OOB portion
>>>> depends on chardev fixes that are still pending a pull request from
>>>> Paolo, that dependence can only be observed at runtime by clients
>>>> that use the new oob feature.  Given the timing of soft freeze, and
>>>> the fact that the chardev fixes do not form a build dependency, I
>>>> think it's okay if this pull request gets processed before Paolo's
>>>> (but it's also okay if Paolo's goes in first).
>>
>>
>> Based on the testsuite failures, it looks like Paolo's pull request with
>> chardev fixes DOES have to go in first.
>
>
> Nearing the end of my workday; I'm not sure what the status is on Paolo's
> pull request with the chardev fixes, but hope that it doesn't invalidate
> this pull request from still being considered as soft freeze material.

The freeze approach is that if you get v1 of the pull on the list
before the date, then the purpose of the following week before rc0
is to get the stragglers in and so that we can do re-spins if there
were minor issues with anything. So it's ok.

thanks
-- PMM
